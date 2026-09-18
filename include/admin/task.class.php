<?php

class Task extends iData  {
	
	var $Tasks;
	/**
	 *刷新首页
	 */
	function refreshIndex($NodeID, $window = 'top.CrawlerTaskFrame.addThread')
	{
		$params = array('NodeID'=>$NodeID);
		Task::addTask('refreshIndex', $params, 'refreshIndex'.$NodeID, $window);
	
	}

	/**
	 *刷新附加发布
	 */
	function refreshExtra($PublishID,$NodeID, $window = 'top.CrawlerTaskFrame.addThread')
	{
	
		$params = array('NodeID'=>$NodeID, 'PublishID'=>$PublishID);
		Task::addTask('refreshExtra', $params, 'refreshExtra'.$PublishID, $window);
	
	}

	function refreshIndexTree($NodeID, $window = 'top.CrawlerTaskFrame.addThread')
	{
		global $iWPC;
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$NodeIDs = explode('%', $NodeInfo[ParentNodeID]);

		foreach($NodeIDs as $key=>$var) {
		
			Task::refreshIndex($var, $window );
		}
	
	}

	/**
	 *刷新节点下所有内容页
	 */
	function refreshContent($NodeID, $num, $window = 'top.CrawlerTaskFrame.addThread')
	{
		$params = array('NodeID'=>$NodeID, 'offset'=> $num);
		Task::addTask('refreshContent', $params, 'refreshContent'.$NodeID, $window);
	
	}

	/**
	 *发布节点下所有内容页
	 */
	function publishContent($NodeID, $num, $window = 'top.CrawlerTaskFrame.addThread')
	{
		$params = array('NodeID'=>$NodeID, 'offset'=> $num);
		Task::addTask('publishContent', $params, 'publishContent'.$NodeID, $window);
	
	}

	/**
	 *取消发布节点下所有内容页
	 */
	function unpublishContent($NodeID, $num, $window = 'top.CrawlerTaskFrame.addThread')
	{
		$params = array('NodeID'=>$NodeID, 'offset'=> $num);
		Task::addTask('unpublishContent', $params, 'unpublishContent'.$NodeID, $window);
	
	}

	function refreshSiteInit($params)
	{
		global $iWPC,$db,$table;
		extract ($params, EXTR_PREFIX_SAME, "params_");
		
		if($NodeID == 0) {
			$result = $db->Execute("select NodeID from $table->site where ParentID=0");
			$NodeIDs = array();
			while(!$result->EOF) {
				$NodeInfo = $iWPC->loadNodeInfo($result->fields[NodeID]);

				if($include_sub == 1) {
					$tmp = explode('%', $NodeInfo[SubNodeID]);
					$NodeIDs = array_merge ($NodeIDs, $tmp);
				} else {
					$NodeIDs[] = $NodeID;
				}
				$result->MoveNext();		
			}
		} else {
		
			$NodeInfo = $iWPC->loadNodeInfo($NodeID);
			//得到待更新的节点id数组
			if($include_sub == 1) {
				$NodeIDs = explode('%', $NodeInfo[SubNodeID]);
			} else {
				$NodeIDs[] = $NodeID;
			}		
		}



		//初始化待刷新首页任务列表
		if($refresh_index == 1) {
			foreach($NodeIDs as $var) {
				$Tasks[] = array(
							'type' => 'index',
							'targetId' => $var,							
						);
			
			}
		}

		//初始化待刷新内容页任务列表

		if($refresh_content == 1) {
			foreach($NodeIDs as $var) {
				$Tasks[] = array(
							'type' => 'content',
							'targetId' => $var,							
						);
			}
		}

		if($refresh_extra == 1) {
			$extrapublish = new extra_publish_admin();
			foreach($NodeIDs as $var) {
				$extraPublishList = $extrapublish->getAll($var);
				if(!empty($extraPublishList)) {
					foreach($extraPublishList as $varIn) {
						$Tasks[] = array(
									'type' => 'extra',
									'targetId' => $var,	
									'publishId'=> $varIn['PublishID'],
								);				
					}				
				}


			}
		}

		return $Tasks;
	
	}



	//批量发布初始化
	function publishSiteInit($params)
	{
		global $iWPC,$db,$table;
		extract ($params, EXTR_PREFIX_SAME, "params_");
		
		if($NodeID == 0) {
			$result = $db->Execute("select NodeID from $table->site where ParentID=0");
			$NodeIDs = array();
			while(!$result->EOF) {
				$NodeInfo = $iWPC->loadNodeInfo($result->fields[NodeID]);

				if($include_sub == 1) {
					$tmp = explode('%', $NodeInfo[SubNodeID]);
					$NodeIDs = array_merge ($NodeIDs, $tmp);
				} else {
					$NodeIDs[] = $NodeID;
				}
				$result->MoveNext();		
			}
		} else {
		
			$NodeInfo = $iWPC->loadNodeInfo($NodeID);
			//得到待更新的节点id数组
			if($include_sub == 1) {
				$NodeIDs = explode('%', $NodeInfo[SubNodeID]);
			} else {
				$NodeIDs[] = $NodeID;
			}		
		}




		//初始化待刷新内容页任务列表

		
			foreach($NodeIDs as $var) {
				$Tasks[] = array(
							'type' => 'content',
							'targetId' => $var,							
						);
			}
		



		return $Tasks;
	
	}




	/**
	 *使用js添加一个任务iframe窗口
	 */
	function addTask($action, $params, $taskID, $window = 'top.CrawlerTaskFrame.addThread')
	{
		global $sys;
		foreach($params as $key=>$var) {
			$query .= "&{$key}={$var}";
		}
		

		echo "<script language='JavaScript'>\n";
		echo $window."(\"admin_task.php?sId=".$sys->session['sId']."&o=".$action."&mode=running&TaskID=".$taskID.$query."\" , \"".$taskID."\");\n";
		echo "</script>";
		//exit;
		


	
	}

	/**
	 *添加任务执行信息到系统状态窗口
	 */
	function addTaskInfo($info,$taskID)
	{
		echo "<script language='JavaScript'>\n";
		echo "top.TaskInfoFrame.addInfo(\"".addslashes($info)."\", '".$taskID."')\n";
		echo "</script>";
	
	}

	/**
	 *关闭iframe任务窗口
	 */
	function endTask($taskID)
	{
		exit("<script language='JavaScript'>parent.endThread('".$taskID."');</script>");
	
	}

	function taskSessionAdd()
	{
		global  $db,$table;
		if($this->dataInsert($table->tasks)) {
			return true;
		} else return false;

	
	}

	function taskSessionGet($TaskID)
	{
		global  $db,$table;
		$result = $db->getRow("SELECT TaskData FROM $table->tasks WHERE TaskID='".$TaskID."'");
		
		return 	unserialize(stripslashes($result['TaskData']));
		
	}

	function taskSessionUpdate($TaskID)
	{
		global  $db,$table;
		$where="where TaskID='".$TaskID."'";
		if($this->dataUpdate($table->tasks,$where)) {
			return true;
		
		}	else return false;
	
	}

	function taskSessionEnd($TaskID)
	{
		global  $db,$table;
		return $db->query("DELETE FROM $table->tasks WHERE TaskID='".$TaskID."'");
	}

}
?>