<?php
class contributionUser extends iData {
	
	function move($ContributionID, $targetCateID,$CateInfo)
	{
		$this->flushData();//Disabled the record, del
		$this->addData('CateID', $targetCateID);
		if($this->contributionEdit($CateInfo,$ContributionID) )
			return true;
		else
			return false;
	
	}
	
	/**
     * Method:	拷贝实体内容到新的节点
	 * @param int $IndexID, $targetCateID
	 * @return boolean
     */
	function copyTo($IndexID, $targetCateID)
	{
		global  $iWPC,$sys;
		$contentInfo = $this->getContentInfo($IndexID);

		$CateInfo = $iWPC->loadNodeInfo($contentInfo[CateID]);
		$fieldInfo = content_table_admin::getTableFieldsInfo($CateInfo[TableID]);			

		$this->flushData();

		foreach($fieldInfo as $key=>$var) {
			$this->addData($var[FieldName], $contentInfo[$var[FieldName]]);			
		}

		$time = time();
		$this->addData('CreationDate', $time);
		$this->addData('ModifiedDate', $time);
		$this->addData('CreationUserID', $sys->session[sUId]);
		$this->addData('LastModifiedUserID', $sys->session[sUId]);

		//debug($contentInfo);
		$PublishDate =  $contentInfo[PublishDate];

		if($this->contentAdd($targetCateID,$PublishDate)) {
			return true;
		} else
			return false;
	}


	/**
     * Method:	创建虚连接索引
	 * @param int $IndexID
	 * @return boolean
     */
	function createLink($IndexID, $targetCateID)
	{
		$ContentID = $this->getIndexInfo($IndexID, 'ContentID');
		$this->flushData();
		$this->addData('ContentID', $ContentID);
		$this->addData('CateID', $targetCateID);
		$this->addData('Type', 0);
		$this->addData('PublishDate', time());

		if($this->indexAdd())
			return true;
		else
			return false;
	
	}

	/**
     * Method:	删除记录
	 * @param int $IndexID
	 * @return boolean
     */
	function del($CateInfo, $ContributionID)
	{
		global $db_config;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		$where="where ContributionID=".$ContributionID;
		$this->flushData();//Disabled the record, del
		$this->addData('State', -1);
		if($this->dataUpdate($table_name,$where)) {
			return true;
		
		} else return false;
	
	}

	function contribution($CateInfo, $ContributionID)
	{
		global $db_config,$iWPC,$IN;

		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		$where="where ContributionID=".$ContributionID;
		$this->flushData();//Disabled the record, del
		$this->addData('State', 1);
		$this->addData('ContributionDate', time());
		if($this->dataUpdate($table_name,$where)) {
			$contributionInfo = $this->getContributionInfo($CateInfo,$ContributionID);
			$NodeID = $contributionInfo['NodeID'];
			$NodeInfo = $iWPC->loadNodeInfo($NodeID);
			require_once INCLUDE_PATH."admin/workflowAdmin.class.php";
			$workflow = new workflowAdmin();
			
			$workflowRecordInfo = $workflow->getRecordInfoByStateBeforeOp($NodeInfo['WorkFlow'], 1);
			if($workflowRecordInfo['StateAfterOp'] ==2 && $workflowRecordInfo['Executor']==0) {
				$IN['NodeID'] = $NodeID;
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
				$contribution = new contributionAdmin();
				$contribution->approve($NodeInfo, $ContributionID);
			
			}

			return true;
		
		} else return false;
	
	}

	function unContribution($CateInfo, $ContributionID)
	{
		global $db_config;

		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		$where="where ContributionID=".$ContributionID;
		$this->flushData();//Disabled the record, del
		$this->addData('State', 0);
		if($this->dataUpdate($table_name,$where)) {
			return true;
		
		} else return false;
	
	}

	function recordExists($CateInfo,$fieldName, $fieldValue)
	{
		global  $db_config,$iWPC,$db;

		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];

		$sql = "SELECT $fieldName FROM $table_name WHERE $fieldName='$fieldValue'";
		$result = $db->getRow($sql);
		if(empty($result[$fieldName])) 
			return false;
		else
			return true;
	
	}

	function canContribution($CateInfo, $ContributionID)
	{
		global $db_config,$db;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		
		$sql = "SELECT State  FROM $table_name WHERE  ContributionID={$ContributionID}"	;
		$result = $db->getRow($sql);

		if($result[State] == 0 || $result[State] == 3)
			return true;
		else
			return false;

	
	}

	function canUnContribution($CateInfo, $ContributionID)
	{
		global $db_config,$db;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		
		$sql = "SELECT State  FROM $table_name WHERE  ContributionID={$ContributionID}"	;
		$result = $db->getRow($sql);

		if($result[State] == 1)
			return true;
		else
			return false;

	
	}
	/**
     * Method:	获取对应节点下的部分内容实体索引(含实体内容)列表
	 * @param int $CateID, $start, $offset
	 * @return array
     */
	function getContributionLimit($CateInfo, $start = 0, $offset = 15,  $State = '!= -1')
	{
		global $db,$db_config,$sys,$table;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;


		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];

		if(empty($CateInfo[CateID])) {
			$sql  ="SELECT c.*,s.Name FROM $table_name c left join $table->site s ON c.NodeID=s.NodeID  where  c.State{$State} AND c.OwnerID={$sys->uId} ORDER BY CreationDate DESC LIMIT $start, $offset";
		
		} else {
			$sql  ="SELECT c.*,s.Name FROM $table_name c left join $table->site s ON c.NodeID=s.NodeID  where c.CateID='{$CateInfo[CateID]}' AND c.State{$State} AND c.OwnerID={$sys->uId} ORDER BY CreationDate DESC LIMIT $start, $offset";
		
		}
		//echo $sql;

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
	 * @param int $CateID
	 * @return int
     */
	function getContributionRecordNum($CateInfo, $State = '!= -1') 
	{
		global $table,$db,$db_config,$sys;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];

		if(empty($CateInfo[CateID])) {
			$sql = "SELECT COUNT(*) as nr  FROM $table_name WHERE State{$State}  AND OwnerID={$sys->uId}"	;
	
		} else {
			$sql = "SELECT COUNT(*) as nr  FROM $table_name WHERE CateID='{$CateInfo[CateID]}'  AND State{$State}  AND OwnerID={$sys->uId}"	;
	
		}
		$result = $db->getRow($sql);

		return $result[nr];

	}

	/**
     * Method:	获取对应IndexID的内容实体索引记录
	 * @param int $CateID
	 * @return int
     */
	function getIndexInfo($IndexID, $field = '*')
	{
		global $table,$db;
		$sql = "SELECT $field  FROM $table->content_index WHERE IndexID='$IndexID'"	;
		$result = $db->getRow($sql);

		if($field != '*')
			return $result[$field];
		else
			return $result;

	
	}


	function getContributionInfo($CateInfo,$ContributionID, $field = '*')
	{
		global $table,$db,$iWPC,$db_config;

		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];

		$sql  ="SELECT $field FROM $table_name WHERE  ContributionID='$ContributionID'";
		$result = $db->getRow($sql);
		if($field == '*')
			return $result;
		else
			return $result[$field];

	}



//--------------------------
//内容模型数据库操作 添加/更新/删除
//--------------------------
	function add($CateInfo)
	{	
		global  $db_config,$iWPC;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		if($this->dataInsert($table_name)) {
			if($this->insData['State'] == 1) {
				$this->contribution($CateInfo, $this->db_insert_id);
			}
			return true;
		} else return false;
	
	}

	function contributionEdit($CateInfo,$ContributionID) 
	{
		global  $db_config,$iWPC;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$CateInfo[TableID];
		$where="where ContributionID=".$ContributionID;
		if($this->dataUpdate($table_name,$where)) {
			return true;
		
		}	else return false;

	
	}

	function getNoteList($CateInfo, $ContributionID)
	{
	
		global $db,$table,$sys;
		
		$sql  ="SELECT n.*,g.gName FROM $table->contribution_note n left join $table->user u ON n.NoteUserID=u.uId left join $table->group g ON g.gId=u.uGId  where  n.CateID='{$CateInfo[CateID]}'  AND  n.ContributionID={$ContributionID} ORDER BY n.NoteDate DESC ";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
	
	}





	function getContributionLimitByNode($NodeInfo, $start = 0, $offset = 15,  $State = '!= -1')
	{
		global $db,$db_config,$sys,$table;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;


		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];
		
		if(empty($NodeInfo[NodeID])) {
			$sql  ="SELECT c.*,s.Name FROM $table_name c left join $table->site s ON c.NodeID=s.NodeID  where  c.State{$State} AND c.OwnerID={$sys->uId} ORDER BY CreationDate DESC LIMIT $start, $offset";
		
		} else {
			$sql  ="SELECT c.*,s.Name FROM $table_name c left join $table->site s ON c.NodeID=s.NodeID  where c.NodeID='{$NodeInfo[NodeID]}' AND c.State{$State} AND c.OwnerID={$sys->uId} ORDER BY CreationDate DESC LIMIT $start, $offset";
		
		}
		//echo $sql;

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
	 * @param int $CateID
	 * @return int
     */
	function getContributionRecordNumByNode($NodeInfo, $State = '!= -1') 
	{
		global $table,$db,$db_config,$sys;
		$table_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$NodeInfo[TableID];

		if(empty($NodeInfo[NodeID])) {
			$sql = "SELECT COUNT(*) as nr  FROM $table_name WHERE  State{$State}  AND OwnerID={$sys->uId}"	;

		} else {
			$sql = "SELECT COUNT(*) as nr  FROM $table_name WHERE NodeID='{$NodeInfo[NodeID]}'  AND State{$State}  AND OwnerID={$sys->uId}"	;
		
		}
		$result = $db->getRow($sql);

		return $result[nr];

	}

}


?>