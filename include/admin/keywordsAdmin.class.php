<?php
	
class keywordsAdmin extends iData {
	
	function add()
	{
		global $table;
		if($this->dataInsert($table->keywords)) {
			return true;
		} else return false;
	
	}

	function del($kId)
	{
		global $table;
		$which="kId";
		
		if($this->dataDel($table->keywords,$which,$kId,$method="="))
			return true;
		else return false;
	
	}

	function update($kId)
	{
		global $table;
		$where="where kId=".$kId;
		if($this->dataUpdate($table->keywords,$where))
			return true;
		else return false;
	
	}

	function getAll()
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->keywords ";
		$result = $db->Execute($sql, 2, 10000);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}
	
	function getLimit($start = 0, $offset = 15)
	{
		global $table,$db;
		if($start == '')	$start = 0;

		if($offset == '')	$offset = 15;

		$sql  ="SELECT * FROM $table->keywords  ORDER BY kId DESC LIMIT $start, $offset";
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
		$sql = "SELECT COUNT(*) as nr  FROM $table->keywords "	;
		$result = $db->getRow($sql);

		return $result[nr];

	}
	function getInfo($kId)
	{
		global $table,$db;
		
		

		$sql  ="SELECT * FROM $table->keywords   WHERE kId='$kId'";
		
		$result = $db->getRow($sql);
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
		$sql = "SELECT COUNT(*) as nr  FFROM $table->keywords o LEFT JOIN $table->client c ON o.cId=c.cId $where"	;
		 
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


		$sql  ="SELECT o.*,c.* FROM $table->keywords o LEFT JOIN $table->client c ON o.cId=c.cId $where ORDER BY o.oId DESC LIMIT $start, $offset";
		 
		$result = $db->query($sql);
		while($row = $db->fetch_array($result)) {
			$data[] = $row;
		}
		

		return $data;
	
	}
	*/
}

?>