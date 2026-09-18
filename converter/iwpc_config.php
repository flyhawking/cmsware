<?php

$iwpc_db_config['db_driver']   = 'db';	 
$iwpc_db_config['db_type']     = 'mysql';
$iwpc_db_config['db_host']     = 'localhost';	//数据库主机名
$iwpc_db_config['db_user']     = 'root';		//数据库用户名
$iwpc_db_config['db_password'] = '';			//数据库密码
$iwpc_db_config['db_name']     = 'iwpc26';		//数据库名
$iwpc_db_config['table_pre']     = "iwpc_";		//表名前缀

$iwpc_table['cate'] = $iwpc_db_config['table_pre']."cate";
$iwpc_table['content'] = $iwpc_db_config['table_pre']."main_doc";
$iwpc_table['comment'] = $iwpc_db_config['table_pre']."comment";
 
?>