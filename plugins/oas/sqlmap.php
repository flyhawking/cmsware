<?php

$_sqlMap_select = array(
	'getOasInfo' => "select * from {$GLOBALS['plugin_table']['oas']['setting']}",
	'getAllPermission'=> "select * from {$GLOBALS['plugin_table']['oas']['permission']}",
	'getPermissionInfo'=>  "select * from {$GLOBALS['plugin_table']['oas']['permission']} where PermissionKey='#PermissionKey#'",

);

$_sqlMap_insert = array(
	'user'=> array(
		'table'=> $table->user,
		'sql'=>"insert into {$GLOBALS['plugin_table']['oas']['setting']} values(#UserName#)"),
	'addPermission'=>array(
		'table'=> $GLOBALS['plugin_table']['oas']['permission']),

);


$_sqlMap_update = array(
	'updateOasInfo'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['setting'],
		//'where'=>"UserID=#UserID# AND UserName=#UserName#",
		'sql'=>"update {$table->user} set UserName=#UserName# where UserID=#UserID#"),
		

);

$_sqlMap_delete = array(
	'user'=> array(
		'table'=> $table->user,
		'where'=>"UserID=#UserID# AND UserName=#UserName#",
		'sql'=>"delete from {$table->user} where UserID=#UserID# "),
	'delPermission'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['permission'],
		'where'=>"PermissionKey='#PermissionKey#'",),
	'delAccessMap'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access_map'],
		'where'=>"PermissionKey='#PermissionKey#'",),
 
);





?>