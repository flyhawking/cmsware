<?php
$table_search = $db_config['table_pre'].'plugin_fulltext_search_'.$TableID; 

$sql = "Create table IF NOT EXISTS $table_search  (
					IndexID Integer(10) NOT NULL ,
					ContentID Integer(10) NOT NULL ,
					NodeID Integer(10) NOT NULL ,
					PublishDate Integer(10) ,
					URL Char(250) ,
					Primary Key (IndexID) ,
					KEY ContentID (ContentID), 
					KEY NodeID (NodeID), 
					KEY PublishDate (PublishDate) 
				)";
$db->query($sql);
?>