<?php

$table_header = &$db_config['table_pre'];
$install_sql = <<<EOT
CREATE TABLE {$table_header}plugin_base_comment (
  `CommentID` int(10) NOT NULL auto_increment,
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `Author` varchar(100) default NULL,
  `CreationDate` int(10) default NULL,
  `Ip` varchar(15) default NULL,
  `Comment` text,
  PRIMARY KEY  (`CommentID`),
  KEY `IndexID` (`IndexID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM ;




CREATE TABLE {$table_header}plugin_base_count (
  `Hits_Total` int(10) NOT NULL default '0',
  `Hits_Today` int(10) NOT NULL default '0',
  `Hits_Week` int(10) NOT NULL default '0',
  `Hits_Month` int(10) NOT NULL default '0',
  `Hits_Date` int(10) NOT NULL default '0',
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `CommentNum` int(10) NOT NULL default '0',
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;



CREATE TABLE {$table_header}plugin_base_setting (
  `TableID` int(6) unsigned NOT NULL default '0',
  `CommentMode` tinyint(1) default '0',
  `CommentTpl` varchar(250) default NULL,
  `CommentCache` tinyint(1) default '1',
  `CommentPageOffset` tinyint(3) default '15',
  `CommentLength` int(10) default NULL,
  `IpHidden` tinyint(1) default '1',
  `AllowBBcode` tinyint(1) default '0',
  `AllowSmilies` tinyint(1) default '0',
  `AllowHtml` tinyint(1) default '0',
  `AllowImgcode` tinyint(1) default '0',
  `SearchMode` tinyint(1) default '0',
  `SearchTpl` varchar(250) default NULL,
  `SearchProTpl` varchar(250) default NULL,
  `SearchPageOffset` tinyint(3) default '15',
  `AllowSearchField` text,
  PRIMARY KEY  (`TableID`)
) TYPE=MyISAM;



INSERT INTO `{$table_header}plugin_base_setting` VALUES (1, 1, '/plugins/base/comment_bbsInterface.html', 1, 15, 1000, 1, 0, 0, 0, 0, 0, '/plugins/base/search_result.html', '/plugins/base/search_pro.html', 10, 'Title,Content');
EOT;

$result = plugin_runquery($install_sql);