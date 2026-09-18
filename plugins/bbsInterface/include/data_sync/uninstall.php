<?php
$table_header = &$db_config['table_pre'];

$uninstall_sql = <<<EOT
DROP TABLE {$table_header}plugin_bbsi_access;
DROP TABLE {$table_header}plugin_bbsi_setting;
EOT;
$result =  plugin_runquery($uninstall_sql);
?>