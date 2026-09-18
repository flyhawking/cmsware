<?php
require_once 'common.php';


require_once INCLUDE_PATH."admin/contribution_admin.class.php";
require_once INCLUDE_PATH."admin/content_table_admin.class.php";
require_once INCLUDE_PATH."admin/site_admin.class.php";
require_once INCLUDE_PATH."admin/userAdmin.class.php";
require_once INCLUDE_PATH."admin/workflowAdmin.class.php";
require_once INCLUDE_PATH."cms.class.php";
require_once INCLUDE_PATH."cms.func.php";

require_once INCLUDE_PATH."admin/publishAdmin.class.php";
require_once INCLUDE_PATH."admin/content_table_admin.class.php";
//require_once INCLUDE_PATH."admin/tplAdmin.class.php";
require_once INCLUDE_PATH."admin/site_admin.class.php";
require_once INCLUDE_PATH."cms.class.php";
require_once INCLUDE_PATH."cms.func.php";
require_once INCLUDE_PATH.'encoding/encoding.inc.php';
require_once INCLUDE_PATH."admin/psn_admin.class.php";
require_once INCLUDE_PATH."admin/plugin.class.php";
require_once INCLUDE_PATH."admin/publishAuthAdmin.class.php";
require_once INCLUDE_PATH."admin/task.class.php";
require_once INCLUDE_PATH.'image.class.php';

$Plugin = new Plugin();

contributionAdmin::isValid();

$contribution = new contributionAdmin();
$workflow = new workflowAdmin();
$site = new site_admin();
//$db->setDebug(1);

//debug($IN);
	if(empty($IN[NodeID])) 	goback('error_NodeID_null');
	/*
	//权限验证
	if(!$sys->canManagePublish('approve', $IN[NodeID])) {
			goback($sys->returnMsg);

	}
	*/


if(!empty($IN[NodeID])) {
	$site->contributionPermissionDetector($IN[o], $IN[NodeID], $IN);
	$NodeInfo = $iWPC->loadNodeInfo($IN[NodeID]);
}
	


switch($IN[o]) {
		case 'list':
			if(empty($NodeInfo['NodeID'])) goback('error_NodeID_invalid');
			$TPL->assign('NodeID', $IN[NodeID]);
			$TPL->display('contribution_admin_frameset.html');
			
			break;
		case 'content_header'://内容管理 头部功能导航
			$TPL->assign('NodeID', $IN[NodeID]);
			$TPL->assign_by_ref("NodeInfo", $NodeInfo);

			if($NodeInfo['NodeType'] == 2) {
				$ParentNodeInfo = $iWPC->loadNodeInfo($NodeInfo['InheritNodeID']);
				$NodeInfo['ParentNodeName'] = $ParentNodeInfo['Name'];
			}

			$TPL->display('contribution_admin_header.html');
			$diableDebug = true;
			break;
		case 'content_list': //内容管理 文章列表
			unset($_SESSION['DB_QUERY_CACHE']);
			$offset = 15;
			if($sys->session[sGIsAdmin] == 1) {
				$GroupState  = $workflow->getAllStateByGroup($NodeInfo[WorkFlow], 'admin');
			} else{
				$GroupState  = $workflow->getAllStateByGroup($NodeInfo[WorkFlow], $sys->session[sGId]);
				
			}			
			
			if(empty($IN[State])) {
				$State = $GroupState;
			} else $State = $IN[State];
				
			//echo $State;
			$num= $contribution->getContributionRecordNum($NodeInfo, $State);
			$pagenum=ceil($num/$offset);
			if(empty($IN[Page]))
				$Page = 1;
			else
				$Page = $IN[Page];

			$start=($Page-1)*$offset;
			
			if($sys->session[sGIsAdmin] == 1) {
				$TPL->assign('workflowRecord', $workflow->getAllWorkFlowRecordByGroup($NodeInfo[WorkFlow],'admin'));
			} else {
				$TPL->assign('workflowRecord', $workflow->getAllWorkFlowRecordByGroup($NodeInfo[WorkFlow], $sys->session[sGId]));
			}

			$TPL->assign('workflowState', $workflow->getState($GroupState));
			$TPL->assign('sGIsAdmin', $sys->session[sGIsAdmin]);
			$TPL->assign('DisplayItem', content_table_admin::getDisplayFieldsInfo($NodeInfo[TableID]));
			$TPL->assign('catelist', $CATE_LIST);
			$TPL->assign("pList", $contribution->getContributionLimit($NodeInfo, $start, $offset, $State));
			$TPL->assign("NodeInfo", $NodeInfo);
			

			if(empty($IN[State])) {
				$TPL->assign("pagelist",pagelist($pagenum,$Page,"{$base_url}o=content_list&type=main&NodeID={$IN[NodeID]}",'#000000'));
			} else {
				$TPL->assign("pagelist",pagelist($pagenum,$Page,"{$base_url}o=content_list&type=main&NodeID={$IN[NodeID]}&State={$IN[State]}",'#000000'));;
			
			} 
			
			$TPL->display('contribution_admin_list.html');
			
			break;
		case 'contribution_editor_frameset':
			$TPL->assign('NodeID', $IN[NodeID]);
			$TPL->assign('ContributionID', $IN[ContributionID]);
			$TPL->assign('o', $IN[extra]);
			$TPL->display('contribution_editor_frameset.html');

			break;
		case 'contribution_editor_header':
			$TPL->assign('NodeID', $IN[NodeID]);
			$TPL->assign("NodeInfo", $NodeInfo);
			$TPL->display('contribution_editor_header.html');
			$diableDebug = true;
			break;
		

		case 'edit':
			if(empty($IN[ContributionID])) goto('contribution_list');
			$pInfo = $contribution->getContributionInfo($NodeInfo, $IN[ContributionID]);
			$pInfo[SubNodeIDs] = explode(',', $pInfo[SubNodeID]);
			$pInfo[IndexNodeIDs] = explode(',', $pInfo[IndexNodeID]);

			$TableID = 	$NodeInfo[TableID];

			$tableInfo = content_table_admin::getTableFieldsInfo($TableID);

 			$diableDebug = true;

			include MODULES_DIR.'contribution_editor.php' ;

			break;
		case 'edit_submit':
			if(empty($IN[ContributionID])) goto('contribution_list');

			$fieldInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);			

			$contribution->flushData();

			foreach($fieldInfo as $key=>$var) {
				if(empty($var['EnableContribution'])) continue;
					$field = 'data_'.$var[FieldName];
					if(is_array($IN[$field])) {
						foreach($IN[$field] as $keyIn=>$varIn) {
							if($keyIn == 0)
								$value = $varIn;
							else
								$value .= ';'.$varIn;


						}
					} elseif($var[FieldInput] == 'RichEditor') {
						$field = 'data_'.$var[FieldName].'_html';
						$value = RichEditor_Filter($IN[$field]);
						//debug($IN);
						if($IN['data_'.$var[FieldName].'_ImgAutoLocalize'] == '1') {
							//echo $result;
							$ImgAutoLocalize = new ImgAutoLocalize($IN[NodeID]);
							$result = $ImgAutoLocalize->execute($value);

							if($result)
								$value = $result;
						} 
					} else
						$value = $IN[$field];

					$contribution->addData($var[FieldName], $value);
				
			}
			//CreationDate  ModifiedDate  CreationUserID  LastModifiedUserID  ApprovedByUserID 
			$contribution->addData('ModifiedDate', time());

			$contribution->addData('NodeID', $IN[TargetNodeID]);
			if(!empty($IN[SubTargetNodeID])) {
				foreach($IN[SubTargetNodeID] as $key=>$var) {
					if($key == 0)
						$subTargetNodeID = $var;
					else
						$subTargetNodeID .= ','.$var;

				}
				$contribution->addData('SubNodeID', $subTargetNodeID);
			
			}

			$IndexTargetNodeID = '';
			if(!empty($IN[SubTargetNodeID])) {
				foreach($IN[IndexTargetNodeID] as $key=>$var) {
					if($key == 0)
						$IndexTargetNodeID = $var;
					else
						$IndexTargetNodeID .= ','.$var;

				}
				$contribution->addData('IndexNodeID', $IndexTargetNodeID);
			}


			if($contribution->contributionEdit($NodeInfo, $IN[ContributionID])) {
				echo "<script>\n
					parent.window.opener.refreshWorkArea();				
					</script>\n";
				showmessage('contribution_edit_ok',$referer);	
				exit;				


			}else
				goback('contribution_edit_fail');
			break;
		case 'view':
			if(empty($IN[ContributionID])) goto('contribution_list');
			$pInfo = $contribution->getContributionInfo($NodeInfo,$IN[ContributionID]);
				
			$NodeInfo = $iWPC->loadNodeInfo($pInfo[NodeID]);
			$NodeArray = unserialize($NodeInfo[Nav]);
			foreach($NodeArray as $key=>$var) {

				if($key == 0) {

					$Navigation = "{$var[Name]}";
						
				} else {
					$Navigation .= "&nbsp;-&gt;&nbsp;{$var[Name]}";
						
				}



			}
			$pInfo[NodeName] = $Navigation;

			
			
			$SubNodeIDs = explode(',', $pInfo[SubNodeID]);
			if(!empty($SubNodeIDs[0])) {

				foreach($SubNodeIDs as $key=>$var) {
					$NodeInfo = $iWPC->loadNodeInfo($var);
					$NodeArray = unserialize($NodeInfo[Nav]);
					foreach($NodeArray as $key=>$var) {

						if($key == 0) {

							$Navigation = "{$var[Name]}";
						
						} else {
							$Navigation .= "&nbsp;-&gt;&nbsp;{$var[Name]}";
						
						}



					}
					$pInfo[SubNodeIDs][] = $Navigation;

				}



			}

			$TableID = 	$NodeInfo[TableID];

			$tableInfo = content_table_admin::getTableFieldsInfo($TableID);
			include MODULES_DIR.'contribution_admin_view.php' ;
			break;

		case 'approve':
			unset($_SESSION['DB_QUERY_CACHE']);
			if(!empty($IN[multi]) && !empty($IN[pData]) ) {
				foreach($IN[pData] as $var) {
					$result = $contribution->approve($NodeInfo, $var);				
					userAdmin::Counter($var, 'ApproveNum','+',1,$NodeInfo);
					userAdmin::Counter($var, 'ContributionNum','-',1,$NodeInfo);
				}

				if($result)
					showmessage('contribution_approve_ok', $referer);
				else
					showmessage('contribution_approve_fail', $referer);

			} elseif(!empty($IN[ContributionID])) {
			
				if($contribution->approve($NodeInfo, $IN[ContributionID])) {
					userAdmin::Counter($IN[ContributionID], 'ApproveNum','+',1,$NodeInfo);
					userAdmin::Counter($IN[ContributionID], 'ContributionNum','-',1,$NodeInfo);
					showmessage('contribution_approve_ok', $referer);
				
				} else
					showmessage('contribution_approve_fail', $referer);
			
			} else
				showmessage('contribution_approve_fail_not_select', $referer);
			
			//clearDir($TPL->cache_dir,'index.html;.htaccess') ;
			break;

		case 'callback':
				unset($_SESSION['DB_QUERY_CACHE']);
	//$db->setDebug(1);
			if(!empty($IN[multi]) && !empty($IN[pData]) ) {
				foreach($IN[pData] as $var) {
					$result = $contribution->callback($NodeInfo, $var);				
					userAdmin::Counter($var, 'CallBackNum','+',1,$NodeInfo);
					userAdmin::Counter($var, 'ContributionNum', '-',1,$NodeInfo);
					//userAdmin::Counter($var, 'NoContributionNum', '-',1);
					if(!empty($IN[callbackReason]))
						$contribution->addNote($NodeInfo, $var, $IN[callbackReason]);	
				}
				if($result)
					showmessage('contribution_callback_ok', $referer);
				else
					showmessage('contribution_callback_fail', $referer);

			} elseif(!empty($IN[ContributionID])) {
				if($contribution->callback($NodeInfo, $IN[ContributionID])) {
					userAdmin::Counter($IN[ContributionID], 'CallBackNum','+',1,$NodeInfo);
					userAdmin::Counter($IN[ContributionID], 'ContributionNum', '-',1,$NodeInfo);
					//userAdmin::Counter($IN[ContributionID], 'NoContributionNum', '-',1,$NodeInfo);
					//exit;
					if(!empty($IN[callbackReason]))
						$contribution->addNote($NodeInfo, $IN[ContributionID], $IN[callbackReason]);	

					showmessage('contribution_callback_ok', $referer);

				} else
					showmessage('contribution_callback_fail', $referer);

			}

			break;

		case 'workflow':
			unset($_SESSION['DB_QUERY_CACHE']);
			if(!empty($IN[multi]) && !empty($IN[pData]) ) {
				$OpInfo = $workflow->getRecordInfo($IN[OpID]);
				foreach($IN[pData] as $var) {
					$result = $contribution->workflow($IN[OpID], $NodeInfo, $var );				
					

					$NoteMsg = "OP: ".$OpInfo[OpName]."[{$OpInfo[OpID]}]\r\n";
					if(!empty($IN[callbackReason])) {
						$NoteMsg .= "----------------------------------\r\nNOTE: ".$IN[callbackReason];
					}
					$contribution->addNote($NodeInfo, $var, $NoteMsg);	
					
				}
				if($result)
					showMsg($OpInfo[OpName]." OK ", $referer);
				else
					showMsg($OpInfo[OpName]." Failed! ", $referer);

			} elseif(!empty($IN[ContributionID])) {
				 
				$OpInfo = $workflow->getRecordInfo($IN[OpOneID]);
				if($contribution->workflow($IN[OpOneID], $NodeInfo, $IN[ContributionID])) {
					$NoteMsg = "OP : ".$OpInfo[OpName]."[{$OpInfo[OpID]}]\r\n";
					if(!empty($IN[callbackReason])) {
						$NoteMsg .= "--------------------------------------------\r\nNOTE : ".$IN[callbackReason];
					}
					$contribution->addNote($NodeInfo, $IN[ContributionID], $NoteMsg);	

					showMsg($OpInfo[OpName]." OK ", $referer);

				} else
					showMsg($OpInfo[OpName]." Failed! ", $referer);

			} else {
				showMsg($OpInfo[OpName]." Failed! ", $referer);
		
			}

			break;
		case 'viewNote':
			$TPL->assign("NoteList", $contribution->getNoteList($NodeInfo, $IN[ContributionID]));
			$TPL->display('note_list.html');
			break;
		case 'del':
			if(!empty($IN[multi]) && !empty($IN[pData]) ) {
				foreach($IN[pData] as $var) {
					$result = $contribution->del($NodeInfo, $var);				
 				}
				if($result)
					showmessage('contribution_del_ok', $referer);
				else
					showmessage('contribution_del_fail', $referer);

			} elseif(!empty($IN[ContributionID])) {
				if($contribution->del($NodeInfo, $IN[ContributionID])) {
					showmessage('contribution_del_ok', $referer);
				} else
					showmessage('contribution_del_fail', $referer);
			} else {
				showmessage('contribution_del_fail', $referer);
			}	
			break;

	}

 
include MODULES_DIR.'footer.php' ;
?>
