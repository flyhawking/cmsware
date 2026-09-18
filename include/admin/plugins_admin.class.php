<?php
	
class PluginsAdmin extends iData {
	
	function add()
	{
		global $table;
		if($this->dataInsert($table->plugins) && $this->installPlugin($this->db_insert_id)) {
			return true;
		
		} else return false;
	
	}

	function del($pId)
	{
		global $table;
		$which="pId";
		
		if($this->uninstallPlugin($pId) && $this->dataDel($table->plugins,$which,$pId,$method="=")) {
			
			return true;
		
		} else return false;
	
	}

	function update($pId)
	{
		global $table;
		$where="where pId=".$pId;
		if($this->dataUpdate($table->plugins,$where))
			return true;
		else return false;
	
	}

 
	
	function getLimit($start = 0, $offset = 15)
	{
		global $table,$db;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;

		$sql  ="SELECT * FROM $table->plugins  ORDER BY pId DESC LIMIT $start, $offset";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		return $data;
		
	}

	function getAll()
	{
		global $table,$db;
 		$sql  ="SELECT * FROM $table->plugins  ORDER BY pId DESC  ";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		return $data;
		
	}
	
	function getRecordNum() 
	{
		global $table,$db;
		$sql = "SELECT COUNT(*) as nr  FROM $table->plugins "	;
		$result = $db->getRow($sql);

		return $result[nr];


	}

	function getInfo($pId)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->plugins   WHERE pId='$pId'";
		
		$result = $db->getRow($sql);
		return $result;
	}

	function installPlugin($pId)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$pluginInfo = $this->getInfo($pId);
 		$processFile = PLUGIN_PATH.$pluginInfo['Path'].'/include/data_sync/install.php';
		if(file_exists($processFile)) include($processFile);
		return $result;
		
 	}

	function uninstallPlugin($pId)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$pluginInfo = $this->getInfo($pId);
 		$processFile = PLUGIN_PATH.$pluginInfo['Path'].'/include/data_sync/uninstall.php';
		if(file_exists($processFile)) include($processFile);
		return $result;
	
	}





/*
	function searchRecordNum($field, $keywords)
	{
		global $table,$db;
		if($field == 'CUSTOMER') {
			$where = "WHERE c.cName LIKE '%$keywords%'";
		
		} elseif ($field == 'AREA') {
			$where = "WHERE c.cArea LIKE '%$keywords%'";
		
		} else {
			$where = "WHERE o.$field LIKE '%$keywords%'";
		
		}
		$sql = "SELECT COUNT(*) as nr  FFROM $table->plugins o LEFT JOIN $table->client c ON o.cId=c.cId $where"	;
		 
		$result = $db->query_first($sql);
		return $result[nr];
	
	}

	function searchLimit($field, $keywords, $start, $offset)
	{
		global $table,$db;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;
		if($field == 'CUSTOMER') {
			$where = "WHERE c.cName LIKE '%$keywords%'";
		
		} elseif ($field == 'AREA') {
			$where = "WHERE c.cArea LIKE '%$keywords%'";
		
		} else {
			$where = "WHERE o.$field LIKE '%$keywords%'";
		
		}


		$sql  ="SELECT o.*,c.* FROM $table->plugins o LEFT JOIN $table->client c ON o.cId=c.cId $where ORDER BY o.oId DESC LIMIT $start, $offset";
		 
		$result = $db->query($sql);
		while($row = $db->fetch_array($result)) {
			$data[] = $row;
		}
		

		return $data;
	
	}
	*/
}

?>