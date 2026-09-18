<?php
$table_header = &$db_config['table_pre'];

$uninstall_sql = <<<EOT
DROP TABLE {$table_header}plugin_base_comment;
DROP TABLE {$table_header}plugin_base_count;
DROP TABLE {$table_header}plugin_base_setting;
EOT;
$result =  plugin_runquery($uninstall_sql);
?>