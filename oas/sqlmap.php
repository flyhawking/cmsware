<?php

$_sqlMap_select = array(
	'getPublishInfo' => "SELECT p.*,u.UserName as CreationUserName,u.UserID as CreationUserID from #table_publish# p, #table_content# c, {$GLOBALS['plugin_table']['oas']['user']} u  where p.IndexID='#IndexID#' AND c.ContentID=p.ContentID AND c.CreationUserID=u.UserID",

 	'getContentInfo' => "SELECT i.*,c.*,u.UserName as CreationUserName,u.UserID as CreationUserID from $table->content_index i, #table_content# c, {$GLOBALS['plugin_table']['oas']['user']} u  where i.IndexID='#IndexID#' AND c.ContentID=i.ContentID AND c.CreationUserID=u.UserID",

 	'getCommentInfo' => "SELECT * from {$GLOBALS['db_config']['table_pre']}plugin_base_comment  where CommentID='#CommentID#' ",

	'getCountInfo'=> "SELECT * From {$GLOBALS['db_config']['table_pre']}plugin_base_count WHERE IndexID='#IndexID#'",

);

$_sqlMap_insert = array(
	'comment'=> array(
		'table'=> $GLOBALS['db_config']['table_pre']."plugin_base_comment",
		),
 
);


$_sqlMap_update = array(
	'updateCommentNum'=> array(
 		'sql'=>"update {$GLOBALS['db_config']['table_pre']}plugin_base_count set `CommentNum`=CommentNum+1 where IndexID='#IndexID#'"),
		
	'updateCommentInfo'=> array(
 		'sql'=>"update {$GLOBALS['db_config']['table_pre']}plugin_base_comment set `Comment`='#Comment#' where CommentID='#CommentID#'"),

	'updateHits'=> array(
		'sql'=>"UPDATE {$GLOBALS['db_config']['table_pre']}plugin_base_count Set `Hits_Total`=Hits_Total+1 where IndexID='#IndexID#'",
	),

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