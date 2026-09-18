<?php
class iWPC26 extends iData {

	function addCate()
	{
		global $table, $db_config;
		if($this->dataInsert($table->site)) return true;
		else return false;	

	}

	function addContent()
	{
		global $table, $db_config;
		$table_content =  $db_config['table_pre'].$db_config['table_content_pre']."_1"; 
		if($this->dataInsert($table_content)) return true;
		else return false;	

	}	

	function addIndex()
	{
		global $table, $db_config;
		if($this->dataInsert($table->content_index)) return true;
		else return false;
	
	
	}
	
	function addComment()
	{
		global $table, $db_config;
		$table_comment =  $db_config['table_pre'].'plugin_base_comment'; 
		if($this->dataInsert($table_comment)) return true;
		else return false;	

	}

	function addCount()
	{
		global $table, $db_config;
		$table_count =  $db_config['table_pre'].'plugin_base_count'; 
		if($this->dataInsert($table_count)) return true;
		else return false;
	
	
	}

	function getCateNum()
	{
		global $table, $iwpc_table, $db_config, $db, $iWPC;

		$result= $db->getRow("SELECT COUNT(*) as nr  FROM  {$iwpc_table['cate']}");
		return $result['nr'];			
	
	}


	function getCateLimit($start=0, $offset = 100) 
	{
		global $table, $iwpc_table, $db_config, $db, $iWPC;
		$sql="SELECT * FROM {$iwpc_table['cate']} LIMIT $start,$offset";
 		$recordSet=$db->Execute($sql);			
		while(!$recordSet->EOF) {			
			$data[]=$recordSet->fields;
			$recordSet->MoveNext();		
		}
		$recordSet->Close(); 	
		return $data;
	}


	function getContentNum()
	{
		global $table, $iwpc_table, $db_config, $db, $iWPC;

		$result= $db->getRow("SELECT COUNT(*) as nr  FROM  {$iwpc_table['content']}");
		return $result['nr'];			
	
	}

	function getContentLimit($start=0, $offset=100)
	{
		global $table, $iwpc_table, $db_config, $db, $iWPC;
		$sql="SELECT * FROM {$iwpc_table['content']} LIMIT $start,$offset";
		$recordSet=$db->Execute($sql);			
		while(!$recordSet->EOF) {			
			$data[]=$recordSet->fields;
			$recordSet->MoveNext();		
		}
		$recordSet->Close(); 	
		return $data;

	}

	function getCommentNum()
	{
		global $table, $iwpc_table, $db_config, $db, $iWPC;

		$result= $db->getRow("SELECT COUNT(*) as nr  FROM  {$iwpc_table['comment']}");
		return $result['nr'];			
	
	}

	function getCommentLimit($start=0, $offset=100)
	{
		global $table, $iwpc_table, $db_config, $db, $iWPC;
		$sql="SELECT * FROM {$iwpc_table['comment']} LIMIT $start,$offset";
		$recordSet=$db->Execute($sql);			
		while(!$recordSet->EOF) {			
			$data[]=$recordSet->fields;
			$recordSet->MoveNext();		
		}
		$recordSet->Close(); 	
		return $data;
	
	
	}


}
?>