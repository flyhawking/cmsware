<?php
class publishAdmin extends iData  {
	

	function publishAdmin()
	{
		global $_BeanFactory;
		
		if(!isset($_BeanFactory)) {
			
			require_once LIB_PATH."Spring.php";
			$_BeanFactory = new Spring("spring.appcontext.php");
			//print_r($_BeanFactory->appcontext);
			$this->beanFactory = &$_BeanFactory;
		} else	$this->beanFactory = &$_BeanFactory;
	}

	/**
     * Method:	添加索引记录
	 * @param int $NodeID, int $PublishDate, int $Type
	 * $Type=0 虚连接,$Type=1 实连接
	 * @return boolean
     */
	function indexAdd() {
		global $table;
		if($this->dataInsert($table->content_index)) {	
			return true;
		} else 
			return false;
				
	}
	function indexEdit($IndexID)
	{
		global $table;
		$where="where IndexID=".$IndexID;
		if($this->dataUpdate($table->content_index,$where)) {
			return true;
		
		}	else return false;
	
	}
	
	/**
	 * 判断对应节点是否存在$IndexID=?的实链接的虚链接
	 *
	 */
	function linkExists($ContentID, $NodeID)
	{
		global $table,$db;
		$result = $db->getRow("select IndexID from $table->content_index where NodeID='$NodeID' AND ContentID='$ContentID' and Type=0 and State!='-1'" );
		if(empty($result[IndexID]))
			return false;
		else
			return true;
		
	}


	function getResyncIndexLimit($NodeID, $start = 0, $offset = 15,  $State = '!= -1', $Type = '')
	{
		global $table,$db,$iWPC,$db_config;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;

		if(!empty($Type)) $Type = "AND i.Type=$Type";
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);

		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
		
		$sql  ="SELECT i2.NodeID,i2.ContentID,i.State,i.Top,i.Pink,i.Sort,i2.URL,i.IndexID,i.PublishDate,i.Type,c.*,u.uName as CreationUser FROM $table->content_index i,$table->content_index i2 ,$table_name c,$table->site s Left Join $table->user u ON u.uId=c.CreationUserID where i.NodeID='$NodeID' AND i.ParentIndexID=i2.IndexID AND i.ContentID =c.ContentID AND s.NodeID='$NodeID' AND i.State{$State} $Type   ORDER BY i.Top , i.Sort  , i.PublishDate   LIMIT $start, $offset";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
		
	}


	function restore($IndexID)
	{
		$this->flushData();//Disabled the record, del
		$this->addData('State', 0);
		if($this->indexEdit($IndexID))
			return true;
		else
			return false;	
	}

	function destroy($IndexID)
	{
		global $table,$iWPC,$db_config,$db;
		if(empty($IndexID)) return false;
		$this->unpublish($IndexID);
		$IndexInfo = $this->getIndexInfo($IndexID);
		//print_r($IndexInfo);exit;
		if($IndexInfo['Type'] == 1 || $IndexInfo['Type'] == 3 || $IndexInfo['Type'] == 4) {
			//$this->dataDel($table->content_index, 'ContentID', $IndexInfo['ContentID'], "="); //del all Index Record
			if($IndexInfo['Type'] == 1) {
 				$result = $db->Execute("select IndexID from $table->content_index where IndexID !='{$IndexID}' AND ContentID='{$IndexInfo['ContentID']}' AND TableID='{$IndexInfo['TableID']}'");
				while(!$result->EOF) {
					$this->destroy($result->fields['IndexID']);
					$result->MoveNext();
				}
			}
			$this->dataDel($table->content_index, 'ParentIndexID', $IndexInfo['IndexID'], "="); 
			$this->destoryResource($IndexID);
			$NodeInfo = $iWPC->loadNodeInfo($IndexInfo[NodeID]);
			$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
			return $this->dataDel($table_name, 'ContentID', $IndexInfo['ContentID'], "="); //del Content Record
		} else { //if Type is not 1/3/4 ,then del only the index
			$this->destoryResource($IndexID);
			return $this->dataDel($table->content_index, 'IndexID', $IndexID, "=");
	
		}
	}

	function destoryResource($IndexID)
	{
		global $table,$db,$iWPC,$db_config,$SYS_ENV;
		$result = $db->Execute("SELECT * FROM $table->resource_ref	WHERE IndexID='$IndexID'");
		while(!$result->EOF) {
			$num_result = $db->getRow("SELECT COUNT(*) as nr FROM $table->resource_ref  WHERE ResourceID='{$result->fields[ResourceID]}'");
			if($num_result[nr] == 1) {
				$resource_result = $db->getRow("SELECT Path FROM $table->resource  WHERE ResourceID='{$result->fields[ResourceID]}'");
				if(file_exists($SYS_ENV['ResourcePath'].'/'.$resource_result[Path])) {
					echo "Delete ".$SYS_ENV['ResourcePath'].'/'.$resource_result[Path]." ...<br/>";
					unlink($SYS_ENV['ResourcePath'].'/'.$resource_result[Path]);
			
				}
				$db->query("DELETE FROM $table->resource WHERE ResourceID='{$result->fields[ResourceID]}'");
			}  
			$result->MoveNext();
		}
		
		$db->query("DELETE FROM $table->resource_ref	WHERE IndexID='$IndexID'");

	}

	function empty_recycle_bin($NodeID)
	{
		global $table,$iWPC,$db_config;
		$list = $this->getAllIndex($NodeID, '=-1', 'IndexID,NodeID,ContentID,Type');
		//debug($list);
		if(!empty($list)) {
			foreach($list as $key=>$var) {
				if($var['Type'] == 1 || $var['Type'] == 3 || $var['Type'] == 4) {
					$this->dataDel($table->content_index, 'ParentIndexID', $var['IndexID'], "="); 
					$this->destoryResource($var['IndexID']);

					$NodeInfo = $iWPC->loadNodeInfo($var[NodeID]);
					$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
					$result =  $this->dataDel($table_name, 'ContentID', $var['ContentID'], "="); 
				} else {
					$result =  $this->dataDel($table->content_index, 'IndexID', $var['IndexID'], "=");
			
				}
				
			}
			if($result)
				return true;
			else
				return false;
		
		} else
			return true;

	}

	function getResourceInfo($IndexID, $Category)
	{
		global $table,$db,$iWPC,$db_config;
		$sql = "select   * from $table->resource_ref ref ,$table->resource r where ref.ResourceID=r.ResourceID and ref.IndexID='$IndexID' and r.Category='$Category'";
		//echo $sql;
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;

	}


	function getAllIndex($NodeID, $State, $field = '*')
	{
		global $table,$db,$iWPC,$db_config;
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];

		$sql  ="SELECT $field FROM $table->content_index  where State{$State} ";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
	
	}

	function getLinkState($IndexID)
	{
		global $table,$iWPC,$db;


		$result = $this->getContentInfo($IndexID);
		$LinkState['self'] = $result;

		$sql = "SELECT IndexID,NodeID  FROM $table->content_index WHERE ContentID='{$result[ContentID]}' AND Type=1  AND State!=-1";
		$result_solid = $db->getRow($sql);
		$NodeInfo = $iWPC->loadNodeInfo($result_solid[NodeID]);

		$LinkState['solid'] = array(
								'Name'=> $NodeInfo['Name'],
								'NodeID'=> $NodeInfo['NodeID'],
								'IndexID'=> $result_solid['IndexID'],
							  );
		
		$sql = "SELECT IndexID,NodeID  FROM $table->content_index WHERE ContentID='{$result[ContentID]}' AND Type=0 AND State!=-1";
		$result_void = $db->Execute($sql);
		while(!$result_void->EOF) {
				
			$NodeInfo = $iWPC->loadNodeInfo($result_void->fields[NodeID]);
			$LinkState['void'][] = array(
									'Name'=> $NodeInfo['Name'],
									'NodeID'=> $NodeInfo['NodeID'],
									'IndexID'=> $result_void->fields['IndexID'],
									);

			$result_void->MoveNext();
		}

		$sql = "SELECT IndexID,ParentIndexID,NodeID  FROM $table->content_index WHERE ContentID='{$result[ContentID]}' AND Type=2  AND State!=-1";
		$result_index = $db->Execute($sql);
		while(!$result_index->EOF) {
				
			$NodeInfo = $iWPC->loadNodeInfo($result_index->fields[NodeID]);
			$LinkState['index'][] = array(
									'Name'=> $NodeInfo['Name'],
									'NodeID'=> $NodeInfo['NodeID'],
									'IndexID'=> $result_index->fields['IndexID'],
									);

			$result_index->MoveNext();
		}

		return $LinkState;

	}

	function top($IndexID, $Num)
	{
		$this->flushData();//Disabled the record, del
		$this->addData('Top', $Num);
		if($this->indexEdit($IndexID))
			return true;
		else
			return false;
	}



	function pink($IndexID, $Num)
	{
		$this->flushData();//Disabled the record, del
		$this->addData('Pink', $Num);
		if($this->indexEdit($IndexID))
			return true;
		else
			return false;
	}

	function sortIt($IndexID, $Num)
	{
		$this->flushData();//Disabled the record, del
		$this->addData('Sort', $Num);
		if($this->indexEdit($IndexID))
			return true;
		else
			return false;
	}

	/**
     * Method:	修改索引所属节点
	 * @param int $IndexID, $targetNodeID
	 * @return boolean
     */
	function move($IndexID, $targetNodeID)
	{
		$this->unpublish($IndexID, 0);
		$this->flushData();//Disabled the record, del
		$this->addData('NodeID', $targetNodeID);
			
		if($this->indexEdit($IndexID))
			return true;
		else
			return false;
	
	}
	
	/**
     * Method:	拷贝实体内容到新的节点
	 * @param int $IndexID, $targetNodeID
	 * @return boolean
     */
	function copyTo($IndexID, $targetNodeID)
	{
		global  $iWPC,$sys;
		$contentInfo = $this->getContentInfo($IndexID);

		$NodeInfo = $iWPC->loadNodeInfo($contentInfo[NodeID]);
		$fieldInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);			

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
		 
		$Info[PublishDate] = $contentInfo[PublishDate];
		if($this->contentAdd($targetNodeID,$Info)) {
			return true;
		} else
			return false;
	}


	/**
     * Method:	创建虚连接 
	 * @param int $IndexID
	 * @return boolean
     */
	function createLink($IndexID, $targetNodeID)
	{
		global $iWPC;
		$IndexInfo = $this->getIndexInfo($IndexID);
		$this->flushData();
		$this->addData('ContentID', $IndexInfo[ContentID]);
		$this->addData('NodeID', $targetNodeID);
		$this->addData('TableID', $IndexInfo[TableID]);
		$this->addData('Type', 0);
		$this->addData('PublishDate', time());

		if($this->indexAdd()) {
			$IndexID = $this->db_insert_id;
			$this->flushData();
			$this->addData('ParentIndexID', $IndexID);
			if($this->indexEdit($IndexID)) {
				$NodeInfo = $iWPC->loadNodeInfo($targetNodeID);
				if($NodeInfo[AutoPublish] == 1)
					$this->publish($IndexID);

				return true;
			} else
				return false;		
		} else
			return false;
	
	}

	/**
     * Method:	创建索引连接,用于专题
	 * @param int $IndexID
	 * @return boolean
     */
	function createIndexLink($IndexID, $targetNodeID)
	{
		global  $iWPC;
		$IndexInfo = $this->getIndexInfo($IndexID);
		$this->flushData();
		$this->addData('ParentIndexID', $IndexID);
		$this->addData('ContentID', $IndexInfo[ContentID]);
		$this->addData('NodeID', $targetNodeID);
		$this->addData('TableID', $IndexInfo[TableID]);
		$this->addData('Type', 2);
		$this->addData('PublishDate', time());

		if($this->indexAdd()) {
			$NodeInfo = $iWPC->loadNodeInfo($targetNodeID);
			if($NodeInfo[AutoPublish] == 1)
				$this->publish($this->db_insert_id);
			
 			return true;
	
		} else
			return false;
	
	}

	/**
     * Method:	删除索引记录
	 * @param int $IndexID
	 * @return boolean
     */
	function indexDel($IndexID)
	{
		global $table,$db;
		$this->unpublish($IndexID);
		//exit(1);
		$IndexInfo = $this->getIndexInfo($IndexID);

		$where="where IndexID=".$IndexID;
		$this->flushData();//Disabled the record, del
		$this->addData('State', -1);
		if($this->dataUpdate($table->content_index,$where)) {
			//$this->clearPublishedItem($IndexID);
			/*$ContentID = $this->getIndexInfo($IndexID,'ContentID');
			if(!$this->haveLink($ContentID)) {
		
				$this->flushData();//Disabled the record, del
				$this->addData('Disabled', 1);
				if($this->mDocUpdate($ContentID))
					return true;
				else
					return false;
			
			} else*/

			if($IndexInfo['Type'] == 1) {
				$result = $db->Execute("select IndexID from $table->content_index where IndexID !='{$IndexID}' AND ContentID='{$IndexInfo['ContentID']}' AND TableID='{$IndexInfo['TableID']}'");
				while(!$result->EOF) {
					//echo "<br>IndexID:".$result->fields['IndexID'];
					$this->indexDel($result->fields['IndexID']);
					$result->MoveNext();
				}
			}

			unset($IndexInfo);
			unset($result);


			return true;
		
		} else return false;
	
	}

	/**
     * Method:	检测内容实体是否有实/虚连接索引
	 * @param int $ContentID
	 * @return boolean
     */
	function contentHaveIndex($ContentID)
	{
		global $table,$db;

		$sql  ="SELECT count(*) as nr FROM $table->content_index  WHERE ContentID='$ContentID' ";

		$result = $db->getRow($sql);

		if($result[nr]>0) return true;
		else return false;
	
	}

	/**
     * Method:	获取对应节点下的部分内容实体索引(含实体内容)列表
	 * @param int $NodeID, $start, $offset
	 * @return array
     */
	function getIndexLimit($NodeID, $start = 0, $offset = 15,  $State = '!= -1', $Type = '')
	{
		global $table,$db,$iWPC,$db_config;
		site_admin::isValid();
		content_table_admin::isValid();
		psn_admin::isValid();
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;

		if(!empty($Type)) {
			$pos = strpos($Type, "=");
			if($pos === false) {
				$Type = "AND i.Type=$Type";
			
			} else {
				$Type = "AND i.Type $Type";
			
			}
		}
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		if(empty($NodeInfo[TableID])) return false;
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
		
		/***新增OAS User支持***/
		if($NodeInfo['NodeType'] == 3 ) {
			$table_user = $db_config['table_pre'].'plugin_oas_user';
			$sql  ="SELECT i2.NodeID,i2.ContentID,i.State,i.Top,i.Pink,i.Sort,i2.URL,i.IndexID,i.PublishDate,i.Type,c.*,u.UserName as CreationUser FROM $table->content_index i LEFT JOIN $table->content_index i2 ON  i2.IndexID=i.ParentIndexID   LEFT JOIN $table_name c ON c.ContentID =i.ContentID  LEFT JOIN $table->site s ON s.NodeID='$NodeID' Left Join $table_user u ON u.UserID=c.CreationUserID where i.NodeID='$NodeID' AND i.State{$State} $Type   ORDER BY i.NodeID DESC,i.State DESC,i.Top DESC, i.PublishDate DESC, i.Sort DESC LIMIT $start, $offset";

		} else {
			$sql  ="SELECT i2.NodeID,i2.ContentID,i.State,i.Top,i.Pink,i.Sort,i2.URL,i.IndexID,i.PublishDate,i.Type,c.*,u.uName as CreationUser FROM $table->content_index i LEFT JOIN $table->content_index i2 ON  i2.IndexID=i.ParentIndexID   LEFT JOIN $table_name c ON c.ContentID =i.ContentID  LEFT JOIN $table->site s ON s.NodeID='$NodeID' Left Join $table->user u ON u.uId=c.CreationUserID where i.NodeID='$NodeID' AND i.State{$State} $Type   ORDER BY i.NodeID DESC,i.State DESC,i.Top DESC, i.PublishDate DESC, i.Sort DESC LIMIT $start, $offset";

		}
		/***新增OAS User支持***/

 
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
	function getIndexRecordNum($NodeID, $State = '!= -1', $Type = '') 
	{
		global $table,$db;
		if(!empty($Type)) $Type = "AND Type=$Type";
		$sql = "SELECT COUNT(*) as nr  FROM $table->content_index WHERE NodeID='$NodeID'  AND State{$State} $Type "	;
		//$result = $db->getRow($sql, 2, 300);
		$result = $db->getRow($sql);

		return $result[nr];

	}

	/**
     * Method:	获取对应IndexID的内容实体索引记录
	 * @param int $NodeID
	 * @return int
     */
	function getIndexInfo($IndexID, $field = '*')
	{
		global $table,$db;
		if(isset($GLOBALS["Cache_IndexInfo"][$IndexID])) {
			if($field != '*')
				return $GLOBALS["Cache_IndexInfo"][$IndexID][$field];
			else
				return $GLOBALS["Cache_IndexInfo"][$IndexID];
			
		} else {
			$sql = "SELECT $field  FROM $table->content_index WHERE IndexID='$IndexID'"	;
			$result = $db->getRow($sql);
			if($field != '*') {
				return $result[$field];

			} else {
				$GLOBALS["Cache_IndexInfo"][$IndexID] = $result;
				return $result;		
		
			}
		
		}


	
	}


	/**
     * Method:	获取对应IndexID的内容实体记录
	 * @param int $IndexID
	 * @return int
     */
	function getContentInfo($IndexID)
	{
		global $table,$db,$iWPC,$db_config;
		//$sql  ="SELECT ContentID,NodeID FROM $table->content_index  WHERE IndexID='$IndexID'";
		if(isset($GLOBALS["Cache_ContentInfo"][$IndexID])) {
			return $GLOBALS["Cache_ContentInfo"][$IndexID];
		} else { 
			$result = $this->getIndexInfo($IndexID);
			
			$NodeInfo = $iWPC->loadNodeInfo($result[NodeID]);
			if(empty($NodeInfo[TableID])) return false;
			$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];

			//$sql  ="SELECT i.*,c.* FROM $table->content_index i ,$table_name c WHERE i.ContentID='{$result[ContentID]}' AND c.ContentID = i.ContentID AND i.IndexID='$IndexID'";
			$sql  ="SELECT i2.NodeID,i2.ContentID,i2.State,i2.Top,i2.Pink,i2.Sort,i2.URL,i2.SelfTemplate ,i2.SelfPSN,i2.SelfURL,i2.SelfPSNURL,i2.SelfPublishFileName,i.IndexID,i.PublishDate,i.Type,c.*,u.uName as CreationUser FROM $table->content_index i LEFT JOIN $table->content_index i2 ON  i2.IndexID=i.ParentIndexID   LEFT JOIN $table_name c ON   c.ContentID = i.ContentID LEFT JOIN $table->site s ON s.NodeID='{$result[NodeID]}' LEFT JOIN $table->user u ON u.uId=c.CreationUserID where i.NodeID='{$result[NodeID]}'   AND i.IndexID='$IndexID'";

			$result = $db->getRow($sql);
			$result['TableID'] = $NodeInfo[TableID];
			//$result['NodeInfo'] = $NodeInfo;
			$GLOBALS["Cache_ContentInfo"][$IndexID] = $result ;
			
			return $result;
		
		
		}		

	}

	function getPublishInfo($IndexID)
	{
		global $table,$db,$iWPC,$db_config;
		//$sql  ="SELECT ContentID,NodeID FROM $table->content_index  WHERE IndexID='$IndexID'";
		if(isset($GLOBALS["Cache_ContentInfo"][$IndexID])) {
			return $GLOBALS["Cache_ContentInfo"][$IndexID];
		} else { 
			$result = $this->getIndexInfo($IndexID);

			$NodeInfo = $iWPC->loadNodeInfo($result[NodeID]);

			$table_publish = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$NodeInfo[TableID];
			$table_content = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
			$plugin_table['oas']['user'] = $db_config['table_pre'].'plugin_oas_user';

			/*******新增OAS支持*******/
			if($NodeInfo['NodeType'] == 3) {
				$sql = "SELECT p.*,u.UserName as CreationUserName,u.UserID as CreationUserID from $table_publish p, $table_content c, {$plugin_table['oas']['user']} u  where p.IndexID='$IndexID' AND c.ContentID=p.ContentID AND c.CreationUserID=u.UserID";
			} else {
				$sql  ="SELECT * from $table_publish where IndexID='$IndexID'";
			}
			/*******新增OAS支持*******/
		 

			$result = $db->getRow($sql);
			//$GLOBALS["Cache_ContentInfo"][$IndexID] = $result ;
			

			 
			return $result;
		
		
		}		

	}

	/**
     * Method:	轻量级的getInfo、只获取标题字段和URL
	 * @param int $IndexID
	 * @return int
     */
	function editor_getContentInfo($IndexID)
	{
		global $table,$db,$iWPC,$db_config,$CONTENT_MODEL_INFO;
		$sql  ="SELECT ContentID,NodeID FROM $table->content_index  WHERE IndexID='$IndexID'";
		
		$result = $db->getRow($sql);

		$NodeInfo = $iWPC->loadNodeInfo($result[NodeID]);
		$TableID = &$NodeInfo[TableID];
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$TableID;

		$TitleField = $CONTENT_MODEL_INFO[$TableID]['TitleField'];

		$sql  ="SELECT i.IndexID, i.URL,c.{$TitleField} FROM $table->content_index i, $table_name c where i.ContentID =c.ContentID  AND i.IndexID='$IndexID'";

		$result = $db->getRow($sql);
 		$result[TableID] = $TableID;

		


		return $result;
	
	}

	function getUnPublishLimit($NodeID, $start, $offset)
	{
		global $db,$table;
		$sql  ="SELECT IndexID From $table->content_index  WHERE State=0 AND NodeID={$NodeID} LIMIT $start, $offset";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}

		return $data;		
	}

	function getPublishLimit($NodeID, $start, $offset)
	{
		global $db,$table;
		$sql  ="SELECT IndexID From $table->content_index  WHERE State=1 AND NodeID={$NodeID} LIMIT $start, $offset";

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}

		return $data;		
	}

//--------------------------
//内容模型数据库操作 添加/更新/删除
//--------------------------

	function IsRecordExists($params)
	{
		global  $db_config,$iWPC,$db,$table;

		$NodeInfo = $iWPC->loadNodeInfo($params[NodeID]);
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
		
		if($params[o] == 'add') {
			$sql = "SELECT t.$params[FieldName] FROM $table_name t, $table->content_index i WHERE t.{$params[FieldName]}='{$params[FieldValue]}' AND i.NodeID={$params[NodeID]} AND i.ContentID=t.ContentID AND i.State!=-1";
		
		} elseif($params[o] == 'edit') {
			$sql = "SELECT t.$params[FieldName],t.ContentID as tContentID,i.* FROM $table_name t, $table->content_index i WHERE t.{$params[FieldName]}='{$params[FieldValue]}'  AND i.ContentID=t.ContentID AND i.IndexID!={$params[IndexID]} AND i.NodeID={$params[NodeID]} AND i.State!=-1";
		
		}

		//echo $sql;



		$result = $db->getRow($sql);
		//print_r($result);
		if(empty($result[$params['FieldName']])) 
			return false;
		else
			return true;
	
	}

	function contentAdd($NodeID,$IndexInfo)
	{	
		global  $db_config,$iWPC,$IN;
		$PublishDate = empty($IndexInfo[PublishDate]) ? time() : $IndexInfo[PublishDate];
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
		//$this->debugData();
		if($this->dataInsert($table_name)) {
				$this->flushData();
				$this->addData('ContentID', $this->db_insert_id);
				$this->addData('NodeID', $NodeID);
				$this->addData('PublishDate', $PublishDate);
				$this->addData('Type', 1);
				$this->addData('TableID', $NodeInfo[TableID]);
				//$this->addData($IndexInfo);
				/*if(!empty($IndexInfo[SelfURL])) {
					print_r($IndexInfo);exit;
					$this->addData('URL', $IndexInfo[SelfURL]);
					$this->addData('Type', 4);
				
				} else {
					$this->addData('Type', 1);
			
				}*/

				//$this->debugData();
				if($this->indexAdd()) {
					$IndexID = $this->db_insert_id;
  					$IN['IndexID'] = $IndexID;
					$this->flushData();
					$this->addData('ParentIndexID', $IndexID);
					$this->addData($IndexInfo);
					if(!empty($IndexInfo[SelfURL])) {
						$this->addData('URL', $IndexInfo[SelfURL]);
						$this->addData('Type', 4);
						
					} else {
						$this->addData('Type', 1);
					
					}
					
					$this->delData("SubTargetNodeID");
					$this->delData("IndexTargetNodeID");

					$this->indexEdit($IndexID);
					$db_insert_id = $this->db_insert_id;

					if($NodeInfo[AutoPublish] == 1)
						$this->publish($this->db_insert_id);

					$this->db_insert_id = $db_insert_id;
					if(!class_exists('site_admin')) {
						require_once INCLUDE_PATH."/admin/site_admin.class.php";
					}
					$SonNodes = site_admin::getSonNode($NodeID);
					if(!empty($SonNodes)) {
						foreach($SonNodes as $key=>$var) {

							$this->createLink($IndexID, $var);
						
						}					
					
					}


/*****************************/
			if(!empty($IndexInfo[SubTargetNodeID])) {
				foreach($IndexInfo[SubTargetNodeID] as $key=>$var) {
 					$this->createLink($IndexID, $var);

				}			
			}

 			if(!empty($IndexInfo[IndexTargetNodeID])) {
				foreach($IndexInfo[IndexTargetNodeID] as $key=>$var) {
					$this->createIndexLink($IndexID, $var);
					
 				}			
			}

 
/*****************************/




					return true;
				
				} else
					return false;

		} else return false;
	
	}

	function imageContentAdd($NodeID,$PublishDate)
	{
		global  $db_config,$iWPC;

		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
		//$this->debugData();
		if($this->dataInsert($table_name)) {
				$this->flushData();
				$this->addData('ContentID', $this->db_insert_id);
				$this->addData('NodeID', $NodeID);
				$this->addData('Type', 3);
				$this->addData('State', 1);
				$this->addData('PublishDate', $PublishDate);
				if($this->indexAdd()) {
					$IndexID = $this->db_insert_id;
					$this->flushData();
					$this->addData('ParentIndexID', $IndexID);
					$this->indexEdit($IndexID);

					return true;
				
				} else
					return false;

		} else return false;
	
	}

	function contentEdit($IndexID, $IndexInfo="") 
	{
		global  $db_config,$iWPC;
		$indexInfo = $this->getIndexInfo($IndexID);
		//echo $IndexID;
		//print_r($indexInfo);
		$ContentID = $indexInfo[ContentID];
		$NodeID = $indexInfo[NodeID];
		//echo $NodeID;
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		//debug($NodeInfo);
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$NodeInfo[TableID];
		$where="where ContentID=".$ContentID;
		if($this->dataUpdate($table_name,$where)) {
			
			$this->flushData();
			if(!empty($IndexInfo)) $this->addData($IndexInfo);

			if(!empty($IndexInfo[SelfURL])) {
				$this->addData('URL', $IndexInfo[SelfURL]);
				$this->addData('Type', 4);
				
			} else {
				$this->addData('Type', 1);
			
			}
				
			if($this->indexEdit($IndexID)) {
				if($NodeInfo[AutoPublish] == '1') {
					$this->refresh($IndexID);
			
				}
				return true;

			} else
				return false;
		
		}	else return false;

	
	}


	function extraUpdate($ContentID,$eId)
	{
		global  $db_config;
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$eId;
		$where="where ContentID=".$ContentID;
		if($this->dataUpdate($table_name,$where))
			return true;
		else return false;
	
	}

	function publish($IndexID)
	{
		global $iWPC, $table, $db, $db_config;
		$info = $this->getIndexInfo($IndexID);
		psn_admin::isValid();

		$NodeInfo = $iWPC->loadNodeInfo($info[NodeID]);
		if($info[State] == 1)	return true;
		elseif($info[Type]==2 ) {
			$this->flushData();
			$this->addData('State', 1);
			$where="where IndexID=".$IndexID;
			if($this->dataUpdate($table->content_index,$where)) {
				return true;
			} else
				return false;
						

		} elseif ($info[Type]==4) {
			if($this->publishURL($IndexID)) {
				$this->flushData();
				$this->addData('State', 1);
				$where="where IndexID=".$IndexID;
				if($this->dataUpdate($table->content_index,$where))
					return true;					
				else 
					return false;
			} else
				return false;		
		}

		switch($NodeInfo[PublishMode]) {
			case '0'://不发布
				return true;
				break;
			case '1'://静态发布
			case '3':
				if($this->publishMakeHtml($IndexID)) {
					$this->flushData();
					$this->addData('State', 1);
					$where="where IndexID=".$IndexID;
					if($this->dataUpdate($table->content_index,$where))
						return true;					
					else 
						return false;
				} else
					return false;
				break;
			case '2'://动态发布
				if($this->publishDynamic($IndexID)) {
					$this->flushData();
					$this->addData('State', 1);
					$where="where IndexID=".$IndexID;
					if($this->dataUpdate($table->content_index,$where))
						return true;					
					else 
						return false;
				} else
					return false;
				break;
 
		}


	}

	/**
	 * 取消发布
	 *
	 * @param int $IndexID
	 * @param int $mode  0-临时取消发布 1-取消发布
	 * @access public
	 * @return bool
	 */
	function unpublish($IndexID, $mode = 1)
	{ 
		global $table,$db,$iWPC,$db_config,$Plugin;

		$info = $this->getIndexInfo($IndexID);
		$NodeInfo = $iWPC->loadNodeInfo($info[NodeID]);
		if($info[Type]==2 || $info[Type]==4){
			$this->flushData();
			$this->addData('State', 0);
			$where="where IndexID=".$IndexID;
			if($this->dataUpdate($table->content_index,$where))
				return true;
			else return false;
		
		
		};

		$this->flushData();
		$this->addData('State', 0);
		$where="where IndexID=".$IndexID;
		if($this->dataUpdate($table->content_index,$where)) {
			
			if($info[Type] == 1 || $info[Type] == 0 || $info[Type] == 3) {
				$this->clearPublishedItem($info['ContentID'],$info['NodeID'], $mode);//清除其他发布，包括图片等
			
			}
			$this->publishDel($IndexID,$mode);
			$publishInfo=$this->getContentInfo($IndexID);
			include(SETTING_DIR.'content.ini.php');

			$publishInfo[$mainContentLabel];
			$parseInfo = $this->_htmlPhoto_parseContent($publishInfo[$mainContentLabel]);
			//print_r($parseInfo);exit;
			if(!empty($parseInfo['IndexIDs'])) {
				foreach($parseInfo['IndexIDs'] as $key=>$var) {
					$this->unpublish($var, $mode);
				}		
			}
				
			//if($info[Type] == 1) {
				//$Plugin->del($IndexID);
				/*$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);
				$deploy = new dbDeploy();						
				$deploy->connectTo(content_table_admin::getTableInfo($NodeInfo[TableID], 'DSNID'), $NodeInfo[TableID]);
				$deploy->del($IndexID);
				$deploy->close();
				*/
				//$db->connect($db_config);
						

			//}
			return true;
		
		}
		else 
			return false;
		


	}
	
	/**
	 * 清空发布资源
	 * 包括生成的静态页面、图片资源、publish表内容等
 	 *
	 * @param  int $ContentID 内容ID
	 * @param  int $NodeID 节点ID
	 * @param  int $mode 模式 0-临时取消发布 1-取消发布
	 * @access private 
	 * @return bool
	 */
	function clearPublishedItem($ContentID, $NodeID , $mode=1)
	{
		global $db,$table;
		$sql = "SELECT *  FROM $table->publish_log  WHERE ContentID={$ContentID} AND NodeID=$NodeID ";
		//$psn = new psn_admin();
		$psn = &$this->beanFactory->getBean('psn');

		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$psn->connect($result->fields[PSN]);
			$psn->delFile('',$result->fields[FileName]);
			$result->MoveNext();
		}

		$sql = "DELETE  FROM $table->publish_log  WHERE ContentID='{$ContentID}' AND NodeID='$NodeID' ";
		//echo $sql."<br>";
		if($result = $db->query($sql))
			return true;
		else
			return false;


	}	
	
	/*
	 *刷新内容页
	 */
	function refresh($IndexID)
	{
		global $iWPC, $table,$db,$db_config;
		$info = $this->getIndexInfo($IndexID);
		$NodeInfo = $iWPC->loadNodeInfo($info[NodeID]);
 		if($info[State] == 0)	{
			return true;
		} elseif($info[Type]==2) {
			return true;
		} elseif($info[Type]==4) {
		
			return $this->publishURL($IndexID) ;
		
		}

		switch($NodeInfo[PublishMode]) {
			case '0'://不发布
				return true;
				break;
			case '1'://静态发布
			case '3': 
				if($this->publishMakeHtml($IndexID)) {		
					return true;		
				} else
					return false;
				break;
			case '2'://动态发布
				if($this->publishDynamic($IndexID)) {
					return true;	
				} else
					return false;
				break;
		}


	}



	/*
	 *刷新首页
	 */
	function refreshIndex($NodeID, $tplname, $filename)
	{
		global $iWPC,$SYS_ENV;
		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$this->NodeInfo = &$NodeInfo;
		switch($NodeInfo[PublishMode]) {
			case '0';
				return true;
				break;
			case '2':
			case '3':
				$template = new kTemplate();
				$template->template_dir = SYS_PATH.'templates';
				$cacheId = $NodeID.'0'.$NodeInfo['IndexTpl'];
				for($i=0;$i<=10;$i++) {
					$template->clear_cache($NodeInfo['IndexTpl'], $NodeID.$i.$NodeInfo['IndexTpl']);
				}
				return true;
				break;
		
		}
		$filename = formatPublishFile($filename);
		//$indexName = $NodeInfo[IndexName];
		//$indexTpl = $NodeInfo[IndexTpl];


		$template = new kTemplate();
		$template->template_dir = $SYS_ENV[templatePath];
		$template->compile_dir = SYS_PATH.'sysdata/templates_c/';
		$template->assign('NodeInfo', $NodeInfo);
		$template->assign('cms_version', CMSWARE_VERSION);


		if(!class_exists('TplVarsAdmin')) {
			require_once INCLUDE_PATH.'admin/TplVarsAdmin.class.php';
		}


		$tpl_vars = TplVarsAdmin::getAll();
		foreach($tpl_vars as $key=>$var) {//模板变量赋值

			if($var['IsGlobal']) {//全局模板变量
				$template->assign($var['VarName'], $var['VarValue']);	
			} else {
				if(preg_match("/,".$this->NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
					$template->assign($var['VarName'], $var['VarValue']);	
				} else {
					foreach(explode('%', $this->NodeInfo['ParentNodeID']) as $varIn) {
						if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
							$template->assign($var['VarName'], $var['VarValue']);	
						}
					}
				}
			}

 		}

		if(!empty( $tplname)) {

			//$tplname =  $NodeInfo[IndexTpl];
			
			if(!file_exists($template->template_dir. $tplname)) {
				new Error("Error: The index template  \'{$template->template_dir}{ $tplname}\' does not exits, Please Set it First to run.");
				return false;
			}

		} else {
			new Error("Error: You have not set the index template, Please Set it First.");
			return false;
		
		} 
		$template->registerPreFilter('CMS_Parser');

		$output=$template->fetch($tplname, 1); //Get the parsed content,ready for publishing.
		$output = restoreXMLHeader($output) ;
		//echo $output;exit;
		$this->IndexID = 0;
		$this->publishInfo[NodeID] = $NodeID;
		$this->publishInfo[ContentID] = 0;

		if($this->_publishing($filename, $output)) {
			return true;
		}else 
			return false;



	}

	function fetchIndex($NodeID, $template_dir = '', $templatefilename = '')
	{
		global $iWPC,$SYS_ENV,$IN;
		if(!empty($NodeID)) {
			$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		} else {
			$NodeInfo['NodeID'] = 0;
 		
		}

		$this->NodeInfo = &$NodeInfo;
		 
		$tplname = empty($templatefilename) ? $NodeInfo[IndexTpl] : $templatefilename;

		$template = new kTemplate();
		$template->template_dir = empty($template_dir) ? $SYS_ENV[templatePath] : $template_dir;
		$template->compile_dir = SYS_PATH.'sysdata/templates_c/';
		$template->assign('NodeInfo', $NodeInfo);
		$template->assign('cms_version', CMSWARE_VERSION);
		if(!empty($IN['IndexID'])) {
			$publishInfo= $this->getPublishInfo($IN['IndexID']);
			foreach($publishInfo as $key=>$var) {
	 
				$template->assign($key, $var);
			}
		
		}


		if(!class_exists('TplVarsAdmin')) {
			require_once INCLUDE_PATH.'admin/TplVarsAdmin.class.php';
		}


		$tpl_vars = TplVarsAdmin::getAll();
		foreach($tpl_vars as $key=>$var) {//模板变量赋值

			if($var['IsGlobal']) {//全局模板变量
				$template->assign($var['VarName'], $var['VarValue']);	
			} else {
				if(preg_match("/,".$this->NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
					$template->assign($var['VarName'], $var['VarValue']);	
				} else {
					foreach(explode('%', $this->NodeInfo['ParentNodeID']) as $varIn) {
						if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
							$template->assign($var['VarName'], $var['VarValue']);	
						}
					}
				}
			}

 		}

		if(!empty( $tplname)) {

			//$tplname =  $NodeInfo[IndexTpl];
			
			if(!file_exists($template->template_dir. $tplname)) {
				new Error("Error: The index template  \'{$template->template_dir}{ $tplname}\' does not exits, Please Set it First to run.");
				return false;
			}

		} else {
			new Error("Error: You have not set the index template, Please Set it First.");
			return false;
		
		} 
		$template->registerPreFilter('CMS_Parser');

		$output=$template->fetch($tplname, 1); //Get the parsed content,ready for publishing.
		$output = restoreXMLHeader($output) ;
		return $output;



	}
	
	/*
	 * 发布自定义URL的文档
	 * 
	 * */
	function publishURL($IndexID)
	{
		global $db,$db_config,$Plugin;
		global $table;
		global $SYS_ENV;
		global $TPL;
		global $SMARTY_VAR;
		global $iWPC;
		$NodeID = $this->getIndexInfo($IndexID, $field = 'NodeID');

		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$publishInfo=$this->getContentInfo($IndexID);
		$this->IndexID = $IndexID;
		$this->NodeInfo = &$NodeInfo;
		$this->publishInfo = $publishInfo;
		$this->flushData();
		$this->addData("URL", $publishInfo[SelfURL]);
		$this->URL = $publishInfo[SelfURL];
		$right = $this->indexEdit($IndexID);
  		$publishInfo[$mainContentLabel] = $this->ReplaceKeywords($publishInfo[$mainContentLabel]);
		foreach($publishInfo as $key=>$var) {
 			$this->resourcePublish($publishInfo[$key]);
			$this->htmlPhotoPublish($publishInfo[$key]);
			$this->psnPublish($publishInfo[$key]);
			//$publishInfo[$key] = $var;
		}

		//deploy to database
		$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);
		$this->flushData();
		foreach($FieldsInfo as $key=>$var) {
			if(empty($var['EnablePublish'])) continue;
			$this->addData($var[FieldName],  $publishInfo[$var[FieldName]]);
		}
		$this->addData('IndexID', $publishInfo[IndexID]);
		$this->addData('ContentID', $publishInfo[ContentID]);
		$this->addData('NodeID', $publishInfo[NodeID]);
		$this->addData('PublishDate', $publishInfo[PublishDate]);
		$this->addData('URL', $this->URL);
		$publishInfo['URL'] = $this->URL; //fix FullText Plugin `lost URL` Bug
		$this->publishUpdate($NodeInfo['TableID']);
		
		if(isset($Plugin)) {
			$Plugin->update($publishInfo);
		}

		return $right;
	}
	
		
	function publishDynamic($IndexID)
	{
		global $db,$db_config,$Plugin;
		global $table;
		global $SYS_ENV;
		global $TPL;
		global $SMARTY_VAR;
		global $iWPC;
		$NodeID = $this->getIndexInfo($IndexID, $field = 'NodeID');

		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$publishInfo=$this->getContentInfo($IndexID);

		$fieldInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);			
		foreach($fieldInfo as $key=>$var) { //过滤掉Diabled发布的字段内容
			if(!empty($var['EnablePublish'])) continue;
			else {
				unset($publishInfo[$var['FieldName']]);
			}
		
		}

		$this->IndexID = $IndexID;
		$this->NodeInfo = &$NodeInfo;
		$this->publishInfo = $publishInfo;
		include(SETTING_DIR.'content.ini.php');


		$PublishFileFormat = $NodeInfo['ContentPortalURL'];
		foreach($filenameFormatMap as $key=>$var) {
			$PublishFileFormat = str_replace($key,$var, $PublishFileFormat);
		}



  		$publishInfo[$mainContentLabel] = $this->ReplaceKeywords($publishInfo[$mainContentLabel]);
		foreach($publishInfo as $key=>$var) {
	 		
			$publishInfo[$key] = $this->convertPSN2URL($var);
		
			$this->resourcePublish($publishInfo[$key]);
			$this->htmlPhotoPublish($publishInfo[$key]);
			$this->psnPublish($publishInfo[$key]);
					
			//$publishInfo[$key] = $var;
		}

 
		eval ("\$publishFileName = \"$PublishFileFormat\";");
		$publishFileName = str_replace("{Page}" , 0 , $publishFileName);
		$publishFileName = str_replace("{IndexID}" , $IndexID , $publishFileName);
					

		

		$this->flushData();
		$this->addData("URL", $publishFileName);
		$this->URL = $publishFileName;
		$right = $this->indexEdit($IndexID);

			//deploy to database
		if($this->publishInfo[Type] == 1 || $this->publishInfo[Type] == 0 || $this->publishInfo[Type] == 3) {
				$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);

				/*$deploy = new dbDeploy();

				$deploy->connectTo(content_table_admin::getTableInfo($NodeInfo[TableID], 'DSNID'), $NodeInfo[TableID]);
				foreach($FieldsInfo as $key=>$var) {
					$deploy->addData($var[FieldName], fulltextEncoder(html2txt($publishInfo[$var[FieldName]])) );
				}
				//$deploy->debugData();
				$deploy->addData('IndexID', $publishInfo[IndexID]);
				$deploy->addData('ContentID', $publishInfo[ContentID]);
				$deploy->addData('NodeID', $publishInfo[NodeID]);
				$deploy->addData('PublishDate', $publishInfo[PublishDate]);
				$deploy->addData('URL', $this->URL);
				$deploy->update();
				$deploy->close();

				*/
				//$TPL->template_dir = SYS_PATH.'templates';
				$TPL->clear_cache($NodeInfo['ContentTpl'], $IndexID.'0'.$NodeInfo['ContentTpl']);

				$this->flushData();
				foreach($FieldsInfo as $key=>$var) {
					if(empty($var['EnablePublish'])) continue;
					$this->addData($var[FieldName],  $publishInfo[$var[FieldName]]);
				}
				$this->addData('IndexID', $publishInfo[IndexID]);
				$this->addData('ContentID', $publishInfo[ContentID]);
				$this->addData('NodeID', $publishInfo[NodeID]);
				$this->addData('PublishDate', $publishInfo[PublishDate]);
				$this->addData('URL', $this->URL);
				$publishInfo['URL'] = $this->URL; //fix FullText Plugin `lost URL` Bug
				$this->publishUpdate($NodeInfo['TableID']);
				if(isset($Plugin)) {
 					$Plugin->update($publishInfo);
				}
 

						

		}

		return $right;
	}
	

	function publishUpdate($TableID)
	{
		global $table,$db,$iWPC,$db_config;
		$table_publish = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$TableID;
		//echo 'aaaaaaa';exit;
		if($this->dataReplace($table_publish)) {			

			return true;
		
		} else return false;
	
	}

	/**
 	 * 这里删除publish、插件表的相关发布内容
	 */
	function publishDel($IndexID, $mode = 1)
	{
		global $table,$db,$iWPC,$db_config,$Plugin;
		$NodeID = $this->getIndexInfo($IndexID, $field = 'NodeID');
		
		if(!is_object($Plugin)) {
			require_once INCLUDE_PATH."admin/plugin.class.php";
			$Plugin = new Plugin();

		}

		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$table_publish = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$NodeInfo['TableID'];
		
		if($this->dataDel($table_publish, 'IndexID', $IndexID,'=' )) {	
			if($mode == 1) {
				$Plugin->del($IndexID);
			}
			
			return true;	
		} else return false;	
	}

	function publishMakeHtml($IndexID) {
		global $db,$db_config,$Plugin;
		global $table;
		global $SYS_ENV;
		global $TPL;
		global $SMARTY_VAR;
		global $iWPC;
		$NodeID = $this->getIndexInfo($IndexID, $field = 'NodeID');
		$GLOBALS['IN']['NodeID'] = empty($GLOBALS['IN']['NodeID']) ? $NodeID : $GLOBALS['IN']['NodeID'];

		$NodeInfo = $iWPC->loadNodeInfo($NodeID);
		$publishInfo=$this->getContentInfo($IndexID);
		$fieldInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);			
		foreach($fieldInfo as $key=>$var) {
			if(!empty($var['EnablePublish'])) continue;
			else {
				unset($publishInfo[$var['FieldName']]);
			}
		
		}
		$this->IndexID = $IndexID;
		$this->NodeInfo = &$NodeInfo;
		$this->publishInfo = $publishInfo;
		$template = new kTemplate();
		$template->assign('cms_version', CMSWARE_VERSION);
		
		if(!class_exists('TplVarsAdmin')) {
			require_once INCLUDE_PATH.'admin/TplVarsAdmin.class.php';
		}

		$tpl_vars = TplVarsAdmin::getAll();
		foreach($tpl_vars as $key=>$var) {//模板变量赋值

			if($var['IsGlobal']) {//全局模板变量
				$template->assign($var['VarName'], $var['VarValue']);	
			} else {
				if(preg_match("/,".$this->NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
					$template->assign($var['VarName'], $var['VarValue']);	
				} else {
					foreach(explode('%', $this->NodeInfo['ParentNodeID']) as $varIn) {
						if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
							$template->assign($var['VarName'], $var['VarValue']);	
						}
					}
				}
			}

 		}
		//debug($this->NodeInfo);
		if($this->publishInfo[Type] == 3) {
			$template->template_dir = $SYS_ENV[templatePath];
			if(!file_exists($template->template_dir.$this->NodeInfo[ImageTpl])) {
					new Error("Error: The Image template {$template->template_dir}{$this->NodeInfo[ImageTpl]} you have set  for your Image does not exists, system now use the default template \"{$SYS_ENV[templatePath]}/default/image.html\" to run.");
					$tplname = 'image.html';
					$template->template_dir =  $SYS_ENV[templatePath].'/default/';		
			} else {
				$tplname =  $this->NodeInfo[ImageTpl];
				$template->template_dir = $SYS_ENV[templatePath];
			
			}
		
		} else {

			if(!empty($this->publishInfo[SelfTemplate])) {
				if(preg_match("/\{TID:([0-9]+)\}/isU", $this->publishInfo[SelfTemplate], $matches)) { 
					require_once INCLUDE_PATH."admin/cate_tpl_admin.class.php";
					if(!isset($cate_tpl)) {
						$cate_tpl = new cate_tpl_admin();
						$TID = $matches[1];
						$TInfo = $cate_tpl->getInfo($TID);
						$this->publishInfo[SelfTemplate]="/ROOT/".$TInfo[TCID]."/".$TInfo[TID].".tpl";
							
					}
						
				}

				$tplname =  $this->publishInfo[SelfTemplate];
				$template->template_dir = $SYS_ENV[templatePath];
				
				if(!file_exists($template->template_dir.$this->publishInfo[SelfTemplate])) {
					new Error("Error: The content template {$template->template_dir}{$this->publishInfo[Template]} you have set alone for your content does not exists, system now use the default template \"{$SYS_ENV[templatePath]}/default/content.html\" to run.");
					$tplname = 'content.html';
					$template->template_dir =  $SYS_ENV[templatePath].'/default/';		
				}
			
			} elseif(!empty($this->NodeInfo[ContentTpl])) {
				$tplname =  $this->NodeInfo[ContentTpl];
				$template->template_dir = $SYS_ENV[templatePath];
				
				if(!file_exists($template->template_dir.$this->NodeInfo[ContentTpl])) {
					new Error("Error: The content template {$template->template_dir}{$this->NodeInfo[ContentTpl]} does not exists, system now use the default template \"{$SYS_ENV[templatePath]}/default/content.html\" to run.");
					$tplname = 'content.html';
					$template->template_dir =  $SYS_ENV[templatePath].'/default/';		
				}

			} else {	
				new Error("Warning: You haven\'t set the content template, system now use the default template \"{$SYS_ENV[templatePath]}/default/content.html\" to run.");
				$tplname = 'content.html';
				$template->template_dir =  $SYS_ENV[templatePath].'/default/';

			}				

		}


	
			
		$template->compile_dir = SYS_PATH.'sysdata/templates_c/';
		$template->registerPreFilter('CMS_Parser');
		include(SETTING_DIR.'content.ini.php');

 
		$PublishFileFormat = $NodeInfo['PublishFileFormat'];
		
		foreach($filenameFormatMap as $key=>$var) {
			$PublishFileFormat = str_replace($key, $var, $PublishFileFormat);
		}


  		$publishInfo[$mainContentLabel] = $this->ReplaceKeywords($publishInfo[$mainContentLabel]);
		foreach($publishInfo as $key=>$var) {
			$PublishFileFormat = str_replace("{".$key."}", addslashes($var), $PublishFileFormat);

			$publishInfo[$key] = $this->convertPSN2URL($var);

			$this->resourcePublish($publishInfo[$key]);
			$this->htmlPhotoPublish($publishInfo[$key]);
			$this->psnPublish($publishInfo[$key]);
			$template->assign($key, $publishInfo[$key]);
		}

		$PublishFileFormat = formatPublishFile($PublishFileFormat);

		$publishInfo[NodeInfo] = $NodeInfo;
		$template->assign_by_ref('Publish', $publishInfo);
		$template->assign('Navigation', $Navigation);
		$template->assign('sysRelateDoc', $RelateDoc);
		$template->assign_by_ref('NodeInfo', $NodeInfo);
		$template->registerPreFilter('CMS_Parser');

			//deploy to publish respository



		if(empty($this->NodeInfo[Pager]))	$this->NodeInfo[Pager]="default.php";

		//$this->NodeInfo[Pager] = "wap.php";
		include(SETTING_DIR."pager/".$this->NodeInfo[Pager]);//加载分页器



			
			$this->flushData();

			$URL = $this->getHtmlURL($publishFileName);
			print $URL."<br>";

			$this->addData("URL", $URL);
			$this->URL = $URL;
			$publishInfo['URL'] = $this->URL;
			$this->indexEdit($IndexID);

			/*//deploy to publish respository
			if($this->publishInfo[Type] == 1 || $this->publishInfo[Type] == 0 || $this->publishInfo[Type] == 3) {
				$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);

				$this->flushData();
				foreach($FieldsInfo as $key=>$var) {
					$this->addData($var[FieldName],  $publishInfo[$var[FieldName]]);
				}
				$this->addData('IndexID', $publishInfo[IndexID]);
				$this->addData('ContentID', $publishInfo[ContentID]);
				$this->addData('NodeID', $publishInfo[NodeID]);
				$this->addData('PublishDate', $publishInfo[PublishDate]);
				$this->addData('URL', $this->URL);
				$this->publishUpdate($NodeInfo['TableID']);
				if(isset($Plugin)) {
					$Plugin->update($publishInfo);
				
				}
				

			}*/
		return $right;
		
	}




	/**
	 * 大图生成静态页面的发布处理
	 */
	function htmlPhotoPublish(&$content)
	{
		global $table;
		$parseInfo = $this->_htmlPhoto_parseContent($content);
		$publishInfo1 = $this->publishInfo;
		if(!empty($parseInfo['IndexIDs'])) {
			foreach($parseInfo['IndexIDs'] as $key=>$var) {
				if($this->publishMakehtml($var)) {
					$this->flushData();
					$this->addData('State', 1);
					$where="where IndexID=".$var;
					$this->dataUpdate($table->content_index,$where);
				
				}
				$content =str_replace($parseInfo['matches'][$key], $this->URL, $content); 
			}
		}

		//print_r($publishInfo1);
		$this->publishInfo = $publishInfo1;

		//$localImgArray = $this->_resourcePublishing($ImgArray);
	
	}
	
	/**
	 * 解析内容，获取有效大图内容的indexID
	 */
	function _htmlPhoto_parseContent($content)
	{
		$_Image_Pattern="/cmsware:\/\/publish\/url.cw\?IndexID=([0-9]+)/ise";
		//cmsware://publish/url.cw?IndexID


		if(preg_match_all($_Image_Pattern,$content,$match,PREG_PATTERN_ORDER)) {
			$returnValue = array(
				'IndexIDs'=>$match[1],
				'matches'=>$match[0],
			);
		}
		//print_r($match);exit;
		if(is_array($returnValue['IndexIDs']))	{
			$returnValue['IndexIDs'] = array_unique ($returnValue['IndexIDs']);		
		}

		if(is_array($returnValue['matches']))	{
			$returnValue['matches'] = array_unique ($returnValue['matches']);		
		}


		//debug($img_data);
		return $returnValue;
	
	}

	function psnPublish(&$content)
	{

			$psn = new psn_admin();
			$patt = "/\{PSN-URL:([0-9]+)\}/isU";
			//echo $content;
			if(preg_match_all ($patt, $content ,$matches)) {
				foreach($matches[0] as $key=>$var) {
					$psnInfo = $psn->getPSNInfo( $matches[1][$key]);
					$content = str_replace($matches[0][$key], $psnInfo[URL], $content);
				}
				
			}
			unset($psn);

	}

	function resourcePublish(&$content)
	{
		global $db,$table,$SYS_ENV;

		$ImgArray = $this->_parseContent($content);
		//print_r($ImgArray);
		if(!empty($ImgArray)) {
			$sql = "SELECT varValue as num FROM $table->sys WHERE  varName ='publishResourceNum'";
			$row = $db->getRow($sql);
			$this->publish_num = $row[num];
			$localImgArray = $this->_resourcePublishing($ImgArray);
 			
			if($localImgArray)
				$this->_output($content, $ImgArray, $localImgArray);	
			else
				return false;		
 		} else
			return true;
	
	}
	
	function publishAll(&$string)
	{
		$this->psnPublish($string); //处理{PSN-URL:3}
		$this->cmsware_stream_parse($string); //处理cmsware://publish/url.cw?IndexID=1
		$this->resourcePublish($string); //处理<img src="../resource/h00/h01/img2005229992929.gif" >
	}

	function cmsware_stream_parse(&$string)
	{
		$parseInfo = $this->_htmlPhoto_parseContent($string); //处理cmsware://publish/url.cw?IndexID=5这样的stream
		if(!empty($parseInfo['IndexIDs'])) {
			foreach($parseInfo['IndexIDs'] as $key=>$var) {
				$url = $this->getIndexInfo($var, 'URL');
				$string =str_replace($parseInfo['matches'][$key], $url , $string); 
			}
		}



	}
	
	/**
	 * 获得发布Log
	 *
 	 * @param int $ContentID
	 * @param int $NodeID
	 * @access private 
	 * @return array 
	 */
	function getPublishLog($ContentID, $NodeID)
	{
		global $db,$table,$SYS_ENV;
		$publishLog = array();
		$result = $db->Execute("select FileName from $table->publish_log where ContentID='$ContentID' AND NodeID='$NodeID'");

		while(!$result->EOF) {
			$pathinfo = pathinfo($result->fields['FileName']);
			$publishLog[$pathinfo['basename']] = $result->fields['FileName'];
			$result->MoveNext();
		}

		return $publishLog;
	
	}

	function _resourcePublishing($ImgArray)
	{
		global $db,$table,$SYS_ENV;
		if(!is_array($ImgArray)) return false;
			
			$isUploadResources = array(); //已经发布的资源,避免一次发布过程对同一资源重复发布多次

			//$psn = new psn_admin();
			$psn = &$this->beanFactory->getBean('psn');
			$publishLog = $this->getPublishLog($this->publishInfo[ContentID], $this->publishInfo[NodeID]);
			//print_r($publishLog);

			$patt = "/{PSN:([0-9]+)}([\S]*)/is";
			preg_match ($patt, $this->NodeInfo[ResourcePSN] ,$matches);
			$PSNID = $matches[1];
			$publish_path = $matches[2];
					//debug($matches);
			$psnInfo = $psn->getPSNInfo($PSNID);
			$psn->connect($psnInfo[PSN]);
			$psn->sendVar[IndexID] = $this->IndexID;
			$psn->sendVar[NodeID] = $this->publishInfo[NodeID];
			$psn->sendVar[ContentID] = $this->publishInfo[ContentID];
			//save file in category dir
			foreach($ImgArray as $key=>$var) {
				$pathinfo = pathinfo($var);
				

				$sql = "select Name,Path  from $table->resource where Name = '{$pathinfo['basename']}'";
				//echo $sql;
				$result = $db->getRow($sql);
				$filename = $SYS_ENV['ResourcePath'].'/'.$result[Path];
				if(empty($result['Name'])) {
					/*$header = substr($var, 0, 3);
					if($header == '../') {
						$dataPath = $this->makeAutoPath();
						$destination = $dataPath.'/'.$pathinfo['basename'];

						$psn->upload($var, $publish_path.'/'.$destination);

						$saveFile[$key] = $this->getResourceURL().'/'.$destination;
						if(!psn_admin::logExits($psn->sendVar[ContentID], $psnInfo[PSN], $publish_path.'/'.$destination))
							$this->Counter();
					
					} else {
						$saveFile[$key] = $var; //修复重大bug
					}*/
					$saveFile[$key] = $var; //修复重大bug

						//continue;
				} else {
					if(!empty($publishLog[$pathinfo['basename']])) {
						if(!in_array($filename, $isUploadResources)) {
							$isUploadResources[] = $filename;
							$psn->upload($filename, $publishLog[$pathinfo['basename']]);
							$saveFile[$key] = $this->getPSNURL().$publishLog[$pathinfo['basename']];
							echo "PublishLog: ".$saveFile[$key]."<br>";
						} 	
					} else {
						if(!in_array($filename, $isUploadResources)) {
							$isUploadResources[] = $filename;
							$dataPath = $this->makeAutoPath();
							$destination = $dataPath.'/'.$pathinfo['basename'];
							//echo $publish_path.'/'.$destination;
							$saveFile[$key] = $this->getResourceURL().'/'.$destination;
							$psn->upload($filename, $publish_path.'/'.$destination, $saveFile[$key]);
							if(!psn_admin::logExits($psn->sendVar[ContentID], $psnInfo[PSN], $publish_path.'/'.$destination))
								$this->Counter();
							
							echo "Publishing: ".$saveFile[$key]."<br>";
						}
					}

					
					
					//$saveFile[$key] = $var; //修复重大bug

				}
					

			}
			$psn->close();

			return $saveFile;
	}
	
	function makeAutoPath() 
	{

		$num = $this->publish_num;
 
		$num = strval($num);
		$add_zero = 8- strlen($num);
		$num = str_repeat('0', $add_zero).$num;

		$DirSecond = "h".substr($num, 0, 3);
		$DirFirst = "h".substr($num, -5,2);
		
		return $DirSecond ."/".$DirFirst;

	}

	function Counter($num = 1)
	{
		global $db,$table;
		$sql = "UPDATE $table->sys SET `varValue`=varValue +1  where varName='publishResourceNum'";
		$row = $db->query($sql);
	
	}
	function _parseContent(&$content)
	{
		global $SYS_ENV;
		$_Image_Pattern=array(//   /<a[\s]+[^><]*[\s]+href=[\"]?(http:\/\/[^\"><\s]+)[\"]?[^><]*>/ise
			"1"=>array(
				'pattern'=>"/<img[\s]*[^><]*[\s]*src=[\"]?([^\"><\s]*.[jpg|gif|png|jpeg])[\"]?[\s]*[^><]*>/ise"
				,'dataKey'=>'1')
		,
			"2"=>array(
				'pattern'=>"/href=\"([^\"><\s]*.[jpg|gif|png|jpeg])\"/ise"
				,'dataKey'=>'1')
		,
			"3"=>array(
				'pattern'=>"/(\.\.\/resource\/[^\"><\s]*.[jpg|gif|png|jpeg|".$SYS_ENV['upAttachType']."])/ise"
				,'dataKey'=>'1')
		,
			/*"4"=>array(
				'pattern'=>"/(..\/resource\/[^\"><\s]*.[".$SYS_ENV['upAttachType']."])/ise"
				,'dataKey'=>'1')
		,
			*/
		);

		 
		$matches = array();
		foreach($_Image_Pattern as $key=>$var) {
			$datakey = $var['dataKey'];


			if(preg_match_all($var[pattern],$content,$match,PREG_PATTERN_ORDER)) {
 				$matches= array_merge($match[$datakey], $matches) ;
						//print_r($matches);
						
			}
				
				

				
		}			
		$img_data = $matches;
		if(is_array($img_data))	{
			array_unique ($img_data);		
			$img_data = $this->_imgLocalFilter($img_data);
		}
		//debug($img_data);

		return $img_data;
	}

	function _imgLocalFilter($img_data)
	{
		global $SYS_ENV;
		preg_match_all("/{([^}]+)}/siU",$SYS_ENV[localImgIgnoreURL],$matches );	
		$ignoreURLs = $matches[1];

		foreach($img_data as $var) {
			$urlinfo = parse_url($var);
			$urlinfo[host] = strtolower($urlinfo[host]);
			if (in_array ($urlinfo[host], $ignoreURLs)) {
				$return[] = $var;
			} elseif(empty($urlinfo[host])) {
				$return[] = $var;
			}else
				continue;

		}
		//debug($return);
		return $return;
	}

	function _output(&$value, $ImgArray, $localImgArray)
	{
		foreach($ImgArray as $key=>$var) {
 			$value = str_replace($ImgArray[$key], $localImgArray[$key], $value);
			//echo $value;
		}
	}	
	/**
     * Method: _publishing($filename,$content)
     * 开始发布 -> 远程ftp或者本地.
     * @param string $filename,string $content
	 * @return boolean
     */
	function _publishing($filename,$content)
	{	
		//$psn = new psn_admin();
		$psn = &$this->beanFactory->getBean("psn");

		$patt = "/{PSN:([0-9]+)}([\S]*)/is";

		if(!empty($this->publishInfo[SelfPSN])) {
			preg_match ($patt, $this->publishInfo[SelfPSN] ,$matches);
		
		} else {
			preg_match ($patt, $this->NodeInfo[ContentPSN] ,$matches);
		
		}
		$PSNID = $matches[1];
		$publish_path = $matches[2];
		//debug($matches);
		$psnInfo = $psn->getPSNInfo($PSNID);
		$psn->connect($psnInfo[PSN]);
		$psn->sendVar[IndexID] = $this->IndexID;
		$psn->sendVar[NodeID] = $this->publishInfo[NodeID];
		$psn->sendVar[ContentID] = $this->publishInfo[ContentID];
		$filename = $publish_path.'/'.$filename;

		if($psn->put($filename, $content)) {
			$psn->close();
			return true;
		} else {
			$psn->close();
			return false;
		
		}
	}


	function getResourceURL()
	{
		$patt = "/{PSN-URL:([0-9]+)}([\S]*)/is";

		$ResourceURL = str_replace('{NodeID}', $this->NodeInfo['NodeID'], $this->NodeInfo[ResourceURL]);

		if(preg_match ($patt, $ResourceURL ,$matches)) {
			$PSNID = $matches[1];
			$publish_path = $matches[2];
			$psnInfo = psn_admin::getPSNInfo($PSNID);

			$url = $psnInfo[URL].$publish_path;
	
		
		} else {
			$url = $ResourceURL;
		}




		return $url;
	
	}

	function convertPSN2URL($_str) {
		$patt = "/{PSN-URL:([0-9]+)}/is";
		if(preg_match_all($patt, $_str ,$matches)) {
			foreach($matches[0] as $key=>$var) {
				$psnInfo = psn_admin::getPSNInfo($matches[1][$key]);
				$_str = str_replace($var, $psnInfo[URL],$_str );
			}
		} 

		return $_str;
	
	}

	function getPSNURL()
	{
		$patt = "/{PSN-URL:([0-9]+)}([\S]*)/is";

		$ResourceURL = str_replace('{NodeID}', $this->NodeInfo['NodeID'], $this->NodeInfo[ResourceURL]);

		if(preg_match ($patt, $ResourceURL ,$matches)) {
			$PSNID = $matches[1];
 			$psnInfo = psn_admin::getPSNInfo($PSNID);

			$url = $psnInfo[URL];
	
		
		} else {
			$url = $ResourceURL;
		}




		return $url;
	
	}

	function getHtmlURL($publishFileName) 
	{	
		$patt = "/{PSN-URL:([0-9]+)}([\S]*)/is";
		
		$publishFileName = formatPublishFile($publishFileName);
		if(!empty($this->publishInfo[SelfPSNURL])) {
			if(preg_match ($patt, $this->publishInfo[SelfPSNURL] ,$matches)) {
				$PSNID = $matches[1];
				$publish_path = $matches[2];
				$psnInfo = psn_admin::getPSNInfo($PSNID);

				$url = $psnInfo[URL].$publish_path.'/'.$publishFileName;
		
			
			} else {
 				$url = $this->publishInfo[SelfURL].'/'.$publishFileName;
			}		
		} else {
			//support {PSN:1}/software/{NodeID}
			$ContentURL = str_replace('{NodeID}', $this->NodeInfo['NodeID'], $this->NodeInfo[ContentURL]);
			if(preg_match ($patt, $ContentURL ,$matches)) {
				$PSNID = $matches[1];
				$publish_path = $matches[2];
				$psnInfo = psn_admin::getPSNInfo($PSNID);

				$url = $psnInfo[URL].$publish_path.'/'.$publishFileName;
		
			
			} else {
				$url = $ContentURL.'/'.$publishFileName;
			}		
		}
		
		





		return $url;
	}




	function ReplaceKeywords($str)
	{
		global $table, $db, $SYS_ENV;
		if(!isset($this->Cache_ReplaceKeywords)) {
			$this->Cache_ReplaceKeywords = array();
			$sql="SELECT * FROM $table->keywords ";
			$recordSet=$db->Execute($sql, 2, 10000);
			while(!$recordSet->EOF) {	
				$this->Cache_ReplaceKeywords[] = $recordSet->fields;
				$recordSet->MoveNext();
			}
			$recordSet->Close();  
		
		}  

		if(!empty($this->Cache_ReplaceKeywords)) {
			foreach($this->Cache_ReplaceKeywords as $key=>$var) {
				if($var['IsGlobal']) {//全局关键字
					//$str = str_replace($var['keyword'], $var['kReplace'], $str);
					//$str =preg_replace($var['keyword'], $var['kReplace'], $str);
					$str = $this->doPregReplace($var['keyword'], $var['kReplace'], $str);
				} else {
					if(preg_match("/,".$this->NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
						$str = $this->doPregReplace($var['keyword'], $var['kReplace'], $str);
						//$str = str_replace($var['keyword'], $var['kReplace'], $str);
					} else {
						//print_r($this->NodeInfo['ParentNodeID']);
						foreach(explode('%', $this->NodeInfo['ParentNodeID']) as $varIn) {
							if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
									 
								$str = $this->doPregReplace($var['keyword'], $var['kReplace'], $str);
								//$str = str_replace($var['keyword'], $var['kReplace'], $str);	
							}
						}
					}
				}
			
			
			}
		
		}

		return $str;

	}

/*
cmsware
<a href="">cmsware</a>
<b>cmsware</b>
<a href="http://www.cmsware.com">cmsware</a>

*/
function doPregReplace($_keyword, $_replace, $_str)
{
	 
		if(preg_match_all("/".preg_quote($_keyword)."/si",$_str, $matches )) {
			if(strpos($_str, "<")===false && strpos($_str, ">")===false) {
				$_str = str_replace($_keyword, $_replace, $_str);
			} else {
				//for($i=0;$i<count($matches[0]);$i++) {
				if(preg_match_all("/(<[^<>]+>[^<>]*)".preg_quote($_keyword)."([^<>]*<[^<>]+>)/si",$_str, $matches )){
					foreach($matches[0] as $key=>$var) {
						if(strpos(strtolower($matches[1][$key]), "href") !== false) {
							$_str = str_replace($matches[0][$key], "[base64]".base64_encode($matches[0][$key])."[/base64]", $_str);
						} else {
							//$_str = str_replace($matches[0][$key], "[base64]".base64_encode($matches[1][$key].$_replace.$matches[2][$key])."[/base64]", $_str);
						} 
					}
				}

				if(preg_match_all("/(<[^<>]+)".preg_quote($_keyword)."([^<>]+>)/si",$_str, $matches )){
					foreach($matches[0] as $key=>$var) {
 						$_str = str_replace($matches[0][$key], "[base64]".base64_encode($matches[0][$key])."[/base64]", $_str);
 					}
				}

 				$_str = str_replace($_keyword, $_replace, $_str);
 					
				if(preg_match_all("/\[base64\](.*)\[\/base64\]/siU",$_str, $matches )){
					foreach($matches[0] as $key=>$var) {
 						$_str = str_replace($matches[0][$key], base64_decode($matches[1][$key]), $_str);
 					}
				}
			
			}
		}

		return $_str ;
}



	function getRelateDoc($IndexID,$from,$to) {
		global $table,$db,$SYS_ENV,$db_config;
		$table_name = $db_config['table_pre'].$db_config['table_content_pre'].'_1';

		$ContentInfo = $this->getContentInfo($IndexID);
		$from = intval($from);
		$to = intval($to);

		$to = $to - $from;
		$keywords=array_unique(explode(",",$ContentInfo[KeyWords]));
		if(!is_array($keywords))
			return false;
		foreach ($keywords as $var) {
			if($var=='')
					continue;

			$sql = "SELECT i.*,c.* FROM $table->content_index i ,$table_name c WHERE c.Keywords LIKE '%$var%' AND i.ContentID = c.ContentID AND i.Type='1' AND i.IndexID!='$IndexID' ORDER BY i.PublishDate DESC LIMIT $from ,$to";
			//echo $sql;

			$relativeLink=$db->Execute($sql);

			while(!$relativeLink->EOF) {
				if(!empty($doclist)) {
					if(in_array($relativeLink->fields, $doclist)) {
						$relativeLink->MoveNext();
						continue;
					
					}
				}
				$doclist[]= $relativeLink->fields;	
			}
			
		}
		if(!is_array($doclist))
			return false;
		
		$resultlist = array_slice ($doclist, $from,$to);
		
		return $resultlist ;
			
	}
	
	function makeIndexSavePath($IndexID)
	{
		$IndexID = strval($IndexID);
		$add_zero = 8- strlen($IndexID);
		$IndexID = str_repeat('0', $add_zero).$IndexID;

		$DirSecond = "h".substr($IndexID, 0, 3);
		$DirFirst = "h".substr($IndexID, -5,2);
//echo $DirSecond ."/".$DirFirst;exit;
 		return $DirSecond ."/".$DirFirst;

 
	}



}


?>