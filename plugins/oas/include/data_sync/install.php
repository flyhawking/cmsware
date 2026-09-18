<?php

$table_header = &$db_config['table_pre'];
$install_sql = <<<EOT
CREATE TABLE {$table_header}plugin_oas_access (
  `AccessID` int(10) NOT NULL auto_increment,
  `AccessType` tinyint(1) default '1',
  `OwnerID` int(10) default NULL,
  `AccessInherit` text,
  `Info` text,
  PRIMARY KEY  (`AccessID`),
  UNIQUE KEY `AccessID` (`AccessID`)
) TYPE=MyISAM;

CREATE TABLE {$table_header}plugin_oas_setting (
  `key` varchar(32) NOT NULL default '',
  `value` text NOT NULL,
  PRIMARY KEY  (`key`)
) TYPE=MyISAM;

CREATE TABLE {$table_header}plugin_oas_sessions (
  `sId` varchar(32) NOT NULL default '',
  `UserName` varchar(32) NOT NULL default '',
  `UserID` int(8) NOT NULL default '0',
  `GroupID` int(8) default NULL,
  `LogInTime` int(10) NOT NULL default '0',
  `RunningTime` int(10) NOT NULL default '0',
  `Ip` varchar(16) NOT NULL default '',
  `SessionData` blob,
  PRIMARY KEY  (`sId`)
) TYPE=MyISAM;

CREATE TABLE {$table_header}plugin_oas_permission (
  `PermissionKey` varchar(32) NOT NULL default '',
  `PermissionInfo` varchar(250) NOT NULL default '',
  `Reserved` tinyint(1) default '0',
  `OrderKey` int(5) NOT NULL default '0',
  PRIMARY KEY  (`PermissionKey`),
  UNIQUE KEY `PermissionKey` (`PermissionKey`)
) TYPE=MyISAM;

CREATE TABLE {$table_header}plugin_oas_access_map (
  `AccessID` int(10) NOT NULL default '0',
  `PermissionKey` varchar(32) NOT NULL default '',
  `AccessNodeIDs` text,
  PRIMARY KEY  (`AccessID`,`PermissionKey`)
) TYPE=MyISAM;

CREATE TABLE {$table_header}plugins_oas_user (
  `UserID` int(11) NOT NULL auto_increment,
  `UserName` varchar(32) NOT NULL,
  PRIMARY KEY (`UserID`)
) TYPE=MyISAM;

INSERT INTO {$table_header}plugin_oas_permission VALUES ('ReadIndex', '首页浏览', 1, 0);
INSERT INTO {$table_header}plugin_oas_permission VALUES ('ReadContent', '内容页浏览', 1, 0);
INSERT INTO {$table_header}plugin_oas_permission VALUES ('PostComment', '发布评论', 1, 0);
INSERT INTO {$table_header}plugin_oas_permission VALUES ('ReadComment', '查看评论', 1, 0);


INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_Address', 'http://passport/soap.php');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_TransactionAccessKey', '1234');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_RootURL', 'http://passport');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('OAS_RootURL', 'http://cmsware/oas');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_SessionActiveTime', '1800');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_AdminUserName', 'hawking');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_AdminPassword', 'a');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_SelfAdminURL', '');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('CWPS_SelfIndexURL', '');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('AccessDenyTpl', '/oas/access_deny.html');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('IndexPageCacheTime', '1800');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('ContentPageCacheTime', '86400');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_enableComment', '1');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_enableCommentApprove', '0');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_Tpl', '/oas/comment/comment.html');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_contentMinLength', '3');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_contentMaxLength', '1000');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_filterMode', '0');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_replaceWord', '*');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_filterWords', 'fuck,shit,靠,妈的');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_PageNum', '15');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_EnableDisplayCache', '1');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('Comment_HiddenCommentIP', '1');
INSERT INTO {$table_header}plugin_oas_setting VALUES ('EnableCacheUseSubDirs', '1');

EOT;

$result = plugin_runquery($install_sql);
?>