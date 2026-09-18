<?php
class Plugin extends iData {
	var $CACHE_AllPlugins;
	
	function canAccess($plugin)
	{
		global $db,$table,$sys;

		if($sys->session['sGIsAdmin'] == 1) return true;

		$sql = "SELECT * FROM $table->plugins where Path='$plugin'";
		$result = $db->getRow($sql);
		if(empty($result['pId']))
			return false;
		else {
			if(strpos($result['AccessGroup'], $sys->session['sGId']))
				return true;
			elseif(strpos($result['AccessUser'], $sys->session['sUId']))
				return true;
			else
				return false;
		
		
		}
		
	}

	function getAllPlugins()
	{
		global $table,$db;
		if(empty($this->CACHE_AllPlugins)) {
			$sql  ="SELECT * FROM $table->plugins  ORDER BY pId DESC  ";
			$result = $db->Execute($sql);
			while(!$result->EOF) {
				$data[] = $result->fields;

				$result->MoveNext();
			}
			$this->CACHE_AllPlugins = $data;
		} else {
			$data = $this->CACHE_AllPlugins;
		}
		return $data;
	
	}
	function update($publishInfo)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$NodeInfo = $iWPC->loadNodeInfo($publishInfo['NodeID']);
		$TableID = $NodeInfo['TableID'];
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/update.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	}

	function del($IndexID)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
 
		$IndexInfo = $db->getRow("SELECT NodeID  FROM $table->content_index WHERE IndexID='$IndexID'");
		$NodeInfo = $iWPC->loadNodeInfo($IndexInfo['NodeID']);
		$TableID = $NodeInfo['TableID'];
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/del.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	
	}

	function addTable($TableID)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/add_table.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	
	}

	function delTable($TableID)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/del_table.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	
	}

	function addField($TableID, $data)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/add_field.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	
	}

	function editField($TableID, $fieldInfo, $data)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/edit_field.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	
	}

	function delField($TableID, $fieldInfo)
	{
		global $table,$db,$db_config,$sys,$plugin_table,$iWPC;
		$plugins = $this->getAllPlugins();
		foreach($plugins as $key=>$var) {
			$processFile = PLUGIN_PATH.$var['Path'].'/include/data_sync/del_field.php';
			if(file_exists($processFile)) include($processFile);
		
		}
	
	}

}
?>