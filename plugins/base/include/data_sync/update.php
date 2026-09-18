<?php
$table_count =  $db_config['table_pre'].'plugin_base_count'; 
$sql = "SELECT IndexID FROM $table_count WHERE IndexID = '{$publishInfo['IndexID']}'";
$result = $db->getRow($sql);
if(empty($result[IndexID])) { //记录不存在,插入记录
	$sql = "INSERT INTO $table_count (`IndexID`, `ContentID`, `NodeID`,`TableID`) VALUES('{$publishInfo['IndexID']}', '{$publishInfo['ContentID']}', '{$publishInfo['NodeID']}', '{$publishInfo['TableID']}')";
	$db->query($sql);
}  
//  echo $sql;

?>