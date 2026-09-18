<?php

$_sqlMap_select = array(
	'getOasInfo' => "select * from {$GLOBALS['plugin_table']['oas']['setting']}",
	'getAccessInfoByGroupID'=>"SELECT * FROM {$GLOBALS['plugin_table']['oas']['access']} where OwnerID=#GroupID# AND AccessType=1 ",
	'getAccessInfoByAccessID'=>"SELECT * FROM {$GLOBALS['plugin_table']['oas']['access']} where AccessID=#AccessID#",
	
	'getAllPermission'=>"SELECT * FROM {$GLOBALS['plugin_table']['oas']['permission']} ORDER BY OrderKey ",
	
	'getAccessMapByAccessID'=>"SELECT * FROM {$GLOBALS['plugin_table']['oas']['access_map']} where AccessID=#AccessID#",

);

$_sqlMap_insert = array(
	'addAccess'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access']),
	'addAccessMap'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access_map']),

);


$_sqlMap_update = array(
	'updateAccess'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access'],
		'where'=>"AccessID='#AccessID#'"),
 		

);

$_sqlMap_delete = array(
	'user'=> array(
		'table'=> $table->user,
		'where'=>"UserID=#UserID# AND UserName=#UserName#",
		'sql'=>"delete from {$table->user} where UserID=#UserID# "),
	'delAccess'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access'],
		'where'=>"AccessID='#AccessID#'"),
	'delAccessMap'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access_map'],
		'where'=>"AccessID='#AccessID#'"),
 
);


 


?>