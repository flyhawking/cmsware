<?php
require_once "common.php";
require_once ROOT_PATH."plugins/base/plugin.config.php";
require_once "comment.lang.php";

if(isset($IN['page'])) $IN['Page'] = $IN['page'];

$Page = empty($IN['Page']) ? 1 : intval($IN['Page']);

if(empty($IN['id']) && empty($IN['IndexID']) && empty($IN['Id'])) {
	die('IndexID empty');
} else {
	$IndexID = $Id = empty($IN['id']) ? (empty($IN['IndexID']) ? $IN['Id'] : $IN['IndexID']) : $IN['id'];
}
$table_count =  &$plugin_table['base']['count'];
$table_comment =  &$plugin_table['base']['comment'];

$result = $db->getRow("SELECT NodeID FROM $table_count WHERE IndexID=$IndexID");
if(empty($result['NodeID'])) {
	die('Invalid IndexID');
} else {
	$NodeInfo = $iWPC->loadNodeInfo($result['NodeID']);
	$table_content = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$NodeInfo['TableID'];
	$NodeID = $NodeInfo['NodeID'];
}


if(preg_match("/\{TID:([0-9]+)\}/isU", $OAS_SETTING['Comment_Tpl'], $matches)) { 
	require_once INCLUDE_PATH."admin/cate_tpl_admin.class.php";
	if(!isset($cate_tpl)) {
	 	$cate_tpl = new cate_tpl_admin();
 		$TID = $matches[1];
		$TInfo = $cate_tpl->getInfo($TID);
		$OAS_SETTING['Comment_Tpl']="/ROOT/".$TInfo[TCID]."/".$TInfo[TID].".tpl";
			
	}
		
}

$tpl= (RUNNING_MODE == 'lite') ? "/TPL-LITE/style/".$SYS_ENV['SiteStyle']."/oas/comment.html" :  $OAS_SETTING['Comment_Tpl'];
$TPL->assign('TableID', $NodeInfo['TableID']);
$TPL->assign_by_ref('NodeInfo', $NodeInfo);



switch ($IN['o']) {
	case 'display' :
		if(in_array(basename(__FILE__), $EnableAccessInterceptorOAS)) {
			if(!$Access->canAccess($NodeID,'ReadComment')) {//验证评论查看权限
				$TPL->assign('deny_code', $Access->deny_code);
				$TPL->display($OAS_SETTING['AccessDenyTpl']);
				exit;
			} 
		}

 		$offset = empty($OAS_SETTING['Comment_PageNum']) ? 20 : $OAS_SETTING['Comment_PageNum'];


		$TPL->caching = $OAS_SETTING['Comment_EnableDisplayCache'];
		$TPL->cache_lifetime = '10000000000000000';  
		$TPL->assign_by_ref("kTPL_Caching", $TPL->caching );
		$cache_id = $Page.$Id;
		

		if($TPL->caching && $TPL->is_cached($tpl, $cache_id)) {
				$TPL->run_cache($tpl, $cache_id);
		} else {
			require_once INCLUDE_PATH."data.class.php";
			require_once INCLUDE_PATH."data.remote.class.php";
			//require_once INCLUDE_PATH."functions.php";


			require_once INCLUDE_PATH.'image.class.php';
			require_once INCLUDE_PATH."file.class.php";
			if (!extension_loaded('ftp')) {
				require_once INCLUDE_PATH."ftp.class.php";
			}
			require_once INCLUDE_PATH."Error.php";
			require_once INCLUDE_PATH."exception.class.php";
			require_once INCLUDE_PATH."admin/psn_admin.class.php";
			require_once INCLUDE_PATH."admin/dsn_admin.class.php";
			include_once SETTING_DIR."cms.ini.php";
		//$db->setDebug(1);
			include_once(CACHE_DIR.'Cache_SYS_ENV.php');
			include_once(CACHE_DIR.'Cache_PSN.php');
			include_once(CACHE_DIR.'Cache_CateList.php');


			require_once INCLUDE_PATH."admin/publishAdmin.class.php";
			require_once INCLUDE_PATH."admin/content_table_admin.class.php";
			require_once INCLUDE_PATH."admin/tplAdmin.class.php";
			require_once INCLUDE_PATH."admin/psn_admin.class.php";
			require_once INCLUDE_PATH."admin/site_admin.class.php";
			require_once INCLUDE_PATH."admin/dsn_admin.class.php";
			require_once INCLUDE_PATH."cms.class.php";
			require_once INCLUDE_PATH."cms.func.php";

 			// {{{ add 2006-01-14
			if($OAS_SETTING['Comment_enableCommentApprove'] == 1) {
				$where = " IndexID=$Id AND Approved=1 ";
 			} else {
				$where = " IndexID=$Id ";
 			}
			// }}}


			$result= $db->Execute("SELECT COUNT(*) as nr  FROM $table_comment where $where ");
			
			$num=((int)$result->fields[nr]);
				//echo $num;
				
			$pagenum=ceil($num/$offset);
			$currentpage=$Page;
			$start=($currentpage-1)*$offset;



				
			$sql="SELECT * FROM $table_comment where $where Order by CommentID DESC LIMIT $start,$offset";
				
			$recordSet=$db->Execute($sql);
				
			while(!$recordSet->EOF) {	
							
					if($OAS_SETTING['Comment_HiddenCommentIP']) {
						$pattern = "/^([0-9]+).([0-9]+).([0-9]+).([0-9]+)$/";
						$replacement = "\\1.\\2.\\3.*";
						$recordSet->fields[Ip] = preg_replace($pattern, $replacement, $recordSet->fields[Ip] );
					
					}
					
					$_izz[]=$recordSet->fields;
					$recordSet->MoveNext();
					
			}
			$recordSet->Close(); 
					
			
			$result= $db->getRow("SELECT i.NodeID,i.URL,i.IndexID,i.PublishDate,i.Type,i.Sort,i.Pink,c.* FROM $table->content_index i,$table_content c  where i.IndexID=$Id AND i.ContentID =c.ContentID");
			
			$TPL->assign_by_ref("CommentList",$_izz);
			$TPL->assign("CountNum",$num);
			$TPL->assign_by_ref("Publish",$result);
			
			$TPL->assign("NodeId",$NodeId);
			$TPL->assign("Id",$Id);
			$TPL->assign("Page",comment_display_page($pagenum,$Page,$PHP_SELF."?o=display&amp;id=$Id"));
			$TPL->registerPreFilter('CMS_Parser');
			if($TPL->caching) {
				$TPL->run_cache($tpl, $cache_id);
			} else {
				$TPL->display($tpl);

			}
		
		}
		$db->Close(); 
		break;
	case 'post' :
		if(in_array(basename(__FILE__), $EnableAccessInterceptorOAS)) {
			if(!$Access->canAccess($NodeID,'PostComment')) {//验证评论发布权限
				goback("comment.access_deny");
				$TPL->assign('deny_code', $Access->deny_code);
				$TPL->display($OAS_SETTING['AccessDenyTpl']);
				exit;
			} 
		}
		
		$table_count = $db_config['table_pre'].'plugin_base_count';

		if ($IN['content'] != '') {
			
			//{{{ 评论发表功能改进 2006-1-10
			if($OAS_SETTING['Comment_enableComment'] != 1) goback("comment.disabled");


			$content = trim(addslashes(htmlspecialchars($IN['content'])));
			
			$IN['username'] = empty($Access->oas->session['UserName']) ? $_LANG_ADMIN['guest'] : $Access->oas->session['UserName'];
			


			if(strlen($content) > $OAS_SETTING['Comment_contentMaxLength'])
				goback("comment.length.overflow", array($OAS_SETTING['Comment_contentMaxLength']));
			

			if(strlen($content) <= $OAS_SETTING['Comment_contentMinLength'] ) 
				goback("comment.length.less", array($OAS_SETTING['Comment_contentMinLength']));

 
			//关键字过滤
			if(!empty($OAS_SETTING['Comment_filterMode'])) {
				$bannedWords = explode(',', $OAS_SETTING['Comment_filterWords']);
				$content_todo = str_replace(' ', '', $IN['content']);
				$username_todo = str_replace(' ', '', $IN['username']);
				foreach($bannedWords as $var) {
					$posA = strpos($content_todo, $var);
					$posB = strpos($username_todo, $var);
					if($posA === false && $posB === false) continue;
					else {
						if($OAS_SETTING['Comment_filterMode'] == 1) goback("comment.badwords", array($var));
						else {
							$replace = str_repeat($OAS_SETTING['Comment_replaceWord'], ceil(strlen($var)/2));
 							$content = str_replace($var, $replace, $content);
 						}
				
					}
				
				}
			
			}

			//}}}
			
			//`CommentID` , `IndexID` , `ContentID` , `NodeID` , `Author` , `CreationDate` , `Ip` , `Comment`
			$time = time();
			$ip = $IN["IP_ADDRESS"];

			$sql = "SELECT ContentID,NodeID From $table_count WHERE IndexID='$Id'";
			$result = $db->getRow($sql);
			
			$IN['username'] = $db->escape_string($IN['username']);
			$content = $db->escape_string($content);

			$add = $db->query("INSERT INTO $table_comment (  `IndexID` , `ContentID` , `NodeID` , `Author` , `CreationDate` , `Ip` , `Comment` , `UserID`) 
						VALUES (
							 '$Id' , '{$result[ContentID]}' , '{$result[NodeID]}' , '{$IN['username']}' , '$time' , '$ip' , '$content', '{$Access->oas->session['UserID']}'
						)");
			$db->query("UPDATE $table_count SET `CommentNum`=CommentNum+1 where IndexID='$Id'");
			if ($add) {
				$result= $db->Execute("SELECT COUNT(*) as nr  FROM $table_comment where IndexID=$Id");
				
				$num=((int)$result->fields[nr]);
				for($i=1;$i<=$num;$i++) {
					$TPL->clear_cache($tpl, $i.$Id);
				}

				include_once("js.config.php");
				$cacheId = "comment".$Id."000";
				$tplname = &$templateKeys["comment"];
				$TPL->clear_cache($tplname, $cacheId );
				
 				if($OAS_SETTING['Comment_enableCommentApprove'] == 0) echo $_LANG_ADMIN['post_ok'];
				else echo $_LANG_ADMIN['post_ok_approve'];
				
				
				echo "<meta http-equiv=\"refresh\" content=\"2;url=comment.php?o=display&amp;id=$Id\">";
				
			}
		} else {
			goback("comment_null");
		}

		break;

}

include('debug.php');




?>
