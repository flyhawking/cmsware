<?php

$_sqlMap_select = array(
	'getOasInfo' => "select * from {$GLOBALS['plugin_table']['oas']['setting']}",
	'getAccessInfoByUserID'=>"SELECT * FROM {$GLOBALS['plugin_table']['oas']['access']} where OwnerID=#UserID# AND AccessType=0 ",
	'getAccessInfoByAccessID'=>"SELECT * FROM {$GLOBALS['plugin_table']['oas']['access']} where AccessID=#AccessID#",
	
	'getRecordNum'=>"SELECT count(*) nr FROM {$GLOBALS['plugin_table']['oas']['access']} where AccessType=0",
	'getRecordLimit'=> "SELECT * FROM {$GLOBALS['plugin_table']['oas']['access']} WHERE AccessType=0 Limit #start#, #offset# ",

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
	'delAccess'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access'],
		'where'=>"AccessID='#AccessID#'"),
	'delAccessMap'=> array(
		'table'=> $GLOBALS['plugin_table']['oas']['access_map'],
		'where'=>"AccessID='#AccessID#'"),
 
);





?>