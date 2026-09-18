<?php
$table_header = &$db_config['table_pre'];
$TableIDs = array();
$result = $db->Execute("SELECT * FROM {$table_header}plugin_fulltext_fields ");
while(!$result->EOF) {
	if(!in_array($result->fields['TableID'], $TableIDs)) {
		$TableIDs[] = $result->fields['TableID'];
		$sql = "DROP TABLE {$table_header}plugin_fulltext_search_".$result->fields['TableID'];
		$db->query($sql);
	}
 	$result->MoveNext();
}
$result->close();

$uninstall_sql = <<<EOT
DROP TABLE {$table_header}plugin_fulltext_fields;
DROP TABLE {$table_header}plugin_fulltext_setting;
EOT;
$result =  plugin_runquery($uninstall_sql);
?>