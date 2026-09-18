<?php
require_once "common.php";




//处理路径变量或是用URL的Get方式传入参数，同时允许传入五个自定义变量在模板中使用
if ( empty($_SERVER["PATH_INFO"]) || strpos($_SERVER["SERVER_SOFTWARE"], "IIS")   ) { //Apache,http://www.cmsware.net/member/index.php/6,2.html
	$IN['nodeid'] = intval($IN['nodeid']); //处理nodeid为整型
	$IN['page']   = intval($IN['page']);  //处理页号为整型
//	$IN['Custom1']   = intval($IN['Custom1']);  //自定义传入变量1到5
//	$IN['Custom2']   = intval($IN['Custom2']);
//	$IN['Custom3']   = intval($IN['Custom3']);
//	$IN['Custom4']   = intval($IN['Custom4']);
//	$IN['Custom5']   = intval($IN['Custom5']);

} else {
    $PATH_INFO=substr($_SERVER["PATH_INFO"],1,strrpos($_SERVER["PATH_INFO"],'.')-1);
    list($IN['id'], $IN['page'], $IN['Custom1'], $IN['Custom2'], $IN['Custom3'], $IN['Custom4'], $IN['Custom5']) = explode(',', $PATH_INFO);

}



$IndexID = &$IN['id'];
$Page = empty($IN['page']) ? 0 : $IN['page'];
$result = $db->getRow("SELECT NodeID FROM $table->content_index WHERE IndexID=$IndexID");
if(empty($result['NodeID'])) {
	die('Invalid IndexID');
} else {
	$NodeInfo = $iWPC->loadNodeInfo($result['NodeID']);
	$table_content = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$NodeInfo['TableID'];
	$NodeID = &$NodeInfo['NodeID'];
}


if(!$NodeInfo) {
	die('NodeID is InValid');
}
if(in_array(basename(__FILE__), $EnableAccessInterceptorOAS)) {
	if(!$Access->canAccess($NodeID,'ReadContent')) {//验证首页访问权限
		$TPL->assign('deny_code', $Access->deny_code);
		$TPL->display($OAS_SETTING['AccessDenyTpl']);
		exit;
	} 

}



//$TPL->client_caching = true;
$TPL->caching = true;
$TPL->cache_lifetime = $OAS_SETTING['ContentPageCacheTime'];

$tplname = &$NodeInfo['ContentTpl'];

//缓存的文件ID用传入参数变量做识别
$cacheId = $IndexID.$Page.$IN['Custom1'].$IN['Custom2'].$IN['Custom3'].$IN['Custom4'].$IN['Custom5'].$tplname;

//更新计数
require_once LIB_PATH.'SqlMap.class.php';

$sqlMap = new SqlMap(dirname(__FILE__)."/sqlmap.php");
$sqlMap->startTransaction();
$sqlMap->addData('IndexID', $IndexID);
$sqlMap->update("updateHits");


if($TPL->is_cached($tplname, $cacheId)) {
	$TPL->run_cache($tplname, $cacheId);

} else {
	require_once INCLUDE_PATH."data.class.php";
	require_once INCLUDE_PATH."data.remote.class.php";
	//require_once INCLUDE_PATH."functions.php";
	require_once SYS_PATH."config.php";


	require_once KTPL_DIR . 'kTemplate.class.php';
	require_once INCLUDE_PATH.'image.class.php';
	require_once INCLUDE_PATH."file.class.php";
	if (!extension_loaded('ftp')) {
		require_once INCLUDE_PATH."ftp.class.php";
	}
	require_once INCLUDE_PATH."Error.php";
	require_once INCLUDE_PATH."exception.class.php";
	require_once INCLUDE_PATH."admin/psn_admin.class.php";
 	include_once SETTING_DIR."cms.ini.php";
	require_once KDB_DIR.'kDB.php';
	$db = new kDB($db_config['db_driver']);
	$db->connect($db_config);
//$db->setDebug(1);
	include_once(CACHE_DIR.'Cache_SYS_ENV.php');
	include_once(CACHE_DIR.'Cache_PSN.php');
	include_once(CACHE_DIR.'Cache_CateList.php');




 


	require_once INCLUDE_PATH."admin/publishAdmin.class.php";
	require_once INCLUDE_PATH."admin/content_table_admin.class.php";
	require_once INCLUDE_PATH."admin/tplAdmin.class.php";
	require_once INCLUDE_PATH."admin/psn_admin.class.php";
	require_once INCLUDE_PATH."admin/site_admin.class.php";
	require_once INCLUDE_PATH."cms.class.php";
	require_once INCLUDE_PATH."cms.func.php";

	$publish = new publishAdmin();


	$NodeInfo = $iWPC->loadNodeInfo($NodeID);
	$publishInfo= $publish->getPublishInfo($IndexID);
	//print_r($publishInfo);
	$publish->IndexID = $IndexID;
	$publish->NodeInfo = &$NodeInfo;
	$publish->publishInfo = $publishInfo;
 		foreach($tpl_vars as $key=>$var) {//模板变量赋值

				if($var['IsGlobal'] == 1) continue;
				elseif(preg_match("/,".$NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
					$TPL->assign($var['VarName'], $var['VarValue']);	
				} else {
					foreach(explode('%', $NodeInfo['ParentNodeID']) as $varIn) {
						if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
							$TPL->assign($var['VarName'], $var['VarValue']);	
						}
					}
				}
		 

 		}

		if($publish->publishInfo[Type] == 3) {
			if(!file_exists($TPL->template_dir.$publish->NodeInfo[ImageTpl])) {
					new Error("Error: The Image template {$TPL->template_dir}{$publish->NodeInfo[ImageTpl]} you have set  for your Image does not exists, system now use the default template \"{$SYS_ENV[templatePath]}/default/image.html\" to run.");
					$tplname = 'image.html';
					$TPL->template_dir =  $TPL->template_dir.'/default/';		
			} else {
				$tplname =  $publish->NodeInfo[ImageTpl];
			
			}
		
		} else {

			if(!empty($publish->publishInfo[SelfTemplate])) {
				$tplname =  $publish->publishInfo[SelfTemplate];
				
				if(!file_exists($TPL->template_dir.$publish->publishInfo[SelfTemplate])) {
					new Error("Error: The content template {$TPL->template_dir}{$publish->publishInfo[Template]} you have set alone for your content does not exists, system now use the default template \"{$SYS_ENV[templatePath]}/default/content.html\" to run.");
					$tplname = 'content.html';
					$TPL->template_dir =  $TPL->template_dir.'/default/';		
				}
			
			} elseif(!empty($publish->NodeInfo[ContentTpl])) {
				$tplname =  $publish->NodeInfo[ContentTpl];
				
				if(!file_exists($TPL->template_dir.$publish->NodeInfo[ContentTpl])) {
					new Error("Error: The content template {$TPL->template_dir}{$publish->NodeInfo[ContentTpl]} does not exists, system now use the default template \"{$SYS_ENV[templatePath]}/default/content.html\" to run.");
					$tplname = 'content.html';
					$TPL->template_dir = $TPL->template_dir.'/default/';		
				}

			} else {	
				new Error("Warning: You haven\'t set the content template, system now use the default template \"{$SYS_ENV[templatePath]}/default/content.html\" to run.");
				$tplname = 'content.html';
				$TPL->template_dir =  $TPL->template_dir.'/default/';

			}				

		}


	
		
		$TPL->registerPreFilter('CMS_Parser');
		include(SETTING_DIR.'dcontent.ini.php');

		$PublishFileFormat = $NodeInfo['ContentPortalURL'];
		foreach($filenameFormatMap as $key=>$var) {
			$PublishFileFormat = str_replace($key,$var, $PublishFileFormat);
		}
	 
		foreach($publishInfo as $key=>$var) {
			//$publishInfo[$key] = $publish->ReplaceKeywords($publishInfo[$key]);
			
 			//$publish->resourcePublish($var);
			//$publish->htmlPhotoPublish($var);
			//$publish->psnPublish($var);
			$TPL->assign($key, $var);
		}
		 
		$TPL->assign_by_ref('Publish', $publishInfo);
		$TPL->assign_by_ref('PublishInfo', $publishInfo);
		$TPL->assign('Navigation', $Navigation);
		$TPL->assign('sysRelateDoc', $RelateDoc);
		$TPL->assign('NodeInfo', $NodeInfo);
					$TPL->assign('Custom1', $IN['Custom1']);    //自定义传入变量1
					$TPL->assign('Custom2', $IN['Custom2']); 
					$TPL->assign('Custom3', $IN['Custom3']); 
					$TPL->assign('Custom4', $IN['Custom4']); 
					$TPL->assign('Custom5', $IN['Custom5']); 

		$TPL->registerPreFilter('CMS_Parser');
		if (preg_match_all($patt, $publishInfo[$mainContentLabel], $match)) {
				$contentArray = preg_split($patt, $publishInfo[$mainContentLabel]);

				if($contentArray[0] == "") {
					$contentArray = array_slice ($contentArray, 1); 
					
					$pagenum=count($contentArray);
					$pagenum_pre = $pagenum;
					$totalnum=$pagenum;
					$pagenum--;
					$pagenum_pre--;
					$hawking = 1;
				} else {
					$pagenum=count($contentArray);
					$pagenum_pre = $pagenum;
					$totalnum=$pagenum;
					$pagenum--;
					$pagenum_pre--;
					$hawking = 0;
				}

				do { 

					eval ("\$publishFileName = \"$PublishFileFormat\";");
					$publishFileName = str_replace("{Page}" , $pagenum_pre , $publishFileName);
					if ($hawking==1) {
						
						$pageNav[] = array(
							'Title' => $match[1][$pagenum_pre],
							'URL' => $publishFileName,
							'Link' => $publishFileName,
						);
					} else {
						if($match[1][$pagenum_pre-1] == '')
							$match[1][$pagenum_pre-1]= $IndexPageTitle;
						$pageNav[] = array(
							'Title' => $match[1][$pagenum_pre-1],
							'URL' => $publishFileName,
							'Link' => $publishFileName,
						);
					}
				} while($pagenum_pre--);
				
				$pageNav = array_reverse ($pageNav);


					eval ("\$publishFileName = \"$PublishFileFormat\";");
					$pagelist =  DynamicPublish::Page($totalnum-1,$Page+1,$publishFileName) ;
					
					$TPL->assign($mainContentLabel,$SYS_ENV['CMSware_Mark'].$contentArray[$Page]);
					if($hawking == 1)
						$TPL->assign($_pageTitle,$match[1][$Page]);
					else
						$TPL->assign($_pageTitle,$match[1][$Page-1]);
					$TPL->assign($_pageList,$pagelist);
					$TPL->assign($_pageNav, $pageNav);

					$pageInfo[PageNum] = $pagenum;
					$pageInfo[Page] = $Page;
					$TPL->assign('PageInfo', $pageInfo);

					//echo $SYS_ENV['CMSware_Mark'] ;
					$TPL->run_cache($tplname, $cacheId); 

				
				
			}else {
				//echo 'aaaaaaaaaa';
				$TPL->assign($mainContentLabel,$SYS_ENV['CMSware_Mark'].$publishInfo[$mainContentLabel]);
				//echo $SYS_ENV['CMSware_Mark'] ;
				$TPL->run_cache($tplname, $cacheId); 
	
			}
				
	

}
include('debug.php');
?>