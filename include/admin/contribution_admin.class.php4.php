<?php
class contributionAdmin extends iData {

	function approve($NodeInfo, $ContributionID)
	{
		global $db_config, $sys,$IN;
		require_once INCLUDE_PATH."admin/publishAdmin.class.php";
		$publish = new publishAdmin();

		$contentInfo = $this->getContributionInfo($NodeInfo,$ContributionID);
		$fieldInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);			

		$publish->flushData();

		foreach($fieldInfo as $key=>$var) {
			$publish->addData($var[FieldName], $contentInfo[$var[FieldName]]);			
		}

		$time = time();
		$publish->addData('CreationDate', $time);
		$publish->addData('ModifiedDate', $time);
		$publish->addData('CreationUserID', $sys->session[sUId]);
		$publish->addData('LastModifiedUserID', $sys->session[sUId]);
		$publish->addData('ContributionUserID', $contentInfo[OwnerID]);
		$publish->addData('ContributionID', $ContributionID);
		//debug($contentInfo);
		$IndexInfo[PublishDate] = $time;
		$IN['NodeID'] = $NodeInfo['NodeID'];
	
		if($publish->contentAdd($contentInfo[NodeID], $IndexInfo)) {

			$SubNodeIDs = explode(',', $contentInfo[SubNodeID]);
			$IndexID = $publish->db_insert_id;
			if(!empty($SubNodeIDs[0])) {
				foreach($SubNodeIDs as $key=>$var) {
					$publish->createLink($IndexID , $var);
			
				}
			}

			$IndexNodeIDs = explode(',', $contentInfo[IndexNodeID]);

			if(!empty($IndexNodeIDs[0])) {
				foreach($IndexNodeIDs as $key=>$var) {
					$publish->createIndexLink($IndexID , $var);
			
				}
			}

			$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
			$where="where ContributionID=".$ContributionID;
			$this->flushData();//Disabled the record, del
			$this->addData('State', 2);
			$this->addData('ContributionDate', time());
			if($this->dataUpdate($table_name,$where)) {
				return true;
			
			} else return false;


		} 


	
	}

	function isValid()
	{
		require(SYS_PATH.'/license.php');
		$license_array = $License;
		unset($License);
		if($license_array['Module-Contribution']!=1)
			goback('license_Module_Contribution_disabled');
	
	}

	function del($NodeInfo, $ContributionID)
	{
		global $table, $db_config;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		$which="ContributionID";
		
		if($this->dataDel($table_name,$which, $ContributionID,$method="="))
			return true;
		else return false;
	
	}

	function callback($NodeInfo, $ContributionID)
	{
		global $db_config;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		$where="where ContributionID=".$ContributionID;
		$this->flushData();
		$this->addData('State', 3);
		if($this->dataUpdate($table_name,$where)) {
			return true;
		
		} else return false;
	
	}

	function addNote($NodeInfo, $ContributionID, $callbackReason)
	{
		global $db_config,$sys,$table;
		$cInfo = $this->getContributionInfo($NodeInfo,$ContributionID);
		$this->flushData();
		$this->addData('ContributionID', $ContributionID);
		$this->addData('CateID', $cInfo[CateID]);
		$this->addData('Note', $callbackReason);
		$this->addData('NoteUserID', $sys->uId);
		$this->addData('NoteUserName', $sys->uName);
		$this->addData('NoteDate', time());
		if($this->dataInsert($table->contribution_note))
			return true;
		else return false;	
	
	
	}
	/**
     * Method:	获取对应节点下的部分内容实体索引(含实体内容)列表
	 * @param int $NodeID, $start, $offset
	 * @return array
     */
	function getContributionLimit($NodeInfo, $start = 0, $offset = 15,  $State = '!= -1')
	{
		global $db,$db_config,$sys,$table;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;

		//echo $State;exit;
		if(strpos($State, ',')) {
			$State = " IN ($State)";
		} elseif($State != '!= -1' && !empty($State)) {
			$State = "=$State";
		
		} elseif(empty($State)) return false;


		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		$SubNodeID = str_replace("%", ",", $NodeInfo['SubNodeID']);
		
		if(empty($SubNodeID))	return false;

		$sql  ="SELECT t.*,u.uName as OwnerName,s.Name as NodeName,w.Name as StateName FROM $table_name t left join $table->site s ON s.NodeID=t.NodeID left join $table->user u ON t.OwnerID=u.uId left join $table->workflow_state w ON t.State=w.State where t.NodeID IN($SubNodeID) AND t.State{$State}  ORDER BY t.CreationDate DESC LIMIT $start, $offset";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
		
	}

	/**
     * Method:	获取对应节点下的内容实体索引数量值
	 * @param int $NodeID
	 * @return int
     */
	function getContributionRecordNum($NodeInfo, $State = '!= -1') 
	{
		global $table,$db,$db_config,$sys;
		if(empty($NodeInfo[TableID])) return 0;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		
		$SubNodeID = str_replace("%", ",", $NodeInfo['SubNodeID']);
		if(strpos($State, ',')) {
			$State = " IN ($State)";
		} elseif($State != '!= -1' && !empty($State)) {
			$State = "=$State";
		
		} elseif(empty($State)) return false;

		if(empty($SubNodeID)) return false;
		$sql = "SELECT COUNT(*) as nr  FROM $table_name WHERE NodeID IN($SubNodeID)  AND State{$State}"	;
		$result = $db->getRow($sql, 3);

		return $result[nr];

	}

	
	function getPublishRecordNum($NodeInfo, $State = '!= -1')
	{
		global $table,$db,$db_config,$sys;
		
		$SubNodeID = str_replace("%", ",", $NodeInfo['SubNodeID']);

		if(empty($SubNodeID)) return false;
		$sql = "SELECT COUNT(*) as nr  FROM $table->content_index WHERE NodeID IN($SubNodeID)  AND State{$State}"	;
		$result = $db->getRow($sql,3);

		return $result[nr];
	
	}


	function getContributionInfo($NodeInfo,$ContributionID)
	{
		global $table,$db,$iWPC,$db_config;
		if(empty($NodeInfo[TableID])) return false;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];


		$sql  ="SELECT t.*,u.uName as OwnerName FROM $table_name t left join $table->user u ON  u.uId=t.OwnerID WHERE   ContributionID='$ContributionID' ";
		$result = $db->getRow($sql);

		return $result;
	}




	function contributionEdit($NodeInfo,$ContributionID) 
	{
		global  $db_config,$iWPC;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		$where="where ContributionID=".$ContributionID;
		if($this->dataUpdate($table_name,$where)) {
			return true;
		
		}	else return false;

	
	}


	function workflow($OpID, $NodeInfo, $ContributionID)
	{
		global  $db,$table,$db_config,$workflow,$_LANG_ADMIN, $site;
		
		if(!isset($workflow)) {
			require_once INCLUDE_PATH."admin/workflowAdmin.class.php";
			$workflow = new workflowAdmin();
		}

		$OpInfo = $workflow->getRecordInfo($OpID);

		if($OpInfo[StateAfterOp] == 2) {
			if(!isset($site)) {
				require_once INCLUDE_PATH."admin/site_admin.class.php";
				$site = new site_admin();	
			}
			//Access Detector
 			if(!$site->canAccess($NodeInfo, "Approve") ) {
				goback(sprintf($_LANG_ADMIN['site_permission_deny_approve'], $NodeInfo['Name']) ,1);
			}
		
		}


		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		$sql="update $table_name set State='{$OpInfo[StateAfterOp]}' where ContributionID='$ContributionID'";

		$result = $db->query($sql);

		if($result) {
			if($OpInfo[StateAfterOp] == 2) {
				if($this->approve($NodeInfo, $ContributionID)) {
					userAdmin::Counter($ContributionID, 'ApproveNum','+',1,$NodeInfo);
					userAdmin::Counter($ContributionID, 'ContributionNum','-',1,$NodeInfo);
					return true;
				
				} else return false;
			} elseif($OpInfo[StateAfterOp] == 3) {
					userAdmin::Counter($ContributionID, 'CallBackNum','+',1,$NodeInfo);
					userAdmin::Counter($ContributionID, 'ContributionNum', '-',1,$NodeInfo);
					return true;
			} else return true;
		} else return false;





	}

	function getNoteList($NodeInfo, $ContributionID)
	{
	
		global $db,$table,$sys;
		$sql  ="SELECT n.*,g.gName FROM $table->contribution_note n left join $table->user u ON n.NoteUserID=u.uId left join $table->group g ON g.gId=u.uGId  where  n.ContributionID={$ContributionID} ORDER BY n.NoteDate DESC ";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
	
	}

}


?>