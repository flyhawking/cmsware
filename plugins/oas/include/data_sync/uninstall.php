<?php
$table_header = &$db_config['table_pre'];

$uninstall_sql = <<<EOT
DROP TABLE IF EXISTS {$table_header}plugin_oas_access ;
DROP TABLE IF EXISTS {$table_header}plugin_oas_setting ;
DROP TABLE IF EXISTS {$table_header}plugin_oas_sessions ;
DROP TABLE IF EXISTS {$table_header}plugin_oas_permission ;
DROP TABLE IF EXISTS {$table_header}plugin_oas_access_map ;
DROP TABLE IF EXISTS {$table_header}plugins_oas_user;
EOT;
$result =  plugin_runquery($uninstall_sql);
?>