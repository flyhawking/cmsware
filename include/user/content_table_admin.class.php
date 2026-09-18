<?php
class content_table_admin extends iData{

	/**
     * Method:	添加新的内容模型表
	 * @void
	 * @return boolean
     */
	function addTable($TableID = 0)
	{
		global $table,$db_config,$db;
		if($this->dataInsert($table->content_table)) {
			$table_content_name = $db_config['table_pre'].$db_config['table_extra_pre'].'_'.$this->db_insert_id;
			$table_contribution_name = $db_config['table_pre'].$db_config['table_contribution_pre'].'_'.$this->db_insert_id;
			$sql_content = "CREATE TABLE `$table_content_name` (
					`ContentID` INT( 10 ) NOT NULL AUTO_INCREMENT,
					`CreationDate` INT( 10 ) NOT NULL,
					`ModifiedDate` INT( 10 ) NOT NULL,
					`CreationUserID` INT( 8 ) NOT NULL,
					`LastModifiedUserID` INT( 8 ) NOT NULL,
					`ContributionUserID` INT( 8 ) NOT NULL,
					PRIMARY KEY (
					`ContentID` 
					),
					) TYPE=MyISAM";
			$sql_contribution = "CREATE TABLE `$table_contribution_name` (
					`ContentID` INT( 10 ) NOT NULL AUTO_INCREMENT,
					`CreationDate` INT( 10 ) NOT NULL,
					`ModifiedDate` INT( 10 ) NOT NULL,
					`CreationUserID` INT( 8 ) NOT NULL,
					`LastModifiedUserID` INT( 8 ) NOT NULL,

					PRIMARY KEY (
					`ContentID` 
					),
					) TYPE=MyISAM";

			if($db->query($sql_content) && $db->query($sql_contribution) ) return true;
			else return false;
			
			
		
		} else return false;
		
	}

	/**
     * Method:获得所有内容模型表
	 * @void
	 * @return array
     */	
	function getAllTable()
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

	/**
     * Method:获得内容模型表的字段详细信息
	 * @param int $TableID
	 * @return array
     */	
	function getTableFieldsInfo($TableID)
	{
		global $table,$db;
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
	function getTableInfo($TableID)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->content_table where TableID=$TableID";
		
		$data  = $db->getRow($sql);
		
		return $data;
	}

	/**
     * Method:更新内容模型表的记录
	 * @param int $eId
	 * @return array
     */	
	function updateTable($TableID)
	{
		global $table;
		$where="where TableID=".$TableID;
		if($this->dataUpdate($table->content_table,$where))
			return true;
		else return false;
	
	}


	/**
     * Method: 删除内容模型表
	 * @param int $eId
	 * @return array
     */		
	function delTable($TableID)
	{
		global $table,$db_config,$db;
		$which="TableID";
		
		if($this->dataDel($table->content_table,$which,$TableID,$method="=")) {

			$db->query("DELETE FROM $table->content_fields WHERE TableID=$TableID");
			$table_name = $db_config['table_pre'].$db_config['table_extra_pre'].'_'.$TableID;

			$sql = "DROP TABLE $table_name ";

			if($db->query($sql)) return true;
			else return false;

		} else return false;
			
		
	
	}
//---------------------------------以下为字段处理-------------------------------	
	/**
     * Method:	添加新的字段内容模型表
	 * @param int $TableID
	 * @param array $data
	 * @return boolean
     */
	function addField($TableID, $data)
	{
		global $table, $db_config, $db;
		$table_name = $db_config['table_pre'].$db_config['table_extra_pre'].'_'.$TableID;
		if($data[FieldSize] != '' && $data[FieldType] != 'text' && $data[FieldType] != 'mediumtext' && $data[FieldType] != 'longtext') $length = "({$data[FieldSize]})";

		

		$sql = "ALTER TABLE `$table_name` ADD `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
		$result = $db->query($sql);

		if($data['index'] != ''  && $data[FieldType] != 'text' && $data[FieldType] != 'mediumtext' && $data[FieldType] != 'longtext') {
			$sql = "ALTER TABLE `$table_name` ADD INDEX (`{$data[FieldName]}`) ";
			$result = $db->query($sql);
		}

		if($data['fulltext'] != '' ) {
			$sql = "ALTER TABLE `$table_name` ADD FULLTEXT (`{$data[FieldName]}`) ";
			$result = $db->query($sql);
		
		}
		//echo $sql;
		//exit;
		if($result) {
			$this->flushData();
			$this->addData('TableID', $TableID);
			$this->addData('FieldTitle', $data[FieldTitle]);
			$this->addData('FieldName', $data[FieldName]);
			$this->addData('FieldType', $data[FieldType]);
			$this->addData('FieldSize', $data[FieldSize]);
			$this->addData('FieldDefaultValue', $data[FieldDefaultValue]);
			$this->addData('FieldInput', $data[FieldInput]);
			$this->addData('FieldDescription', $data[FieldDescription]);

			if($this->_add_field())	return true;
			else return false;

		} else 
			return false;

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

		$table_name = $db_config['table_pre'].$db_config['table_extra_pre'].'_'.$fieldInfo[TableID];
		if($data[FieldSize] != '' && $data[FieldType] != 'text' && $data[FieldType] != 'mediumtext' && $data[FieldType] != 'longtext') $length = "({$data[FieldSize]})";


		$sql = "ALTER TABLE `$table_name` CHANGE `{$fieldInfo[FieldName]}` `{$data[FieldName]}` {$data[FieldType]} $length  NOT NULL";
		$result = $db->query($sql);

		if($data['index'] != ''  && $data[FieldType] != 'text' && $data[FieldType] != 'mediumtext' && $data[FieldType] != 'longtext') {
			$sql = "ALTER TABLE `$table_name` ADD INDEX (`{$data[FieldName]}`) ";
			$result = $db->query($sql);
		}

		if($data['fulltext'] != '' ) {
			$sql = "ALTER TABLE `$table_name` ADD FULLTEXT (`{$data[FieldName]}`) ";
			$result = $db->query($sql);
		
		}
		//echo $sql;
		//exit;
		if($result) {
			$this->flushData();
			$this->addData('FieldTitle', $data[FieldTitle]);
			$this->addData('FieldName', $data[FieldName]);
			$this->addData('FieldType', $data[FieldType]);
			$this->addData('FieldSize', $data[FieldSize]);
			$this->addData('FieldDefaultValue', $data[FieldDefaultValue]);
			$this->addData('FieldInput', $data[FieldInput]);
			$this->addData('FieldDescription', $data[FieldDescription]);

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
		$table_name = $db_config['table_pre'].$db_config['table_extra_pre'].'_'.$info[TableID];
		$sql = "ALTER TABLE `$table_name` DROP `{$info[FieldName]}`";

		//echo $sql;
		//exit;
		if($db->query($sql)) {

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

	/**
     * Method: 获得内容列表中显示的所有字段
	 * @param int $ContentFieldID, $display
	 * @return boolean
     */			
	function getDisplayFieldsInfo($TableID)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->content_fields where TableID=$TableID AND FieldListDisplay=1 Order By FieldOrder";
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