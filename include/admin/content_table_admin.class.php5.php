<?php
class content_table_admin extends iData {

	/**
     * Method:	添加新的内容模型表
	 * @void
	 * @return boolean
     */
	function addTable($TableID = 0)
	{
		global $table,$db_config,$db;
		if($this->dataInsert($table->content_table)) {
			$TableID = $this->db_insert_id;
			$table_content_name = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$this->db_insert_id;
			$table_contribution_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$this->db_insert_id;
			$table_collection_name = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$this->db_insert_id;
			$table_publish_name = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$this->db_insert_id;


			// check mysql version first.
 			$mysql_version = explode('.', $db->getServerInfo()); 
			if (($mysql_version[0] == 4 && $mysql_version[1] > 0) || $mysql_version[0] > 4)  {
				$set_chaset .=" DEFAULT CHARSET=".$db_config['db_charset']." ";	
			} else $set_chaset="";

			$sql_content = "CREATE TABLE `$table_content_name` (
					`ContentID` INT( 10 ) NOT NULL AUTO_INCREMENT,
					`CreationDate` INT( 10 )  default '0',
					`ModifiedDate` INT( 10 )  default '0',
					`CreationUserID` INT( 8 )  default '0',
					`LastModifiedUserID` INT( 8 )  default '0',
					`ContributionUserID` INT( 8 )  default '0',
					`ContributionID` INT( 10 ) default '0',
					PRIMARY KEY (`ContentID` )
				) TYPE=MyISAM" . $set_chaset ;
			$sql_publish = "CREATE TABLE `$table_publish_name` (
					IndexID Integer(10) NOT NULL ,
					ContentID Integer(10) default '0' ,
					NodeID Integer(10) default '0' ,
					PublishDate Integer(10) ,
					URL Char(250) ,
					Primary Key (IndexID) ,
					KEY NodeID (NodeID),
					KEY ContentID (ContentID) ,
					KEY PublishDate (PublishDate)
				) TYPE=MyISAM" . $set_chaset ;
			$sql_contribution = "CREATE TABLE `$table_contribution_name` (
				  `ContributionID` int(10) NOT NULL auto_increment,
				  `CateID` int(8) NOT NULL default '0',
				  `CreationDate` int(10) default '0',
				  `ModifiedDate` int(10) default '0',
				  `ApprovedDate` int(10) default '0',
				  `OwnerID` int(8) default '0',
				  `State` int(5) default '0',
				  `NodeID` int(8)  default '0',
				  `SubNodeID` varchar(250)  default '',
				  `IndexNodeID` varchar(250)  default '',
				  `ContributionDate` int(10) default '0',
				  PRIMARY KEY  (`ContributionID`,`CateID`),
				  UNIQUE KEY `ContributionID` (`ContributionID`),
				  KEY `NodeID` (`NodeID`)
				) TYPE=MyISAM" . $set_chaset ;

			$sql_collection = "CREATE TABLE `$table_collection_name` (
				  `CollectionID` int(10) NOT NULL auto_increment,
				  `CateID` int(8)  default '0',
				  `CreationDate` int(10) default '0',
				  `ModifiedDate` int(10) default '0',
				  `ApprovedDate` int(10) default '0',
				  `PublishDate` int(10) default '0',
				  `State` int(2) default '0',
				  `NodeID` int(8)  default '0',
				  `SubNodeID` varchar(250)  default '',
				  `Src` varchar(250)  default '',
				  `IsImported` tinyint(1)  default '0',
				  PRIMARY KEY  (`CollectionID`,`CateID`),
				  UNIQUE KEY `CollectionID` (`CollectionID`),
				  KEY `C_I` (`CateID`,`IsImported`),
				  KEY `Src` (`Src`)
				) TYPE=MyISAM" . $set_chaset ;

			if($db->query($sql_content) && $db->query($sql_publish) && $db->query($sql_contribution) && $db->query($sql_collection))  {

				$pluginFactory = & get_singleton("CMS.Plugin");
				$plugin = & $pluginFactory->getInstance();
				$plugin->addTable($TableID);

				return true;
			}
			else return false;
			
			
		
		} else return false;
		
	}

	/**
     * Method:获得所有内容模型表
	 * @void
	 * @return array
     */	
	public static function getAllTable()
	{
		global $table,$db;

		$sql  ="SELECT * FROM $table->content_table ";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	
	}

	function isValid($add = 0)
	{
		global $table,$db,$CONTENT_MODEL_INFO;
		
		require(SYS_PATH.'/license.php');
		$license_array = $License;
		unset($License);		
		//$sql  ="SELECT count(*) as nr FROM $table->content_table";
		//$result = $db->getRow($sql);
		$result[nr] = count($CONTENT_MODEL_INFO);

		if($result[nr]+$add > $license_array['ContentModel-num'] && $license_array['ContentModel-num']!=0) {
			goback('license_ContentModel_num_overflow');
		}
	
	}


	/**
     * Method:获得内容模型表的字段详细信息
	 * @param int $TableID
	 * @return array
     */	
	public static function getTableFieldsInfo($TableID)
	{
		global $table,$db,$CONTENT_MODEL_INFO;
		if(!empty($CONTENT_MODEL_INFO)) return $CONTENT_MODEL_INFO[$TableID]['Model']; 
		
		//print_r($CONTENT_MODEL_INFO);
		$sql  ="SELECT * FROM $table->content_fields where TableID=$TableID Order By FieldOrder";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			if(strpos($result->fields[FieldDefaultValue], ';'))
				$result->fields[selectValue] = explode(';' , $result->fields[FieldDefaultValue]);
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
	}

	/**
     * Method:获得内容模型表的信息
	 * @param int $TableID
	 * @return array
     */	
	function getTableInfo($TableID, $field = '*')
	{
		global $table,$db;
		$sql  ="SELECT $field FROM $table->content_table where TableID=$TableID";
		
		$data  = $db->getRow($sql);
		if($field == '*')
			return $data;
		else
			return $data[$field];
	}

	/**
     * Method:更新内容模型表的记录
	 * @param int $eId
	 * @return array
     */	
	function updateTable($TableID)
	{
		global $table,$db;
		$where="where TableID=".$TableID;
		if($this->dataUpdate($table->content_table,$where)) {
			$sql = "UPDATE $table->content_fields SET EnableContribution=0,EnableCollection=0,EnablePublish=0,FieldSearchable=0,FieldListDisplay=0 WHERE TableID=$TableID";
			$db->query($sql);
			return true;
		
		} else return false;
	
	}


	/**
     * Method: 删除内容模型表
	 * @param int $eId
	 * @return array
     */		
	function delTable($TableID)
	{
		global $table,$db_config,$db;
		/*$deploy = new dbDeploy();
		$deploy->connectTo(content_table_admin::getTableInfo($TableID, 'DSNID'), $TableID);
		$deploy->undeploy();
		$deploy->close();*/
		//$db->connect($db_config);
		$which="TableID";
			
		
		if($this->dataDel($table->content_table,$which,$TableID,$method="=")) {

			$db->query("DELETE FROM $table->content_fields WHERE TableID=$TableID");
			$table_name_1 = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$TableID;
			$table_name_2 = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$TableID; 
			$table_name_3 = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$TableID; 
			$table_name_4 = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$TableID; 
			$sql_1 = "DROP TABLE $table_name_1 ";
			$sql_2 = "DROP TABLE $table_name_2 ";
			$sql_3 = "DROP TABLE $table_name_3 ";
			$sql_4 = "DROP TABLE $table_name_4 ";

			if($db->query($sql_1) && $db->query($sql_2) && $db->query($sql_3)  && $db->query($sql_4)) {
				$pluginFactory = & get_singleton("CMS.Plugin");
				$plugin = & $pluginFactory->getInstance();
				$plugin->delTable($TableID);
 				return true;
			
			} else return false;

		} else return false;
			
		
	
	}
//---------------------------------以下为字段处理-------------------------------	
	/**
     * Method:	添加新的字段内容模型表
	 * @param int $TableID
	 * @param array $data
	 * @param boolean _multiField 多字段添加
	 * @return boolean
     */
	function addField($TableID, $data, $_multiField = false)
	{
		global $table, $db_config, $db;


		$table_name_1 = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$TableID;
		$table_name_2 = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$TableID;
		$table_name_3 = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$TableID;
		$table_name_4 = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$TableID; 

		if($_multiField == true) {
			$first_stamp = true;
			$sql_1 = "";
			$sql_2 = "";
			$sql_3 = "";
			$sql_4 = "";
			foreach($data as $key=>$var) {
				$length = "";
				if($var[FieldSize] != '' 
					&& $var[FieldType] != 'text' 
					&& $var[FieldType] != 'mediumtext' 
					&& $var[FieldType] != 'longtext' 
					&& $var[FieldType] != 'contentlink') $length = "({$var[FieldSize]})";
				
				if($first_stamp == true) {
					if($var[FieldType] == 'contentlink') {
						$sql_1 .= "ALTER TABLE `$table_name_1` ADD COLUMN `{$var[FieldName]}` text NOT NULL";
						$sql_2 .= "ALTER TABLE `$table_name_2` ADD COLUMN `{$var[FieldName]}` text NOT NULL";
						$sql_3 .= "ALTER TABLE `$table_name_3` ADD COLUMN `{$var[FieldName]}` text NOT NULL";
						$sql_4 .= "ALTER TABLE `$table_name_4` ADD COLUMN `{$var[FieldName]}` text NOT NULL";
					} else {
						$sql_1 .= "ALTER TABLE `$table_name_1` ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
						$sql_2 .= "ALTER TABLE `$table_name_2` ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
						$sql_3 .= "ALTER TABLE `$table_name_3` ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
						$sql_4 .= "ALTER TABLE `$table_name_4` ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
					}		
					$first_stamp = false;
				} else {
					if($var[FieldType] == 'contentlink') {
						$sql_1 .= ", ADD COLUMN `{$var[FieldName]}` text NOT NULL";
						$sql_2 .= ", ADD COLUMN `{$var[FieldName]}` text NOT NULL";
						$sql_3 .= ", ADD COLUMN `{$var[FieldName]}` text NOT NULL";
						$sql_4 .= ", ADD COLUMN `{$var[FieldName]}` text NOT NULL";
					} else {
						$sql_1 .= ", ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
						$sql_2 .= ", ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
						$sql_3 .= ", ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
						$sql_4 .= ", ADD `{$var[FieldName]}` {$var[FieldType]} $length  NOT NULL";
					}		
				}
			}

			$result = $db->query($sql_1);
			$result = $db->query($sql_2);
			$result = $db->query($sql_3);
			$result = $db->query($sql_4);

			if($result) {

				$pluginFactory = & get_singleton("CMS.Plugin");
				$Plugin = & $pluginFactory->getInstance();

				foreach($data as $key=>$var) {
					$Plugin->addField($TableID, $var);
					$this->flushData();
					$this->addData('TableID', $TableID);
					$this->addData('FieldTitle', $var[FieldTitle]);
					$this->addData('FieldName', $var[FieldName]);
					$this->addData('FieldType', $var[FieldType]);
					$this->addData('FieldSize', $var[FieldSize]);
					$this->addData('FieldDefaultValue', $var[FieldDefaultValue]);
					$this->addData('FieldInput', $var[FieldInput]);
					$this->addData('FieldDescription', $var[FieldDescription]);
					$this->addData('FieldInputFilter', $var[FieldInputFilter]);
					$this->addData('FieldInputPicker', $var[FieldInputPicker]);
					$this->addData('FieldInputTpl', $var[FieldInputTpl]);
					$this->addData('FieldOrder', $var[FieldOrder]);
					$this->addData('FieldListDisplay', $var[FieldListDisplay]);
					$this->addData('IsMainField', $var[IsMainField]);
					$this->addData('IsTitleField', $var[IsTitleField]);
					$this->addData('FieldSearchable', $var[FieldSearchable]);
					$this->addData('EnableContribution', $var[EnableContribution]);
					$this->addData('EnableCollection', $var[EnableCollection]);
					$this->addData('EnablePublish', $var[EnablePublish]);

					$return = $this->_add_field();
				}
				return $return ;
			} else 
				return false;	

		} else {

			if($data[FieldSize] != '' && $data[FieldType] != 'text' && $data[FieldType] != 'mediumtext' && $data[FieldType] != 'longtext' && $data[FieldType] != 'contentlink') $length = "({$data[FieldSize]})";

			
			if($data[FieldType] == 'contentlink') {
				$sql_1 = "ALTER TABLE `$table_name_1` ADD COLUMN `{$data[FieldName]}` text NOT NULL";
				$sql_2 = "ALTER TABLE `$table_name_2` ADD COLUMN `{$data[FieldName]}` text NOT NULL";
				$sql_3 = "ALTER TABLE `$table_name_3` ADD COLUMN `{$data[FieldName]}` text NOT NULL";
				$sql_4 = "ALTER TABLE `$table_name_4` ADD COLUMN `{$data[FieldName]}` text NOT NULL";
			
			} else {
				$sql_1 = "ALTER TABLE `$table_name_1` ADD `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
				$sql_2 = "ALTER TABLE `$table_name_2` ADD `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
				$sql_3 = "ALTER TABLE `$table_name_3` ADD `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
				$sql_4 = "ALTER TABLE `$table_name_4` ADD `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
			
			}
			$result = $db->query($sql_1);
			$result = $db->query($sql_2);
			$result = $db->query($sql_3);
			$result = $db->query($sql_4);

			if($result) {

				$pluginFactory = & get_singleton("CMS.Plugin");
				$Plugin = & $pluginFactory->getInstance();
				$Plugin->addField($TableID, $data);

				$this->flushData();
				$this->addData('TableID', $TableID);
				$this->addData('FieldTitle', $data[FieldTitle]);
				$this->addData('FieldName', $data[FieldName]);
				$this->addData('FieldType', $data[FieldType]);
				$this->addData('FieldSize', $data[FieldSize]);
				$this->addData('FieldDefaultValue', $data[FieldDefaultValue]);
				$this->addData('FieldInput', $data[FieldInput]);
				$this->addData('FieldDescription', $data[FieldDescription]);

	//add at 08/17/2004
				$this->addData('FieldInputFilter', $data[FieldInputFilter]);
				$this->addData('FieldInputPicker', $data[FieldInputPicker]);
				$this->addData('FieldInputTpl', $data[FieldInputTpl]);

	//add at 2006-7-16

				$this->addData('FieldOrder', $data[FieldOrder]);
				$this->addData('FieldListDisplay', $data[FieldListDisplay]);
				$this->addData('IsMainField', $data[IsMainField]);
				$this->addData('IsTitleField', $data[IsTitleField]);
				$this->addData('FieldSearchable', $data[FieldSearchable]);
				$this->addData('EnableContribution', $data[EnableContribution]);
				$this->addData('EnableCollection', $data[EnableCollection]);
				$this->addData('EnablePublish', $data[EnablePublish]);

				if($this->_add_field())	return true;
				else return false;

			} else 
				return false;		

		}
	}

	/**
     * Method:	添加字段信息到content_fields 表
	 * @param void
	 * @return boolean
     */
	function _add_field()
	{
		global $table;
		if($this->dataInsert($table->content_fields))
			return true;
		else return false;
	
	}


	/**
     * Method:	编辑新的字段内容模型表
	 * @param int $ContentFieldID
	 * @param array $data
	 * @return boolean
	 *
     */
	function editField($ContentFieldID, $data)
	{
		global $table, $db_config, $db;
		$fieldInfo = $this->getFieldInfo($ContentFieldID);

		$table_name_1 = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$fieldInfo[TableID];
		$table_name_2 = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$fieldInfo[TableID];
		$table_name_3 = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$fieldInfo[TableID];
		$table_name_4 = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$fieldInfo[TableID];
		if($data[FieldSize] != '' && $data[FieldType] != 'text' && $data[FieldType] != 'mediumtext' && $data[FieldType] != 'longtext' && $data[FieldType] != 'contentlink') $length = "({$data[FieldSize]})";


		if($data[FieldType] == 'contentlink') {
			$sql_1 = "ALTER TABLE `$table_name_1` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` text NOT NULL";
			$sql_2 = "ALTER TABLE `$table_name_2` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` text NOT NULL";
			$sql_3 = "ALTER TABLE `$table_name_3` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` text NOT NULL";
			$sql_4 = "ALTER TABLE `$table_name_4` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` text NOT NULL";
		
		} else {
			$sql_1 = "ALTER TABLE `$table_name_1` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
			$sql_2 = "ALTER TABLE `$table_name_2` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
			$sql_3 = "ALTER TABLE `$table_name_3` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
			$sql_4 = "ALTER TABLE `$table_name_4` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
		
		}
		
		$result = $db->query($sql_1);
		$result = $db->query($sql_2);
		$result = $db->query($sql_3);
		$result = $db->query($sql_4);

		//echo $sql_2;
		//exit;
		if($result) {
			/*$deploy = new dbDeploy();
			$deploy->connectTo($this->getTableInfo($fieldInfo[TableID], 'DSNID'), $fieldInfo[TableID]);
			$deploy->editField($fieldInfo, $data);
			

			$deploy->close();
			//echo $db->info();
			//$db->connect($db_config);
			*/
			$pluginFactory = & get_singleton("CMS.Plugin");
			$Plugin = & $pluginFactory->getInstance();
 			$Plugin->editField($fieldInfo[TableID], $fieldInfo, $data);


			$this->flushData();
			$this->addData('FieldTitle', $data[FieldTitle]);
			$this->addData('FieldName', $data[FieldName]);
			$this->addData('FieldType', $data[FieldType]);
			$this->addData('FieldSize', $data[FieldSize]);
			$this->addData('FieldDefaultValue', $data[FieldDefaultValue]);
			$this->addData('FieldInput', $data[FieldInput]);
			//$this->addData('IsPublish', $data[IsPublish]);
			$this->addData('FieldDescription', $data[FieldDescription]);
//add at 08/17/2004
			$this->addData('FieldInputFilter', $data[FieldInputFilter]);
			$this->addData('FieldInputPicker', $data[FieldInputPicker]);
			$this->addData('FieldInputTpl', $data[FieldInputTpl]);

			if($this->_edit_field($ContentFieldID))	return true;
			else return false;

		} else 
			return false;

	}

	function indexField($ContentFieldID)
	{
		global $table, $db_config, $db;
		$fieldInfo = $this->getFieldInfo($ContentFieldID);

		$table_name_1 = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$fieldInfo[TableID];
		$table_name_2 = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$fieldInfo[TableID];
		$table_name_3 = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$fieldInfo[TableID];
		$table_name_4 = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$fieldInfo[TableID];

		if(($fieldInfo[FieldType] == 'text') || ($fieldInfo[FieldType] == 'mediumtext') || ($fieldInfo[FieldType] == 'longtext')) {
			$sql_1 = "ALTER TABLE `$table_name_1` ADD FULLTEXT (`{$fieldInfo[FieldName]}`) ";
			$sql_2 = "ALTER TABLE `$table_name_2` ADD FULLTEXT (`{$fieldInfo[FieldName]}`) ";
			$sql_3 = "ALTER TABLE `$table_name_3` ADD FULLTEXT (`{$fieldInfo[FieldName]}`) ";
			$sql_4 = "ALTER TABLE `$table_name_4` ADD FULLTEXT (`{$fieldInfo[FieldName]}`) ";
			$result = $db->query($sql_1);
			$result = $db->query($sql_2);
			$result = $db->query($sql_3);
			$result = $db->query($sql_4);
		} else {
			$sql_1 = "ALTER TABLE `$table_name_1` ADD INDEX (`{$fieldInfo[FieldName]}`) ";
			$sql_2 = "ALTER TABLE `$table_name_2` ADD INDEX (`{$fieldInfo[FieldName]}`) ";
			$sql_3 = "ALTER TABLE `$table_name_3` ADD INDEX (`{$fieldInfo[FieldName]}`) ";
			$sql_4 = "ALTER TABLE `$table_name_4` ADD INDEX (`{$fieldInfo[FieldName]}`) ";
			$result = $db->query($sql_1);
			$result = $db->query($sql_2);
			$result = $db->query($sql_3);
			$result = $db->query($sql_4);
	
		
		}

	

		if($result) {
			/*$deploy = new dbDeploy();
			$deploy->connectTo($this->getTableInfo($fieldInfo[TableID], 'DSNID'),$fieldInfo[TableID]);
			$deploy->createIndex( $fieldInfo);


			$deploy->close();
			*/
			//$db->connect($db_config);

			
			$this->flushData();
			$this->addData('IsIndex', 1);

			if($this->_edit_field($ContentFieldID))	return true;
			else return false;

		} else 
			return false;	
	}

	function delFieldIndex($ContentFieldID)
	{
		//ALTER TABLE `ck_content_3` DROP INDEX `Intro`  


		global $table, $db_config, $db;
		$fieldInfo = $this->getFieldInfo($ContentFieldID);

		$table_name_1 = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$fieldInfo[TableID];
		$table_name_2 = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$fieldInfo[TableID];
		$table_name_3 = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$fieldInfo[TableID];
		$table_name_4 = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$fieldInfo[TableID];

		$sql_1 = "ALTER TABLE `$table_name_1` DROP INDEX `{$fieldInfo[FieldName]}` ";
		$sql_2 = "ALTER TABLE `$table_name_2` DROP INDEX `{$fieldInfo[FieldName]}` ";
		$sql_3 = "ALTER TABLE `$table_name_3` DROP INDEX `{$fieldInfo[FieldName]}` ";
		$sql_4 = "ALTER TABLE `$table_name_4` DROP INDEX `{$fieldInfo[FieldName]}` ";
		$result = $db->query($sql_1);
		$result = $db->query($sql_2);
		$result = $db->query($sql_3);
		$result = $db->query($sql_4);
		

		if($result) {
			/*
			$deploy = new dbDeploy();
			$deploy->connectTo($this->getTableInfo($fieldInfo[TableID], 'DSNID'),$fieldInfo[TableID]);
			$deploy->deleteIndex( $fieldInfo);
			*/

			$deploy->close();

			//$db->connect($db_config);
			
			$this->flushData();
			$this->addData('IsIndex', 0);

			if($this->_edit_field($ContentFieldID))	return true;
			else return false;

		} else 
			return false;	
	}
	/**
     * Method:	更新content_fields 表中的字段信息
	 * @param int $ContentFieldID
	 * @return boolean
     */
	function _edit_field($ContentFieldID)
	{
		global $table;
		//echo $ContentFieldID;exit;
		$where="where ContentFieldID=".$ContentFieldID;
		if($this->dataUpdate($table->content_fields,$where))
			return true;
		else return false;
	
	}

	/**
     * Method:获得内容模型某个字段的信息
	 * @param int $ContentFieldID
	 * @return array
     */	
	function getFieldInfo($ContentFieldID)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->content_fields where ContentFieldID=$ContentFieldID";
		
		$data  = $db->getRow($sql);
		
		return $data;
	}

	/**
     * Method: 删除字段@内容模型表
	 * @param int $ContentFieldID
	 * @return boolean
     */		
	function delField($ContentFieldID)
	{
		global $table,$db,$db_config;
		$info = $this->getFieldInfo($ContentFieldID);
		$table_name_1 = $db_config['table_pre'].$db_config['table_content_pre'].'_'.$info[TableID];
		$table_name_2 = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$info[TableID];
		$table_name_3 = $db_config['table_pre'].$db_config['table_collection_pre'].'_'.$info[TableID];
		$table_name_4 = $db_config['table_pre'].$db_config['table_publish_pre'].'_'.$info[TableID];
		
		$sql_1 = "ALTER TABLE `$table_name_1` DROP `{$info[FieldName]}`";
		$sql_2 = "ALTER TABLE `$table_name_2` DROP `{$info[FieldName]}`";
		$sql_3 = "ALTER TABLE `$table_name_3` DROP `{$info[FieldName]}`";
		$sql_4 = "ALTER TABLE `$table_name_4` DROP `{$info[FieldName]}`";

		//echo $sql;
		//exit;
		if($db->query($sql_1) && $db->query($sql_2) && $db->query($sql_3)&& $db->query($sql_4)) {
			
			/*$deploy = new dbDeploy();
			$deploy->connectTo($this->getTableInfo($fieldInfo[TableID], 'DSNID'), $fieldInfo[TableID]);
			$deploy->delField($fieldInfo, $data);
			$deploy->close();*/
			//echo $db->info();
			//$db->connect($db_config);
			$pluginFactory = & get_singleton("CMS.Plugin");
			$Plugin = & $pluginFactory->getInstance();
			$Plugin->delField($info[TableID], $info, $data);

			if($this->_del_data($ContentFieldID)) return true;
			else return false;

		} else return false;
	
	}

	/**
     * Method: 删除字段记录@content_fields内容表字段集
	 * @param int $ContentFieldID
	 * @return boolean
     */		
	function _del_data($ContentFieldID)
	{
		global $table;
		$which="ContentFieldID";
		
		if($this->dataDel($table->content_fields,$which,$ContentFieldID,$method="="))
			return true;
		else return false;
	
	}
	
	/**
     * Method: 对字段集进行排序
	 * @param int $TableID, array $Fields
	 * @return boolean
     */			
	function OrderField($Fields)
	{
		foreach($Fields as $key=>$var) {
			$this->flushData();
			$this->addData('FieldOrder',$key);
			if($this->_edit_field($var))
				$return = true;
			else
				$return = false;

		
		}

		return $return;
	}

	/**
     * Method: 将字段标识为在内容列表中显示
	 * @param int $ContentFieldID, $display
	 * @return boolean
     */			
	function EnableFieldListDisplay($ContentFieldID, $display)
	{
		$this->flushData();
		$this->addData('FieldListDisplay', $display);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;
	
	}

	function EnableFieldSearch($ContentFieldID, $searchable)
	{
		$this->flushData();
		$this->addData('FieldSearchable', $searchable);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;
	
	}


	function EnableContribution($ContentFieldID, $searchable)
	{
		$this->flushData();
		$this->addData('EnableContribution', $searchable);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;
	
	}

	function EnableCollection($ContentFieldID, $searchable)
	{
		$this->flushData();
		$this->addData('EnableCollection', $searchable);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;
	
	}
	function EnablePublish($ContentFieldID, $searchable)
	{
		$this->flushData();
		$this->addData('EnablePublish', $searchable);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;
	
	}


	function setAsMainField($ContentFieldID, $TableID)
	{
		global $table,$db;
		//echo $ContentFieldID;exit;
		$this->flushData();
		$this->addData('IsMainField', 0);
		$where="where TableID=".$TableID;
		$this->dataUpdate($table->content_fields,$where);


		$this->flushData();
		$this->addData('IsMainField', 1);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;	
	}

	/**
	 * 设为标题字段
	 */
	function setAsTitleField($ContentFieldID, $TableID)
	{
		global $table,$db;
		//echo $ContentFieldID;exit;
		$this->flushData();
		$this->addData('IsTitleField', 0);
		$where="where TableID=".$TableID;
		$this->dataUpdate($table->content_fields,$where);


		$this->flushData();
		$this->addData('IsTitleField', 1);
		if($this->_edit_field($ContentFieldID))
			return true;
		else
			return false;	
	}

	/**
     * Method: 获得内容列表中显示的所有字段
	 * @param int $ContentFieldID, $display
	 * @return boolean
     */			
	public static function getDisplayFieldsInfo($TableID)
	{
		global $table,$db ,$CONTENT_MODEL_INFO;
		if(empty($TableID)) return false;
		if(!empty($CONTENT_MODEL_INFO)) {
			foreach($CONTENT_MODEL_INFO[$TableID]['Model'] as $var) {
				if($var['FieldListDisplay'] == 1) $data[] = $var;
				else continue;
				
			}
		} else {
			$sql  ="SELECT * FROM $table->content_fields where TableID=$TableID AND FieldListDisplay=1 Order By FieldOrder";
			$result = $db->Execute($sql);
			while(!$result->EOF) {
				$data[] = $result->fields;
				$result->MoveNext();
			}
		
		}
		//debug($data);
		return $data;
	
	}


	public static function getSearchFieldsInfo($TableID)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->content_fields where TableID=$TableID AND FieldSearchable=1 Order By FieldOrder";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		//debug($data);
		return $data;
	
	}

	public static function getTitleFieldInfo($TableID)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->content_fields where TableID=$TableID AND IsTitleField=1 ";
		$result = $db->getRow($sql);
		//debug($data);
		return $result;
	
	}
}

?>