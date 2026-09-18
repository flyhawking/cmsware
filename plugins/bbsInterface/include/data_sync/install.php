<?php

$table_header = &$db_config['table_pre'];
$install_sql = <<<EOT
CREATE TABLE {$table_header}plugin_bbsi_access (
  `AccessID` int(10) NOT NULL auto_increment,
  `AccessType` int(1) NOT NULL default '0',
  `Info` text NOT NULL,
  `OwnerID` int(10) NOT NULL default '0',
  `ReadIndex` text NOT NULL,
  `ReadContent` text NOT NULL,
  `PostComment` text NOT NULL,
  `ReadComment` text NOT NULL,
  `AuthInherit` text NOT NULL,
  PRIMARY KEY  (`AccessID`,`AccessType`),
  KEY `PermissionType` (`AccessType`,`OwnerID`)
) TYPE=MyISAM AUTO_INCREMENT=19 ;

CREATE TABLE {$table_header}plugin_bbsi_setting (
  `ForegroundPath` varchar(250) NOT NULL default '',
  `BBS` varchar(50) NOT NULL default '',
  `DenyTpl` varchar(250) NOT NULL default ''
) TYPE=MyISAM;

INSERT INTO `{$table_header}plugin_bbsi_setting` VALUES ('../publish/member', 'phpwind2.0.1', '/dynamic/error.html');

EOT;

$result = plugin_runquery($install_sql);
?>