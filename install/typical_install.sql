DROP TABLE IF EXISTS {$table_header}admin_sessions;
CREATE TABLE {$table_header}admin_sessions (
  `sId` varchar(32) NOT NULL default '',
  `sIpAddress` varchar(16) NOT NULL default '',
  `sUserName` varchar(32) NOT NULL default '',
  `sUId` int(8) NOT NULL default '0',
  `sGId` int(8) NOT NULL default '0',
  `sGAuthData` mediumblob NOT NULL,
  `sGIsAdmin` tinyint(1) NOT NULL default '0',
  `sLogInTime` int(10) NOT NULL default '0',
  `sRunningTime` int(10) NOT NULL default '0',
  `IpSecurity` tinyint(1) NOT NULL default '0',
  `sData` longblob,
  PRIMARY KEY  (`sId`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}node_fields;
CREATE TABLE {$table_header}node_fields (
  `FieldID` int(8) NOT NULL auto_increment,
  `FieldTitle` varchar(20) NOT NULL default '',
  `FieldName` varchar(20) default '',
  `FieldType` varchar(20) default '',
  `FieldSize` varchar(20) NOT NULL default '',
  `FieldInput` varchar(20) default '',
  `FieldDescription` mediumtext,
  `FieldOrder` mediumint(8) NOT NULL default '0',
  `FieldAccess` tinyint(1) NOT NULL default '1',
  `FieldDataSource` text,
  PRIMARY KEY  (`FieldID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}block_ip;
CREATE TABLE {$table_header}block_ip (
  `Id` int(6) unsigned NOT NULL auto_increment,
  `IP` char(15) default NULL,
  `ExpireTime` int(10) default NULL,
  `Reason` char(250) default NULL,
  PRIMARY KEY  (`Id`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}category;
CREATE TABLE {$table_header}category (
  `CateID` int(8) NOT NULL auto_increment,
  `TableID` int(8) NOT NULL default '0',
  `Name` varchar(20) default NULL,
  `ParentID` int(8) default NULL,
  `OwnerID` varchar(20) default NULL,
  `Disabled` tinyint(1) default '0',
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`CateID`),
  KEY `C_D` (`CateID`,`Disabled`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}collection_1;
CREATE TABLE {$table_header}collection_1 (
  `CollectionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `PublishDate` int(10) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `Title` varchar(250) NOT NULL default '',
  `TitleColor` varchar(7) NOT NULL default '',
  `Author` varchar(20) NOT NULL default '',
  `Editor` varchar(20) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `SubTitle` varchar(250) NOT NULL default '',
  `Content` longtext NOT NULL,
  `Keywords` varchar(250) NOT NULL default '',
  `FromSite` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text,
  `Src` varchar(250) NOT NULL default '',
  `IsImported` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`CollectionID`,`CateID`),
  UNIQUE KEY `CollectionID` (`CollectionID`),
  KEY `C_I` (`CateID`,`IsImported`),
  KEY `Src` (`Src`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}collection_2;
CREATE TABLE {$table_header}collection_2 (
  `CollectionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `PublishDate` int(10) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `SoftName` varchar(250) NOT NULL default '',
  `SoftSize` varchar(15) NOT NULL default '',
  `Language` varchar(10) NOT NULL default '',
  `SoftType` varchar(50) NOT NULL default '',
  `Environment` varchar(50) NOT NULL default '',
  `Star` int(2) NOT NULL default '0',
  `Developer` varchar(250) NOT NULL default '',
  `SoftKeywords` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `Download` text NOT NULL,
  `Photo` varchar(250) NOT NULL default '',
  `LocalUpload` varchar(250) NOT NULL default '',
  `Src` varchar(250) NOT NULL default '',
  `IsImported` tinyint(1) NOT NULL default '0',
  `CustomSoftLinks` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`CollectionID`,`CateID`),
  UNIQUE KEY `CollectionID` (`CollectionID`),
  KEY `C_I` (`CateID`,`IsImported`),
  KEY `Src` (`Src`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}collection_3;
CREATE TABLE {$table_header}collection_3 (
  `CollectionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `PublishDate` int(10) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `Src` varchar(250) NOT NULL default '',
  `IsImported` tinyint(1) NOT NULL default '0',
  `Title` varchar(100) NOT NULL default '',
  `Author` varchar(50) NOT NULL default '',
  `Size` varchar(20) NOT NULL default '',
  `FlashSrc` varchar(250) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`CollectionID`,`CateID`),
  UNIQUE KEY `CollectionID` (`CollectionID`),
  KEY `C_I` (`CateID`,`IsImported`),
  KEY `Src` (`Src`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}collection_4;
CREATE TABLE {$table_header}collection_4 (
  `CollectionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `PublishDate` int(10) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `Src` varchar(250) NOT NULL default '',
  `IsImported` tinyint(1) NOT NULL default '0',
  `Content` text NOT NULL,
  PRIMARY KEY  (`CollectionID`,`CateID`),
  UNIQUE KEY `CollectionID` (`CollectionID`),
  KEY `C_I` (`CateID`,`IsImported`),
  KEY `Src` (`Src`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}collection_5;
CREATE TABLE {$table_header}collection_5 (
  `CollectionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `PublishDate` int(10) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `Src` varchar(250) NOT NULL default '',
  `IsImported` tinyint(1) NOT NULL default '0',
  `LinkName` varchar(50) NOT NULL default '',
  `LinkURL` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`CollectionID`,`CateID`),
  UNIQUE KEY `CollectionID` (`CollectionID`),
  KEY `C_I` (`CateID`,`IsImported`),
  KEY `Src` (`Src`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}collection_6;
CREATE TABLE {$table_header}collection_6 (
  `CollectionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `PublishDate` int(10) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `Src` varchar(250) NOT NULL default '',
  `IsImported` tinyint(1) NOT NULL default '0',
  `PhotoName` varchar(250) NOT NULL default '',
  `PhotoURL` varchar(250) NOT NULL default '',
  `PhotoIntro` text NOT NULL,
  PRIMARY KEY  (`CollectionID`,`CateID`),
  UNIQUE KEY `CollectionID` (`CollectionID`),
  KEY `C_I` (`CateID`,`IsImported`),
  KEY `Src` (`Src`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}collection_category;
CREATE TABLE {$table_header}collection_category (
  `CateID` int(10) NOT NULL auto_increment,
  `TableID` int(8) NOT NULL default '0',
  `Name` varchar(50) default NULL,
  `ParentID` int(8) default NULL,
  `Disabled` tinyint(1) default '0',
  `NodeID` int(8) default NULL,
  `SubNodeID` varchar(250) NOT NULL default '0',
  `IndexNodeID` varchar(250) default NULL,
  `TargetURL` text,
  `TargetURLArea` text,
  `UrlFilterRule` text,
  `RepeatCollection` tinyint(1) NOT NULL default '0',
  `HiddenImported` tinyint(1) NOT NULL default '1',
  `AutoImport` tinyint(1) default '0',
  `UrlPageRule` text,
  `DelAfterImport` tinyint(1) default '0',
  `InRunPlan` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`CateID`),
  KEY `C_D` (`CateID`,`Disabled`)
) TYPE=MyISAM;


INSERT INTO {$table_header}collection_category VALUES (1,1,'新华网',0,0,1,'3','4','http://www.xinhuanet.com/newscenter/xhyw.htm','新华要闻{DATA}</html>','/(http:\\/\\/news.xinhuanet.com[^\\\"><\\s]*content_[0-9]+.htm)/isU',0,0,1,'<center><a href=\"{DATA}\" class=\"nextpage\"><img',0,0);
INSERT INTO {$table_header}collection_category VALUES (2,2,'华军软件园',0,0,4,'2','2','http://nj.onlinedown.net/sort/1_1.htm','/<font color=\\\"#ffffff\\\">人气<\\/font><\\/td>(.*)<\\/html>/isU','/<a[\\s]*href=\\\"([^\\\"><\\s]*[0-9]+.htm)\\\"/isU',0,1,0,'',0,0);


DROP TABLE IF EXISTS {$table_header}collection_rules;

CREATE TABLE {$table_header}collection_rules (
  `RuleID` int(10) NOT NULL auto_increment,
  `CateID` int(10) NOT NULL default '0',
  `ContentFieldID` int(8) NOT NULL default '0',
  `TableID` int(8) NOT NULL default '0',
  `Rule` text,
  PRIMARY KEY  (`RuleID`,`CateID`),
  UNIQUE KEY `RuleID` (`RuleID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}collection_rules VALUES (1,1,1,1,'<Title>{DATA}</Title>');
INSERT INTO {$table_header}collection_rules VALUES (2,1,6,1,'<font id=\"Zoom\">{DATA}              </font> \n              <table==>[clearRubbish]==>[localizeImg]==>[page]');
INSERT INTO {$table_header}collection_rules VALUES (3,2,10,2,'/<script language=javascript src=&#092;\"..&#092;/ads&#092;/js_ad_show_3.js&#092;\"><&#092;/script>(.*)<&#092;/td>/isU');
INSERT INTO {$table_header}collection_rules VALUES (4,2,11,2,'<table width=\"97%\"  border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\"><tr><td class=\"p150\">{DATA}</td></tr></table>');
INSERT INTO {$table_header}collection_rules VALUES (5,2,12,2,'开 发 商：</b><a href=\"{DATA}\" target=\"_blank\">Home Page</a>');
INSERT INTO {$table_header}collection_rules VALUES (6,2,13,2,'/<b>软件评级：<\\/b>(.*)<br>/isU==>[download_star__newhua]');
INSERT INTO {$table_header}collection_rules VALUES (7,2,14,2,'/<b>运行环境：<\\/b>(.*)<br>/isU');
INSERT INTO {$table_header}collection_rules VALUES (8,2,15,2,'/<b>软件类别：<\\/b>(.*)<br>/isU  ');
INSERT INTO {$table_header}collection_rules VALUES (9,2,18,2,'<td height=\"30\" align=\"center\" class=\"title_1\"><b>{DATA}</b></td>');
INSERT INTO {$table_header}collection_rules VALUES (10,2,17,2,'/<b>软件大小：<\\/b>(.*)<br>/isU');
INSERT INTO {$table_header}collection_rules VALUES (11,2,16,2,'/<b>软件语言：<\\/b>(.*)<br>/isU');
INSERT INTO {$table_header}collection_rules VALUES (12,1,10,1,'');
INSERT INTO {$table_header}collection_rules VALUES (13,1,5,1,'');
INSERT INTO {$table_header}collection_rules VALUES (14,1,2,1,'');
INSERT INTO {$table_header}collection_rules VALUES (15,1,4,1,'');
INSERT INTO {$table_header}collection_rules VALUES (16,1,3,1,'{Default:Hawking}');
INSERT INTO {$table_header}collection_rules VALUES (17,1,8,1,'{Default:新华网}');
INSERT INTO {$table_header}collection_rules VALUES (18,1,9,1,'');
INSERT INTO {$table_header}collection_rules VALUES (19,1,7,1,'');
INSERT INTO {$table_header}collection_rules VALUES (30,2,20,2,'');
INSERT INTO {$table_header}collection_rules VALUES (31,2,19,2,'<table width=\"100%\"  border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\"><tr><td valign=\"top\" class=\"p150\">{DATA}</td>==>[download_url_parser__newhua]');
INSERT INTO {$table_header}collection_rules VALUES (38,2,22,2,'');
INSERT INTO {$table_header}collection_rules VALUES (39,2,23,2,'');

DROP TABLE IF EXISTS {$table_header}content_1;
CREATE TABLE {$table_header}content_1 (
  `ContentID` int(10) NOT NULL auto_increment,
  `Title` varchar(250) NOT NULL default '',
  `TitleColor` varchar(7) NOT NULL default '',
  `Author` varchar(20) NOT NULL default '',
  `Editor` varchar(20) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `SubTitle` varchar(250) NOT NULL default '',
  `Content` longtext NOT NULL,
  `Keywords` varchar(250) NOT NULL default '',
  `FromSite` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text,
  `CreationDate` int(10) NOT NULL default '0',
  `ModifiedDate` int(10) NOT NULL default '0',
  `CreationUserID` int(8) NOT NULL default '0',
  `LastModifiedUserID` int(8) NOT NULL default '0',
  `ContributionUserID` int(8) NOT NULL default '0',
  `ContributionID` int(8) NOT NULL default '0',
  PRIMARY KEY  (`ContentID`)
) TYPE=MyISAM;



INSERT INTO {$table_header}content_1 VALUES (1,'欢迎使用CMSware内容管理系统2','','','','','','\r\n\r\nasdf \r\n<p>CMSware 全新的系统结构，处处体现了自由的思想，让您体验自由管理的非凡感受 <br/><br/>1、所见即所得的编辑功能 <a href=\"../resource/img/h000/h00/img200508241951290.jpg\" target=\"_blank\"><img alt=\"\" src=\"../resource/img/h000/h00/img200508241951290.jpg\" border=\"0\"/></a><br/><br/>CMSware的内容录入界面充分考虑内容维护人员的实际情况，他们可能不精通HTML，但他们会使用Word等办公软件，因此，系统界面与Word 等Office产品紧密集成，可直接从Word里拖动一块内容到CMSware中来。用户也可以在CMSware里直接进行文字的排版处理，比如改变字体名称，字体大小，字体颜色，背景颜色，以及对齐样式等等。还可以透明地插入图片，并可以任意调整图片的位置、大小，与文字进行环绕等等。系统还支持插入Flash动画，超级连接、特殊字符等等。系统会自动将插入的图片、Flash 等文件上传到系统中合适的目录，而无需用户关心这一切。 </p>\r\n<p>2、多级内容维护人员支持 <br/><br/>CMSware使用基于角色的用户管理，通过添加不同权限的用户,你可以将一个网站的管理权限分配给不同的用户.即可以由多人同时管理一个网站.CMSware的用户管理模块使得一切都变得如此轻松.通过建立具有不同管理权限的用户组，可以将用户分成多种级别，超级管理员，分类管理员，以及最基本的文档录入，审核员。一篇内容从最初录入到最后发布到网站上，中间需要经过管理员审批。管理员登陆系统编辑文章并审批，保证内容及时地更新到网站上去。 </p>\r\n<p>3、先进的模板管理模块 <br/><br/>我们充分研究了国内外的内容管理系统，发现他们大都能够实现结合模板自动生成页面，减轻了页面制作人员的工作量，但是模板制作本身缺要求有较高技术水平的人员，有些系统要求使用基于XML的程序语言XSLT来制作模板，有些系统要求UNIX下的TCL语言来写模板，真可谓是减少了HTML设计人员，却增加了XML编程人员，没有从根本上减轻用户的负担。 <br/>模板的目的是决定系统中录入的内容如何生成成HTML页面。模板其实跟一个普通的HTML页面差不多，在其中固定的位置，插入内容采编系统中输入的字段信息，就生成了最终的HTML页面。 <br/>系统提供所见即所得的模板编辑工具，一个普通的HTML制作人员经过短暂的培训即可制作模板。模板对于整个网站只需要一次性制作，即可一直使用。 <br/>在CMSware的前身iwpc里提供了一个类似word的所见即所得的可视化模板编辑器(WYSIWYG)，可以直接让设计师就可自行完成整个模板的制作。编辑器集成系统资源调用标签和系统函数调用标签,你随时可以查阅调用标签.模板都是HTML文件，即可用在FrontPage里，也可以用在 Dreamwaver中，设计师只要先使用自己熟悉的工具，如FrontPage、Dreamwaver等做好静态的页面，然后，在适当的地方插入CMSware调用标签，一个模板就做好了，不需写任何一行代码。\"系统调用模板\",\"系统调用函数文件\",极大方便用户扩展系统功能. 程序还支持自定义js模板功能，使得文章列表的显示更加灵活，定制更加容易。 <br/>而在CMSware中采用类似XML的标签，同时兼容iWPC原有的调用函数标签，提供更先进、更强大的系统数据调用功能。并增加了Dreamwaver制作插件，能直接在Dreamwaver里使用菜单方式设计模板，不需要学习语法。 </p>\r\n<p>4、文件管理模块 <br/><br/>文件管理模块为网站的管理人员提供了一个类似Windows Explorer界面的文件管理器，允许管理员像管理Windows的文件一样管理网站中的所有文件，包括图片文件、包含文件等。每个分类有独自的文件管理模块，以便支持不同的管理员同时对自己所管理分类中的文件进行管理。 </p>\r\n<p>5、多种发布机制(静态/动态) <br/><br/>CMSware可以将网站内容全部生成静态HTML文件,这样可以极大地节约主机资源，提高系统性能，全静态处理技术是做为构建大型站点的必要条件。无论是再强大的CPU，再高明的数据库，在大量用户访问的情况下也会当机的，而使用我们的程序会避免此类问题发生。这也就是为什么“新浪”“网易”甚至包括SOHU的网站搜索界面都是静态发布的原因了。 <br/>CMSware还在前身版本iwpc的基础之上，增加了动态发布方式，让用户可以对内容页面进行更细致的权限和动态功能进行管理，实现动态网站。 </p>\r\n<p>6、专题管理 <br/><br/>对于新闻类网站，当一些突发事件发生时，来不及专门新开栏目，这时可以将有关该事件的内容整理成一个专题。CMSware允许编辑自行根据情况随时增加新的专题，在第一时间给网站的访问者提供丰富的相关信息。专题中的内容即可以是从其他频道里挑选出来的，也可以直接让记者或编辑往该专题里录入内容。 </p>\r\n<p>7、强大的内容调用首页完全自主设计。 <br/><br/>首页的多样化是吸引大多数网友的必须条件之一。CMSware分类栏目首页完全自主定义。包括图片新闻，显示是否调用时间，栏目，静态模块的放置位置等等。也就是说可以达到想做静态网页那样的效果，想怎么做就怎么做，唯一的区别是，她方便，刷新形成静态内容，或直接生成动态内容。 </p>\r\n<p>8、无限级分类 <br/><br/>CMSware支持无级分类，你可以无限制的对分类建立子分类 。而不是固定的一级或者二级分类。更适合结构复杂的大中型网站。 </p>\r\n<p>9、支持搜索引擎 <br/><br/>借助全静态发布技术，CMSware全部的HTML界面使您的网站出现在搜索引擎的几率大大增高。搜索可是大多数网友获得网络资源最主要的一步。可以说，而您选择CMSware发布网站，就是选择了搜索引擎的一个位置... </p>\r\n<p>10、远程安全发布 <br/><br/>CMSware支持远程发布，既支持对远程服务器和数据库的发布，使用CMSware可以对多个网站进行发布管理，实现了用一个网站管理工具对多个站点的同时管理，这样就减轻网站管理员的工作量。只要CMSware里设置好站点的发布地址，选择要发布的站点地址，然后就可以在CMSware里对站点进行远程管理了，在CMSware里编辑过的内容，CMSware就会自动的发布到已选择好的站点地址里。 <br/>由于管理服务器和发布服务器分离，还大大提高了网站管理服务器的安全，如果发布服务器出了问题，只要在管理服务器重新全部发布部署就可恢复网站。 </p>\r\n<p>11、自定义数据库（字段自定义） <br/><br/>CMSware彻底改变了新闻类网站发布系统的传统，为了更体现自由管理的精髓，增加了自定义内容模型的功能。用户可以利用这个功能方便定制自己的各种内容来发布（下载、音乐、图片册、产品展示、人才、酒店预定。。。），CMSware发布系统核心自动处理实现发布功能，还可以外挂配合专门的动态处理程序来实现特别处理。 </p>\r\n<p>12、语言包支持 <br/><br/>通过简单的替换操作就可以更换成其它语言，方便的实现多语言版本。 </p>\r\n<p>13、多数据库支持 <br/><br/>全新的数据库引擎，全面支持主流数据库。默认支持MySQL，并可以通过更换引擎接口就方便的更换到Oracle、MS SQL Server、PostgreSQL等主流数据库。 </p>\r\n<p>14、更加人性化的操作界面 <br/><br/>支持右键菜单，大部分复杂操作只需点击鼠标即可轻松实现。类似Windows资源管理器的文件管理界面，基于Web页面随处管理网站内容。 </p>\r\n<p>15、简洁的内容管理工作流 <br/><br/>特别适合大型综合门户的内容采编、投稿、审核工作流的实现，用户投稿界面与后台管理界面分离，投稿编辑只接触投稿层。从用户投稿到审核到发布，所有环节流程都由用户自己定夺，适应不同环境的应用要求。 </p>\r\n<p>16、自由的内容自动采集功能 <br/><br/>CMSware还提供了专门的内容采集模块，经过设置，可以自动采集对应网站的内容，并且实现了图片资源自动本地化，从而可以大幅降低采编人员的工作量。 <br/>CMSware的自动采集功能不同于普通的采集模块，可以自由的分来源细项来设置要采集的内容，可以采集非常复杂的来源页面，并且可以配合内容模型自动归类整理。 </p>\r\n<p>17、更多自由特性 <br/><br/>简洁的后台管理结构，没有复杂性，容易管理。 <br/>发布文件分卷保存目录可定制性，你可以实现2003/10/05/xxx.html或者2003-10-05/xxx.html这样的目录结构。 <br/>发布文件后缀可定制性，你可以使用html,shtml或者xml作为静态文件的后缀。 <br/>高级文章评论功能，可以实现类似sina的文章评论功能，高级搜索功能，方便资料查找。 <br/>分类模板继承：可以在新建目录时选择是否安装默认模板，如果你不对子分类设置内容页模板，该分类将自动继承上级分类的模板体系。 <br/>首页图片可以调用自动缩略图生成。结合调用页面显示的实际需求，可以自动把图文文章的图片生成缩略图，加快网页下载速度。 <br/>方便的发布助手，极大方便批量更新整个站点，你要做的只是点击几下鼠标，然后就去喝杯咖啡。 <br/>安装时可选的用户密码加密功能，支持“MD5”,“DES”,“none”三种模式，进一步强化系统安全。 <br/>文章支持多页显示,即一篇文章可以分成好几页，还支持相关文章连接。 <br/>系统支持过期内容自动归档，可以自己设置过期时间。 <br/>数据库优化和备份功能等等。 <br/>简洁明快的全自动安装过程。 <br/><br/>还有更多更多的特性，等着您去发现和体验。。。。。。 <br/></p>','','','','',1112108706,1125657820,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73206,'图文：2005\"\"\"全球3G技术发展专题报告会精英论坛','','','','../resource/img/h000/h00/img200509171011110.jpg','','<P align=center>&nbsp;<IMG alt=图文：2005全球3G技术发展专题报告会精英论坛 src=\"../resource/img/h000/h00/037b1e10a9faed5cd950477d0850c67c.jpg\" border=1><BR>图为：2005全球3G技术发展专题报告会精英论坛。(骆磊 摄)</P>\r\n<P>　　新浪科技讯 2005年9月14日-16日3G在中国2005全球峰会和全球3G设备和业务展示在中国北京凯宾斯基饭店举办。会议由信息产业部电信研究院主办，会议旨在进一步推动和促进中国3G产业的发展。新浪网为指定门户支持。9月15日会议进入第三天。</P>\r\n<P>　　主持人：曹淑敏 信息产业部&gt;</FORM></SPAN>典型研究院</P>\r\n<P>　　女士们、先生们，下午好。今天下午的精英论坛是峰会第三天唯一的一个互动环节。在三天的演讲当中大家听到很多很多非常有价值的内容，同时有很多问题，希望有机会问嘉宾。除了在会下大家接触问问题之外，今天这个精英论坛有一个大家集中的机会，针对你们所感兴趣的问题提问。希望大家能充分利用好这个短暂的机会。提问之前首先介绍一下参加精英论坛的嘉宾：杨贵亮、杨泽民、曹强、渡边文夫、何其锐、王彤、卢勇、余熙、丁伟。</P>\r\n<P>　　我先提一个大家非常关心的问题，因为3G在全世界已经开始规模商用，同时在中国也即将迎来它的到来。3G成功的要点到底是什么？KDDI在这两年中，在3G的运营开展业务方面有非常成功的经验。首先请KDDI的渡边先生介绍一下他所认为3G的成功要点有哪些方面。</P>\r\n<P align=center><IMG alt=\"\" src=\"../resource/img/h000/h00/934c38f5d68edb30127b88382b0ed0f3.jpg\" align=middle border=0></P>\r\n<P>　　渡边文夫：</P>\r\n<P>　　非常感谢。我简要地讲一讲3G成功的原因，主要是从KDDI的经历讲一讲。有五个要点。</P>\r\n<P>　　第一，覆盖率的问题。覆盖率对于用户来说非常重要。覆盖率的质量是所有问题当中的重中之重，要求无缝的覆盖。从第一天开始就需要和2G的覆盖率相同。但是如果覆盖率不好，我们的用户就不会使用。</P>\r\n<P>　　第二，手机的质量和价格，我们必须要准备好一些非常质优价廉的手机。这就是3G成功的必要条件。</P>\r\n<P>　　第三，新的服务和新的应用。当然我们需要一些新服务，这样他们就能够感受2G和3G的不同。但是我们不需要一些非常先进的新应用，我们可以从一些很小的新服务开始，小事情就足够了，我们不需要从最开始就做非常复杂的服务。</P>\r\n<P>　　第四，各种套餐的价格。KDDI成功地推出了EV—DO1.0的版本，这样我们就引入了包月的制度。很多人认为3G的一个优点是高的比特速率。如果我们不能够成功地实现高速率，我们的业务就会失败。而KDDI更多的是注重在业务的丰富这个层面，成功的业务如果非常昂贵也不会有人用，这样我们的ARPU就会下降。所以，如果我们想要太注重比特速率，业务就会失败。</P>\r\n<P>　　第五，我们的商业模式。如果想把所有都保持在运营商这一边是不明智的，所以应该和价值链上所有的参与方共同合作。当然IPR的管理也是非常重要的一个问题。用一个词来讲述成功的要素，就想用用户的满意度来描述，任何事都要看用户是否满意，我们的用户并不需要区分各个系统和设备的区别。这就是KDDI的感受，谢谢大家。</P>\r\n<P>　　主持人：</P>\r\n<P>　　这对3G来讲是非常重要的几个方面，这几个方面涵盖了网络、终端、业务、资费方面的等等。其中最重要的用户满意是3G成功最重要的因素。</P>\r\n<P>　　提问：</P>\r\n<P>　　中兴在罗马尼亚布置的TD—SCDMA的试验情况，部署的情况和未来的目标。这个问题非常有针对性，请曹总来回答。</P>\r\n<P>　　曹强：</P>\r\n<P align=center><IMG alt=\"\" src=\"../resource/img/h000/h00/img200509161526100.jpg\" border=0></P>\r\n<P>　　谢谢大家对中兴产品的关心。最近我们的高级副总裁在昨天的宣讲中也提到了，在此之前和媒体的见面当中也提到了，中兴在3G的海外市场方面有一些新的进展，其中有一点是我们的TD—SCDMA在东欧、罗马尼亚有一个试验网，最近的进展情况我们正在积极准备，使我们的设备都到了，目前正在和罗马尼亚方面进行最后测试的标准，以及如何对测试结果进行验证，都在进行积极的准备。通过这件事情有一个很重要的方面，作为我们自己中国品牌的一个3G产品，如何获得在海外市场的开拓，能够给我们提供一个比较有价值的借鉴经验。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢曹总。TD—SCDMA是一个国际标准，而且全球有100多个运营商都拥有TDD频段，所以TDD技术如果成熟，成功地推进，实际上对全球的运营商都有积极的借鉴和未来的价值和使用空间。曹总的努力以及他们提供的信息，对TD—SCDMA是一个非常好的消息是好的发展方向。</P>\r\n<P>　　提问：</P>\r\n<P>　　高通在全球3G芯片上已经形成了规模化，请问在降低成本方面有什么进一步的举措。</P>\r\n<P>　　余熙：</P>\r\n<P>　　高通一贯对降低成本是很重视的，这个问题提得很好。为什么呢？前一段时间我们参与了一个超低端手机CDMA的推广，发现用户在增值业务上对超低端的需求是很大的。比如我们的MMS的芯片上做了单芯片的解决方案，包括在3G的领域，我们也做了很重要的一个工作，把越来越多不同的功能集成在单个芯片上。集成在单个芯片上何处在哪里？第一，降低成本，降低功耗，降低手机的尺寸。这是高通继续努力的一个方向，把更多的功能不断地集成在同一个芯片上。大家以前可以看到，市场上有一些比较大的手机，里面功能比较强大，但是可能用好几个芯片，一个芯片是控制摄像头，一个芯片控制对话，可能还有的芯片是处理多媒体。我们现在已经能做到同一个芯片可以处理上述所有的功能，包括很多应用的功能，这是高通一贯的做法，也是我们努力的方向。我们将来会把越来越多强大的功能尽量集成在所有的芯片当中，这是我们走低端芯片的一个方法。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢余总。从余总的回答也能看到，终端的成本肯定是影响3G发展非常关键的因素。所以，提供芯片的厂家降低成本的举措是大家非常关注的。</P>\r\n<P>　　3G建设之初大家希望了解一下那些影响运营商建设的规模和时间。一个是考虑进程和规模的时候应该考虑哪些因素，另外也希望了解大概需要多长时间，3G的网络可以能够从建设初期到提供商用？下面请朗讯的何总先谈谈你们的经验。</P>\r\n<P>　　何其锐：</P>\r\n<P>　　3G的网络建设挺复杂，从技术含量来说是以CDMA为基础，跟2G不一样。考虑到全国的铺设，运营商本身是否有2代的网络还是一个全新的网络？要考虑建设的规模跟进程的情况。更大部分，3G网络规划的一些思考需要考虑，朗讯做了很多CDMA扩频的网络，经验很丰富。建议中国运营商思考商用规模的时候要谨慎，但是也要超前去做。谨慎超前是什么意思？谨慎是说在于整体投资是要尽量不要重复投资或者是减少投资风险等方面。超前也是说在建设的时候，前期要考虑到将来后期的发展，比较微观来说，铺设基站可能有一些做法，前期铺得比较疏一点，比较薄一点以后需要的时候再补加上去。这样的做法可能以后补站的时候不一定是最优化的选址的地方，对整体网络投资跟成本也是有一定的影响。所以，在超前这方面，我们建议运营商考虑在补站开始建设的时候要考虑到长远发展的需要，补站上要适当考虑到。3G从技术层面来说非常复杂，不管是CDMA、TD—SCDMA、CDMA20001X EVDO，不是考虑话音的业务，考虑的不仅仅是容量跟覆盖的关系，更多是考虑数据跟速率的关系，参考点不是接通率、掉话率，考虑更多的是时率、数据跟速率对比的问题，这些都牵扯到网络规划。这方面的问题很多，现在也在开始跟中国运营商合作，互相探讨这方面的工作，希望我们的运营商早做准备，将来为中国3G的发展贡献一部分力量。</P>\r\n<P>　　丁伟：</P>\r\n<P>　　大家下午好。我就有关3G的布网问题也想谈一下NEC的看法。在3G布网阶段考虑到跟2G运营的不同。如果一个运营商拿到两张不同的牌照，比如现在的GSM和3GPP的WCDMA网有两张牌照，或者是运营商有一张牌照，布网的策略有很大区别。两张牌照主要考虑热点地区怎么去做覆盖，怎么能够吸引这些高的话务量在热点的地方。但是在3G如果是只有一张牌照，可能更加侧重的是怎么先把这个网络的覆盖范围给Cover住。所以，在布网的策略上可能有所不同。另外，随着现在HSDPA的发展，今年可能3G牌照不行，要等到明年的时候，明年在HSDPA这些技术也逐渐地有些国家已经开始商用。所以，是不是在明年上WCDMA网的时候，那时我们可以直接上R4，可以直接上HSDPA，这时我们要考虑到HSDPA是不是要用单独的载频去覆盖，还是HSDPA和目前的话音的R99或者是载频功率的载频，这些都是我们所需要考虑的一些特点。</P>\r\n<P>　　NEC在DoCoMo有很长时间布网的经验。另外，在香港和记也有很多布网3G的经验。今年我们在香港短短3、4个月的时间内就布了将近3000台基站，Cover整个香港的地区。所以，从这方面来讲，NEC具有很多工程实施和网络优化方面的经验。我们也希望在今后中国这边的发展之中能够尽我们的所能，来支持各个运营商。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢两位的回答，刚才不失时机地宣传一下。</P>\r\n<P>　　还有一个问题，因为你建设的规模和你将来的投资汇报是有关系的。如何有效地解决3G网络的投入和资费之间的平衡？实际上涉及到投资回报的问题，建设规模和投入的时间也是有关系的。这个问题作为运营商的KDDI可能有一些经验，卢总可能也有一些经验可以谈一谈。</P>\r\n<P>　　渡边文夫：</P>\r\n<P>　　我对这个问题有点想法。我们在部署3G网络的时候需要很长时间，因为用户已经喜欢了2G，他们已经喜欢了2G这种覆盖的质量。我们可以开始3G，但是如果覆盖不好，客户是不会满意的，而且需要很长的时间才能在全国部署3G网络，而且达到良好的覆盖质量。所以，我并不建议很快部署3G网络。两个办法克服这个问题，一个是用双模手机，也就是2G和3G的双模。同时使用GSM。另外，用后向兼容的技术，CDMA1X或者是到CDMA2000。因为用户不了解系统，用户只是想用手机，想用服务，他们需要非常优化的覆盖。所以，最简单的方法就是减少投资的成本，用双模的手机或者是用后向兼容的技术。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢渡边先生的回答。他一个很重要的观点是在3G网络建设的初期，覆盖是非常重要的。如果覆盖得太小或者是效果不好，很重要的就要影响到用户的使用、用户的感受以及用户的印象。后边也谈到了降低成本，可能不同的技术会有不同的方法，比如通过双模手机或者是网络的平滑演进。但是有一点，覆盖也是很重要的一点。</P>\r\n<P>　　卢勇：</P>\r\n<P>　　首先覆盖这个观点我完全同意KDDI这位先生的看法。对我们来说，爱立信应该说到现在为止几乎全球，尤其是在WCDMA领域，所有各个地区，所有最大和最早的运营商，我们都是主要供应商之一。所以，这里积累的经验，我们是看到三类情况。因为这个问题可能分成两部分，一部分是投入，一部分是资费。投入有三类，一类是绝大多数的GSM运营商，因为它有一张GSM网络作为基本覆盖的基础。对于这些运营商来说，考虑的是怎么把3G的覆盖建立在GSM这个覆盖之上，利用无缝切换，这样可以有一个比较灵活的初期投资，比如初期投资主要是去覆盖一些话务量和用户需求比较大的地区，然或根据用户扩展扩大投资。第二类情况是新运营商，或者有些虽然不是新运营商，但是网络不存在自动切换的能力，有一个例子，一个是和记的各个网络，一个是DoCoMo在日本，因为它的WCDMA网络和两代的PDC的网络中间是没有切换能力的。对这一类运营商来说非常重要的是两件事情，DoCoMo要做的事情是在日本，包括DoCoMo，包括沃达丰(日本)要建立全面的覆盖，因为没有覆盖就没有办法和KDDI等等这样的运营商竞争。第二类是像和记，它也是一个新运营商，没有它的网络，它所做的事情是在它所关注的区域内要建立比较好的覆盖，然后在它自己的覆盖区之外，尽量和其它的2G GSM运营商取得漫游协议，或者是在某些地区取得一个切换协议，这样能够比较好地兼顾一个用户满意程度和初期投资。</P>\r\n<P>　　第三类实际上是更多竞争的情况。比如说像美国的Cingular运营商，他们的情况怎么样呢？虽然建立了一张GSM网络，但是美国各个运营商之间技术的竞争比较激烈，相对来说虽然考虑了3G和2G，实际上不光和GSM，包括和EDGE无缝的切换，还是比较快地推出一个比较完整的全面和深度覆盖的策略，而且在这个基础上还是在今年实际上就要引入HSDPA。</P>\r\n<P>　　我们看到三类网络投资方面的例子。有了投资之后是自费，网络已经建立起来，这部分相对来说是沉积成本，有了沉积成本，希望你的话务量能够尽量多利用你已经建立起来的容量，在这里取得最大的回报。我们看到一个新的趋势，两方面。一方面由于3G本身的网络技术，尤其是增强型的3G HSDPA在今年已经在美国商用，其它网络明年会商用，这些做了以后就把基础的3G的容量扩大了5倍，是在同样的硬件设备上和同样的频谱资源上相对来说，等于说每千兆字节成本降低到原来的20%。有了这样的技术基础以后，跟2G纯粹以分钟数和造字节与话务量不同，更多引入了大的资费包和所谓的包月制度。在这个制度下面你有比较好的资费包或者是包月制度就可以刺激用户的使用量，但是中间要有精心的计算，始终使用量和单位使用量的成本还是给新技术带来了更低的成本基础，这个上面刺激用户的使用量，为内容和使用量支付钱，相对来说这里边是产生了新的商用模式和新的利润空间。正因为有了带宽通道、有了容量，有了单位容量更低的成本，实际上很多新的商用模式，尤其是移动企业应用的商业模式，包括移动三重业务整合，其中包括广播电视的一些业务模式，都已经进入到今天和以后的移动网络上，这可能是看到资费或者是收入对策的一些新的东西。</P>\r\n<P>　　提问：</P>\r\n<P>　　我来自鼎桥技术有限公司，TD是中国3G永远的热点，这几天我们的论坛包括今天会议上有很多演讲者，前两天魏主任对TD产业项目结果也做了说明，TD的独立组装能力及终端的很多业务得到了验证，包括很多运营商也表示会在下面继续进行这些测试，来进行网络的建设。</P>\r\n<P>　　作为信产部，在之后的时间段里，在3G牌照发布之前对TD有哪些计划？</P>\r\n<P>　　杨泽民：</P>\r\n<P>　　对这个问题，其实最权威的答案在这次峰会一开始的时候，由奚部长已经讲了。另外，我在一开始的时候也把研究院最明确的观点都讲了，现在是发令枪响的前后，讨论哪一分钟响枪，不如赶快检查鞋带，检查鞋钉。这次院里召开第三次这样的会，我们的主题跟去年和前年不一样，感觉有很多具体的准备工作真的需要在牌照发放之前就做起来。因为今天在座的台上几位都很有3G组网和运行的实践经验。刚才除了说我们要建立一个网，从规划、设计开始要花时间。另外，要推出一项真正体现3G特点的视频业务，从这项业务本身的规划、设计到在终端上实现也需要11个月到15个月的时间。我这个回答可能可以给大家一个感觉，这个时候我们要做的准备工作是多么的多，才能赶在2008年奥运会之前，让世界上的消费者真正需要的那些业务变成真实的。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢杨院长的回答。杨院长刚才说出非常关键的一点，就是起跑之前你是否准备好了。从我们这个会上的探讨来看，很多在3G引入和发展的过程中，很多问题是需要大家更深入地去研究和准备的，包括我们的媒体在内，这方面是不是也应该多弘扬或者是给大家一些更多的经验，再做好更充分的准备。</P>\r\n<P>　　提问：</P>\r\n<P>　　关于3G终端的问题。在3G发展的过程中，无论3G的任何一项功能，比如IPTV、视频通信、数据传输，每一项都是“电老虎”，吃电相当厉害。在将来的发展中，包括燃料电池或者是超级电源电池的发展还要3、4年才能实现，我想问一下中兴、三星，在我们已经实现的3G的终端上对手机的能耗是如何解决的？</P>\r\n<P>　　王彤：</P>\r\n<P>　　芯片要尽量做到多少耗电，手机厂家要把电池的寿命加强。但是现在在欧洲已经有商用的UMTS手机或者是CDMA2000在亚洲一带的使用，以及TD—SCDMA，现在来看电池不是问题。昨天也讲了很多融合方面的问题，对于手机电视，包括其它的多媒体应用，应该说肯定耗电要加大，而且大幅度加大，但是目前没有看到有什么很短的时间就用完了的问题。</P>\r\n<P>　　主持人：</P>\r\n<P>　　这个问题还有关于终端的成本。千元以内的终端有没有可行性？</P>\r\n<P>　　曹强：</P>\r\n<P>　　很重要的一点，一个是芯片问题，再一个是在手机的制造方面，其实中兴在这方面有比较成功的经验。最近我们成功地把我们的3G手机卖到了欧洲。从这方面来看，国产的手机在标准、耗电所有的这些方面都可以和国外厂家的同类手机相比。所以，在这上面应该说，这在手机界不是一个问题。不管它的制作也好、耗电也好，软件、硬件也好，今天看来不再是一个瓶颈。</P>\r\n<P>　　丁伟：</P>\r\n<P>　　在目前的3G的使用之中，除了原来2G注重话音业务以外，最重要的是有关数据的业务，比如浏览web，怎么做Radio，在商用之中都得到了很广泛的应用。NEC公司目前已经推出了几十种商用的3G终端，耗电时间在这些方面都是没有问题的。我昨天讲网络融合时也谈到，现在我们也推出了一种WCDMA和WLAN双模的商用终端，去年11月在DoCoMo推出。这种终端在WLAN的待机时间已经能够达到230小时以上。在WCDMA同时也待机，属于是双模的待机情况，在WCDMA上的待机时间超过260小时以上。所以，在手机的电池上目前还是领先的情况下。在座的大多数手机厂商都在开发燃料电池，下一个月的国展通信展上我们也会展出燃料电池。相信在不久的将来，手机的耗电时间肯定是越来越长，从消费者和运营商的角度都不用很担心这个问题。</P>\r\n<P>　　王彤：</P>\r\n<P>　　多媒体的芯片图象是图象，声音是声音，刚才高通介绍以后都是单一芯片，从芯片耗电本身来讲应该不用太担心。</P>\r\n<P>　　卢勇：</P>\r\n<P>　　在座的都是芯片厂商，爱立信跟高通是芯片厂商。目前WCDMA、GSM的双模芯片可以做到的待机时间对于我们来说已经是一样，400小时。我们的芯片也提供给包括NEC在内的终端厂商。通话来说，视频通话和话音通话也没有区别。</P>\r\n<P>　　余熙：</P>\r\n<P>　　卢总讲得很好，我们一直也在努力，高通在功耗上不断做改进，芯片上的功耗会越来越好，这是一个系统的工程，芯片、手机、显示屏，比如沈总在前两天的演讲当中也讲到，高通公司最近买了一个LCD的公司，可以在待机情况下零功耗，这又是一个改进。包括应用，应用本身可以设计很少的功耗，使得不用的时候跑到后台。等等等等这些技术，都是我们需要一起努力来减低功耗。将来这不应该是一个阻碍我们发展的问题。</P>\r\n<P>　　主持人：</P>\r\n<P>　　有一个非常具体的问题，是不是有只提供话音的低端手机？</P>\r\n<P>　　丁伟：</P>\r\n<P>　　目前NEC策略上主要推出的都是高端手机。WCDMA市场上目前推出的都是像素在100万像素以上，针对的大多数都是高端的客户。但是针对中国的市场，可能有不同的需求。在中国我们现在也建立了一个研发中心，目前也正在考虑有单一功能的手机。</P>\r\n<P>　　主持人：</P>\r\n<P>　　现在不是Yes，但是中国未来市场需要的话肯定是Yes。我想其它几位终端厂家也应该是类似的回答。刚才已经说了满足客户需求是制造商、运营商是第一职责，所以只要市场需要，大家都会去做。</P>\r\n<P>　　下面转向TD—SCDMA问题。大家比较关心，一个是TD—SCDMA能不能支持高速移动环境下的业务。第二，TD—SCDMA有没有业务独特的地方。第三，从电信研究院的角度，在推动3G和TD—SCDMA方面，从标准、测试其它方面，有没有什么计划或者是有什么样的计划。</P>\r\n<P>　　杨贵亮：</P>\r\n<P>　　首先感谢曹院长的介绍，另外感谢在座的嘉宾对TD—SCDMA的关心。就刚才提的这两方面的问题，一个是TD—SCDMA能不能支持高速移动。作为TD—SCDMA系统在一开始设计的时候就是面向独立运营、独立组网，能够完全提供3G运营环境和业务要求的这样一个系统。所以，不管是从它支持数据的速率上，还是支持的移动运营环境上，包括它的移动速度上，都是经过了大量的仿真和分析，包括这两年做的试验和测试，也包括今年上半年做的产业化试验，都充分证明和验证了TD—SCDMA在高速移动环境下能够支撑相应的移动话音和移动数据业务这方面的要求。</P>\r\n<P>　　第二个问题，关于TD—SCDMA业务的独特性。作为3G家族的成员之一，TD—SCDMA首先在业务的应用和业务的速率上面跟七大几个3G系统都是有一个共同的诉求，就是支持更高的数据速率，支持更多的移动的环境。从用户体验这个角度来讲，实际上他并不关心具体用的是哪个系统，最后关心的是需要什么样的业务，这个业务在什么样的条件下能够支撑他，能够给他提供。包括3G典型的高速数据业务、可视电话，这些应该作为TD—SCDMA来讲，跟其它3G系统的支持是相当的，也都能满足。除此之外，TD—SCDMA本身有它很多特点和应用，支撑业务说有有很多特色的地方。比如支持脱网运行，终端到终端直通方面也有特点，在边缘的地区可能整个网络覆盖达不到的情况下，终端前之间就可以组成通信的模式，这可能是作为TD系统支持脱机应用具有天然的优势。另外，采用了定位的技术。当然现在定位的技术有很多，包括用多个基站联合定位、GPS定位，检测系统定位，定位之外，用TD系统，就可以完成单机站的定位，也可以用一个基站使用中间件之后就可以对用户进行相对比较精确的定位，这个定位也在外场进行了相应的测试，它的方向误差和距离误差都比小区定位高得多。所以，这从业务应用来讲，也是由于采取了TD本身的技术特点带来一些业务应用上的有特色的地方。</P>\r\n<P>　　杨泽民：</P>\r\n<P>　　实际上这次大家都知道电信研究院也承担了整个3G的技术试验的大部分工作，目前正在抓紧和各个方面、各个企业有关的方面一起在做TD—SCDMA产业化的试验。试验本身其实是两重目的，一个是对系统本身的技术性能和商用化的程度进行检验、认证。另外，试验本身也是系统开发、完善必不可少的一个部分。第二，对TD—SCDMA这个技术目前在语音、数据、高速几个方面我们现在已经可以做到商用化的情况，在前两天的报告里大家已经都了解了。后面研究院还是会抓紧时间和各个厂家一起把宽带、支持多媒体这些方面商业化的应用，能够在测试的当中配合它尽快地实现。</P>\r\n<P>　　一个业务从规划到实现还是需要一段时间，前一段整个TD—SCDMA在商业化过程中的速度来看，这半年的时间进度非常快。所以，我们完全有信心在消费者真正需要业务的时候，完全可以提供商用化的产品。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢杨院长，大家可以看到电信研究院在标准、测试方方面面跟整个业界，跟运营商、制造商共同在推进。在TD—SCDMA推进的过程中，大家非常关心的是TD—SCDMA的芯片和终端问题。三星作为参与TD—SCDMA手机提供的制造商之一，这里面也有一个问题问王院长，关于TD—SCDMA手机目前的进展和下一步的开发计划。</P>\r\n<P>　　王彤：</P>\r\n<P>　　目前三星TD—SCDMA终端的进展情况，我昨天在会上已经介绍了，这里不占用更多时间。今后的开发计划是三个方面。第一方面，继续进一步按照商用的要求在移动性方面，包括省电和耗电，在稳定性方面，面向商用还要进一步做工作。刚才杨院长讲了，试验既是一个验证结果，又是一个进一步找到下一步开发目标的过程。我们根据上一次试验的情况，我们下一步的计划，第一个是明年年初用户真正能够使用。第二，即使牌照发了，运营商采购了，即使用户用了，但绝对不仅仅是打通话音的电话，一定有各种各样的应用，包括3G的一些典型的应用，可视，2G已经用的WAP、JAVA，包括分组域的数据等。第三，多模，多模也可以说是融合。因为现在总的来说现在不管全世界3G的用户增加多快，3G运营发展得多么好，技术还是超前于市场的孕育。等到明年的时候，不知道有多少个技术要到来，现在看到最典型的是HSDPA，不知道像DMB的技术或者是1X。另外是多模，现在我们做了GSM和TD—SCDM的双模，今后起码要三模WCDMA，或者是HSDPA，目前我们的计划是HSDPA。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢王院长的回答。三星作为非常快的手机开发商，从各个角度谈了CDMA的开发计划。这里面也有一个问题是关于TD—SCDMA增强型技术，以及目前3GPP正在做的，跟TDD有关的LTE方面有什么样的进展？从昨天的介绍来看，知道有两种方案。这个问题问你们是不是两种方案都准备在做，我想这个问题也是先请杨总回答一下。</P>\r\n<P>　　杨贵亮：</P>\r\n<P>　　去年参加这个会的时候，最后的问题是TD—SCDMA有没有后续的发展方向，实际上当时回答是有好几个方向，当没有仔细谈。今天谈一下TD—SCDMA从最早设立标准到后续发展，实际上一直不断地在进行。它在3GPP这个阵营里做的。对于TD—SCDMA来讲，它版本的发展有两个重要的试验点，一个是3GPP R4，还有现在讨论比较热的HSDPA，这应该是最有可能商用的第一个版本。再后面，包括现在在曹院长组织的整个国内组讨论的是向3GPP 提的增强方案有两个，一个是多载波的TD—SCDMA。现在广泛征求技术方案，在今年年底和明年年初可能做相应方案的技术评估，最后确定哪些方案会写到长期演进的版本里。从3GPP来讲实际上是几个版本在并行，长期演进是一个版本，R7、R8还会继续演进，那是另外一个版本。为什么我们推这个技术方案？涉及到网络建设的投资和后续的投资怎么保证。实际上我们在提方案的时候也是充分考虑到这一点，在提的3GPP的长期演进的方案里，充分考虑了对系统的后向兼容，实际上是对运营商和消费者投资的一种保护，也是它在保护它的性能的同时，能够充分体现它的后向兼容性。当然具体在后续的3GPP长期演进里，讨论方案会很多，主要还是一个是OIBM，一个是多载波的TD—SCDMA。两个方案各有各的优势和发展方向，最后会体现在3GPP发布的不同的版本里。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谈到TD-CDMA的增强型，涉及到整个3G下一步的发展问题。首先从无线部分，一个是如何看待3G自身向什么方向发展。第二个问题，关于3G与其它无线技术，比如和WiMAX之间的关系，是竞争还是互补。</P>\r\n<P>　　卢勇：</P>\r\n<P>　　谢谢曹院长，也谢谢各位。3GPP本身的发展基本上是这样一个路标，从R99以后，今年开始引入商用的是HSDPA，到明年不光是下行链路，会把上行链路也增强，HSUPA类似于HSDPA的技术，另外HSDPA进一步加强，下行对高可以到14M，上行2M多一点。后面会引入MDEMSS，也就是在现有3G的无线网络、移动网络，和它的频谱资源里引入一个广播的能力，我们现在有很多点播能力，在今天的网络上可以用。这个差不多在2007年左右会引入。下一步提出超级3G，这个基本上到现在已经进入一个标准化的进程，之后到明年，到2007年应该把标准化基本上冻结掉。2008年标准化基本上做完以后，2008年、2009年在现有的频谱资源上，在今天的频段上有灵活性，如果把20M的频谱资源，很多3G的运营商20M的频谱资源都用上，可以达到100MBps的能力，这基本上是3GPP目前在做的一些3G无线技术上的演进。后面大家又讲了很多4G，目前正在研究，还没有进入到体系结构上。现在是怎么更多把现有的无线技术综合起来，再采用新的无线技术，能够得到更好的频谱利用效率和更大的容量、更大的带宽。</P>\r\n<P>　　核心网里现在开始最重要的是引入移动软交换，达到整个核心网的运营成本可以进一步降低。这个基础上再向IMS演进，一个是给我们提供更多的新业务。第二，长期把我们的核心网络演进到一个变现级有控制的全IP的核心网络，而且在这个基础上也能够实现移动和固网的融合。所以，这应该是3G本身的一些主要的演进方向。这个之外，跟其它一些无线技术的关系，比如和WiMAX的关系。对爱立信来说当然大家知道，我们是在3G技术上的一些全球的领导者，这个之外实际上我们也是WiMAX论坛的成员，我们也再WIMAX的开发，我们认为这不是竞争性的技术。为什么？有两点。第一，从整个3G和蜂窝移动技术要实现的是两个目标，一个是大范围的覆盖，无缝的覆盖，任何时间任何地点都能用到这个地点。第二，支持我们个人化的手持的比较小的终端，这个基础上也能扩大到PC终端。WIMAX实际上是另外一个起点，很大程度上固定无线是起点，比如802.16B。下面有802.16E，是在固定无线的基础上再引入一定的移动性。这个里面还有一个起点是针对PC用户上网，跟手持终端的差别是什么？不是随时随地都要用，更多是体现热点地区等等这样一些情况。所以，我们认为应用不完全一样。3G的增强型再往后的演进我们叫移动宽带的概念，在移动环境下无缝覆盖下实现宽带，WIMAX更多是无线宽带，无线加上固定或者是有限移动的情况下也提供一个移动宽带接入的能力。所以，这个应用并不完全一样。</P>\r\n<P>　　说到时间表上是这样的情况，大家可能知道HSDPA已经基本上今年、明年开始进入商用，相应的对于WIMAX今年有的叫16D的一些系统，更多是天线对天线视线范围内的无线链接。考虑到标准化进程，可能比2007年还要迟一点。并不是完全同一个时间，应该说在蜂窝技术上引入移动宽带，802.16e会更早一点。说到标准化也不完全一样，基本上在188，制定802.16EWiMAX的标准里，基本上定义的是第一层和第二层的标准，在WiMAX论坛里定义网络层针对有线移动性的标准。凑整个标准化的进程，在网络刚刚启动的角度来看，相应来说离带上移动性的商业化有比较长的若干年时间。</P>\r\n<P>　　总体来说，我们认为这两个并不是矛盾的技术，一个更多实现HSDPA也好，HSUPA也好，3G蜂窝技术的进一步演进也好，实现的是蜂窝移动无缝的环境下带来宽带。一个更多是对无线的环境下，带上移动性和可携带的环境下提供无线宽带而不是移动宽带的连接。</P>\r\n<P>　　渡边文夫：</P>\r\n<P>　　讲到3G和WiMAX的关系，3GPP一直在讲长期的演进。现在我们正在讨论一些要求，我不知道最后会选择哪种技术，不知道是增强型的CDMA2000还是1X，还是WIFI。但是加强型3G是一个更完善的网络，我们必须要使得我们的网络允许我们进行任何方式的连接。而不管2G到3G之间的无线网络使用什么样的类型，4G就代表我们会有一个新一代的通信来代替3G。3GPP和3GPP2所讨论的技术是非常相似的，实际上这些技术之间本身并没有界限。我认为802.16e所使用的技术是非常相似的，我们如果故意区分什么是3G，什么是超3G是没有太大意义的。如果我们的这种接入方式是可以满意的，它就是最好的。</P>\r\n<P>　　WiMAX现在的标准对于移动性来说还不足够，在WIMAX论坛，我们需要和运营商、服务提供商更多的合作来界定这个标准，直到今年年末。运营商在寻求使用无线接入的技术，而我们现在更加注重各种各样的标准。</P>\r\n<P>　　主持人：</P>\r\n<P>　　谢谢渡边先生，他从介绍这几个技术和这几个组织的进展谈到，包括KDDI公司的看法。这里边也特别谈到了，希望杨院长也回答一下。因为各种技术，特别是多种技术出现以后，现在的3G，尤其是跟WiMAX之间，杨院长从研究院的角度如何回答。</P>\r\n<P>　　杨泽民：</P>\r\n<P>　　第一，WiMAX和蜂窝，不管是2代还是3代，出发点不一样。蜂窝系统是从窄带但是很好的移动和覆盖来动手，不断地增加自己的带宽来满足宽带的需要。WiMAX正好倒过来，是从固定、无线，但是很宽的带宽开始，它试图不断地增加自己的移动性和覆盖的范围。所以，这是一个出发点，不一样。虽然从目标上说起来都是将来是大覆盖、高速移动、很宽的带宽，但实际上因为出发点不同，还有一个很重要的原因，任何一个事物从概念上到一个可以实际的使用的系统，是要花时间的。这一点正好我们的蜂窝系统从模拟到2代，到今天已经是一二十年的时间了，所以它整个能够全球这么来用，它的标准工作，商用化的工作花了十几年的时间。现在从WiMAX来说，坦率地讲它要完成整个网络里像这样的这些控制、这些标准化、商用化，是要花时间的。所以，这样时间上的差异很可能会对一个概念上的技术能不能在商业上取得预期的效果，这个事情历史上是有过事情的。</P>\r\n<P>　　另外，《水浒》里有带把的很长的屠刀，还有标准化的刀，从概念上是类似的，都是刀，但实际上他们所擅长做的事情不是太一样。屠刀很可能在某些场合用起来很顺手，但是短刀是在另外一个场合。你用菜刀和一把小刀都能切菜切用，但是你做同一件事情，用类似的技术体验也是不一样的。</P>\r\n<P>　　主持人：</P>\r\n<P>　　刚才大家谈到多种技术和网络发展的时候，已经谈到了网络融合，融合也是一个非常大的、非常热点的一个问题。也有很多问题是关于融合的，有的是网络层面，有的是业务层面，有的是终端层面。首先我想从网络层面，固定和移动网的融合这个角度，希望嘉宾能够回答一下。一个是如何看待，另外是在融合过程中会有什么样的瓶颈。</P>\r\n<P>　　何其锐：</P>\r\n<P>　　网络层次有线、无线的如何实际上更广义不是有线无线，最终是满足用户的需要，满意度是最重要的。我们作为用户，你我都是，我们用什么接入？我们用手机，家里有家里的电话，公司有公司的电话，家里面可以用宽带、WIFI等等。各种接入我们都使用到。我们使用各种不同接入网络的时候，可能取得的信息不一样。我们是不是希望在各种接入里对无线接入、有线接入都能取得一样的业务、一样的服务、一样的内容，这是我们所需求的推动网络融合的需要。奚部长说这种新的技术是市场要推动，但是也要新的技术能够支持。既然有市场推动，也当然有技术能支持。既然有市场驱动，需要各种业务、各种技术的融合，但是IMS也是把各种有线、无线各种接入能够融合在一起。IMS现在谈已经不是概念的问题，从朗讯的角度说，全球有100个试验网络，有好几个已经是商用网络，已经开始部署IMS，运营商能够把各种固网的接入和无线网络融合。将来不仅仅是无线方面，空中接口演进方面速率的提高，更多是站在整个网络能够配合到无线接入跟有线接入各种用户的需要。</P>\r\n<P>　　主持人：</P>\r\n<P>　　在业务融合方面非常典型的也是当前讨论的热点问题是视频业务，或者是电视业务，手机和电视的结合也是大家非常关注的一个话题。在日本有没有这方面的经验，手机视频、手机电视有没有一些特别受用户欢迎的？比如手机电影，这样的业务是不是已经开展了？</P>\r\n<P>　　渡边文夫：</P>\r\n<P>　　是的。在日本已经有一些手机能够承载广播业务，我们的手机不仅能够接收电视节目，还能够提供综合性的服务，比如电视和网络。比如说一个用户在看电视，或者很快跳到一个购物网站，这样有实现了广播和电信网的融合。同时我们还有FM调频，同时我们在这种情况下也会有一种结合的服务，也可以听音乐，也可以去各个音乐公司的网站来购音乐CD，同时还可以听收音机。所以，各个服务的融合也是非常重要的。</P>\r\n<P>　　主持人：</P>\r\n<P>　　所以也看到了，3G已经为业务融合，尤其是为移动通信的发展创造了更大的空间，在手机上跟各种各样的业务结合已经成为可能。在移动通信业务融合的同时，终端如何去满足这种需求也是非常重要的，我们是不是也请一位终端厂家的代表来回答一下，在终端方面如何满足这种需求。</P>\r\n<P>　　王彤：</P>\r\n<P>　　实际上刚才杨院长讲得非常好，我们在讲竞争的时候，讲到3G和WIMAX差异的时候是讲它们的区别。当我们讲融合的时候，也许在网络层面或者是技术原始成长的过程中是不同的。但是从业务整合，业务整合是把所有的网络资源都用上，没有那么大的分别。从用户的感受更没有。到了终端，到了用户手上的时候，实际上我们分辨不出来采用什么样的技术网络。KDDI用的是同样一颗卫星，在韩国和日本同样开了DMB的业务，通过数字广播来用手机看电视，今年已经开通了卫星的DMB的业务，马上要开通电波的DMB的业务，对手机的要求也就更高了。不但能够在通话的时候互相可视，同时还可以通过卫星来看高清晰度的数字电视&gt;</FORM></SPAN>，或者是通过电波来看高清晰度的数字电视。这里既有融合，同时也产生了竞争。刚才卢总讲到了MBMS，也是通过广播信道或者是广播技术传通信的信息，HSDPA、HSUPA，广播比这个带宽还要宽，质量还要好。所以，感觉在终端看到的融合远远比我们看到系统或者技术的融合要来得强烈得多，或者以后的移动通信终端很可能是数字电视的终端，可能是3G、后3G的终端。我们现在谈的3G加MMS、DMB都会在一个手机上，只是满足不同的需求，用在不同的场合。就像有的朋友问有没有专门通话的手机，没有需求当然可以，但是如果有需求，可以有多个功能的融合。 </P>','','1127372929','','73681,73680',1127373764,1127900001,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73205,'图文：电信研究院院长杨泽民致闭幕词','','','','','','<CENTER><IMG alt=科技时代_图文：电信研究院院长杨泽民致闭幕词 src=\"../resource/img/h000/h00/img200509221507400134.jpg\" border=1><BR>图为：信息产业部电信研究院院长杨泽民。(骆磊 摄)<BR><FONT class=title12><B></FONT></B><BR></CENTER>\r\n<P>　　新浪科技讯 2005年9月14日-16日3G在中国2005全球峰会和全球3G设备和业务展示在中国北京凯宾斯基饭店举办。会议由信息产业部电信研究院主办，会议旨在进一步推动和促进中国3G产业的发展。新浪网为指定门户支持。9月15日会议进入第二天。</P>\r\n<P>　　主持人：</P>\r\n<P>　　3G的话题可能花很长时间探讨不完。由于时间关系，这里我们的很多问题没有时间回答。最后一个问题还是交给主办方杨院长。这个问题是电信研究院举办这样的会议，尤其是这次会议，是不是预示着中国的3G牌照很快会落实。大家非常感兴趣，明年电信研究院是不是还要再举办这样的会议？ </P>\r\n<P>　　杨泽民：</P>\r\n<P>　　很感谢大家给我这个机会来回答问题。谈到发牌照的时间，因为电信研究院按照信息产业部&gt;</FORM></SPAN>整个部署，一开始从标准的制定到技术试验，到整个产业化的过程，我们都积极参与其间。我们之所以用了3、4年的时间来做这件事，就是想力促这样一个能够给消费者带来新的福利的技术，能够尽早地在中国实现。另外，对这个时间的判断，电信研究院已经明确地表示了我们乐观的估计。所以，还是借这个时间再谈一些大家可能很关心的事情。</P>\r\n<P>　　首先，从网络的融合来讲。今天是3G的峰会，我们谈蜂窝系统不断演进到今天，大家也发现在这个会上，实际上我们还谈到了WIMAX，谈到了WIFI，谈到了将来的互补。但实际上我们马上要面临的支持我们各种需求的一个网络的环境是什么样呢？是一个融合的环境。</P>\r\n<P>　　先举一个例子，大家在旅行的时候往往都需要用小剪刀，但是很少有人把你们家用的那把很好用的剪子带到身上，而不得已用一个像瑞士军刀里面藏的一个很小的剪子。为什么这么做？回到通信这个事情来，实际上将来我们需要的是一个无缝的网络环境，它能够在任何时间、任何地点满足你通信的要求。我先问大家一个问题，就用蜂窝不就可以了吗？为什么还要互补呢？我有什么必要要再去考虑网络融合的事情呢？原因很简单，其实那就是价格的问题。因为无线的频率是有限的，像蜂窝这样能够在很大的范围来覆盖，它实际上在频率提供众人使用的时候，有一定的相对的困难的。反过来像WIFI这样的，覆盖的范围再小像蓝牙&gt;</FORM></SPAN>，只供你一家来用，覆盖最小的系统是固网，它的覆盖是到了一个点上，是这个时候实际上可以供你使用的带宽是非常大的。这里面区别是什么呢？在众人来共同使用一个有限的资源的时候，它的价格必然是要上涨的。所以，我希望我可以随时随地地来使用很宽的带宽，但同时我也希望我付出的费用越小越好。所以，这样实际上我就希望技术可以使得我必须在广阔范围活动的时候，我支付比较高的价格。但是一旦我到了我的办公室和我家里的时候，我就很希望我在使用同样服务的时候，但是我能够用很便宜的价值。其实这一点最后消费者是看不见的，但是作为研究院，我们希望我们的运营商能够提供由蜂窝系统，像WIMAX、WIFI，能够在更小的范围提供更便宜的无线带宽，以及提供最便宜的最大带宽的固网，能够很好地融合在一起，提供一个无缝的环境。</P>\r\n<P>　　今天提供这样环境的技术已经一个接一个地出现了。包括这次研讨会上大家谈到的IMS技术，这个技术最大的贡献是能够把蜂窝、固定无线和固问很好地都完整地融合在一起。这样当我在广大的区域，从雪山到郊区，到农村，到市中心，到我的办公室，到我的家，我可以感觉不到，但实际上我在用同样的宽带业务的时候，我付的费用已经在不断地最优化。所以，网络的融合首先是我们消费者希望能够用最优的价格使用这个服务的需要。第二，技术在今天已经完全可以提供这样的融合。第三，作为一个全业务的运营商，它可以在这么多他可以支配的技术里做它认为最佳的选择搭配，为我们提供无缝的环境。不同的运营商可能自己的选择会有差异，他在什么地方选用蜂窝，他在什么地方选用WIFI、WIMAX还是其它无线固定接入技术，什么情况下使用光纤到户，可能不同的运营商由于特有的个性和竞争的策略，可能会有不一样的选择，但最终的效果还是一个融合的网络环境提供给消费者一个最优化价格下面的一个最宽的消费带宽。</P>\r\n<P>　　这次非常感谢所有在座的各位，感谢大家的关注和支持。我特别希望这次我们3天的3G的峰会能够使大家对今天这一时刻3G在全世界应用发展的情况有了最新的了解，对中国这边应该做的这些具体的准备工作是哪些，我们应该怎么来做好这些准备工作，也有了更新、更感性的了解。另外，非常非常感谢支持这次研讨会的全球所有产业界的公司的朋友，我相信我们共同为了来推进必将最后造福于我们用户的第三代移动通信技术所付出的这些努力，必将能够产生它积极的成果。</P>\r\n<P>　　最后，特别感谢这次峰会上全体的演讲者，现在特别是在台上以及在台下的演讲者，感谢他们所做的这些精彩的演讲。正是他们这些努力，使得我们这次所有参加会议的朋友们能够有所收获。</P>\r\n<P>　　大家已经看到了，其实电信研究院我们所关心的领域不只是3G，我们也连续举办了像下一代网络、全新商业模式的社会，继续大家关心问题的讨论会，我们肯定会按照技术的发展，按照新应用不断的出现，会不断针对这些新的热点来组织这些必须的研讨会。</P>\r\n<P>　　仲秋就快到了，祝大家身体健康，全家多福、多乐。</P>','','1127372861','','',1127373628,1127380269,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73200,'亚太国际光触媒产业论坛锁定广州','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　在光触媒行业颇具影响力的亚太国际光触媒产业论坛即将于9月2日至5日在广州隆重召开。作为广州市人民政府同期举办的广州博览会中的一部分，该论坛由亚太光触媒产业联合会筹委会、日本光触媒协议会、台湾光触媒产业发展协会以及韩国光触媒产业会等四家单位联合发起主办。</p>\n\n<p>　　据论坛承办方广东文博展览有限公司负责人介绍，光触媒应用商涉及照明、建材(地\n板、陶瓷)日用品等各个行业，尤以车内(室内)环境、装饰行业应用较多。据不完全统计，在该行业，目前中国每年约有100亿元的市场容量。有专家预测，未来光触媒的经济效益在环境产业中的市场份额和增长速度都将大幅增长。本次论坛组委会特邀中国科学院外籍院士——日本光触媒之父藤岛昭先生到会并作演讲。(慧萍小何) \n</p>\n\n\t\n\t\t\n','','深圳特区报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73201,'中国电话用户总数破7亿户 手机用户3.63亿','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<center><IMG SRC=\"../resource/img/h000/h00/img200508171850550719.jpg\" BORDER=1 alt=\'科技时代_中国电话用户总数破7亿户 手机用户3.63亿\'><br>移动电话普及率达到28部/百人<br><font class=title12><b></font></b><br></center><p>　　新浪科技讯 据信息产业部公布的截止到6月底的信息，移动电话用户达到3.63168亿户，固定电话用户达到3.37438亿户，中国电话用户总数突破7亿户。全国固定电话普及率达到26部/百人；移动电话普及率达到28部/百人。</p>\n\n<p>　　同时公布互联网宽带接入用户3165.1万户，比上年末增长677.7万户。</p>\n\n\n\t\n\t\t\n','','新浪科技','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73202,'波音英特尔联手打造空中无线宽带网','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　新华网洛杉矶8月1日电(记者司久岳) 美国飞机制造商波音公司和电脑芯片生产商英特尔公司1日宣布，两家公司已达成协议，将联手改进和推广空中高速无线上网服务，使民航机的乘客能在飞行途中漫游网络世界。</p>\n<p>　　作为协议的一部分，两家公司已完成对采用英特尔迅驰芯片的笔记本电脑普通设置的兼容性测试，使波音下属的波音连接公司成为第一家通过英特尔兼容验证的空中上网服务公\n司。</p>\n<p>　　波音连接公司副总裁大卫·弗里德曼说，通过对英特尔迅驰移动技术和设备与波音空中无线上网服务的兼容性进行验证，波音将能为空中旅客提供稳定和高质量的无线上网服务。</p>\n<p>　　目前世界上已有多家航空公司的约70架客机提供“波音连接”空中上网服务。</p>\n\t\n\t\t\n','','新华网','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73203,'中移动将斥资1100亿建3G网 覆盖全国80%地域','','','','','','\n\n\n\n\n<p><font size=\"2\"><br/>昨天，来自信息产业部电信研究院负责3G规划的专家称，3G网络的部署已经进入规划阶段。 </font></p>\n<p><font size=\"2\">信息产业部电信研究院规划研究所无线通信研究部主任贺丰表示，WCDMA正在进行规划，目前正制订规划原则、做规划前准备。贺丰目前承担3G实验网络规划与设计研究工作。 </font></p>\n<p><font size=\"2\">贺丰说，WCDMA部署初期将以覆盖为主，容量为辅，并且要快速广度覆盖。对于外界关心的3G资费问题，贺丰明确指出，3G终端将面向中高端用户，但资费不会高于现有2G时代，甚至会更低；并且，各大运营商将采用资费捆绑套餐手段来推广3G。 </font></p>\n<p><font size=\"2\">昨天，上半年刚刚获得240亿元纯利的中移动宣布，该公司将采用WCDMA技术发展3G网络，首期将瞄准上海、广州等沿海大城市，随即向内地大城市推进。 </font></p>\n<p><font size=\"2\">《每日经济新闻》从中移动内部获悉，中移动已经计划在未来两年投入1100亿元，建立一个覆盖中国80%地域的3G网络。</font></p>\n\t\t\n','','每日经济新闻','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73199,'《商业周刊》：创新设计让摩托罗拉涅槃再生','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　天极网8月3日特稿(戴寻严 编译)在过去的第二季度中，在全球手机巨头陷入低迷的时期，摩托罗拉却找回了感觉，不仅扭亏为盈，还赶超三星当上了全球手机市场的“老二”。摩托罗拉的神奇状态从何而来?本周的《商业周刊》给出了答案:创新设计让摩托罗拉“涅槃再生”!</p>\n\n<p>　　这是一个七月中旬闷热的周五，一群摩托罗拉的设计师们正集中在芝加哥设计中心\n的26层，他们正在讨论几款新手机的原型。此时，一身休闲打扮的首席执行官赞德(Edward J. Zander)从门口探进头来:“我可以进来吗?” 很快，他直奔主题，桌上放的手机原型是Q款的，这款手机带有字母键盘，为的是和广受欢迎的加拿大RIM公司的“黑莓”(BlackBerry)手机展开竞争。</p>\n\n<p>　　任何一个细节都逃不过赞德的火眼金睛。他和设计师把摩托罗拉的一个原型机和竞争对手的放在一块。“我们的有点长，”赞德大声地表示担忧。“是，不过它只有别人的一半厚，”设计师多尔(Sean Daw)的反驳很迅速。赞德拿起另外一个型号，并开始按键。“我不知道。用Good软件的那个对我来说更好一些。”赞德所指的Good是一个手机软件公司。这个Q原型虽然看上去非常类似，但有着细微的差别:键盘高出几毫米，按键需要使稍微大一点的力气。最后，赞德终于找到了一个感觉不错的原型，“现在这一款看上去不错。”</p>\n\n<p>　　赞德对于摩托罗拉公司似乎也找到了良好的感觉。在夙敌诺基亚和三星电子的业绩表现平庸的时候，曾经陷入窘境的摩托罗拉却找到了感觉。7月19日，摩托罗拉公司公布财报，其中二季度的销售猛增了来自哪里?手机销售量达到了创纪录的3400万部。这使得摩托罗拉的全球市场占有率升至17%。这是过去7年来最高的，并使它和占有33%的“老大”诺基亚之间的距离进一步缩小。“我们已经是一个强劲的亚军，”赞德在发布财报时说，“我们现在的目标是第一名。”</p>\n\n<p>　　摩托罗拉新的梦想的核心，是一个经过大修的新产品战略:设计领先，技术跟进。自从1928年以加尔文制造公司的身份诞生以来，公司到处都是工程师。这使得摩托罗拉创新不断，包括最先进的手机。但到了1990年代末期，这种策略开始出现失误，一连串新手机失宠于市场，很多新品到期无法兑现。现在，赞德</p>\n\n<p>　　在公司重新进行了调整，设计师居于重要地位。多尔设计师说:“过去，一直都是工程师扔给我们一个电路板，然后发号施令说，给它加一个塑料外壳!现在，我们做任何事情都根据预先制定的目标，工程师反过来向我们提供帮助。”</p>\n\n<p>　　摩托罗拉在过去几年中一直试图提高其设计水平。赞德的继任者和公司创始人的孙子加尔文(Christopher B. Galvin)曾经雇用了很多有创新能力的天才，包括广受尊重的索尼公司骨干威克斯(James Wicks)，他现在已是摩托罗拉手机设计部门的新老总。然而，带有上流社会气质的加尔文很少置身于日常的决策当中。赞德不一样，他几乎一半的时间都呆在在市内的设计中心，并鼓励那些设计师“孵出”最酷的创意，而不是成天都在伊利诺伊州的摩托罗拉总部。他经常敦促、刺激设计师，看上去像是一个有点麻烦的将军。此外，赞德还请耐克公司的前任执行官Geoffrey Frost出任营销总监一职，并赋予他将设计师的精彩主意在合作伙伴间广为传播的任务。</p>\n\n<p>　　摩托罗拉所发生的变化让它在网络运营商那里获得了认可——即使是在竞争对手的“老巢”韩国。SK电讯公司的产品规划经理You Jong O说:“摩托罗拉的动作很同步，他们的产品管理非常棒。”</p>\n\n<p>　　现在，手机业务的用户忠诚度急剧下降，如果错失一步两步，赞德和摩托罗拉的好运都将烟消云散。除了诺基亚，摩托罗拉还必须领先于韩国的三星和LG电子公司。一些运营商表示摩托罗拉还必须证明自己的动作能象韩国“二人组”一样快，并将数码相机和游戏等功能集成到它的手机中。运营商Verizon无线公司的首席技术官里奇(Dick Lynch)说:“摩托罗拉还有很长的路要走。”</p>\n\n<p>　　无论怎么耀眼的成功都不会只是来自一部手机。赞德想做的是开发一种不断创新的“工艺”，以便研发出一个接一个的成功新品。去年推出的超薄手机Razr，虽然价格有500多美元，但已经证明是一个大赢家。摩托罗拉的忠实用户最近已经开始等待即将推出的iTunes手机，届时将可以从苹果的在线音乐网站下载美妙的旋律。7月25日亮相的Q手机也迎来如潮好评，它只有11毫米厚，113克重，分析人士称它将创造另外一个市场奇迹。业内人士Ed Lewis说，摩托罗拉依靠这款Q将在两年时间内超过竞争对手“黑莓”。</p>\n\n<p>　　事实上，摩托罗拉身上发生的变化正是美国企业当今逐步演进的一个缩影。从通用电气到宝洁公司，由于全球化将低成本的竞争对手从地球的另外一角带到了家门口，他们逐步加强了对创新和研发的重视。从Q的问世，可以看到看到摩托罗拉试图“凤凰涅槃”的艰难历程。</p>\n\n<p>　　在Q产品问世之前，摩托罗拉曾先后研发了代号为“达芬奇”和“MPX”的新手机，但都难以满足赞德的雄心。只有在他找到具有技术背景的Ronald G. Garriques之后，研发Q的道路才重新回到了正轨。</p>\n\n<p>　　在Q的发布会上，微软公司首席执行官鲍尔默同时远程视频进行了观摩，他惊呼“Q将会给手机带来一场革命”。赞德说Q和Razr是踏上未来创新征途的一个发令信号。“我们离成功还十分遥远，” 赞德说。他已经决定将更多的梦想变为现实，哪怕这意味着他还需要“探头”闯进更多的设计师会议。\n</p>\n\n\t\n\t\t\n','','ChinaByte','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73198,'中域电讯闪电收购宇讯达 深圳手机市场突变','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t<p>　　文/孟旭东</p>\n\t\n\t<p>　　7月31日，中域电讯收购宇讯达通信的消息在业内不胫而走；次日，中域电讯·宇讯达店率先取代了原宇讯达西丽、布吉、东门、岗厦、华强北、康乐、南油等10余家分店的招牌。中域收购、整合宇讯达的速度如此之迅速，震撼了深圳手机市场。中域电讯董事长兼总裁李建明在接受记者电话采访时证实了收购宇迅达的消息，虽然李建明没有透露此次收购的具体金额，但此前中域已有收购佛山华光、重庆科有、广西鑫辉、广西中人等电讯经营企业入主当地市场的先例，联想到宇讯达在深圳手机连锁领域曾经与天音、恒波并称“三大巨头”的\n地位，中域鲸吞宇讯达的目标自然是意在深圳这块手机市场的“肥肉”。</p>\n<p>　　<strong>收购助中域突破核心商圈</strong></p>\n<p>　　创建于1997的宇讯达通信是深圳地区首家获得中国移动(深圳分公司)、中国联通(深圳分公司)一级代理商资格的手机连锁企业，并且与摩托罗拉等多家手机厂家签订了“直供协议”，曾在深圳拥有20间分店，分布在华强北、罗湖、东门、南山、西丽、布吉、康乐、南油等繁华商圈。</p>\n<p>　　中域电讯营销中心副总经理曾幼红在接受记者采访时表示，中域电讯一直强调规模经营，“收购兼并”是中域电讯使用最频繁的拓展方式，其做大做强的三件利器就是“特许加盟、经营联盟、收购兼并”。他说：“目前的手机零售行业，特别是连锁经营领域，最为核心的要素就是规模和速度。如果你初具规模，便停滞不前，你的规模将越来越小。在某种意义上讲，速度决定规模，速度可以改变规模，中域电讯就是以‘中域速度’在建设‘中域模式’。宇迅达通信是一家非常优秀的手机连锁企业，但其失去了深圳特区市场、乃至珠三角市场上世纪末和本世纪初‘一鼓作气’的历史机会……”虽然宇讯达近年来发展趋缓，但其在关内核心商圈的网点正是中域所看中的，这就给了觊觎深圳市场已久的中域一个机会。</p>\n<p>　　李建明年前也曾表示，中域电讯在深圳市场将采取明显的“农村包围城市”战略，经过近3年的成熟运作，中域电讯已经将深圳手机零售市场牢牢地握在手中。选择在此时吃下宇迅达，是完成中域电讯品牌发展的战略布局的必然结果。另据了解，中域的终极目标是要占据深圳市场超过35%的市场份额。</p>\n<p>　　<strong>渠道整合将是必然趋势</strong></p>\n<p>　　深圳是广东手机第二大市场，其对周边城市有着不可估量的辐射力。在过去相当长的一段时期内，深圳手机市场的格局真可谓“三足鼎立”，以宇讯达、天音、恒波为代表的本土连锁企业，曾经在与以中域、国美、苏宁为代表的外来品牌的市场竞争中，扮演着主要角色。一度被深圳市民和手机厂家戏称为深圳手机零售的“三巨头”。</p>\n<p>　　深圳手机市场早已进入“煮酒论英雄”的时代，在激烈的市场竞争中，整个通讯行业已经进入了寡头垄断的初级阶段，强者会更加强大，弱者就被兼并或淘汰，除了具有规模优势和品牌信誉的大型企业及其它中、小零售商迟早将被迫退出市场。在中域电讯成功收购宇讯达之后，，深圳手机零售市场三足鼎立的局势早已被打破。目前，中域电讯在深圳市场的连锁店布局已经超过了60家，名副其实地登上了深圳手机零售市场的“龙头宝座”</p>\n<p>　　与当年的家电业一样，电讯行业的拉锯战同样会是持久的，以中国市场之大，横向整合的舞台可谓无限宽广。在这个过程中，各种力量的重组与整合一刻都不会停顿。原因非常简单，任何一家企业要在激烈的竞争中占据优势地位，必须拥有市场、资本、品牌、上游厂家等更多的资源，集群优势更加突出。李建明坦言，中域电讯将会在未来一到二年时间内，在广东省内再度拓展300至500个连锁网点，而且，在未来的市场拓展过程中，中域电讯会相对提高自营网点的比例，收购和兼并将会是中域电讯经常实施的市场策略。2005年的广东手机市场真的要“地震”了。(孟旭东)</p>\n<p>　　<strong>【业界声音】</strong></p>\n<p>　　恒波营销中心副总经理：张英铎</p>\n<p>　　收购宇迅达增强了中域在深圳市场的实力，对于整个市场肯定是有一定的影响，特别是对中小型连锁企业，但对整个深圳的市场格局改变应该不大。一直以来，类似的兼并、收购都有，中小型手机连锁以后会越来越不好做。只有做强做大，才能在这样严酷的竞争环境生存下去。</p>\n<p>　　易天移动数码副总裁：温玉湘</p>\n<p>　　我们不好评价中域收购事件，但整体来讲对深圳市场的影响应该不大。大家的经营模式不同，我们会专注地做好自己的事，是不是深圳市场的“老大”，最后要靠市场说了算。</p>\n<p>　　协亨深圳分公司总经理：周净</p>\n<p>　　收购应该对市场没有什么影响，但是我们很痛心，因为又失去了一个做正品行货的战友。现在对手机卖场冲击最大的是来自水货、假货的冲击，协亨会继续坚持正品低价的经营方针。 </p>\n\n\t\n\t\t\n','','深圳商报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73195,'波音英特尔联手打造空中无线宽带网','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　美国飞机制造商波音公司和电脑芯片生产商英特尔公司8月1日宣布，两家公司达成一项协议，将联手改进和推广空中高速无线上网服务，使民航机的乘客能在飞行途中漫游网络世界。\n</p>\n\n\n\t\n\t\t\n','','人民网－国际金融报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73196,'语音占国内移动收入90% 移动与互联网将整合','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　作者:熊熊 编译</p>\n\n<p>　　【赛迪网讯】8月3日外电消息，据中国官方数据显示，目前中国的移动数据服务与基础语音服务一样正在飞速发展。 </p>\n\n<p>　　来自如SMS短消息和手机铃声等移动数据服务的收入，目前已占到了服务供应商收入\n总数的7%以上。 </p>\n\n<p>　　信息产业部电信研究院通信政策研究所所长陈金桥表示，预计中国电信服务领域产生的收入在未来的十年内还将以每年两位数的增长率进行增长。 </p>\n\n<p>　　他同时表示，尽管目前语音收入占据了移动服务收入总数的90%以上，但数据业务却具有十分巨大的发展潜力。 </p>\n\n<p>　　未来，移动通讯服务与互联网服务的整合也将加快移动数据业务的发展脚步。陈金桥这样说道。(c000)  \n</p>\n\n\t\n\t\t\n','','赛迪网','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73197,'传台湾将批准直接从中国内地进口手机提案','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　作者:熊熊 编译　</p>\n\n<p>　　【赛迪网讯】8月3日外电消息，近日有消息人士透露，预计隶属于台湾经济部的台湾外贸局将在本月下旬批准直接从中国内地进口手机的提案。届时中国内地的手机制造商、建于内地的台资手机制造厂以及如诺基亚和摩托罗拉等国际知名企业都将从中受益。 </p>\n\n\n<p>　　据业内资料显示，台湾最初曾于2003年计划打开直接从中国内地进口手机的大门，但当时这项提案却由于遭到了如摩托罗拉和索尼爱立信等领军销售商，以及包括明基、英华达和迪比特在内的台湾本土手机公司的强烈反对而最终宣告破产。 </p>\n\n<p>　　然而据台湾近期发布的一项调查显示，目前80%以上的台湾手机制造商都已开始对这项提案表示支持。而在两年前曾强烈表示反对的摩托罗拉，此次选择了中立。 </p>\n\n<p>　　已获得法国Sagem以及中国内地的波导、厦新手机代理权的台湾御立集团董事长张子柏表示，如果该项提案果真获批并于今年9月起开始实行，那么包括TCL、夏新、中兴和华为在内的中国内地手机制造商有可能将在今年占据台湾3G手机市场10%的市场份额。 </p>\n\n<p>　　张子柏同时表示，直接从中国内地进口手机之后原来需要3周的运货期将缩短为1天，这项政策将使得进口每部手机的成本降低5到10美元。 </p>\n\n<p>　　御立集团计划在今年9月将夏新的第二代3G手机9201和9203引入到台湾市场，每部手机的售价在新台币7000元(约合220美元)到8000元(约合251美元)之间，约比夏新的N5000手机便宜新台币1500元(约合47美元)。(c000)  \n</p>\n\n\t\n\t\t\n','','赛迪网','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73192,'诺基亚诞生新掌门','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　芬兰赫尔辛基消息　8月2日全球最大的手机供应商诺基亚宣布，现任CEO奥利拉将于2006年6月1日卸任，该职将由现任手机部门主管奥利-佩卡·卡拉斯沃接任。</p>\n\n<p>　　诺基亚同时表示，奥利拉卸任后有可能仍供职本公司，担任非执行董事长一职，维持其在董事会的席次。</p>\n\n\n<p>　　消息一经公布，诺基亚在欧洲股市下跌0.5%。</p>\n\n<p>　　现年54岁的奥利拉可谓诺基亚的缔造者。1992年他担任诺基亚执行官之初，诺基亚还是一家濒临破产、原本生产卫生纸的传统企业，如今它已成为傲视全球的高科技巨星。</p>\n\n<p>　　今年52岁的卡拉斯沃1980年加入诺基亚，目前担任诺基亚手机部门主管，负责生产入门级手机业务。</p>\n\n<p>　　此间分析人士认为，奥利-佩卡·卡拉斯沃和奥利拉的经营理念相近，此次高层更换表明诺基亚将继续延续其现有的经营战略。</p>\n\n<p>　　(本报实习生　郭艳艳)\n</p>\n\n\t\n\t\t\n','','人民网－国际金融报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73193,'摩托罗拉联手北电 注资Wi-Fi创业公司风险基金','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　天极网8月3日消息 (老沈 编译) 据外电报道，一家Wi-Fi创业企业Trapeze网络公司近日称，摩托罗拉公司和北电网络公司已经分别持有该公司的股份。</p>\n\n<p>　　摩托罗拉风险基金是摩托罗拉公司的战略投资公司，它与北电网络公司一起对Trapeze公司第三轮融资进行注资。本次投资的财务条款未披露，但是Trapeze公司技术总监Simone说，公司本轮融资共募集了2250万美元。</p>\n\n\n<p>　　这是该创业企业的第三次融资，是由风险投资基金Duff Ackerman & Goodrich领导的，它使得这家公司的融资总量达到6759万美元，该公司首次融资是在2002年。</p>\n\n<p>　　Trapeze公司制造无线路由器，用于管理无线与接入站点，这些接入装置将PC、笔记本电脑和其他Wi-Fi功能设备连接到公司网络上。</p>\n\n<p>　　这家创业企业在今年早些时候宣布与北电公司建立战略合作关系。两家公司正在联合开发产品，北电公司分销Trapeze公司的设备。但这是Trapeze公司第一次与摩托罗拉公司建立正式关系。</p>\n\n<p>　　该公司技术总监称，对我们来说，摩托罗拉是战略合作伙伴。它们显然清楚地知道何时应当进入无线语音和数据通讯。我们的重点是开发无线局域网技术。但是我们都看到了市场转向移动的趋势，知道手机和无线局域网将走向整合。</p>\n\n<p>　　摩托罗拉公司最近发布了一些新产品，其中就有既可用于手机网络，也可用于无线局域网环境的新设备。</p>\n\n<p>　　近半年来，随着思科公司和西门子公司公收购了一些较小的创业企业，像摩托罗拉和北电这类大公司都对无线局域网路由设备创业企业表示出更大兴趣。(完)\n</p>\n\n\t\n\t\t\n','','ChinaByte','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73194,'诺基亚任命新总裁','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　【据新华社电】(记者赵长春)全球最大手机生产商诺基亚集团公司董事会1日宣布，任命诺基亚手机生产部门主管奥利-佩卡·卡拉斯沃出任该集团公司总裁兼首席运营官，并于2006年6月接替约尔马·奥利拉出任该集团公司首席执行官。</p>\n\n<p>　　现年52岁的奥利-佩卡·卡拉斯沃将于今年10月1日走马上任。诺基亚集团公司现任总裁佩卡·阿拉-皮耶蒂莱因个人原因辞职。掌管诺基亚公司13年之久的现任首席执行官奥利\n拉也将于明年5月底卸任。 \n</p>\n\n\t\n\t\t\n','','深圳商报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73190,'大学生暑期寻梦北京移动','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　7月20日下午，动感地带“寻梦之旅”———北京移动首届学生暑期社会实践活动在北京交通大学举行了开幕式。教育部、北京市学联和北京移动的领导莅临开幕式并发表讲话，对活动给予了充分的肯定。动感地带“寻梦之旅”是由北京移动与教育部教育管理信息中心联合主办的大型公益性社会活动。按照活动计划，来自清华大学、北京大学、人民大学、北京交通大学等高校的50名大学生将进入北京移动10多个营业厅，进行为期20多天的实习。实习期间北京移动将按照企业标准对入选大学生进行系统的培训，同时还将按照公司规章制度对\n他们进行规范管理。整个实践活动将以切实提升实践参与人员的能力锻炼为主旨。</p>\n\n<p>　　关注大学生就业</p>\n\n<p>　　大学生是国家的栋梁，而动感地带是年轻客户最贴心的移动通信品牌。基于此，北京移动决定通过动感地带“寻梦之旅”为大学生与其职业梦想之间搭建一座连接的桥梁。据北京移动介绍，动感地带“寻梦之旅”经过了细致的策划和安排。如招聘的选拔过程、“入职”前的系统培训等环节设计一丝不苟，目的是为大学生营造真枪实弹的“工作环境”。而将实践地点安排在北京移动营业厅，则是为了借动感地带“拼搏、进取”的内涵，激发大学生积极的心态，增强就业信心。</p>\n\n<p>　　此次动感地带“寻梦之旅”只是北京移动整个“寻梦”活动的开始，在大学生的热情响应下，动感地带“寻梦之旅”将会长期进行下去。在以后的活动过程中，会采用更为灵活的时间安排，在双休日、节假日也会组织日常实践活动；同时，活动范围也将更为广泛，将由大学生进一步扩展到中学生，以利于更多学生能够加入这一具有社会意义的实践活动中来。</p>\n\n<p>　　彰显优秀企业公民品质</p>\n\n<p>　　企业立身于社会，仅仅作为营利主体为社会提供优质的产品和服务是远远不够的，还必须关注社会的发展，承担起“企业公民”的社会责任。</p>\n\n<p>　　北京移动始终把承担社会责任看做是企业发展的重要使命，公司的企业文化也始终强调企业应为国家、为社会创造更大价值。多年来，北京移动已经形成了通过公益活动等多种形式回报社会的传统。2003年“非典”</p>\n\n<p>　　肆虐北京期间举办的青年志愿者慰问活动、2004年底印度尼西亚苏门答腊岛附近海域海啸发生后开通的“海啸绿色通道”等等，都是其承担社会责任、回报社会之举。</p>\n\n<p>　　北京移动正是通过这样的一系列的公益活动为其持续发展奠定了深厚的社会基础。此次动感地带“寻梦之旅”再次彰显北京移动优秀企业公民的品质。</p>\n\n<p>　　推进构建和谐社会</p>\n\n<p>　　从整个社会来看，北京移动动感地带“寻梦之旅”活动的社会意义远远超出了为大学生提供实践机会本身。中国社会科学院有关专家指出，大学生就业问题牵涉到社会的方方面面，已成为全社会普遍关注的社会问题。动感地带“寻梦之旅”社会实践活动，起到了积极的示范作用，它号召企业不但要关注自身经济发展，而且应通过积极具体的行动承担社会责任，尽一个优秀企业公民的义务。</p>\n\n<p>　　北京移动为学生举办的动感地带“寻梦之旅”活动，将是一个新的起点，将促进更多的企业关注社会问题，承担应有的社会责任。更多的优秀企业公民将行动起来，共同推进和谐社会的构建。</p>\n\n<p>　　(广文)\n</p>\n\n\t\n\t\t\n','','京华时报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73191,'华为拿到全球11个3G商用合同','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　晨报讯(记者 焦立坤)“截至2005年上半年，华为WCDMA在全球共取得11个商用合同，已取得WCDMA 5%的基本专利，跻身全球前五位，并于今年2月在全球率先发布WCDMA分布式基站。”在日前召开的亚太移动通讯发展论坛上，华为副总裁王良文称，华为已跻身全球WCDMA“第一集团”。</p>\n\n<p>　　WCDMA是全球三大主流3G标准之一，主导权在欧洲人手中。</p>\n\n\n<p>　　王良文还透露，目前华为已在全球建立了庞大的销售服务平台：已有8个地区部，并在55个国家建立了代表机构和服务中心，各类产品进入90多个国家和地区。\n</p>\n\n\t\n\t\t\n','','北京晨报','',NULL,1126863856,1126863856,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73188,'UT斯达康Q2净亏损747万美元 调降对Q3预期','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　作者:云雀</p>\n\n<p>　　【赛迪网讯】8月3日消息 通讯设备制造商UT斯达康周二报告了第二季度业绩。受结构调整和中国业务疲软影响，本季度产生净亏损，该公司并降低了对第三季度的预期。财报发布后，公司股票下跌了10%以上。 </p>\n\n\n<p>　　UT斯达康将对第三季度的收入预期由此前的6.8亿美元降至6.6亿美元，较市场平均预期7.791亿美元低14%。 </p>\n\n<p>　　UT斯达康股票截至周二收盘时已下跌了3.2%。在财报公布后，该支股票在盘后交易中再次下跌10.2%，报价于每股7.7美元。 </p>\n\n<p>　　据UT斯达康发布的财报显示，第二季度净亏损747万美元，合每股亏损65美分。一年前同期的业绩为盈利4390万美元，或每股收益33美分。 </p>\n\n<p>　　据路透社的调查显示，市场分析家此前对UT斯达康本季度业绩的平均预估为每股亏损76美分。 </p>\n\n<p>　　UT斯达康本季度净营收7.23亿美元，较去年同期的6.896亿美元增长5%。 </p>\n\n<p>　　另外，该公司任命弗朗西斯·巴顿(Francis Barton)担任首席财务官一职。现任的首席财务官最近已被任命为首席运营官。 \n</p>\n\n\t\n\t\t\n','','赛迪网','',NULL,1126863756,1126863756,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73189,'积累最好的商用经验 华为3G疾行亚太','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　作者：刘琦 </p>\n<p>　　在华为高级副总裁王良文来京参加首届“亚太移动通信论坛”前的一星期，华为公布的2005年上半年业绩为王良文倍添了不少关注度。上半年，华为实现全球销售额330亿元人民币，比去年同期增长85%。</p>\n\n<p>　　更令人惊讶的是，华为上半年海外销售达24.7亿美金，占销售总额的62%，并已超过2004年全年的国际市场销售额。对于力主“走出去”的华为而言，这次疾行无疑是漂亮的一役。而这其中，那个3G市场反而让华为后发先至。</p>\n<p>　　移动市场再度翻番</p>\n<p>　　从华为公布的业绩来看，2005年上半年华为的移动通信产品相对于2004年同期，在销售额上实现了120%的增长，其中CDMA在国际市场上的增长率达到200%。对于根据地在中国的华为来说，对于中国3G牌照未发的情势下，华为的增长有如神助。</p>\n<p>　　王良文如数家珍，在WCDMA领域，华为通过自主研发、创新，已经取得5%的基本专利，跻身全球前五。截止2005年6月30日，华为WCDMA共取得11个商用合同，HSDPA网络和HSDPA数据卡在荷兰TELFORT成功商用。华为于2005年2月在全球率先发布了WCDMA分布式基站，这种创新基站体积小，安装容易，可以极大地降低建网成本，提高建网速度，创新的解决方案进一步巩固了华为WCDMA的全球领先地位。</p>\n<p>　　同时，华为在GSM领域推出了面向3G的解决方案，可以全面支持3G并支持专业集群功能，配合专业的集群手机，可以满足高端用户的调度、会议广播以及紧急呼叫等需求。2005年上半年，华为GSM移动软交换累计出货达到2000万用户容量，服务于20个国家26个运营商。全球首创的GT800系统不仅通过了国家鉴定，而且纳入了3GPP标准，成为全球标准。</p>\n<p>　　除了令华为自豪的WCDMA外，兴奋不已的CDMA2000 1X及1X EV-DO市场上，华为也颇有斩获。2005年上半年，华为连续获得泰国、阿尔及利亚、孟加拉、巴基斯坦以及欧美大单，上半年CDMA出货1000万用户容量。华为已经在10个国家建设了CDMA2000 1x EV-DO网络，包括美国、泰国、墨西哥、巴基斯坦、阿尔及利亚等。</p>\n<p>　　王良文坦言，虽然华为在3G市场晚人一步，但是这晚的一步却让他们跳过了R99，直接进入R4，甚至R5，晚一步却先声夺人。</p>\n<p>　　突破跟随跑</p>\n<p>　　今天，华为名副其实地跻身全球WCDMA第一集团，不再是跟随跑的角色，成为全球R4软交换解决方案领先者，分布式UMTS基站的创立者，而且成功商用。在今年2月份，HSDPA在荷兰成功商用。目前在全球参与的投标中，华为获得11个商用网络。同时，CDMA2000设备进入五十多个国家，容量超过2500万用户。目前有十个正式商用CDMA3G商用网络，通过与西门子合作，华为正式拥有全套的TD-SCDMA解决方案。</p>\n<p>　　基于公司的研发能力，华为推出新一代WCDMA基站，比传统的WCDMA有很多优势的地方，这些研发成果源源不断地输送到全亚洲。原来WCDMA只是提供简单的HSDPA性能，速率不到5兆，通过性能创新，已经支持14.4兆。传统WCDMA基站是窄带收发信机，是单板实现，一个频点，新一代基站的特点是宽带收发信机，一个单板实现两到三个频点，容量大，成本低。传统的WCDMA基站独立的模拟线性功放，新一代的基站是内部集成数字线性功放，省电超过30%。</p>\n<p>　　创新解决方案促进3G产业链发展，成就了华为在亚洲移动市场的疾行。王良文自豪地说，2005年华为还将发布三款UMTS终端。</p>\n<p>　　从远看，华为更是一个亚太移动通信设备商，要想持续发展，能否走向海外，创新方面是必须要具备的条件，不光是技术的创新，还有组织方面的创新。王良文认为，围绕客户需求，进行有竞争力的解决方案的服务，持续为客户提供最大价值的服务。完善全球研发和服务体系，只有研发和服务本地化，才能走向海外。</p>\n<p>　　海外市场使命必达</p>\n<p>　　王良文对于今年上半年华为公司固网产品新进入27个国家，感想颇多，开拓路上的辛酸甘苦自知。截至目前，华为固网产品已服务包括英国、法国、德国、西班牙、葡萄牙、俄罗斯等97个国家和地区。</p>\n<p>　　光网络海外市场销售同比增长超过300%。与英国电信BT、荷兰皇家电信KPN以及跨国运营商ORASTELECOM及WARID等业界著名运营商进行了重要合作，OptiX系列光网络设备新进入22个国家，其中包括荷兰、瑞典、沙特、奥地利、尼日利亚等。</p>\n<p>　　在数据通信领域，今年华为数通产品及解决方案新承建了西班牙、哥伦比亚、巴西、秘鲁、匈牙利、印度、阿联酋等国家的IP骨干网、Metro Ethernet网络，增长率超过100%，成为全球数据通信市场上成长最快的公司。</p>\n<p>　　今年，华为业务与软件产品新进入18个国家，包括印度TATA、印尼Telkomsel、苏丹电信、泰国CAT、哥伦比亚电信、摩洛哥电信等，其中彩铃首次进入欧洲，突破葡萄牙OPTIMUS市场。</p>\n<p>　　王良文认为，华为成绩的取得主要来自于三个坚持：第一是坚持围绕客户需求进行创新，推出满足客户需求的产品，实现客户价值的最大化；第二是坚持管理改进和全球化研发，通过不断提升的能力，保障端到端解决方案高质量的交付；第三是坚持与运营商和友商进行战略合作，加强行业内的经验共享，共同维护行业的健康发展，分享价值链的利益。</p>\n<p>　　华为一直明确这样的战略：首先为客户服务是华为存在的唯一理由，客户需求是华为发展的原动力。为客户提供质量好、服务好，优先满足客户的需求，提升客户竞争力和盈利能力，不断持续管理变革，实行高效的流程管理以及确保端到端的优质交付能力。此外与友商共同发展，是华为在海外发展的妙招，华为和摩托罗拉，西门子等结成良好的战略伙伴和盟友。</p>\n<p>　　创新量化优势</p>\n<p>　　85%的增长率对于早已过了高速发展期的通信业和华为来说，不啻为一次飓风。王良文认为创新是动力。</p>\n<p>　　例如在固网领域的NGN、DSLAM、终端等主要产品上，华为实现跨越式的成长，新产品和解决方案“功不可没”。在NGN(下一代网络)领域，华为推出基于IMS架构的NGN解决方案，保证了网络的持续发展和增值；在宽带领域，华为推出以IPTV、Triple-play为代表的宽带业务端到端解决方案。宽带接入设备保持IP DSLAM市场全球第一，ADSL2+应用全球第一，DSLAM全球第二的市场份额。2005年3月华为成功发布了数字家庭解决方案，产品覆盖家庭通信，家庭娱乐，家庭办公和家网管理，并于7月成为全球最大的家庭网络标准组织-数字生活网络联盟(DLNA)Promoter成员。</p>\n<p>　　今年6月，华为在全球同步发布了ME60系列多业务控制网关，是业界首款为电信级IP网络量身定做的产品，标志着电信运营商在解决IP网络的QoS、网络安全等问题上可以有更大的发挥空间，推动IP网络向电信级网的转型。</p>\n<p>　　王良文认为华为在海外所作的一切都是为了多争取将来在国内建设3G的经验，把更多更好的3G商用经验带给中国市场。扎根中国，才能在海外走的远，走的长，是华为最真诚的心声。 </p>\n\t\n\t\t\n','','通信产业报','',NULL,1126863756,1126863756,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73186,'诺基亚掌门奥利拉明年退休','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　中国区董事长康培凯将接任</p>\n\n<p>　　本报讯　(记者 刘奇　实习生 杨珊) 诺基亚公司现任全球董事长兼CEO约玛·奥利拉将于明年6月1日退休，现任诺基亚中国区董事长康培凯将成为新掌门。诺基亚中国公司昨天证实了这一消息。</p>\n\n\n<p>　　奥利拉执掌诺基亚帅印13年，并使这间起家于橡胶靴、卫生纸的企业，成功成为全球的手机霸主。他卸任之后将担任诺基亚非执行董事长职务。</p>\n\n<p>　　根据诺基亚公布的第二季度财报，其今年在全球手机市场的占有率已经扩大到33%，大幅领先竞争对手摩托罗拉和三星。不过，虽然在市占率、销售额和手机销量上均取得增长，但诺基亚的增速已经开始低于业内的预期。而有业内人士认为，诺基亚自去年年底开始的高层人选持续变更，显然与其增速放缓的业绩有关。\n</p>\n\n\t\n\t\t\n','','京华时报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73187,'动感地带资费大幅下调','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　7月上旬，北京移动对动感地带资费进行了大幅下调，优惠幅度最高达75%。动感地带的此次资费调整，不仅给广大动感地带客户带来了前所未有的超级优惠，更使动感地带整个品牌影响力得到进一步提升。</p>\n\n<p>　　资费下调M-ZONE人独享实惠</p>\n\n\n<p>　　此次动感地带资费下调的优惠幅度非常大，在北京市场实属罕见，广大客户的积极响应可以说也在意料之中。小肖，动感地带的铁杆客户，北京某重点大学一年级的学生。谈起动感地带的资费下调，他的喜悦之情溢于言表，“以前用动感地带，主要是它超级实惠的短信套餐吸引了我，但却很少用来打电话。就算是打也是长话短说，尽量速战速决。现在可好了，动感地带话费太便宜了，平常通话是0.25元/分钟，在每天23：00-9：00的优惠时段，更是只要0.15元/分钟，降价幅度达到了75%，绝对具有吸引力。动感地带尤其适合像我这样的夜猫子。现在在晚上优惠时间打电话，几乎跟打市话一样便宜，还省去了排队打市话的困扰。0.15元/分钟，我就是聊上一个小时也不过一个汉堡钱。因此，有时不知不觉就煲上了电话粥，最近我已经有好几个朋友加入了动感地带。”</p>\n\n<p>　　让广大动感地带客户高兴的还不止这些。新的资费标准，在漫游与长途业务方面同样做出了很大突破。原来动感地带漫游通话还分网内网外，网内0.60元/分钟、网外0.80元/分钟，现在差别定价全部取消，统一定价为漫游状态0.60元/分钟。更大的优惠是，如果动感地带客户在北京本地拨打17951IP国内长途电话，IP长途话费降低到0.1元/分钟的惊爆价格。这样加上基本通话费在内，动感地带客户在本地打长途最低只要0.25元/分钟，而最高也只有0.35元/分钟。对于之前排队在“IP话吧”打长途的客户来说，用手机直接拨打的花费已经几乎和IP话吧持平了。对于很多外出旅行，或是来北京上学、工作的动感地带客户来说真是一项非常贴心的实惠内容。</p>\n\n<p>　　良性发展动感地带扩张地盘</p>\n\n<p>　　如果说话费下调给广大动感地带客户带来的是具体优惠的话，那么全面取消网内网外差别定价则是对整个移动通信市场良性发展的进一步推动。在整个资费调整过程中，北京移动贯彻落实了信产部取消网内网外差别定价的相关精神。在新的发展环境下，取消这一规定对维护消费者利益、促进移动通信市场的健康发展无疑具有重要的意义。</p>\n\n<p>　　除了此次资费下调外，动感地带在今年夏天，还推出了针对动感地带客户积分回报的M计划、为动感地带客户提供社会实习机会的寻梦之旅等众多特权活动，这些活动与优惠的组合出击影响巨大。从目前市场动态看，随着动感地带各项业务的深入推广，尤其是此次资费的全面调整，已经开始带动更多年轻人群加入动感地带，整个品牌影响力也正在进一步提升。(易文)\n</p>\n\n\t\n\t\t\n','','京华时报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73184,'我国手机用户已达3.632亿人 占总人口28%','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　作者:云雀</p>\n\n<p>　　【赛迪网讯】8月3日消息 据信产部最新发布的统计数据，截至6月底，我国手机用户和固定电话用户分别达到了3.632亿人和3.374亿人，各占当前人口总数的28%和26%。 </p>\n\n<p>　　对于网络接入服务，我国宽带用户人数已达3170万，其中2190万(69.1%)属于xDSL\n用户。 \n</p>\n\n\t\n\t\t\n','','赛迪网','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73185,'诺基亚挥别“奥利拉时代”','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　中国区董事长康培凯明年6月接帅印</p>\n\n<p>　　晨报讯(记者 焦立坤)全球手机业老大诺基亚将告别“奥利拉时代”。现年54岁的诺基亚董事长兼CEO约玛·奥利拉将在明年6月1日离职。</p>\n\n<p>　　昨天，诺基亚宣布了这个消息。同时，诺基亚现任总裁彭培佳由于个人原因辞去现\n任职务。诺基亚前任首席财务官、现任手机部门主管兼中国公司董事长康培凯将于今年10月1日就任公司总裁兼首席运营官，并将于明年6月从奥利拉手中接过帅印。</p>\n\n<p>　　在诺基亚的故乡芬兰，奥利拉这个名字是许多人崇拜的偶像。他的背后是一个全球手机巨人成长的传奇故事。</p>\n\n<p>　　上世纪80年代的诺基亚陷入多元化的误区，当时没有多少人知道诺基亚是做什么的。甚至在1988年，时任的诺基亚董事会主席兼CEO因看不到公司的前景而自杀。后来，这家公司最大的股东甚至想把它卖给爱立信，但爱立信当时对它根本没兴趣。艰难时刻，约玛·奥利拉被推上前台，担任公司CEO。正是这个人，成就了诺基亚今日全球手机第一的盛名。 </p>\n\n<p>　　接管诺基亚后，奥利拉作出一个大胆的决定：推行以手机为中心的专业化发展新战略，陆续压缩、出售电视、造纸等业务，集中力量发展移动通讯器材和多媒体技术。</p>\n\n<p>　　穿梭的时光验证了奥利拉决策的英明。2000年，诺基亚成为欧洲市值最高的公司，并连续多年稳坐全球手机第一的宝座。</p>\n\n<p>　　在一份声明中，奥利拉称将继续为诺基亚效力，其新的职务是诺基亚董事会非执行主席。现在，人们把目光投向了他的接班人。</p>\n\n<p>　　康培凯今年52岁，是诺基亚一手培养出来的。他1980年加入诺基亚，现任手机部门主管，此前曾任首席财务官。有意思的是，康培凯在诺基亚的工作履历同奥利拉有很多相似之处，例如奥利拉就任CEO前也曾负责公司财务，并担任过手机业务主管。</p>\n\n<p>　　目前，康培凯所留下的岗位空缺还没有填补，包括中国公司董事长的要职。在诺基亚最新公布的2005年上半年业绩中，其手机市场份额进一步扩大，并特别提到中国市场表现强劲。</p>\n\n\t\n\t\t\n','','北京晨报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73183,'UT斯达康任命前AMD高管为首席财务长','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　新浪科技讯 美国东部时间8月2日(北京时间8月3日)消息，UT斯达康今天宣布任命弗兰-巴顿(Fran Barton)为公司执行副总裁兼首席财务长，任命从2005年9月起生效。巴顿此前在Atmel公司担任执行副总裁兼首席财务长。</p>\n<p>　　UT斯达康CEO陆弘亮表示：“UT斯达康目前正处于一个转型期，我们的目标是向国际市场发展，并保持公司业绩稳步增长。与此同时，我们必须保证公司的财务团队拥有足够的能\n力和经验，以满足公司长期发展目标的需要。在这方面，巴顿有着优异的工作记录，出色的财务和战略规划能力，以及领导科技企业财务团队的丰富经验。”</p>\n<p>　　在加盟UT斯达康之前，巴顿在Atmel公司担任执行副总裁兼首席财务长，负责公司的财务和管理工作；1998年到2001年期间，巴顿曾在AMD公司担任高级副总裁兼首席财务长；1996年到1998年期间，巴顿曾在Amdahl公司担任副总裁兼首席财务长；1974年到1996年期间，巴顿在DEC公司任职，由财务分析师做起，直至DEC公司个人计算机部门副总裁兼首席财务长。</p>\n<p>　　巴顿拥有伍斯特工学院(Worcester Polytechnic Institute)化学工程理学学士学位，以及美国东北大学企业管理硕士学位。(摩尔）</p>\n\t\n\t\t\n','','新浪科技','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73181,'快讯：UT斯达康发布2005年第二季度财报','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　新浪科技讯 美国东部时间8月2日16：05(北京时间8月3日4：05)消息，UT斯达康(Nasdaq:UTSI)今天发布了截至6月30日的2005年第二季度财报。财报显示，UT斯达康第二季度净销售额为7.23亿美元，同比增长5%；净亏损为7470万美元，去年同期净利润为4390万美元。</p>\n\n\n\t\n\t\t\n','','新浪科技','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73182,'UT斯达康发布第二季财报 净亏损7470万美元','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　新浪科技讯 美国东部时间8月2日16：30(北京时间8月3日4：30)消息，UT斯达康(Nasdaq:UTSI)今天发布了截至6月30日的2005年第二季度财报。财报显示，UT斯达康第二季度净销售额为7.23亿美元，同比增长5%；净亏损为7470万美元，去年同期净利润为4390万美元。</p>\n<p>　<strong>　主要业绩：</strong></p>\n\n<p>　　-UT斯达康第二季度营收为7.23亿美元，同比增长5%；</p>\n<p>　　-第二季度获得订单总额为9.15亿美元；</p>\n<p>　　-第二季度在中国签署了价值2.5亿美元的小灵通合同；</p>\n<p>　　-运营现金流约为4400万美元；</p>\n<p>　　-净亏损为7470万美元，去年同期净利润为4390万美元。</p>\n<p>　　<strong>财务分析：</strong>　　</p>\n<p>　　UT斯达康第二季度净销售额为7.23亿美元，比去年同期的6.896亿美元增长5%。其中个人通信部门销售额为3.423亿美元。</p>\n<p>　　UT斯达康第二季度毛利率为15.1%，低于去年同期的25.6%，UT斯达康毛利率的下滑主要受到注销库存和重组计划的影响。不计入个人通信部门，UT斯达康第二季度毛利率为24.5%。UT斯达康个人通信部门第二季度毛利率为4.7%。</p>\n<p>　　按照美国通用会计准则，UT斯达康第二季度净亏损为7470万美元，每股摊薄亏损65美分。UT斯达康第二季度业绩中计入了2070万美元(每股支出16美分)的重组支出，1350万美元(每股支出12美分)的非现金税费支出。2004年第二季度，UT斯达康净利润为4390万美元，每股摊薄收益33美分。</p>\n<p>　　<strong>重组计划：</strong></p>\n<p>　　-UT斯达康员第二季度裁员960人；</p>\n<p>　　-通过第二季度裁员，UT斯达康每季度可削减大约2400万美元的运营支出，裁员效果将从第三季度开始体现。UT斯达康预计，整个重组计划完成之后每季度可削减大约4000万美元的运营支出；</p>\n<p>　　-第二季度削减营运资金大约8200万美元。UT斯达康预计，整个裁员计划完成之后可削减营运资金大约2亿美元；</p>\n<p>　　-第二季度业绩中计入了2070万美元(每股支出16美分)的重组支出。UT斯达康预计，第三季度业绩中将计入500万美元到1000万美元的重组支出；</p>\n<p>　　-UT斯达康预计到第三季度末可以完成整个重组计划。</p>\n<p><strong>　　业务展望：</strong></p>\n<p>　　UT斯达康预计第三季度总营收大约为6.6亿美元到6.8亿美元；毛利率为15%到18%，不计入个人通信部门毛利率为30%到32%；重组支出大约为500万美元到1000万美元；按照美国通用会计准则，每股亏损0.35美元到0.40美元。</p>\n<p>　<strong>　电话会议：</strong></p>\n<p>　　UT斯达康将于美国东部时间8月2日16：30(北京时间8月3日4：30)召开电话会议，届时公司管理团队将出席会议并回答投资者提问。如投资者有意收听此次会议，美国用户可以拨打电话888-398-3046，国际用户可以拨打电话706-634-2492。</p>\n<p>　　如果用户想收听电话会议录音，美国用户可以拨打电话800-642-1687，国际用户可拨打电话706-645-9291，接入代码为7733344。电话会议录音开始时间为美国东部时间8月2日20：30(北京时间8月3日8：30)，结束时间为美国东部时间8月10日2：59(北京时间8月10日14：59)。</p>\n<p>　　投资者还可以访问UT斯达康的网站www.utstar.com收听电话会议直播或录音。如果想收听网站直播，用户需要提前至少十五分钟到网站注册，下载并安装所需的音频软件。(摩尔) </p>\n\t\n\t\t\n','','新浪科技','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73179,'男童咬断光缆通信多次中断 直接经济损失5万','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　据新华社电 陕西省南郑县一名11岁的男孩陈某多次用牙咬断通信光缆图好玩，致使当地通信累计中断29小时，造成直接经济损失5万多元。</p>\n<p>　　4月25日，家住南郑县湘水镇花园坝村的陈某趁学校开运动会之机，偷偷溜出学校，来到南郑县移动公司湘水基站，爬上距地面2米多高的塔架平台玩耍。当陈某打开上锁的设备箱后，发现里面有很粗的五颜六色的胶皮线，好奇的陈某便用牙一点一点地将线咬断后离去\n。</p>\n<p>　　5月10日，他再次用同样方法将已修复好的光纤尾缆咬断。5月17日，他又一次来到移动公司基站将尾缆咬断，并爬上联通公司的湘水基站塔架咬断尾缆玩耍，造成两个基站通信再次中断。当陈某仍在塔架上攀爬玩耍时，被民警发现。</p>\n\t\n\t\t\n','','北京娱乐信报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73180,'诺基亚全球董事长将有更迭','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　信报讯 (记者 廖奇) 昨天，诺基亚中国公司证实现任诺基亚全球CEO约玛·奥利拉将于明年6月离职、转任非执行董事长，其职位将由诺基亚中国公司董事长康培凯接任。</p>\n\n<p>　　诺基亚还宣布，公司总裁佩卡·阿拉佩蒂拉由于个人原因将从公司辞职，生效时间为2006年2月1日。</p>\n\n\n<p>　　比奥利拉年轻两岁的康培凯今年初成为诺基亚中国公司董事长。此前，康培凯先后担任了诺基亚CFO、移动电话事业部总经理等多个职务，工作能力为业界所公认。</p>\n\n<p>　　对于康培凯即将履新，业内人士普遍认为，康培凯不会改变诺基亚已经证明正确的既定方针。\n</p>\n\n\t\n\t\t\n','','北京娱乐信报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73176,'京信通信半年报预警','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　工商东亚的分析师BertrandChui指出，该股目前预测市盈率在10倍以下，建议“持有” </p>\n\n<p>　　昨日，京信通信(2342.HK)发布公告称，由于营运开支增加以及主要客户延迟执行无线覆盖方案之资本开支计划等原因，公司2005年上半年净利润，将较去年同期的约1.18亿港元明显下降，公司将于9月中旬公布中期业绩。</p>\n\n\n<p>　　京信通信称，中报预警的原因如下：受内地电信营运商业务重组的不明朗因素影响，一名主要客户延迟执行资本开支计划，给公司造成不利影响。第二，内地尚未发出3G牌照，而公司已作出相关投资，因而会影响业绩。第三，内地第二代移动通信市场已发展成熟，令公司相关产品的平均售价及边际毛利缩水。第四，去年上半年起，公司国际及电讯主设备制造业务仍在发展阶段，未带来收入贡献。第五，公司在内地建立网络、加大新产品研发力度等令营运开支增加。</p>\n\n<p>　　工商东亚的分析师BertrandChui称，上述主要客户可能是中国联通(0762.HK)，因为该公司推迟了CDMA网络升级工程；他指出，该股目前的预测市盈率在10倍以下，有低估嫌疑，建议“持有”，因为该股最终将受益于内地3G业务的发展。</p>\n\n<p>　　一欧资银行分析师也认为，业绩不佳的部分原因是中国联通CDMA网络投资放缓。但他表示，该股短期内很难大幅反弹，今后的上涨动力可能取决于有关中国发放3G牌照的消息。</p>\n\n<p>　　受中报预警消息影响，昨日，该股一度大跌20.72%，至2.2港元，创出两年新低，10∶45以后该股逐渐反弹，收盘报2\n</p>\n\n\t\n\t\t\n','','每日经济新闻','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73177,'TOM意外退出超级女声短信互动 掌上灵通接手','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　业内人士称，湖南卫视太强势，SP分成受打压 </p>\n\n<p>　　黄婕 </p>\n\n<p>　　《每日经济新闻》昨日获悉，一直与湖南广电有着紧密合作的国内无线增值服务提供商(SP)TOM意外退出“超级女声”，接掌者是总部位于上海同为纳斯达克上市公司的SP掌上\n灵通。</p>\n\n<p>　　掌上灵通公关总监张浩音昨日接受《每日经济新闻》采访时证实了该消息。她表示，掌上灵通通过下属两家子公司———优联时空和上海蔚蓝计算机有限公司为“超级女声”短信投票提供技术支持。此外，还与另一家获得“超级女声”代理权的SP海南众通电脑网络有限公司就此项目进行合作，成为“超级女声”的短信互动环节的主要增值服务代理商。</p>\n\n<p>　　对此，一位SP行业资深人士说，此前，湖南卫视主要节目的短信增值服务几乎都被TOM垄断，在“超级女声”这个最火的节目上马失前蹄，“可能有问题。”</p>\n\n<p>　　“我们确实合作过一段时间。”TOM副总裁冯珏对《每日经济新闻》表示，TOM和湖南卫视在很多项目上分不同阶段签署协议，“超级女声”前期TOM也进行了参与，但现在已经停止合作。对于停止原因，冯珏不愿多谈，但她始终强调，公司开展业务一定要以保证收入利润率为前提。</p>\n\n<p>　　对此，湖南卫视以涉及商业机密为由拒绝接受采访。不过，湖南卫视7月14日在其网站上发布声明称，“湖南卫视2005‘超级女声’从总决赛开始推出全新短信参与平台，与此同时，湖南卫视与原短信平台、声讯平台的业务已终止。”</p>\n\n<p>　　外界猜测，很可能是因为TOM与湖南卫视在利润分成比例上不能达成一致。“除去电信运营商15%的提成，SP和内容提供商一般是五五分成。但是这一分成比例要由媒体的强势程度决定。”同为SP的华友世纪副总裁吴锋说。另一SP老总则表示，随着“超女热”的迅速升温，湖南卫视很可能想提高自己的分成比例，从而与TOM产生分歧。</p>\n\n<p>　　那么，“超女”究竟能给湖南卫视和SP带来多少利润？</p>\n\n<p>　　《每日经济新闻》从湖南卫视官方网站了解到，参与投票的观众，移动用户每发送一条短信为1元，联通用户和小灵通用户每发送一条短信为0.5元。此外，一旦用户发送投票短信，就被移动运营商默认参与接收关于“超女”各类资讯与花絮的增值服务，该服务收费为6元。</p>\n\n<p>　　以成都赛区总决赛为例，由观众投票决出的三甲李宇春、张靓颖、何洁在一周内的短信得票数分别为206564、58172、42335张，总票数约30.7万票。由此产生的捆绑增值费便超过180万元。再以信产部公布的用户数量为比例(移动：联通＋小灵通＝54：45)粗略估算，产生的短信费用约为23万元。比赛收入总计在203万元以上。这个收入中，除去运营商的利润分成(以15%计算)，湖南卫视和SP一场比赛就能进账170万元。</p>\n\n<p>　　不过，张浩音却表示，掌上灵通的收入没有想象那么高，“其实我们没赚多少钱。”\n</p>\n\n\t\n\t\t\n','','每日经济新闻','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73178,'全国小灵通用户“逼近”8000万','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　将以不同市场定位与3G并存 </p>\n\n<p>　　冯晓芳 新华社</p>\n\n<p>　　信息产业部最新统计显示，截至6月底，全国小灵通用户已近8000万户，且平均每个月新增用户数近250万户。按照这一增长比例，到今年年底，全国小灵通用户有望达1亿户。\n</p>\n\n<p>　　专家认为，在未来第三代移动通信(3G)牌照发放后，小灵通还会以其不同的市场定位与3G业务共存。</p>\n\n<p>　　信息产业部有关负责人2日说，小灵通是两大固网运营商中国电信、中国网通目前最重要的业务增长点之一。统计表明，从去年到今年上半年，全国固定电话新增用户中近6成来自新增小灵通用户。</p>\n\n<p>　　中国社会科学院信息化研究中心副研究员刘满强认为，从我国目前的国情来看，用户消费层次的多样性，决定了网络技术的多样性，也决定了小灵通的市场空间为在一定范围内活动的普通百姓。</p>\n\n<p>　　在此基础上，两大固网运营商实现了小灵通机卡分离，给终端用户提供了更多选择。短信、彩信、个性化铃音、无线上网等增值业务的不断推出，也使小灵通的功能更为齐全。近日，固网运营商开始在全国多个城市进行“QBOX业务”试点，使小灵通和固定电话无缝融合。\n</p>\n\n\t\n\t\t\n','','每日经济新闻','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73175,'3G推出尚无定论 京信预警股价缩水1.8亿港元','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　本报记者 邹华 发自上海</p>\n<p>　　昨日，京信通信(2342.HK)董事会表示，由于受多项不利因素困扰，预期截至今年6月底半年纯利将较去年同期的1.18亿港元大幅下降。此则公告发布之后，京信通信的股价在短短的一个小时之内缩水近20%，终盘虽然股价有所回升，但京信通信市值依然缩水近1.8亿港元。</p>\n\n<p>　　京信通信对于公司业绩预警的解释是该公司一名主要客户(由同一集团之公司组成)减慢执行无线覆盖方案的资本开支，这使得京信通信业务受到不利影响；同时，该公司增加在第三代移动电信业务方面投资的同时，但是内地到现在为止尚未发出3G牌照，这也使得京信通信业绩受损。除此之外，第二代移动电信市场已达成熟阶段，也对其产品的售价及边际毛利构成压力。</p>\n<p>　　该公司董事会还表示，虽然已扩展其他新业务，如天线及子系统，以及数码微波系统，但由于发展仍属初始阶段，相对于该公司投资于这方面的额外资源，相关业务并未带来预期中的收入贡献。至于具体下降幅度，京信通信表示中期财务报表现在还在编制过程当中，预计9月中旬将正式公布中期业绩。</p>\n<p>　　银河证券分析师邢志斌表示，内地推出3G的时间、规模及科技配套等资源到现在为止尚未公开，因此相信市场之前对于京信通信受惠3G出台的看法过于理想。京信通信去年产品平均价格下跌超过15%，而集团毛利率则由2003年的46.4%，下跌到2004年的43%，而纯利润也比预期有所下降。</p>\n<p>　　据了解，京信通信主要经营转发器、天线及射频无源器件等无线覆盖产品，中国移动和中国联通是其最大的客户，来自中国移动及中国联通所占的整体营业额，分别达48.7%及37.8%。由于市场一直猜测内地即将推出3G业务，而京信通信作为两大移动运营商的主要设备供应商之一，因此普遍预期3G业务的出台，将使得京信通信生产经营规模成倍增加。</p>\n<p>　　工商东亚指出，京信通信的预警公告短期虽然使得股价大幅下跌，但内地3G发牌政策一旦落实，中国移动、中国联通将作出庞大投资，在3G电讯设备市场的竞争远没有2G激烈，符合资格的生产商只有8到9家，作为其中一员的京信通信，到时候必然将会从中受惠。</p>\n<p>　　瑞银分析员张恭劲认为上半年中国联通减少电讯硬件及服务的开支，这使得京信通信短期之内的业绩可能减少。同时，未来3G出台并不会增加电讯运营商的数量，加上3G推出的初期可能只会首先集中在内地部分主要城市，因此最终可能不会使得京信通信规模呈现大幅度的增长。</p>\n<p>　　昨日，京信通信在开盘后即受到市场的抛压，最低跌至2.20港元，跌幅达到20.72%，此后在买盘的推动下走高，终盘报收于2.475港元，跌幅依然高达10.81%。 </p>\n\t\n\t\t\n','','第一财经日报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73173,'SBS亏损超1亿欧元 西门子裁减4000德国员工','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　本报记者 惠正一 综合报道</p>\n<p>　　西门子公司的亏损商业服务子公司(下称“SBS”)计划裁减大约4000名德国工人。而与此同时，西门子旗下发电和通讯两个子公司则先后签署新合同，涉及总金额达4亿美元。</p>\n<p>　　据慕尼黑地方报纸《TZ》引用“内部人士”的话称，SBS大约25%的员工将被裁减。S\nBS主要经营信息技术服务，在德国雇有大约1.5万名员工。不过，西门子的发言人拒绝对报道置评。而就在上周，西门子首席执行官KlausKleinfeld表示，西门子将对状况不佳的子公司进行裁员，其中就包括SBS。不过，当时Kleinfeld拒绝透露预计裁员的数量。SBS第三财政季度亏损额由上年同期的200万欧元扩大至1.09亿欧元。</p>\n<p>　　与SBS亏损裁员景况不同，西门子旗下另两个子公司则双喜临门。发电子公司西门子PG周一与其日本合作伙伴丸红株式会社在曼谷签署协议，将共同在泰国宋卡修建一个700兆瓦特的复合式循环发电厂，其中西门子PG将承担2个燃气涡轮、1台蒸汽轮机、3台发电机等设备，控制系统以及辅助设施，整个合同价值3.87亿美元。业内估计，泰国在2007年至2015年间，每年的用电量将增加2200兆瓦特。</p>\n<p>　　此外，西门子通讯则从尼泊尔私人手机运营商SpiceNepal手中赢得一份价值2900万美元的合同，为其在尼泊尔全国范围内建设GSM网络。在未来两年半的时间内，西门子将提供、安装整个基础设施，并投入运营。西门子在一个发布会上称，届时尼泊尔将有100万用户能通过GSM网络拨打和接听电话。</p>\n\t\n\t\t\n','','第一财经日报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73174,'中域电讯收购宇讯达 图谋深圳手机连锁市场','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　本报记者 马晓芳 发自广州</p>\n<p>　　昨天，珠三角著名的手机连锁企业中域电讯正式宣布，收购深圳当地连锁企业宇讯达通信的工作已于7月31日全部完成。至此，中域电讯在深圳的连锁店总数突破了60家，广东地区则增加到700家。中域电讯总裁李建明表示，中域电讯将采取复合品牌战略，不会取消宇讯达的品牌。使用复合品牌策略</p>\n\n<p>　　由于涉及商业秘密，李建明不便透露此次收购的具体金额，但他表示这次的收购是100%的股权收购，而不仅仅是控股。对于宇讯达方面的员工，李建明表示“不管是管理者还是勤杂工，只要愿意，我们希望能接收全部管理团队”，中域方面也会派出少量的管理人员以加强两个工作团队的磨合。</p>\n<p>　　当记者问到宇讯达总经理徐建超是否会继续留任原职时，李建明表示，只要徐建超愿意，他是非常欢迎的，但现在主要处理的是交接工作，关于徐建超的去留因为比较敏感，现在不便多说，一个月之内应该会有结果。</p>\n<p>　　李建明介绍说，由于宇讯达在深圳本地有较高的影响力，所以会在广东采取复合品牌的策略，使宇讯达的品牌影响力可以继续，但是对广东以外的地区则会把“中域”和“宇讯达”两个品牌独立做，两个团队也可以相互竞争，至于两个品牌将如何区别定位则要进一步计划。以“中域速度”建设“中域模式”</p>\n<p>　　据了解，宇讯达已经有8年的历史，拥有18家连锁店，一直是摩托罗拉等手机品牌深圳地区唯一的厂家直供零售商，曾经首家荣获中国移动深圳分公司、中国联通深圳分公司一级代理商的资格，在老百姓中有较高的影响力和较好的口碑。</p>\n<p>　　中域电讯近几年则在快速扩展之中。2003年，中域电讯成功收购了佛山华光、重庆科有、广西鑫辉，2004年又收购了广西中人，目前在广东地区的市场占有率为10%左右。中域电讯营销中心副总经理曾幼红认为，目前的手机零售行业，特别是连锁经营领域，最为核心的要素就是规模和速度。如果初具规模，便停滞不前，规模将越来越小，在某种意义上讲，速度决定规模，速度可以改变规模，中域电讯就是以“中域速度”在建设“中域模式”。</p>\n<p>　　他还介绍说，这次中域收购宇讯达是看中了宇讯达无法比拟的品牌和店面位置。李建明也说，目前“中域正在以每月开10多家店的速度扩张”，宇讯达虽然还在盈利，但近几年却几乎处于停滞状态，对于连锁企业来说，不扩张的后果就是被兼并收购，这正是中域和宇讯达一拍即合的原因。而且采取收购的方式进入，对同行的伤害比较小，有利于整个行业的健康发展。</p>\n<p>　　由于广东地区是手机市场的“重地”，对于中域来说，有70%的手机销量集中在广州、深圳和东莞，因此，李建明介绍说，中域在东莞市场已经占据优势的情况下，将进一步开拓广州和深圳市场，中域的目标是在今年内实现广东地区连锁店总数1000家以上，占到零售市场35%以上的份额。</p>\n<p>　　他透露，目前正在跟广州的两家电讯经营企业商谈并购事宜，但在最后签约之前，不方便透露对方的身份。中域也一直在积极筹划上市，但还有“很多东西需要梳理”，上市时间“可能是明年”。 </p>\n\n\n\t\n\t\t\n','','第一财经日报','',NULL,1126863541,1126863541,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73171,'北京网通与北辰集团签订合作协议','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　奥运通信建设紧锣密鼓</p>\n\n<p>　　7月29日，中国网通(集团)有限公司北京分公司与北京北辰实业集团公司签署战略合作协议，北京网通将为“国家会议中心”和“奥运会媒体村”提供全面周到的奥运通信服务。</p>\n\n\n<p>　　国家会议中心总建筑面积为53万平方米，奥运会期间将是主新闻中心(MPC)、国际广播中心(IBC)两个媒体中心的所在地。奥运会媒体村占地约40万平方米，根据国际奥运会媒体指南的要求，2008年约有21600名媒体人员采访报道北京奥运会，其通信系统将在奥运会期间为各国新闻媒体提供语音、数据、互联网接入等包括固定通信、移动通信和集群通信在内的全方位服务。</p>\n\n<p>　　中国网通集团副总经理兼北京市分公司总经理赵继东在签字仪式上承诺，国家会议中心和奥运会媒体村的通信系统工程将按照满足奥运会期间赛事基本需求和充分保证业主经营需求的原则进行建设。奥运会期间保证为新闻工作者、官员、运动员等提供安全可靠、高效畅通的通信保障，提供比以往任何一届奥运会都更加方便、快速和先进的通信服务。</p>\n\n<p>　　(彭超 人民邮电报) \n</p>\n\n\t\n\t\t\n','','中国信息产业网-人民邮电报','',NULL,1126758501,1126758501,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73172,'中电信六部分测试暴露短板 IPTV已现技术断层','','','','','','<P>&nbsp;&nbsp;&nbsp; 张先生家住杭州，每天除了工作和休息外，他把大部分业余时间花在互联网上，打游戏、泡论坛、聊天……张先生已经习惯于这种放松方式。但是，张先生最近上网时却遇到了麻烦。每到晚上8点钟左右，网速就变得奇慢，别说打网络游戏了，连打开普通的网页都需要等待很长时间。 <BR>为此，张先生非常恼火，他曾经找到了他的宽带接入服务提供商——杭州网通的营业部，得到的答案却是：由于近期开通IPTV业务的用户越来越多&nbsp;&nbsp;&nbsp;网络负载增加，造成晚间时段的网络拥堵，建议避开该时段上网。张先生当然无法接受这样的解释，他已经决定脱离杭州网通，选择其他的宽带服务商。<IMG alt=\"\" src=\"../resource/img/h000/h00/img200509221508480133.jpg\" border=0></P>\r\n<P>　　在杭州，目前IPTV用户已经突破了2万户。但是随着用户数量的增多，问题也出现了：原本设计带宽为10M共享的以太网，在IPTV巨大的流量压力下宽带优势荡然无存，甚至还影响到使用普通宽带服务的用户。作为目前国内IPTV运营的一个样板工程，杭州网通面临的问题值得所有准备开通IPTV业务的运营商深思。</P>\r\n<P>　　IPTV面临技术风险</P>\r\n<P>　　杭州网通的危机来自于不成熟的网络技术。IPTV是一个对网络性能和QoS要求极为严格的内容性业务，有调查显示，用户可以忍受语音的不连续性，但是却无法忍受超过5秒钟以上的图像延迟。</P>\r\n<P>　　但是在现有的互联网上解决带宽问题并不是一件易事，它涉及到对传输网、承载网，以及业务接入等各个层面的调整：从引入组播技术到调整BRAS设备，再到选择接入方式，建立安全机制、分级QoS机制，甚至组建家庭网络的方法等等。其中，很多层面的技术都还没有完善、成熟的解决方案。</P>\r\n<P>　　中国电信集团公司CTO韦乐平认为，目前IPTV面临的技术挑战主要有七个方面。第一，网络容量和结构的扩展性能否经受用户量迅速升级的挑战？第二，DSLAM、BRAS能否有良好的组播能力？第三，网络能否保证四个级别的网络服务质量(分级的可用性、延时、抖动和丢包率)？第四，如何在现有的五种视频编码标准(MPEG2、MPEG4，VC1、H.264和AVS)中进行选择？第五，如何保证内容的安全性和数字版权？第六，如何用中间件改善频道选择响应时间？第七，如何在网络、中间件、机顶盒等不同层面实现互操作性？</P>\r\n<P>　　在中国电信和中国网通已经开展的IPTV试商用中，用户数量还十分有限，最多为几千户，所以至今没有出现过大的问题；但是将来如果开始正式商用，用户规模就要扩展到几万、几十万，甚至几百万户，对现有网络的挑战将是前所未有的。</P>\r\n<P>　　产品测试悄然展开</P>\r\n<P>　　时至今日，IPTV对于固网运营商来说已是箭在弦上。但在实际商用之前，运营商还需要进行网络调整和产品、解决方案选型，以期实现更稳定、可靠的IPTV业务运营。</P>\r\n<P>　　据韦乐平透露，从今年6月开始，中国电信已经开始在包括广东、浙江、江苏、陕西和上海5省17市开展IPTV试商用。虽然就试商用的实际作用来看，更多在于探索，但起码使IPTV开始逐渐走出政策的阴影，开始向现实、可运营的业务方向发展。</P>\r\n<P>　　紧随消息发布，中国电信开始了正式操作。为对各省公司进行有效指导，确保IPTV试商用顺利进行，中国电信委托上海电信研究院开展了一次大规模的IPTV测试，并将测试结果下发各省公司作为试验选型参考。</P>\r\n<P>　　测试于7月5日正式开始，7月12日上午结束。据相关人员透露，此次测试涵盖点播时移、直播、信息服务、机顶盒、业务管理、运营支撑六个部分，模拟实际应用环境，力求得到第一手的应用数据。目前市场上的主要的IPTV解决方案提供商均参加了测试，他们是：华为、中兴、UT、西门子、阿尔卡特、思华，共六家公司。但是测试结果仍然处于保密阶段，有消息称，华为、中兴、UT均表现优异。</P>\r\n<P>　　寻找差距</P>\r\n<P>　　中国电信进行此次测试的目的非常明确：为下一步17市的IPTV方案实施选型、探路。但是在测试过程中却暴露出IPTV解决方案与实际需求之间的差距。</P>\r\n<P>　　在目前现有的五种视频编码标准中，MPEG2仍是主流。但是从发展的眼光看，H.264和VC1将逐渐接替MPEG2。所以在此次测试中，上海电信研究院将能否支持端到端的H.264/VC1编码作为考察的一项重点，但是结果却差强人意，一些解决方案的头端和机顶盒设备不支持H.264编码。另外，不支持组播时移功能、系统纠错能力差、增值业务能力弱等问题也普遍存在。</P>\r\n<P>　　一位曾参加测试的上海电信研究院工作人员告诉记者，测试结果并不是让电信方面十分满意，特别是在软件功能和互联互通性方面，还差得很远，很有可能会影响到下一步IPTV试商用网的部署速度。</P>\r\n<P>　　IPTV是很多设备提供商看好的下一块蛋糕，在目前仍缺少大规模应用的情况下，已经涌入了大大小小数百家企业。有专家认为产业整合将很快席卷IPTV设备市场，只有尽快形成强大的产业链和成熟的技术解决方案，才有可能将IPTV这块蛋糕做大。</P>\r\n<P>&nbsp;</P>','','通信产业报','','',1126758501,1127444584,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73170,'全国小灵通用户已近8000万 年底有望达1亿户','','','','','','<P>　　新华网北京8月2日电(记者冯晓芳) 信息产业部最新统计显示，截至6月底，全国小灵通用户已近8000万户，且平均每个月新增用户数近250万户。按照这一增长比例，到今年年底，全国小灵通用户有望达1亿户。 </P>\r\n<P>　　信息产业部有关负责人2日说，素有小灵通之称的无线市话是固网业务的补充和延伸，也是两大固网运营商中国电信、中国网通目前最重要的业务增长点之一。统计表明，从去年到今年上半年，全国固定电话新增用户中近六成来自新增小灵通用户。 </P>\r\n<P>　　中国社会科学院信息化研究中心副研究员刘满强说：“根植于普通百姓的现实需求，是小灵通持续发展壮大的主要原因。”从我国目前的国情来看，用户消费层次的多样性，决定了网络技术的多样性，也决定了小灵通的市场空间为在一定范围内活动的普通百姓。 </P>\r\n<P>　　同时，网络的不断优化，以及新技术、新业务的驱动也使小灵通得到了持续发展。中国电信和中国网通一直进行着网络扩容和优化工作，今年以来，在江苏、浙江、四川、山东、河南和北京等地尤为明显。记者获悉，这两大固网运营商近日与小灵通主要设备供应商UT斯达康签订了1.67亿美元的网络扩容合同。 </P>\r\n<P>　　在此基础上，两大固网运营商实现了小灵通从机卡分离，给终端用户提供了更多选择。短信、彩信、个性化铃音、无线上网等增值业务的不断推出，也使小灵通的功能更为齐全。近日，固网运营商开始在全国多个城市进行“QBOX业务”试点，使小灵通和固定电话无缝融合，提升了小灵通室内通话质量并拓展了固定电话增值业务。专家认为，在未来第三代移动通信(3G)牌照发放后，小灵通还会以其不同的市场定位与3G业务共存。</P>','','新华网','','',1126758501,1127380286,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73169,'思科掩盖漏洞问题 安全专家扮黑客进行揭露','','','','../resource/img/h000/h00/img200509161645340.jpg','','<P>　　【赛迪网讯】8月2日消息，电脑黑客周末努力研拟，以揭露思科系统的一个漏洞。攻击者可能利用该漏洞控制思科的路由器。 </P>\r\n<P>　　路透拉斯维加斯报道，思科本周稍早试图压下系统出现漏洞的消息，这惹恼并刺激了几位出席Defcon电脑安全会议的安全专家。他们一直工作到周六午夜之后，针对此一缺陷拟定计划。 </P>\r\n<P>　　“我们之所以这么做是因为有人说这办不到，”一位黑客说。这位黑客与其它黑客在接受路透采访时均要求匿名。 </P>\r\n<P>　　这些黑客称，他们无意截取电子商务付款、偷看私人电邮、或者发动任何其它恶意攻击。相反的，他们表示只是想要表明思科用户有必要更新其软件，以防御这些可能的恶意攻击。许多思科用户曾延缓此艰难过程，因为这可能得让他们完全无法连网。 </P>\r\n<P>　　安全专家Lynn周三不顾思科及前雇主ISSX的反对，在Black Hat会议上描述了该漏洞。已协助思科开发Lynn一款修补丁程序，但他希望公开讨论以让大家提高警惕。</P>','','赛迪网','','',1126758500,1126860336,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73168,'公用电信网间通信质量监督管理办法','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　第一章 总则 </p>\n\n<p>　　第一条  为加强公用电信网间通信质量监督管理，规范网间通信障碍处理，保障公用电信网间通信畅通，根据《中华人民共和国电信条例》和《公用电信网间互联管理规定》制定本办法。</p>\n\n\n<p>　　第二条  本办法适用于下列公用电信网间通信质量监督管理：</p>\n\n<p>　　(一)固定本地电话网；</p>\n\n<p>　　(二)国内长途电话网；</p>\n\n<p>　　(三)国际电话网；</p>\n\n<p>　　(四)IP电话网；</p>\n\n<p>　　(五)陆地蜂窝移动通信网；</p>\n\n<p>　　(六)卫星移动通信网；</p>\n\n<p>　　(七)互联网骨干网(接入)；</p>\n\n<p>　　(八)信息产业部规定的其他电信网。</p>\n\n<p>　　第三条  信息产业部负责全国范围内的公用电信网间通信质量监督管理。省、自治区、直辖市通信管理局负责本行政区域内的公用电信网间通信质量监督管理。</p>\n\n<p>　　第四条  公用电信网间通信质量应符合信息产业部颁布的《公用电信网间通信质量技术要求》及《公用电信网间互联中继电路扩容技术要求》的规定。对公用电信网间通信质量的测试应按照信息产业部颁布的《公用电信网间通信质量测试方法》及本办法的要求进行。</p>\n\n<p>　　第五条  信息产业部和省、自治区、直辖市通信管理局(以下统称电信监管部门)按照A类障碍、B类障碍、严重障碍、事故和严重事故的网间通信障碍分类对公用电信网间通信质量予以监督管理：</p>\n\n<p>　　(一)A类障碍：</p>\n\n<p>　　1.发端网络的呼损：过网呼叫的发端网络呼损高于20%；</p>\n\n<p>　　单一用户号码在发端网络内的呼损：对某一用户号码的过网呼叫进行测试，该用户号码发起的过网呼叫在发端网络内的呼损高于20%(该用户号码发起的呼叫次数不少于30次，呼叫频次不小于30次／小时、不大于60次／小时)；</p>\n\n<p>　　2.受端网络的来话接通率：过网呼叫的受端网络来话接通率低于80%；</p>\n\n<p>　　单一用户号码在受端网络内的来话接通率：对某一用户号码的过网呼叫进行测试，落地至该用户号码的过网呼叫在受端网络内的来话接通率低于80%(落地至该用户号码的呼叫次数不少于30次，呼叫频次不小于30次／小时、不大于60次／小时)；</p>\n\n<p>　　3.发(受)端网络的呼叫建立时延：过网呼叫在发(受)端网络中的呼叫建立时延，与发(受)端网络中同种可比业务的连接建立时延的差异大于6秒的发生概率超过20%；</p>\n\n<p>　　单一用户号码在发(受)端网络中的呼叫建立时延：对某一用户号码的过网呼叫进行测试，在发(受)端网络中的呼叫建立时延，与发(受)端网络中同种可比业务的连接建立时延的差异大于6秒的发生概率超过20%(该用户号码发起的呼叫或者落地至该用户号码的呼叫次数不少于30次，呼叫频次不小于30次／小时、不大于60次／小时)；</p>\n\n<p>　　4.发(受)端网络的断话等异常现象：过网呼叫在发(受)端网络中形成的断话、单通、错号、无回铃音、虚假回铃音(指主叫用户听到回铃音，被叫用户不振铃，下同)等现象的发生概率超过20%；</p>\n\n<p>　　单一用户号码在发(受)端网络中的断话等异常现象：对某一用户号码的过网呼叫进行测试，在发(受)端网络中形成的断话、单通、错号、无回铃音、虚假回铃音等现象的发生概率超过20%(该用户号码发起的呼叫或者落地至该用户号码的呼叫次数不少于30次，呼叫频次不小于30次／小时、不大于60次／小时)；</p>\n\n<p>　　5.网间互联中继电路的负荷：公用电信网间某一中继群连续三日忙时呼损均高于5%，或者经电信监管部门网间结算及互联互通监测系统(以下简称监测系统)监测，连续三日忙时每线话务量平均达到《网间通信障碍互联中继电路负荷表》(附件5)中相应数值。</p>\n\n<p>　　本办法所称A类障碍是指符合上述条件之一且不属于B类障碍、严重障碍、事故和严重事故的情况。</p>\n\n<p>　　(二)B类障碍：</p>\n\n<p>　　1.发端网络的呼损：过网呼叫的发端网络呼损高于40%；</p>\n\n<p>　　2.受端网络的来话接通率：过网呼叫的受端网络来话接通率低于60%；</p>\n\n<p>　　3.发(受)端网络的呼叫建立时延：过网呼叫在发(受)端网络中的呼叫建立时延，与发(受)端网络中同种可比业务的连接建立时延的差异大于6秒的发生概率超过40%；</p>\n\n<p>　　4.发(受)端网络的断话等异常现象：过网呼叫在发(受)端网络中形成的断话、单通、错号、无回铃音、虚假回铃音等现象的发生概率超过40%；</p>\n\n<p>　　5.网间互联中继电路的负荷：公用电信网间某一中继群连续三日忙时呼损均高于40%，或者经电信监管部门监测系统监测，连续三日忙时每线话务量平均达到《网间通信障碍互联中继电路负荷表》中相应数值。</p>\n\n<p>　　本办法所称B类障碍是指符合上述条件之一且不属于严重障碍、事故和严重事故的情况。</p>\n\n<p>　　(三)严重障碍：</p>\n\n<p>　　1.发端网络的呼损：过网呼叫的发端网络呼损高于40%，影响到发端网络5000以上用户；</p>\n\n<p>　　2.受端网络的来话接通率：过网呼叫的受端网络来话接通率低于60%，影响到发端网络5000以上用户(含异地用户)；</p>\n\n<p>　　3.发(受)端网络的呼叫建立时延：过网呼叫在发(受)端网络中的呼叫建立时延，与发(受)端网络中同种可比业务的连接建立时延的差异大于6秒的发生概率超过40%，影响到发端网络5000以上用户(含异地用户)；</p>\n\n<p>　　4.发(受)端网络的断话等异常现象：过网呼叫在发(受)端网络中形成的断话、单通、错号、无回铃音、虚假回铃音等现象的发生概率超过40%，影响到发端网络5000以上用户(含异地用户)；</p>\n\n<p>　　5.网间互联中继电路的负荷：在本地网范围内，公用电信网间某一中继群连续三日忙时呼损均高于40%，或者经电信监管部门监测系统监测，连续三日忙时每线话务量平均达到《网间通信障碍互联中继电路负荷表》中相应数值，影响到发端网络5000以上用户(含异地用户)。</p>\n\n<p>　　本办法所称严重障碍是指符合上述条件之一且不属于事故和严重事故的情况。</p>\n\n<p>　　(四)事故：</p>\n\n<p>　　1.在一个本地网范围内，网间通信全阻、关口局至某一局向全部中断或网间某一业务全部中断不满2小时或者直接影响范围不满5万(用户×小时)；</p>\n\n<p>　　2.造成网间通信严重障碍，一日内累计2小时以上不满12小时。</p>\n\n<p>　　本办法所称事故是指符合上述条件之一的情况。</p>\n\n<p>　　(五)严重事故：</p>\n\n<p>　　1.在一个本地网范围内，网间通信全阻、关口局至某一局向全部中断或网间某一业务全部中断2小时以上或者直接影响范围5万(用户×小时)以上；</p>\n\n<p>　　2.造成网间通信严重障碍，一日内累计12小时以上。</p>\n\n<p>　　本办法所称严重事故是指符合上述条件之一的情况。</p>\n\n<p>　　杂音、串音、衰耗等语音质量异常情况待相关技术标准出台后予以规定。互联网骨干网间通信质量异常情况另行规定。</p>\n\n<p>　　本办法所称网间通信障碍是指未达到《公用电信网间通信质量技术要求》规定的情况。</p>\n\n<p>　　本办法所称网间通信障碍处理是指网间通信障碍的沟通、协调、报告、申告及排除。</p>\n\n<p>　　本办法所称用户数是指严重障碍、事故、严重事故发生前七日内在相同时段使用相同业务的主叫用户数的平均值。本办法所称中断是指通信中断，即呼损为100%或来话接通率为0%。本办法所涉及的技术术语参见信息产业部颁布的《公用电信网间通信质量技术要求》、《公用电信网间互联中继电路扩容技术要求》及《公用电信网间通信质量测试方法》。</p>\n\n<p>　　第二章 网间通信障碍处理  </p>\n\n<p>　　第六条  电信业务经营者应设立互联工作机构负责公用电信网间通信质量管理工作。电信业务经营者应明确地市级机构、省级机构、总部公用电信网间通信质量管理的联络人及责任人，应设立地市级机构网间通信障碍24小时申告电话、传真电话，保证每天24小时网间通信障碍沟通渠道的畅通。电信业务经营者县级区域的网间通信质量管理职能，由其地市级机构代为行使。</p>\n\n<p>　　本办法所称联络人是指负责公用电信网间通信质量管理的一般管理人员，主要职责是对本企业或下属机构反映，或者其他企业申告的网间通信障碍，与对方同级机构联络人实时沟通、协调，及时排除网间通信障碍。网间通信障碍未予以及时排除的，向本企业同级机构责任人及时报告。</p>\n\n<p>　　本办法所称责任人是指负责公用电信网间通信质量管理的公司领导、互联工作机构领导，主要职责是对本企业联络人或下属机构反映，或者其他企业申告的网间通信障碍，予以沟通、协调、指挥、调度，在网间通信障碍处理过程中发挥领导者的作用。</p>\n\n<p>　　第七条  电信业务经营者总部责任人的姓名、联络方式由其总部向信息产业部备案；电信业务经营者地市级机构、省级机构责任人的姓名及联络方式，以及网间通信障碍24小时申告电话、传真电话，由其省级机构向省、自治区、直辖市通信管理局备案。</p>\n\n<p>　　互联双方同级机构应相互书面通报本方联络人和责任人的姓名、联络方式，网间通信障碍24小时申告电话、传真电话。</p>\n\n<p>　　若上述信息发生变化，变更的信息应在24小时内以传真方式向相关电信业务经营者通报，并在10日内向电信监管部门备案。</p>\n\n<p>　　第八条  电信业务经营者应做好地市级机构间、省级机构间、总部间的沟通、协调工作。当前一级沟通、协调未果或沟通失败时，应采用后一级的沟通方式予以沟通、协调。</p>\n\n<p>　　第九条  当接到网间通信障碍用户申诉、企业申告，或者经电信监管部门监测系统测试、企业测试发现网间通信障碍时，电信业务经营者应按照先本网后他网的障碍排查顺序，排查网间通信障碍的障碍段落是在本网还是在他网。在确认非本网原因后，应向对方同级机构申告。向对方地市级机构申告时，可采用传真方式提交或当面提交《网间通信障碍申告单》(附件1)的书面方式申告，也可采用网间通信障碍24小时申告电话、联络人电话等电话方式申告。向对方省级机构、总部申告时，可采用传真方式提交或当面提交《网间通信障碍申告单》的书面方式申告。</p>\n\n<p>　　当采用传真方式提交《网间通信障碍申告单》时，应使用网间通信障碍24小时申告电话、联络人电话确认对方是否收到传真；被申告方应在收到书面申告后一小时内传真回执签收的《网间通信障碍申告单》。当面提交《网间通信障碍申告单》时，被申告方应在《网间通信障碍申告单》(一式两份)上签收。</p>\n\n<p>　　当采用电话方式申告时，应做好电话记录，视本方工作需要做好电话录音，并在一小时内向对方补交《网间通信障碍申告单》。被申告方应在收到书面申告后一小时内传真回执签收的《网间通信障碍申告单》。</p>\n\n<p>　　第十条  电信业务经营者向对方同级机构申告后，互联双方联络人、责任人应积极沟通，紧密配合，及时采取有效措施排除网间通信障碍，恢复网间通信。</p>\n\n<p>　　网间通信障碍排除后，被申告方应填写《网间通信障碍申告单》相关栏目传真告知对方，并电话确认对方是否收到传真；申告方应在收到传真后一小时内向对方传真回执确认障碍是否消除，并电话确认对方是否收到传真回执。</p>\n\n<p>　　互联双方省级以下机构(含省级机构)应按照以下原则并参照本网内同类障碍的处理时限，共同制定网间通信障碍的处理时限：</p>\n\n<p>　　(一)对于A类障碍，从收到《网间通信障碍申告单》到消除网间通信障碍的最长时间不得超过72小时；</p>\n\n<p>　　(二)对于B类障碍，从收到《网间通信障碍申告单》到消除网间通信障碍的最长时间不得超过72小时；</p>\n\n<p>　　(三)对于严重障碍，从收到《网间通信障碍申告单》到消除网间通信障碍的最长时间不得超过24小时；</p>\n\n<p>　　(四)对于事故、严重事故，从收到《网间通信障碍申告单》到消除网间通信障碍的最长时间不得超过12小时。</p>\n\n<p>　　第十一条  电信业务经营者遇有网间通信障碍不能及时排除的，应以本企业内部规定的沟通方式(如书面方式、电话方式)及时与本企业上级机构沟通，由本企业上级机构继续协调。与本企业上级机构沟通的时限、程序及其他条件由本企业自行确定。</p>\n\n<p>　　第十二条  电信业务经营者在网间通信障碍的沟通、协调过程中，应妥善保存以下相关证据，以便电信监管部门确定责任方，相关证据应真实、准确，并至少保存一年：</p>\n\n<p>　　1.用户申诉记录或企业申告材料(书面材料、电话记录及电话录音等)；</p>\n\n<p>　　2.网间通信障碍的测试记录(拨测记录及相关信令流程记录等)；</p>\n\n<p>　　3.与对方的沟通协调记录。电信业务经营者采用的网间通信障碍测试手段应能科学判别网间通信障碍的障碍段落是在本网还是在他网。</p>\n\n<p>　　第十三  条电信业务经营者发现严重障碍、事故、严重事故时，应立即与对方沟通，互联双方相关机构责任人应参与指挥网间通信障碍排除。在排障遇到困难时，应本着先抢通、后排障的原则立即恢复通信。电信业务经营者省级机构应按照《公用电信网间互联管理规定》并参照《电信运营业重大事故报告规定(试行)》规定的时限、程序、内容向省、自治区、直辖市通信管理局报告。</p>\n\n<p>　　第十四条  电信业务经营者遇有网间通信障碍经地市级机构间、省级机构间沟通、协调后，在本办法第十条规定的时限内仍不能排除的，电信业务经营者省级机构可提交《网间通信障碍申告单》及相关证据，向省、自治区、直辖市通信管理局申告。</p>\n\n<p>　　电信业务经营者省级机构向省、自治区、直辖市通信管理局提交《网间通信障碍申告单》后，发现网间通信障碍消失或得到排除时，应立即向省、自治区、直辖市通信管理局报告。</p>\n\n<p>　　电信业务经营者省级机构向省、自治区、直辖市通信管理局提交的相关证据应符合本办法第十二条的要求。</p>\n\n<p>　　电信业务经营者有义务配合电信监管部门对网间通信障碍调查取证。</p>\n\n<p>　　第十五条  电信业务经营者省级机构向省、自治区、直辖市通信管理局提交《网间通信障碍申告单》后，在下列时限内网间通信障碍未得到排除，且未收到省、自治区、直辖市通信管理局下达《网间通信障碍责任判定书》(附件2)的，电信业务经营者总部可提交《网间通信障碍申告单》及相关证据，向信息产业部电信管理局申告：</p>\n\n<p>　　对于A类障碍，从提交《网间通信障碍申告单》到消除网间通信障碍或收到《网间通信障碍责任判定书》的最长时间原则上不超过十日。</p>\n\n<p>　　对于B类障碍，从提交《网间通信障碍申告单》到消除网间通信障碍或收到《网间通信障碍责任判定书》的最长时间原则上不超过七日。</p>\n\n<p>　　对于严重障碍、事故、严重事故，电信业务经营者总部可视情况随时与信息产业部电信管理局沟通。</p>\n\n<p>　　电信业务经营者总部与信息产业部电信管理局间沟通，可以和电信业务经营者总部间沟通交叉进行。电信业务经营者总部向信息产业部电信管理局提交的相关证据应符合本办法第十二条的要求。</p>\n\n<p>　　第十六条  电信业务经营者应相互配合，按照信息产业部颁布的《公用电信网间电话业务路由设置的技术要求》，制定并实施网间通信保障的应急预案，保证在节假日等异常话务突发情况及其他紧急状态下的网间通信畅通和通信安全。在实施应急预案遇到困难时，可向省、自治区、直辖市通信管理局申请协调。 </p>\n\n<p>　　第三章 公用电信网间通信质量监督  </p>\n\n<p>　　第十七条  省、自治区、直辖市通信管理局应监督电信业务经营者建立地市级机构间、省级机构间的定期沟通机制，在制度上保证网间通信障碍在基层得以沟通、协调。</p>\n\n<p>　　省、自治区、直辖市通信管理局应定期与电信业务经营者沟通公用电信网间通信质量问题，听取电信业务经营者的意见，发现问题或问题隐患后应及时疏导，妥善处理。</p>\n\n<p>　　沟通的频次应随本行政区域内公用电信网间通信质量问题涉及范围及严重程度的变化而变化。</p>\n\n<p>　　第十八条  省、自治区、直辖市通信管理局应利用以下渠道，分析本行政区域内公用电信网间通信质量的主要矛盾，主要矛盾所分布的主要地区，突出监控重点：</p>\n\n<p>　　(一)定期分析省内用户申诉受理电话(12300)涉及公用电信网间通信质量问题的数据信息，组织电信业务经营者排查网间通信障碍；</p>\n\n<p>　　(二)定期分析电信监管部门监测系统的输出数据信息，督促电信业务经营者对网间互联中继电路及时扩容或排除网间通信障碍；</p>\n\n<p>　　(三)要求电信业务经营者对公用电信网间通信质量定期测试并提交能科学判别网间通信障碍的障碍段落是在本网还是在他网的测试记录。</p>\n\n<p>　　分析及测试的频次，应随本行政区域内公用电信网间通信质量问题涉及范围及严重程度的变化而变化。</p>\n\n<p>　　第十九条  电信监管部门应不定期进行公用电信网间通信质量的监督抽查，及时了解公用电信网间通信质量状况，并视情况向电信业务经营者通报监督抽查结果。</p>\n\n<p>　　第二十条  省、自治区、直辖市通信管理局收到电信业务经营者省级机构提交的《网间通信障碍申告单》及相关证据后，应在下列时限内予以取证，下达《网间通信障碍责任判定书》并及时告知申告方：</p>\n\n<p>　　对于A类障碍，从收到《网间通信障碍申告单》到下达《网间通信障碍责任判定书》的最长时间原则上不超过十日。</p>\n\n<p>　　对于B类障碍，从收到《网间通信障碍申告单》到下达《网间通信障碍责任判定书》的最长时间原则上不超过七日。</p>\n\n<p>　　对于严重障碍、事故、严重事故，省、自治区、直辖市通信管理局可随时介入处理，督促相关各方立即恢复通信，并可随时取证，判定责任方。</p>\n\n<p>　　省、自治区、直辖市通信管理局可利用电信监管部门监测系统及其他必要的技术手段，判定网间通信障碍的障碍段落是在申告方的网络还是在被申告方的网络。</p>\n\n<p>　　省、自治区、直辖市通信管理局在取证期间，发现网间通信障碍消失或得到排除时，应在上述时限内告知申告方，不再下达《网间通信障碍责任判定书》。</p>\n\n<p>　　第二十一条  信息产业部电信管理局收到电信业务经营者总部提交《网间通信障碍申告单》及相关证据后，应填写《网间通信障碍申告转办单》(附件3)转交省、自治区、直辖市通信管理局办理。省、自治区、直辖市通信管理局收到《网间通信障碍申告转办单》后，应在转办单上规定的时限内办理完毕。</p>\n\n<p>　　第二十二条  信息产业部电信管理局应每月发布全国公用电信网间通信质量的情况通报，对全国范围内公用电信网间通信质量予以监督。通报内容包括：未在规定时限内解决网间通信障碍的情况、由于公用电信网间通信质量问题对电信业务经营者的处罚情况、网间通信障碍用户申诉情况、网间通信障碍企业申告情况等。</p>\n\n<p>　　第二十三条  省、自治区、直辖市通信管理局应每月发布本行政区域内公用电信网间通信质量的情况通报，对本行政区域内公用电信网间通信质量予以监督，并同时抄送信息产业部。省、自治区、直辖市通信管理局应每月向信息产业部上报《公用电信网间通信质量月报表》(附件4)。月报表内容包括：</p>\n\n<p>　　(一)未在规定时限内解决网间通信障碍的情况及相关责任方；</p>\n\n<p>　　(二)由于公用电信网间通信质量问题对电信业务经营者的处罚情况(罚款、通报批评等)；</p>\n\n<p>　　(三)发生的严重障碍、事故和严重事故及处理情况。</p>\n\n<p>　　第二十四条  省、自治区、直辖市通信管理局应按照信息产业部颁布的《公用电信网间电话业务路由设置的技术要求》，要求电信业务经营者相互配合，制定并实施网间通信保障应急预案。当电信业务经营者实施应急预案遇到困难时，应予以协调，保证在节假日等异常话务突发情况及其他紧急状态下的网间通信畅通和通信安全。</p>\n\n<p>　　第四章 罚则  </p>\n\n<p>　　第二十五条  违反本办法第十条的规定，未在规定时限内排除网间通信障碍的，电信监管部门应根据《中华人民共和国电信条例》第七十一条的规定对责任方进行处罚，视情况给予通报批评，并可建议有关部门或者单位对相关电信业务经营者的主要领导给予记过处分，对直接责任人员给予警告或记过的行政处分。</p>\n\n<p>　　第二十六条  有下列行为之一的，电信监管部门应视情况给予通报批评，并可建议有关部门或者单位对相关电信业务经营者的主要领导给予记过处分，对直接责任人员给予警告或记过的行政处分：</p>\n\n<p>　　(一)违反本办法第六条的规定，未设立网间通信障碍二十四小时申告电话、传真电话；</p>\n\n<p>　　(二)违反本办法第七条的规定，未向对方通报本方联络人、责任人的姓名、联络方式，网间通信障碍二十四小时申告电话、传真电话及变更的信息；</p>\n\n<p>　　(三)违反本办法第九条的规定，不受理对方书面申告或电话申告，或者收到对方书面申告后未签收或未在规定时限内传真回执；</p>\n\n<p>　　(四)违反本办法第十二条的规定，故意向电信监管部门提供虚假的网间通信障碍相关证据或故意混淆障碍类别，或者采用的网间通信障碍测试手段经电信监管部门组织专家论证会论证或由信息产业部指定的检测机构检测证明无法科学判别网间通信障碍的障碍段落是在本网还是在他网，屡次利用此测试手段作为申告证据；</p>\n\n<p>　　(五)违反本办法第十四条的规定，拒绝配合电信监管部门对网间通信障碍调查取证。</p>\n\n<p>　　第二十七条  在本地网范围内，A类障碍、B类障碍的同类情况在三个月内共出现两次以上(含两次)申告或者在六个月内共出现三次以上(含三次)申告，且责任方为同一电信业务经营者的，电信监管部门应视情况对责任方给予通报批评，并可建议有关部门或者单位对相关电信业务经营者的主要领导给予记过处分，对直接责任人员给予警告或记过的行政处分。</p>\n\n<p>　　第二十八条  擅自中断网间互联互通，关闭或限制原已互联互通的网间通信业务的，电信监管部门应根据《中华人民共和国电信条例》第七十条、《公用电信网间互联管理规定》第四十八条的规定进行处罚，并可建议有关部门或者单位对相关电信业务经营者的主要领导给予记过以上行政处分，对直接责任人员给予记大过、降级、撤职直至开除的行政处分；构成犯罪的，依据《最高人民法院关于审理破坏公用电信设施刑事案件具体应用法律若干问题的解释》(以下简称《司法解释》)，移交司法机关追究刑事责任。</p>\n\n<p>　　第二十九条  擅自对其他电信业务经营者的业务进行限呼、拦截的，电信监管部门应根据《中华人民共和国电信条例》第七十二条、第七十六条以及《公用电信网间互联管理规定》第四十七条的规定进行处罚，并可建议有关部门或者单位对相关电信业务经营者的主要领导给予记过以上行政处分，对直接责任人员给予记过、记大过、撤职直至开除的行政处分；构成犯罪的，依据《司法解释》，移交司法机关追究刑事责任。</p>\n\n<p>　　第三十条  互联一方网内发生可能影响网间通信的路由组织、中继电路、信令方式、局数据、软件版本等的调整，未按《公用电信网间互联管理规定》第三十四条的规定提前向对方通报情况的，电信监管部门应根据《公用电信网间互联管理规定》第四十六条进行处罚，并可根据不同后果，建议有关部门或者单位对相关电信业务经营者的主要领导给予记过以上行政处分，对直接责任人员给予记大过、降级直至开除的行政处分。</p>\n\n<p>　　第三十一条  没有严格执行公用电信网间通信质量保障责任制度和网间通信障碍处理机制，导致网间通信严重障碍，甚至造成事故、严重事故的，电信监管部门应根据《公用电信网间互联管理规定》第四十八条的规定进行处罚，并可根据不同后果，建议有关部门或者单位对相关电信业务经营者的主要领导给予记过以上行政处分，对直接责任人员给予记大过、降级直至开除的行政处分；构成犯罪的，依据《司法解释》，移交司法机关追究刑事责任。</p>\n\n<p>　　第五章 附则  </p>\n\n<p>　　第三十二条  公用电信网间通信质量不符合《公用电信网间通信质量技术要求》规定，且未达到A类障碍严重程度的，各电信业务经营者应相互配合，协同处理，并可视情况按照A类障碍向电信监管部门申告，电信监管部门可参照本办法予以监督管理。</p>\n\n<p>　　第三十三条  本办法由信息产业部负责解释。</p>\n\n<p>　　第三十四条  本办法自2005年8月1日起施行，2003年11月12日信息产业部颁布的《公用电信网间互联互通质量监督管理办法(试行)》同时废止。(人电邮电报)\n</p>\n\n\t\n\t\t\n','','中国信息产业网-人民邮电报','',NULL,1126758500,1126758500,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73167,'亚欧使用电子钱包手机业务 美国也跃跃欲试','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　【赛迪网讯】8月2日消息，设想一下，只需在一台机器前面挥动一下你的手机，就可以在自动唱片点唱机上购买一首歌曲、买上一包食品，还可以购买体育比赛的入场券。 </p>\n<p>　　路透纽约报道，在亚洲和欧洲的消费者已经开始使用手机购买汽水和支付停车费用之时，讨论已久的电子钱包概念也开始慢慢接近美国消费者了。 </p>\n\n<p>　　在瑞典、爱尔兰和英国等国家，司机可以不必向计时器投币，而只需通过手机发一条短信就可以完成付费。 </p>\n<p>　　日本NTT DoCoMo的约200万客户已经可以使用内建签帐卡的手机向约2万家餐厅和超市等商家付款。 </p>\n<p>　　DoCoMo还计划让用户使用手机来代替火车车票。作为推动手机商务活动的一部分，该公司还投资一家信用卡公司。 </p>\n<p>　　在2000年达康(dot.com)泡沫破裂之后，美国公司对无线手机钱包业务保持低调。现在许多公司仍然持怀疑态度，不过由于此项业务在美国和海外发展回暖，有些公司已经跃跃欲试。 </p>\n<p>　　\"现在又可以讨论(手机商务)了。技术和商业模式都在发展，\"美国第三大手机运营商Sprint的业务发展主管比尔鲍姆(Chris Bierbaum)说道。</p>\n\t\n\t\t\n','','赛迪网','',NULL,1126758500,1126758500,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73163,'冒充联通员工屡屡骗取钱财','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　本报讯 (实习记者 昭玮 实习生 翁芸芸 程勇)本报日前刊登了《冒充联通员工 收了押金开溜 向阳小区30余住户上了当》一文，不少读者打来电话，询问如何通过正规的渠道安装CDMA环保、智能型桌面电话，记者为此采访了中国联通西安分公司，为市民朋友提个醒。</p>\n\n<p>　　中国联通西安分公司数据部的杨副经理通过查询后证实，本报日前刊登的骗取向阳小区居民押金的立威科技有限公司根本就不是联通公司的，目前为西安联通公司代理CDMA桌\n面电话业务的只有16家公司。现在有些骗子公司在外面骗取用户钱财，给联通造成了不好的影响。杨副经理通过本报提醒读者，所有和西安联通有代理业务关系的公司的业务员都在西安联通公司备案，联通公司会给每个业务员制作统一工牌，上面贴有业务员的照片，在照片下面标明业务员的姓名、职位、部门和编号，业务员在给用户装机时，必须出示工牌，用户也可向业务员索要一张“中国联通便民公话用户通知书”，拨打上面的联通便民公话服务中心电话13325470468进行查询，只要用户报出业务员的编号，便可分辨业务员是否是联通公司的员工。杨副经理告诉记者，现在西安联通的便民公话资费为：市话每分钟0.1元，长话每分钟0.3元，无座机费。\n</p>\n\n\t\n\t\t\n','','三秦都市报','',NULL,1126758499,1126758499,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73164,'互联网周刊：黑莓的魅力','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　即使打着挑战Blackberry口号的MOTO Q来了，对RIM也并不形成威胁，因为Blackberry不是硬件而是软件和理念的成功</p>\n\n<p>　　本刊记者｜陈亮</p>\n\n<p>　　美国当地时间7月25日，摩托罗拉在芝加哥召开了MOTO NOW 2005会议，这是其一年\n一度的财政分析师年会，然而今年的会议上，人们的目光却被吸引到了MOTO家族的移动手持设备身上，尤其是以挑战Blackberry(黑莓)为口号的“MOTO Q”。据称，这款产品将是世界上最轻薄的无线电邮接收器。</p>\n\n<p>　　作为智能手持设备产业的一个组成部分，无线电邮接收器似乎太小了，并不足以引起人们的注意。然而，Blackberry的成功却让众多持这个观点的人大吃一惊。过去的两年间，iPod给苹果带来了4倍的股价增长，而Blackberry却给它的缔造者RIM公司(Research in Motion)带来了股价增长6倍的业绩。《福布斯》杂志在“2005年全球20大高增长品牌”评选中，给了Blackberry极高的评价，在过去四年中，这个品牌的增长率达到了36%，仅次于苹果电脑的38%，位居第二。</p>\n\n<p>　　电子邮件几乎已经成为人们处理日常事务的最重要工具，“随时随地收发电邮”，对于业务繁忙的商务人士来说，无疑是一个极具诱惑力的概念。</p>\n\n<p>　　事实上，诺基亚、Palm等公司从上世纪90年代就开始尝试生产可以无线收发电子邮件的移动终端产品，不过，早期产品单调的屏幕色彩、过于简单的功能和蹩脚的键盘设计让消费者一度感到，这只不过是个哗众取宠的玩具。与这些大牌制造商相比，RIM也似乎并不具有优势，然而一直潜心于无线电邮技术研发和推广的RIM，却选择了适时的机会转变商业模式，从“卖设备”转为“卖无线电邮的中间件平台”。2002年11月，诺基亚开始把Blackberry邮件接收器集成到它的手机上，作为一种软件功能来提供，此后，RIM的成功便一发不可收拾。</p>\n\n<p>　　今天，人们面前可供选择的智能手持设备可谓琳琅满目，如PalmOne的Treo系列、RIM的Blackberry系列。不过，相比之下，PalmOne的Treo更像一个完整概念的智能手机。当然，你也可以选择用笔记本电脑来随时处理电子邮件，但如果有这样一个拥有QWERTY键盘、俨然一台笔记本电脑的设备，而且操作简单，省去了携带电脑以及开机的麻烦，何乐而不为呢？</p>\n\n<p>　　摩托罗拉最新的MOTO Q，外形上看起来就像MOTO V3手机那样酷，其厚度仅为1.1厘米，安装了微软的Windows Mobile 5.0操作系统。这款产品将于2006年第一季度上市，向Blackberry和PalmOne的Treo发动直接进攻。</p>\n\n<p>　　同属移动手持设备，PDA惨淡经营的情形与Blackberry们的火爆形成了鲜明对比。IDC的数据显示，到目前为止，PDA市场已经遭遇了连续6个季度的下滑。作为PDA领域最有代表性的公司，最近两年来，Palm也经历了多次的震荡，从分拆为PalmOne和PalmSource，再到今年7月PalmOne重新复名为Palm。</p>\n\n<p>　　如果说是功能多元化的智能手机夺去了PDA的生存空间，无线电邮设备的成功似乎无从解释。同样是功能相对单一，为何两者却有如此不同的处境？或许，这不是产品本身的差异所导致的。Blackberry的成功象征了无线电邮接收器市场的成功，正如iPod的成功带动了整个数字音乐播放市场，也正是Blackberry让这个原本默默无闻的市场最终成了炙手可热的领域。而Blackberry的成功，在本质上并非设备本身的成功，而是“随时随地收发电邮”的理念的成功。从这个角度来说，MOTO Q和PalmOne的Treo一样，更偏向于多元功能的智能手机，它或许能够在产品领域冲击市场，但对于RIM这个非手机行业的企业来说，这种冲击并不令人畏惧，因为Blackberry的模式是—从硬件走向软件。 \n</p>\n\n\t\n\t\t\n','','互联网周刊','',NULL,1126758500,1126758500,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73165,'诺基亚CEO奥利拉明年6月卸任 前财务长接任','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　刘易守 编译 </p>\n\n<p>　　据港台媒体报导，全球最大手机供应商诺基亚(Nokia)发布新闻稿指出，为持续企业发展前景，高层人事将有大变动;担任诺基亚执行官超过13年，成功将传统产业企业改造成高科技公司的Jorma Ollila将于2006年6月1日起卸下执行官一职，接任者则是该公司前财务长、目前主掌低端手机业务的Olli-Pekka Kallasvuo。</p>\n\n\n<p>　　诺基亚董事会称Ollila卸职后，可能仍保有非执行职的董事长头衔，维持在董事会的席次。Ollila现年54岁，自1992年担任诺基亚执行官，把一家濒临破产边缘、原本生产卫生纸的传产企业打造成傲视全球的高科技巨星。在1992年到2000年间，他让诺基亚营收增长9倍，诺基亚品牌成为全球第五大知名品牌，排名超越奇异电子(GE)及麦当劳(McDonald)等世界知名企业。</p>\n\n<p>　　Ollila在1985年加入诺基亚，担任财务相关工作，他在大学主修政治学，最后靠手机扬名立万。他于1990年接任诺基亚手机业务部门时，部门销售额占集团营收约1成，2年后接任执行官，各方揣测他可能为了业绩，把诺基亚切成一块块出售，但他看出手机的潜力，在生产电视、电缆之外，全力发展手机。他担任诺基亚执行官期间，该公司股价增长超过500倍。</p>\n\n<p>　　Ollila本任执行官任期到2006年为止，先前他已表达不再续任的意愿，且以目前的时空背景，的确应该有新的执行官来领导诺基亚，对抗来自亚洲及美国的竞争对手。将继任的Kallasvuo在被提拔为低端手机业务主管之前，是诺基亚的财务长，各方对他打理日常营运工作的能力毫不怀疑，但仍有分析师指出，Kallasvuo是否能制定出有效的营运策略，仍待观察。\n</p>\n\n\t\n\t\t\n','','ChinaByte','',NULL,1126758500,1126758500,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73166,'诺基亚欲冲刺美国市场 发布40款新手机抢滩','','','','../resource/img/h000/h00/img200509161713350.jpg','','<P>　　【赛迪网讯】8月2日消息，诺基亚执行官接班人Olli-Pekka Kallasvuo表示，提高公司在美国手机市场的业绩将是他的首要之务。 </P>\r\n<P>　　港台媒体报道，Kallasvuo说：“我们致力冲刺美国市场，在当地的投资，预期将显现成效。” </P>\r\n<P>　　诺基亚在美国手机市场屈居第四，不敌摩托罗拉和LG等强敌。摩托罗拉的Razr等流行酷炫机型吸引消费者趋之若鹜。Strategy Analytics.分析师Milton Keynes说：“诺基亚在西欧、北美洲流失版图，在日本可说是没有市场。当消费者买第一支手机时，可能是诺基亚，但当他们物色更精巧的手机时，往往转向青睐诺基亚的对手。” </P>\r\n<P>　　Kallasvuo将自2006年6月1日接替将退休的现任执行官Jorma Ollila，赫尔辛基Mandatum stockbrokers电信产业分析师Erkki Vesola说，他也必须改善与美国手机门号商的关系。 </P>\r\n<P>　　根据Strategy Analytics在7月28日发布，诺基亚第二季在全球手机市场占有率达32.3%，高于前一季的31.2%，主要受新兴市场销售。摩托罗拉市场版图由16.7%扩大至18%，排名第三大的三星由14.2%下滑至13%。 </P>\r\n<P>　　根据市场调查公司Gartner Inc.在6月16日发布，在今年第一季，摩托罗拉在美市场占有率达34.5%，销售量逼近1200万部。反观，诺基亚由去年同期的24.2%大幅下滑至14.3%，北美市场排名落到老四，次于摩托罗拉、LG和三星。 </P>\r\n<P>　　诺基亚拟今年推出40款新手机，抢攻市场版图，其中3款为3G手机。手机业务占诺基亚总营收近80%。 </P>\r\n<P>　　Kallasvuo在2004年元月获任命执掌手机分支兵符此后，他一直致力开发诺基亚在东欧和拉丁美洲等新兴市场版图。诺基亚占非洲和中东市场版图约61%，占中欧和东欧版图42%。 </P>\r\n<P>　　截至昨天，诺基亚股价今年以来计涨13.3%。本月1日下跌1.21%，在赫尔辛基股市收13.01欧元。 </P>\r\n<P>　　诺基亚在7月21日宣布第二季获利增长15%，逊于分析师的预估值，股价闻讯下挫。 </P>\r\n<P>　　第二季净利增至7.99亿欧元 (9.72亿美元)，或每股0.18欧元，去年同期则为6.95亿欧元，或每股0.15欧元。第二季销售由64.6亿欧元增至80.6亿欧元。 </P>\r\n<P>　　分析师原先预估，诺基亚第二季净利达8.69亿欧元，或每股0.20欧元。 </P>\r\n<P>　　诺基亚同时宣布本季获利可能减少的利空，预估第三季每股盈余介于0.14-0.17欧元之间，相较于去年同期的0.15欧元。 </P>','','赛迪网','','',1126758500,1126862018,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73161,'陕西南郑男童咬断通信光缆 通信中断29小时','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　本报汉中讯 (记者 王仕伟 通讯员 辛石)南郑一11岁男孩陈某多次用牙咬断通信光缆图好玩，致使当地通信累计中断29小时，造成直接经济损失5万多元。</p>\n\n<p>　　家住南郑县湘水镇花园坝村的陈某，自幼家境贫寒，靠政府救济款、粮生活。今年4月25日，该陈趁学校开运动会之机，偷偷溜出学校来到该县移 动公司湘水基站，爬上距地面2米多高的塔架平台玩耍。当陈某打开上锁的设备箱后，发现里面有很粗的五颜六色的胶皮\n线，好奇的陈某便用牙一点一点地将线咬断后离去。5月10日，该陈再次用同样方法将已修复好的光纤尾缆咬断。5月17日，该陈又一次来到基站将尾缆咬断，并爬上联通公司的湘水基站塔架咬断尾缆玩耍，造成两个基站通信再次中断。当陈某仍在塔架上攀爬玩耍时，被民警发现。</p>\n\n<p>　　日前，陈某经警方批评教育后由学校领导和村干部看管。\n</p>\n\n\t\n\t\t\n','','三秦都市报','',NULL,1126758499,1126758499,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73162,'内地厂商力夺台湾地区3G手机市场一成份额','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　刘易守 编译  </p>\n\n<p>　　据港台媒体报导，内地手机厂商全面抢搭台湾地区3G列车，代理波导、夏新等内地手机的御立集团预估，2005年底前内地品牌手机将拿下台湾地区3G市场1成比重。尽管台湾地区手机市场在3G部份比重仍低，但内地厂商积极卡位动作，一旦台湾地区3G市场快速起飞，内地3G手机将在台湾地区市场具备举足轻重地位，尤其目前台湾地区整体市场除手机双雄摩\n托罗拉(Motorola)及诺基亚(Nokia)各维持约2成市场占有率率外，其他厂商都不到1成，很容易被后起之秀的内地厂商追赶过去，并掀起一波市场洗牌风。</p>\n\n<p>　　率先引进内地3G手机来台的御立集团董事长张子柏指出，包括TCL在内的内地手机大厂，未来都可能加入台湾地区3G战局，预期夏新等内地品牌手机2005年底前有机会抢下台湾地区3G手机1成市场占有率率。尽管3G手机战火仍不明朗，不过，内地3G手机来势汹汹，与2G时代不可同日而语，一旦台湾地区3G市场世代交替超乎预期，势必带给内地手机厂商极佳契机，此一趋势近期也在手机厂、渠道及电信厂商之间引发高度关注。</p>\n\n<p>　　过去在台湾地区市场默默无闻的内地手机厂商，近期在一连串3G开台热潮中，摇身一变成为当红炸子‘机’，除中华电信(2412)已采用夏新手机外，台湾地区大哥大(3045)最快将在8月新增夏新为供应商，预计在10月开台的威宝电信，更是将半数重兵都集结在内地厂商，包括夏新、华为、中兴通信及UT斯达康(UTStarcom)等，都可望站上火线。</p>\n\n<p>　　不过，内地手机品牌的技术完整度、售后服务、品牌形象、在地化支持能力、全球实战经验，都受到台手机厂质疑。明基电通(2352)董事长李焜耀便表示，内地手机加入台湾地区3G市场竞争，明基乐观其成，但其是否已先进军其他海外市场，还是没有经验就先来台湾地区市场销售，值得进一步观察。</p>\n\n<p>　　华硕电脑(2357)研发处协理徐衍珍则认为，内地厂商因为投入3G手机开发比早，因而能比快推出产品，但以内地手机产业生态来看，过去在2G、2.5G时代都大量仰赖设计公司，目前包括Qualcomm、易利信手机授权平台(EMP)的3G专利费用居高不下，势将提高门槛，并影响内地手机厂整体战力，因此，先推出产品不见得会赢，反而是稳扎稳打的明基、华硕等台湾地区手机品牌厂商，可望在2005年底到2006年迎头赶上。</p>\n\n<p>　　张子柏对此表示，早在5～6年前就评估引进内地品牌手机，但当时技术与设计落差确实太大，2004年正式引进内地手机时，高端款式便已赶上来，约符合台湾地区市场的中、低端定位，2005年进入3G时代后，台面上可推出3G手机的厂商多达15家，几乎没有技术及规格的明显领先者，多数是外观时尚的竞争，若有正规的经销渠道及售后服务体系，内地手机厂商竞争力不会比比差。</p>\n\n<p>　　以目前台湾地区手机市场竞局呈现双雄拼斗局面，6月摩托罗拉及诺基亚各拿下近24%占有率，联手拿下近半江山，至于第三名以后的厂商市场占有率率都不到7%。渠道厂商认为，以内地3G手机卡位速度，甚至超越国际二线手机厂商及台湾地区品牌，并趁乱杀出重围，未来对于台湾地区及韩日等二线品牌厂商，恐将造成一定冲击，尤其若台湾地区3G市场快速窜起，台湾地区手机市场版图甚至可能因内地厂商加入战局而面临重整。\n</p>\n\n\t\n\t\t\n','','ChinaByte','',NULL,1126758499,1126758499,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73160,'日系手机“水土不服” 松下能否扳回颓势','','','','../resource/img/h000/h00/img200509161648020.jpg','','<P>　　本报记者 赵霞</P>\r\n<P>　　酷暑袭人，而日系手机企业在中国市场的经营状况却仿佛正在遭遇“八月飞雪”：先是东芝手机扭亏无望，正式宣布撤资中国市场；后有三洋、三菱经营乏力，业绩一蹶不振；甚至一度雄心勃勃的NEC、京瓷手机亦出现销售状况不容乐观的传闻。</P>\r\n<P>　　就在上述五大日本手机品牌举步维艰之际，数月来一直保持缄默的另一大日本手机企业——松下反倒以全新姿态在中国市场高调亮相。7月25日，松下电器(中国)有限公司在北京隆重推出了以VS系列为主打的包括MX、SA在内的三大系列共7款手机。“我们能达到5%～10%的占有率就满意了。”面对日系手机企业遭遇的一片颓势，松下电器(中国)有限公司移动通信公司总经理板仓太郎对未来已算寄予厚望。</P>\r\n<P>　　<STRONG>强调功能创新 寻求差异化生存</STRONG></P>\r\n<P>　　其实，日系手机也曾诞生数款经典机型，松下GD88、NEC N8就一直让人记忆犹新。而板仓太郎之所以对于此次推出的新品充满信心，是因为这些手机在功能上的提升。“手机的画面都是高清、高亮度，在阳光下依然能保持绚丽的色彩，还配备了摄像头、MP3和精彩的游戏，这些都迎合了中国消费者对手机功能的新需求。”他说。</P>\r\n<P>　　即将上市的松下手机包括时尚超薄型的VS2/VS3、运动型的SA6和商务型的MX6，其他3款手机VS7、SA7和MX7将在今年九十月份上市。对于先期推出的4款新品，最受瞩目的卖点就是它们都拥有炫色大屏幕——2.2英寸、约1600万色的QVGA彩屏以及高亮度300cd/m2显示技术，使这些手机新品的屏幕色泽鲜艳，图像逼真。据称，这些功能都是松下历史上首次推出。而每个不同的系列又具有独特的卖点，在遵循时尚、娱乐、高品质原则的同时，这些新品分别瞄准了不同的细分市场。</P>\r\n<P>　　VS3和VS2的目标消费群以年轻、时尚的女性为主，在外观上更加顺应时下流行的轻薄趋势，VS系列的主打产品——VS3沿袭了松下经典的“X-Changeable Cover”多变彩壳功能，还可播放MP3音乐。在拍照功能上，VS3、VS2采用130万像素摄像头，特别是VS3，能支持2秒内的15张连拍。</P>\r\n<P>　　MX6是一款贴近商务人士需求的手机，其电池容量达到了以往松下手机的两倍。值得一提的是，松下MX6还获得了中国移动的认证，可提供新闻天气、在线理财、移动梦网等丰富的资讯服务。</P>\r\n<P>　　SA6针对的是爱好户外运动的青年，该手机内置了“Sonic The Hedgehog”和“Super Real Soccer”3D游戏。除了扣人心弦的游戏情节，SA6还拥有高亮度的彩屏，以及超大的电池容量，待机时间长达三周。后续即将上市的VS7、MX7和SA7三款新品更是发挥了大屏幕、高清晰度、高亮度的优势，甚至还具备了2.5英寸超大屏幕和200万像素的摄像头，其屏幕尺寸和拍照功能比松下同系列产品更为高端。</P>\r\n<P>　　“我们将利用自己的综合实力，把电视领域应用的高新技术投入到手机产品中。”板仓太郎说。</P>\r\n<P>　　<STRONG>尚需跨越“三重门” 重点加强本地化运作</STRONG></P>\r\n<P>　　近期，国内手机市场的形势可以概括为“新机+降价”，性价比依然是消费者购机时最为关心的“硬指标”。而截至记者发稿时，上述松下新品均未在卖场出现，其在国内市场的定价不得而知。但板仓太郎称，此次推出的新品仍将主打中高端市场。</P>\r\n<P>　　在专做高端手机的东芝败走中国CDMA阵营，老牌厂商诺基亚等猛扑低端市场的今天，松下的中高端策略能否扭转其自身乃至整个日系手机业务惨淡的经营状态？</P>\r\n<P>　　权威统计数据表明，截至2004年底，我国共批准手机生产企业38家，其中中资企业15家，外资企业23家，产能3亿部，占全球的45%，出口1.46亿部。目前，我国又核准手机企业8家，而正在申请的企业总数已超过60家，预计2005年国内手机产能将达到5亿部。尽管国内手机市场仍呈现稳步增长态势，但毕竟容量有限，随着进入者增多，利润终将会被摊薄。而此时，厂商的产品设计、研发能力、营销策略、服务手段等是否能够真正满足市场需求，就成为决定手机企业成败的关键因素。因此，业内人士认为，日系手机军团要想在经营中挽回颓势，尚需跨过“三重门”。</P>\r\n<P>　　首先是产品的定位。日系手机普遍主攻中高端，然而，诺基亚、摩托罗拉等巨擘已将目光转移到价格仅为几百元的低端市场。特别是，当今市场中、高端产品的降价风潮正愈演愈烈。7月27日的市场报价显示，索尼爱立信新推的娱乐机型W800c以近5000元的价格现身，上市仅10天就狂跌了500多元；以外观取胜的NEC超薄折叠机N730今年5月上市时尚以近2000元的身价示众，如今已大降600元；百万像素的诺基亚3230、娱乐功能强大的摩托罗拉E680价格均已跌破3000元……一片降价声中，中国的消费者不见得会因为功能设计上的特色就肯出高价。尽管低价会损失利润，但如果仅仅固守中高端，手机厂商将很难在残酷的竞争中获胜。</P>\r\n<P>　　其次是对消费习惯的揣摩。手机正日益演化为一种流行文化的象征和载体，需要在设计上加入更多的文化、时尚元素。“中国的消费习惯与日本有很大差异，我们会在研究中国消费者的基础上，推出适合其需求的产品，进行市场差异化布局。”板仓太郎说。而与松下相比，日本手机企业的核心研发中心往往设在日本本土，对产品功能的追求胜过外观，推出的机型偏大，难以满足中国消费者对小巧、轻薄的偏好。此外，消费者的需求正呈现多样化趋势，欧美甚至国产品牌都在纷纷加快推陈出新的速度，相比之下，日本手机企业推出新品的速度缓慢，急需缩短产品开发周期。</P>\r\n<P>　　最后是经营策略的转变。日系手机厂商习惯于与运营商联盟，由运营商控制手机终端的销售，而自己则专注于按运营商要求进行手机生产。偏重技术、制造，疏于市场拓展成为日系手机企业经营中的“致命伤”。由于中国手机市场并非运营商绝对主导的运作方式，因此，各手机厂商之间的竞争比日本市场激烈得多，迫切需要进行本土化运作。在中国开放3G业务后，手机厂商和运营商的关系将更加密切，需要双方加大合作力度，推行手机与业务捆绑销售的策略。如果日系手机厂商仍不加紧改善其与运营商之间的关系，通过低成本、扁平化销售渠道扩大市场份额，那么，它们在中国市场的日子将更加难熬。</P>\r\n<P>　　信息产业部的统计数据表明，今年1～5月，GSM和CDMA手机的累计生产数量已达10528.1万部，与去年同期的8180.4万部相比增长了28.7%。在这个手机产量已膨胀到超过市场容量的时候，不仅是那些在中国市场水土不服的日系手机企业，所有手机厂商都面临着一场严峻的考验。 </P>','','中国电子报','','',1126758499,1126860485,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73159,'2008奥运通信，网通准备好了吗','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　本报记者 刘晶</p>\n<p>　　承担奥运会期间的通信服务，对中国的运营商是一个全新的考验。因为这一世界最大的体育赛事会带来对通信网络全方位的要求，大容量的语音、数据、视频流的传输要畅通无阻，随时随地可能发生的通信需求要支持，安全可靠方便的信息传递方式要普遍提供。在2004年的7月份，中国网通成为2008年北京奥运会固定通信合作伙伴。如今一年已过，面临着越\n来越近的2008年奥运会，中国网通准备好了吗？</p>\n<p>　　日前，中国网通在京正式启动了奥运战略，对包括另外5个赛会城市青岛、天津、沈阳、秦皇岛、上海在内的全国30个省级分公司进行了总动员，此举意味着中国网通开始全面备战2008年的盛会，并借此提升网络、业务、服务等方面的水平。</p>\n<p>　　网络目标：实用又好用</p>\n<p>　　中国网通对本届奥运会的通信服务承诺目标是“任何人、任何时间在任何奥运相关场所，都能够实现安全、方便、快捷、高效地获取可支付得起的、丰富的、多语言智能化的、个性化的信息服务。”如何实现这一目标，建立一张实用又好用的通信网络呢？</p>\n<p>　　据介绍，中国网通将建立一张奥运通信专网，将网络结构分为网络管理层、骨干传送层、业务网络层、场馆接入层、业务提供层五个层面。</p>\n<p>　　根据中国网通的规划，场馆间光缆、管道及场馆内综合布线等基础设施构成网络传送的物理层，由奥运场所骨干传送网、北京本地骨干传送网、赛会城市间骨干传送网及国际骨干传送网组成奥运会网络骨干传送层；而面向用户提供语音、数据、视音频、接入及移动业务的各种业务网络则构成了网络的业务层。业务层全部承载在奥运场所骨干传送网上，而奥运场所骨干传送网则承载在覆盖完善、容量大的北京本地骨干传送网、赛会城市间骨干传送网及国际骨干传送网上，通过具有世界先进水平的统一网络管理系统进行全程端到端的管理，充分保证每一个奥运场馆连接的可靠性。</p>\n<p>　　中国网通提出，在每个场馆内全部设置固定通信机房，采用双物理路由的管道及光缆接入，在机房内配置电源系统、传输系统、交换系统、综合接入系统、综合视音频传送系统、数据系统等，提供场馆所需的各种固定通信服务，各奥运场馆间不同的通信系统通过网络的冗余设计和互联电路的备份机制构成科学合理的奥运网络，包括骨干传送网络、交换网络、综合接入网、互联网传送网络、综合视音频传送网、数据网络，实现奥运会通信保障。</p>\n<p>　　场馆建设是今年重点</p>\n<p>　　记者了解到，2008年奥运会场馆分散、规模空前，其通信网络的复杂程度要超过历届奥运会。在获得固定通信服务合作伙伴的资格后，中国网通就成立了奥运通信管理部，该部门与各方全面交流，积极借鉴悉尼和雅典的成功经验，努力使奥运通信网络与目前复杂的城市网络相对应，逐步推进奥运通信工程建设。</p>\n<p>　　在成为合作伙伴的一年中，中国网通首先搭出了奥运会的重要通信平台——北京宽带综合业务传送网，这也是国内最大的智能城域光网络系统。此后中国网通与国家奥林匹克体育中心签订“奥运项目通信全面合作协议”，启动了规模较大的奥运场馆通信建设工程；与其他合作公司签署了北京2008年奥运会高清电视传送的相关协议；与奥运37项竞赛场馆工程、15项非竞赛场馆的所有场馆业主建立工作关系，并收集确认了各个场馆的基本信息；已完成了11个新建场馆的草图评审和反馈；完成数字北京大厦项目施工图评审，促进该项目实施，确保如期竣工；完成北京奥组委旧址办公大楼通信工程、北京奥林匹克转播公司(BOB)办公楼通信工程;积极开展奥组委新址办公大楼通信工程；已经分别在北京、青岛召开奥运六城市的专项工作会议，组织落实相关工作。</p>\n<p>　　在今年年初的工作会议上，中国网通提出要特别重视对奥运场馆的通信建设。据北京网通奥运通信管理部总体规划与项目管理部经理张旭介绍，2008奥运会的主赛场设在北京，共有场馆37个，在北京的有32个场馆，其中新建场馆11个，改扩建场馆12个，临建场馆8个。按规划需要，场馆分为中心区和非中心区。中心区包括竞赛场馆10个，非竞赛场馆6个，即奥运村、记者村、IBC、MPC、数字北京大厦、奥林匹克森林公园；非中心区包括22个竞赛场馆，以及非竞赛场馆的奥组委办公大楼、BOB总部大楼、酒店、非主流媒体中心等。</p>\n<p>　　目前，北京网通和奥组委经过充分沟通，已经明确了奥运会主要的通信需求，确立了场馆通信工程建设的基本原则和大体的通信技术方案，并形成了总体的建设时间表。据了解，2008年奥运会的通信实施纲要将有三个版本，每一版都将根据技术的演进和市场的变化，吸取时代的元素进行改进。第一版目前已经成形，即将进行任务分解，系统地开始实施；第二版将于2006年年底确定；到2008年一季度，将推出第三个版本，也就是奥运通信的最终方案。</p>\n<p>　　宽带奥运是主线</p>\n<p>　　中国网通奥运战略的亮点就是其实施主线——“宽带奥运”。</p>\n<p>　　据悉，中国网通所制定的“宽带奥运”是一个完整的战略体系，从高速网络、宽带接入、综合业务、丰富应用和便捷服务多个层面进行规划和实施。包括建立遍布奥运区域、通达全国、连接世界的立体便捷的新型智能网络，提供安全、稳定、成熟、先进的通信技术;实现奥运会通信的宽带化，包括图像传输的宽带化、互联网接入的宽带化，数据传输的宽带化，多种应用的宽带化等;在全面满足奥运通信需求的基础上，到2008年之前在北京等地区率先实现“家家通宽带”，内容应用日益繁荣，亮点业务形成规模效应;建立以人为本、个性化、符合国际惯例的综合信息服务体系。从而保证北京2008年奥运会成为历史上第一届真正意义上的“宽带”奥运会。同时，“宽带奥运”的实现，将推动“宽带北京”的形成，从而有效提高北京的信息化水平。</p>\n<p>　　成为奥运合作伙伴，对中国网通而言主要带来两件事，一件是做好网络建设和运营，另一件就是借奥运之机做好市场营销工作，利用奥运合作伙伴的排他性，扩大竞争优势。</p>\n<p>　　目前中国网通在六大赛会城市的奥运营销已经展开。打上了中国网通品牌烙印的“奥运通信”将为通信市场注入新的活力，据北京网通前期进行的调查显示，已有80%的用户知道中国网通是2008年奥运会的通信服务合作伙伴。 </p>\n<p>　　相关链接</p>\n<p>　　奥运战略三项计划</p>\n<p>　　中国网通奥运战略由保障计划、发展计划、辐射计划三部分组成。</p>\n<p>　　——奥运保障计划。根据奥运通信服务的需求，制订稳定先进的实施方案和安全便捷的保障方案，保障奥运通信服务的完全成功，具体包括12个专业的奥运设施建设计划、IT支撑系统计划、服务保障计划、安全管理计划以及奥运项目管理计划。其中，网络的安全性和稳定性是首要考虑的因素。中国网通将采用稳定成熟技术，充分考虑奥运突发事件和网络多重保护，做好安全、防护工作。</p>\n<p>　　——奥运发展计划。借助奥运市场的拉动效应，开展有计划的市场营销活动，促进品牌提升、业务创新、市场拉动、合作发展，取得奥运效益。中国网通围绕奥运战略发展主线将设定一套具有战略意义的整体营销计划。在时间区间上，这一计划将一直持续到2012年，在2008年达到高潮，通过传播的累积效果实现奥运品牌效应的最大化。</p>\n<p>　　——奥运辐射计划。借助奥运的品牌辐射效应，推动中国网通集团各项管理工作的整体提升，具体包括人力资源计划、服务质量管理计划、企业文化建设计划、流程再造计划。</p>\n\t\n\t\t\n','','中国电子报','',NULL,1126758499,1126758499,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73154,'手机报势头不凡 第五媒体待破带宽瓶颈','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　总编 项立刚 </p>\n<p>　　消息称，广东移动联合广东的几大报业集团，开展“手机报纸”业务，这一业务的出现受到广泛的关注。其实“手机报”这个产品已经不是一个新的产品了，2004年7月《中国妇女报》就开始了最初的尝试，今天占据了移动市场1/6强的广东移动和中国几个最大的报业集团的联合出手，势头自然不凡。</p>\n\n<p>　　未来的新闻传播主要媒体是什么？手机可能是一个不可忽视的载体，和所有纸质媒体和多媒体相比，手机具有其他媒体不可比的独特优势，目前中国手机用户已经达到3.5亿，这些用户大部分时间都会携带手机，手机成为最方便快捷的终端，在手机上可能运行图文、声音、影像多种媒体形式。甚至手机还具有一定的强迫性，报纸读者可以不买，电视可以不开，但是用户却不可能不看新收到的彩信。</p>\n<p>　　这个意义上，“手机报”的前途不言而喻。</p>\n<p>　　当然如果我们只是认为“手机报”是把报纸做成电子版，在手机上发送，可能还是停留在比较初级的层面上，事实上今天的报纸形式、文章长度甚至语言习惯都并不符合手机的传播方式，快速、简洁、直接是手机媒体必须面对的问题，对于不同的用户提供具有个性化和专业化的问题服务，也是“手机报”面临的一个重要问题。</p>\n<p>　　要做“手机报”绝不是我们有一个平面媒体，就去办一个“手机报”，而是需要在研究手机用户可能的消费习惯，他们对于价格的承受，也要建立和运营商的合作模式，如流量分成。在这个基础上，我们要按照手机媒体的特色去开发选题，在文章结构、表达方式、语言风格上形成新媒体的风格，同时图片、声音和影像的整合也是我们要探讨的问题。</p>\n<p>　　我想，随着3G的到来，带宽瓶颈的打破，新闻传播形式将会突破现有的形式，第五媒体将会展现其旺盛的生命力。 </p>\n\t\n\t\t\n','','通信世界','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73155,'中国移动搭台 武侠大片走秀','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　如果说电影也有自己的黄金时段，那么暑期档无疑一年中最重要的时段。如果说电影也有自己的T型台，那么各路电影的推广活动就像是在T型台上走秀，其表现将直接影响消费者的购买欲望。将于7月29日在全亚洲同步首映的《七剑》成为这个暑期档里最值得期待的武侠巨制，仅凭导演徐克的一代宗师身份和该片云集的中、港和韩三地巨星，就足以让《七剑》光彩夺目。然而，在电影推广活动，《七剑》依然不遗余力，其\"手机版官方网站\"更是成为推广中的一大亮点。 </p>\n\n<p>　　据悉，《七剑》的\"手机版官方网站\"是由国内知名的电信运营商中国移动通信倾力打造。这是中国移动通信在电影推广上的首次\"触电\"，其制作的\"手机版官方网站\"在《七剑》出鞘前就先行吸引了市场目光，成为一个备受关注的大片走秀T型台。 </p>\n<p>　　<strong>手机上的大片秀</strong></p>\n<p>　　尽管电影《七剑》的公映日期定在7月29日，其与中国移动通信联合推出的\"手机版《七剑》官方网站\"却早在7月1日就开始预热市场。中国移动通信从7月1起，便在移动梦网的首页滚动新闻、影视频道、音乐频道、手机资讯、MO新生活等多个板块为用户开辟了 \"手机版《七剑》官方网站\"的入口。 </p>\n<p>　　记者依据介绍进入\"手机看《七剑》\"的主页后，一股\"剑气\"扑面而来：页面的最顶端是以天山为背景的\"七剑\"二字，正是电影海报的经典背景。画面下书\"莫问日月、天瀑竞星、青干区龙舍神剑\"-分别是一代宗师徐克亲手设计的七把剑的名称。整个主页以浅蓝色底配着遒劲的字体和精美的电影图片，在不大的手机屏幕上可看起来竟也十分具有美感。自去年推出WAP2.0以来，技术上的突破使得中国移动通信的WAP页面越来越接近互联网民熟悉的集文字图片声音于一体万维网页面。这使得MO手机上网的页面对于用户而言更有亲和力，更能吸引眼球，手机版《七剑》官方网站便是一个例证。</p>\n<p>　　页面上分列着\"手机看七剑\"、\"最新资讯快递\"、\"七剑英雄谱\"、\"珍藏图铃\"、\"激情外场地\"和\"天山论剑\"七大板块，这些板块分别提供电影背景介绍、影片最新资讯、电影人物及其演员资料、电影海报及其音乐下载、电影拍摄幕后故事和片花等内容，其中的\"天山论剑\"专供《七剑》迷用手机留下自己的评论。这些内容丰富各具特色的板块几乎将所有与电影《七剑》有关的信息和资料一网打尽，并独家提供电影原声音乐和多达21个电影片断的下载，足以让影迷先饱耳福和眼福。</p>\n<p>　　作为国内移动通信数据业务的一大创新，\"手机版《七剑》官方网站\"的系列数据业务首次将文字、图片、音频和视频产品整合在一起，不仅立体化的展示了电影《七剑》的风采，也让移动用户独家体验真正的手机多媒体业务。移动通信数据业务的多媒体化可谓未来的一个发展方向，近年来频频更新换代的手机终端无论花样如何翻新，都是走向多媒体多功能的终端。中国移动通信此次籍与《七剑》携手推广的良机率先尝试推出整合了多媒体业务的手机网页，其技术实力自不必说，就消费者的业务体验而言就比\"单媒体\"更能吸引眼球。</p>\n<p>　　尽管在内容和业务设计上\"手机版《七剑》官方网站\"都有值得称道之处，中国移动通信却宣布这些业务都免收信息费，用户通过登陆手机版《七剑》官方网站还可能获得北京首映式观映票、仿真七剑、《七剑》海报、徐克手绘插图、明星签名照片、《七剑》PC游戏体验卡等奖品。这一系列举措自然能帮助走秀的《七剑》汇集更多人气，对于不以电影市场为目标的中国移动通信而言，此中则另有深意。</p>\n<p>　　完美走秀打造双赢</p>\n<p>　　普通T型台的灯光总是集中在走秀模特的身上，这个规则在中国移动通信和武侠巨制《七剑》携手创立的走秀场上却遭到了颠覆，T型台得到的关注不亚于走秀的大片。《七剑》的推广方慈文传媒长袖善舞，在古装武侠巨作的市场推广上游刃有余。而舞台的搭建者中国移动通信同样在移动通信增值服务市场上风云叱诧，一直都以其创新和敏锐领跑市场。二者在各自的领域都是高手，其携手上演的推广大戏里没有主配角之分，只有目标的不同。</p>\n<p>　　武侠巨制《七剑》的目标当然首先是票房，影片本身的吸引力再加上亮点频出推广走秀，使得《七剑》成为当前呼声最高的暑期档大片。除了票房，《七剑》更被电影业人士赋予点燃中国电影暑期档热情的重任。暑期档在欧美电影市场上非常成熟，在我国却一直表现平平，一大原因在于暑期档的国产大片少且没有连续性。徐克呕三年心血打造的《七剑》定于在暑期档推出，其票房一旦实现重大突破则会给市场注入信心，有助于我国国产电影暑期档的成熟和稳定。因此被国内电影业界看好。选择与中国移动通信携手推广，《七剑》无疑是非常明智的。中国移动通信不仅拥有最大规模的用户群体，还构建了成熟的移动增值服务体系。其旗下的子品牌\"移动梦网\"因开创了国内电信增值业务的新商务模式而取得了巨大的商业成功。移动梦网不仅以中国移动通信的优势网络和雄厚技术为基础，更汇聚了国内最优秀的服务提供商。在移动增值业务研发、设计和推广上中国移动通信都具备不可比拟的优势。这些优势为《七剑》的推广活动增色不少。</p>\n<p>　　\"手机版《七剑》官方网站\" 除了在内容提供上具有排他性以外，在业务上最大的创新之处在于首次将文字、图片、音视频整合在一起，这两点足以成为\"手机看《七剑》\"的杀手锏。而中国移动通信并不完全以这两大业务亮点吸引眼球，整个\"手机版《七剑》官方网站\"免除信息费的同时还为用户赠送礼品，当然是想获取更多的MO手机上网点击率，吸引更多用户来体验手机上的多媒体业务。电信增值服务在推广中的最大的瓶颈就是\"消费体验\"，新业务的推出除了在设计上必须延续消费者已经培养的使用习惯外，还需具有简便、有用等的特点。要使消费者接受新业务，唯一的途径就是\"体验\"，最大的拦路虎也是\"体验\"。中国移动通信在市场推广上深谙此道，纵然\"手机版《七剑》官方网站\"可借武侠巨制吸引眼球，更需要给手机用户一个体验的理由。</p>\n<p>　　对于中国移动通信和《七剑》而言，谁搭台谁走秀都不重要，两者的并肩合作像极了徐克在电影中设计的\"日月\"剑：这是两把相连的子母剑，双剑时而成一体，攻击范围可大可细。\"日月\"剑是七剑中最亮的一把剑，并且会越打越明亮耀眼。\"日月\"双剑并出，结局只能有一种：完美走秀打造双赢。 </p>\n\t\n\t\t\n','','ZDNet China','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73156,'10年风雨同舟 华为GSM服务全球8000用户','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　自1995年开始研究GSM以来，华为GSM以“持续投入，不断创新”的精神，已在全球50多个国家90多个运营商获得规模商用，服务8000万用户，累计部署超过30万载波，推出了专业集群系统GT800。保加利亚的BTC、巴西的CTBC以及沙特电信STC在2004年选择GSM/EGDE供应商时都不约而同的选择华为。非洲最大的跨国运营商MTN选择华为在尼日利亚部署了超过9000个TRX的GSM网络，尼日利亚MTN一跃成为MTN集团赢利能力最强的“现金牛”。</p>\n\n\n<p>　　中国运营商给了华为GSM最宝贵的支持。</p>\n\n<p>　　华为GSM在中国的部署超过10万载频，中国是华为GSM最重要的市场之一。</p>\n\n<p>　　1997年，华为GSM首次在北京通信展发布了GSM解决方案。1998年年底在内蒙通过了GSM商用技术鉴定。1999年，推出大容量的BSC和MSC。1999年，承建中国移 动全国智能网。2000年推出GPRS解决方案。2000年以前，整体华为GSM的研发重心都是围绕中国市场，如大容量的MSC适合作关口局等等。</p>\n\n<p>　　1999年以前，华为GSM的全部研发人员还不足500人，缺乏商用经验，在国际巨头的降价竞争面前，一度连一个商用实验局也找不到，很多华为人至今都很怀念内蒙东胜和河北沧州，是这两个地方用广阔的胸怀容纳了华为GSM，没有客户的支持，就没有华为GSM的今天。甘肃白银是华为GSM第一个大规模商用局，覆盖了白银、武威。记得当时割接的时候是周日，网络运行稳定，可是一到周一的上午9：00点，突然大面积的电话打不通了，现场气氛非常紧张。“华为GSM是否不行了？”，疑虑和焦急困扰着每一个人。华为总部和现场成立了紧急处理组，通过话统发现，GSM系统的下行链路受到强烈的无线电干扰，经过几天的排查，最后查明是某金属公司早在90年代初引进的一套宽带无线接入系统带来的干扰。由于那套系统是为了广播金属期货行情用的，所以周末休息，周一9点开工，下午5点停工。在解决问题的过程中，甘肃省局的领导也到现场参与拨测，不断鼓励现场的技术人员。是用户的支持使华为GSM逐渐成长起来。</p>\n\n<p>　　2001年，针对少局所，广覆盖的需求，华为开发了一体化小基站，并提出了边际网覆盖的思路，为村村通电话做出了自己的贡献。</p>\n\n<p>　　“很感激所有帮助过我们的客户和专家”，华为GSM产品线总监王海杰说，“华为坚持围绕客户需求进行创新，为客户持续的创造价值，以此来回报客户对华为GSM的厚爱。”</p>\n\n<p>　　海外市场给了华为GSM腾飞的翅膀</p>\n\n<p>　　由于国内市场格局已定，2000年以后，华为GSM逐渐在海外市场扎根，目前已经在俄罗斯、南非、中东北非，亚太和欧洲都获得规模商用，占全球新增GSM市场份额的10%以上。对于新GSM牌照，华为的中标率高达33%。目前华为GSM的销售额70%来自海外市场，海外市场不仅让华为GSM产品扭亏为盈，更重要的是了解到全球市场的差异性，为3G产品的设计奠定了良好的基础。</p>\n\n<p>　　围绕客户需求进行开发，为客户创造价值是华为的理念。典型的案例是华为与泰国AIS的合作，使AIS用户从400万迅速发展到1200万。华为倡导的大容量少局所的核心网解决方案、低成本快速建网的无线接入网解决方案都在实际应用中获得了用户认可。华为GSM的基站子系统产品包括了支持EDGE的系列化基站：宏蜂窝室内型、室外型、一体化小基站等，系列化基站适应不同应用场景，具有广覆盖技术、灵活组网、多样化内置传输、内置电源等特点，能够在保持网络可持续发展的同时大大降低整网建设成本。</p>\n\n<p>　　随着3G研发的进展，华为开始采用3G平台来开发新GSM解决方案。华为GSM核心网采用移 动软交换平台，可平滑支持WCDMA R4，因此受到了全球移 动运营商的欢迎，累计已经部署超过2000万线。华为GSM移 动软交换有以下特点：兼容2G/3G，分布式组网，VoIP组网，大容量少局所，双归属网络，A-FLEX资源共享，无信令点平滑扩容，业务快速布署等特点。</p>\n\n<p>　　意识到专业集群市场有巨大的商机后，2003年，华为启动GT800数字集群系统的研究。2005年，GT800被3GPP纳入国际标准。GT800支持脱网直通、单基站通信等专业功能，快速呼叫建立时间小于700毫秒，群组业务丰富适用，组内用户容量不受限制，并实现全方位的优先级管理，具有比现有系统更突出的集群优势。GT800是专网、共网和城市应急联动的最佳选择。华为GSM-R承建的大秦线也于2005年6月开通运行。</p>\n\n<p>　　“GSM在2005年将进入到2G/3G融合的发展阶段，同时基于GSM的集群业务也将成为新的发展趋势，”华为GSM产品线总监王海杰说，“华为GSM将不断增加服务能力和解决方案的适用性，在2G/3G融合以及集群共网等解决方案上为客户创造价值。”\n</p>\n\n\t\n\t\t\n','','新浪科技','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73157,'宽带奥运带来什么','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t<p>　　文/彭芳</p>\n\t\n\t<p>　　7月22日，在中国网通成为北京2008奥运会合作伙伴一周年之际，</p>\n\n<p>　　中国网通奥运战略启动大会如期举行</p>\n\n<p>　　7月22日，在中国网通成为北京2008奥运会合作伙伴一周年之际，中国网通奥运战略启动大会举行。大会除在北京设置主会场外，还在包括另外5个赛会城市在内的全国30个省\n级分公司设立分会场。网通全国各体员工通过网通的视频会议系统同步看到主会场的现场直播，形成了全国互动、共同参与的盛况。</p>\n\n<p>　　奥运战略助力企业提升</p>\n\n<p>　　中国网通奥运战略由保障计划、发展计划、辐射计划三部分组成。该战略的实施能够指导相关通信设施建设，直接满足奥运通信需求，并且还将借助奥运市场的拉动效应，使中国网通取得奥运效益，使广大客户得到更满意的服务。</p>\n\n<p>　　其中，奥运保障计划是指根据奥运通信服务的需求，制订稳定先进的实施方案和安全便捷的保障方案，保障奥运通信服务的完全成功，具体包括12个专业的奥运设施建设计划、IT支撑系统计划、服务保障计划、安全管理计划以及奥运项目管理计划。网络的安全性和稳定性是其中的首要考虑因素。在采用稳定成熟技术，充分考虑奥运突发事件和网络多重保护的前提下，中国网通将做好安全、防护工作。</p>\n\n<p>　　奥运发展计划是指借助奥运市场的拉动效应，开展有计划的市场营销活动，促进品牌提升、业务创新、市场拉动、合作发展，取得奥运效益。奥运品牌以及奥运相关活动、事件、群体为网通开展特殊营销活动创造了有利契机。中国网通将围绕奥运战略发展主线设定一套具有战略意义的整体营销计划。在时间区间上，这一计划将持续到2012年，在2008年达到高潮，通过传播的累积效果实现奥运品牌效应的最大化。</p>\n\n<p>　　借助奥运的品牌辐射效应，奥运辐射计划有利于推动中国网通集团各项管理工作的整体提升，具体体现在人力资源计划、服务质量管理计划、企业文化建设计划、流程再造计划方面。从企业文化角度考虑，优秀的企业文化是奥运通信的升华。</p>\n\n<p>　　奥运战略巩固网络安全</p>\n\n<p>　　据了解，2008年奥运会场馆分散、规模空前，其通信网络的复杂程度超过了历届奥运会。在获得固定通信服务合作伙伴的资格后，中国网通成立了奥运通信管理部，该部门与各方全面交流，积极借鉴悉尼和雅典的成功经验，努力使奥运通信网络与目前复杂的城市网络相对应，逐步推进奥运通信工程建设。</p>\n\n<p>　　一年来，中国网通的主要工作成就是：奥运会的重要通信平台----北京宽带综合业务传送网顺利竣工，这是国内最大的智能城域光网络系统；与国家奥林匹克体育中心签订“奥运项目通信全面合作协议”，启动了规模较大的奥运场馆通信建设工程；与其他合作公司签署了北京2008年奥运会高清电视传送的相关协议；与奥运37项竞赛场馆工程、15项非竞赛场馆的所有场馆业主建立工作关系，并收集确认了各个场馆的基本信息；已完成了11个新建场馆的草图评审和反馈；完成数字北京大厦项目施工图评审，促进该项目实施，确保如期竣工；完成北京奥组委旧址办公大楼通信工程、北京奥林匹克转播公司(BOB)办公楼通信工程；积极开展奥组委新址办公大楼通信工程；已经分别在北京、青岛召开奥运六城市的专项工作会议，组织落实相关工作。</p>\n\n<p>　　目前，北京网通和奥组委经过充分沟通，已经明确了奥运会主要的通信需求，确立了场馆通信工程建设的基本原则和大体的通信技术方案，并形成了总体的建设时间表。据了解，2008年奥运会的通信实施纲要将有三个版本，每一版都将根据技术的演进和市场的变化，吸取时代的元素进行改进。第一版目前已经成形，即将进行任务分解，开始系统实施；第二版将于2006年年底确定；到2008年一季度，将推出第三个版本，也就是奥运通信的最终方案。</p>\n\n<p>　　据了解，奥运通信建设方案将全面满足奥运比赛赛事及场馆通信需求，通信网络具有灵活性等特点，能够满足用户需求的变化；选用的设备具有集成性，能够同时支持宽窄带综合接入业务。在实际建设过程中，北京网通将采用稳定成熟的技术，以网络稳定性为第一要素的前提下兼顾技术的前瞻性，符合新技术发展趋势。网络的灾难恢复能力也十分重要。各场馆将采用物理双路由结构，通过SDH自愈功能和光纤备份功能，形成网络自愈能力，对突发事件进行有效规划。同时，在保障奥运基本需求的前提下，北京网通还会尽量利用现网设备，重视投资效益。在进行方案比选及投资效益分析后，从技术和经济两方面论证其投资可行性，兼顾近远期发展，保障奥运会后设备的可再利用性。</p>\n\n<p>　　奥运战略促进视频应用</p>\n\n<p>　　每一次的奥运会，都是一个国家通信实力的展示；而每一次的奥运会，也都会有一个新的通信技术和通信业务成为亮点。1996年亚特兰大奥运会上，互联网将世界连接在乐一起；2000年悉尼奥运会上，移动通信成为亮点；2004年雅典奥运会上，网络管理和安全手段受到关注。展望2008年奥运会，视频信息技术将得到广泛应用，其中，数字高清电视信号的传送将是一大亮点。</p>\n\n<p>　　按照广电总局的规划，我国将于2008年全面推广数字高清电视的地面传输，并于2015年关闭现有的模拟电视广播。考虑到这一发展趋势，北京网通将在2008年奥运会上提供高清电视传送服务。据了解，北京奥林匹克转播公司(BOB)提供的奥运比赛节目，将有60%～70%是数字高清信号。通过中国网通和国外电信运营商的携手合作，全球观众在家中就能收看到比过去更加清晰、更加生动、更加真实的奥运比赛，更真切地感受奥运的精彩魅力。\n</p>\n\n\t\n\t\t\n','','中国计算机报','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73158,'中国通信制造业勾画发展蓝图','','','','../resource/img/h000/h00/img200509161648160.jpg','','<P>　　本报记者 刘英赫</P>\r\n<P>　　7月28日，由中国电子信息产业发展研究院主办的“亚太移动通信发展论坛(首届年会)”在京召开。会议期间，就亚太移动通信的产业格局、发展趋势、区域合作、市场商机及和谐共赢等方面的热点课题进行了充分研讨。而与会的中国通信企业更是表示出强烈的愿望，希望能够在未来的时间内将自己的客户版图拓展到世界的多个角落，他们也表示，一切的根基将来自于亚太市场的稳固。</P>\r\n<P>　　近年来，亚太移动通信越来越彰显其活力和示范效能，并正在成为全球移动通信的制造中心和全球最大的移动用户市场。随着亚太移动通信的蓬勃发展和中国第三代移动通信的蓄势待发，亚太移动通信的产业格局以及相关运营与制造业的竞争格局均将发生深刻变化。</P>\r\n<P>　　创新成为市场竞争分水岭</P>\r\n<P>　　由于本次论坛主题为“制胜亚太 构想全球”，来自运营业、制造业的代表对亚太移动通信市场发展现状与趋势，亚太移动通信的产业格局与竞争环境，亚太移动通信网间协作与商机共赢，亚太区域协作、优势互补及共赢策略分析，第三代移动通信对中国及亚太地区的机遇与挑战等话题进行了深入的研讨。有专家指出，亚太的移动通信市场在未来10年仍将保持较高速度的增长，并将逐渐成为全球移动通信市场发展的主动力。</P>\r\n<P>　　有消息称，日前我国通信制造业的代表企业华为被亚太运营商和咨询师组织评选为“2005年最佳无线设备供应商”。这个消息证明了中国通信产业的实力。来自Frost&amp;Sullivan的分析师谢仲腾指出，未来5年中，全球移动通信市场将处于一种稳定上升的态势。“其中最为引人关注的将是在亚太移动领域较大的增长空间，而亚太地区的增长主要来自于中国，运营商和设备提供商的双赢格局成为市场向前发展的动力。”谢仲腾以华为已创造的优秀业绩为例，得出“创新是亚太设备制造商在全球竞争的关键”的结论。</P>\r\n<P>　　中国企业上半年海外创奇迹</P>\r\n<P>　　近日，记者从中兴、华为等公司获得消息，这些通信企业在今年的上半年都取得了海外市场的重大突破，这一现象已经被海外媒体重点关注。日前，记者从华为公司获得信息，2005年上半年，华为实现全球销售额330亿元人民币，比去年同期增长85%。上半年海外销售达24.7亿美元，占销售总额的62%，并已超过2004年全年的国际市场销售额。新进入了19家运营商，包括成功入选英国电信“二十一世纪网络”的名单。</P>\r\n<P>　　值得关注的是，华为公司2005年上半年移动通信产品相对于2004年同期，销售额实现了120%的增长，其中CDMA在国际市场上的增长率达到200%。在WCDMA领域，华为通过自主研发、创新，已经取得5%的基本专利，跻身全球前五。截至2005年6月30日，华为WCDMA共取得11个商用合同，HSDPA网络和HSDPA数据卡在荷兰Telfort成功商用。华为于2005年2月在全球率先发布了WCDMA分布式基站，这种创新基站体积小，安装容易，可以极大地降低建网成本，提高建网速度，创新的解决方案进一步巩固了华为WCDMA的全球领先地位。</P>\r\n<P>　　在CDMA2000 1X及1X EV-DO市场上，华为2005年上半年连续获得泰国、阿尔及利亚、孟加拉、巴基斯坦以及欧美大单，上半年CDMA出货1000万用户容量。华为已经在10个国家建设了CDMA 2000 1x EV-DO网络，包括美国、泰国、墨西哥、巴基斯坦、阿尔及利亚等。</P>\r\n<P>　　而作为中国通信制造业中最大的上市公司，中兴通讯虽然还没有发布上半年财报，但据悉海外也是全线飘红。可见，中国企业未来的主流市场开始有向海外漂移的趋势。</P>\r\n<P>　　海外市场形势依然不容乐观</P>\r\n<P>　　近日，华为公司无线产品线副总裁王良文表示，华为成绩的取得主要来自于三个坚持：第一是坚持围绕客户需求进行创新，推出满足客户需求的产品，实现客户价值的最大化；第二是坚持管理改进和全球化研发，通过不断提升的能力，保障端到端解决方案高质量的交付；第三是坚持与运营商和友商进行战略合作，加强行业内的经验共享，共同维护行业的健康发展，分享价值链的利益。</P>\r\n<P>　　但是针对海外市场，有专家表示，中国企业由于长期扎根于国内市场，所以需要面对的问题依然较多，特别是中国通信企业的客户虽然在发达国家也取得了一些成绩，但从目前情况看，多半还是集中于发展中国家地区，而且这些国家的市场存在着一些不确定性。另外，如何解决客户结算也是一个较大的问题。王良文表示，华为已经获得了国家金融机构的支持，每年也都有不少的贷款，同时在一些欠发达地区，中国企业也可以采取以货易货的模式，来代替其他模式进行商品交易。</P>\r\n<P>　　虽然说目前中国企业找到了一些海外市场的应对措施，但是从目前的情况来看，中国企业在海外市场的路也不容乐观。 </P>','','中国电子报','','',1126758499,1126860499,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73152,'方正宽带推出暑期体验网络无限乐趣活动','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　今年的暑期酷热难当，各地的气温相继冲破了历史最高值，出行的人流大大减少了，却也正是网络宽带运营商们“跑马圈地”的好时机。</p>\n\n<p>　　6月底、7月初以来，伴随着气温的节节升高，各大宽带运营商之间的竞争也进入了白热化，它们纷纷祭出了促销活动的法宝，争抢市场份额，这其中，方正宽带于近期推出的“暑期体验网络无限乐趣活动”尤其令人瞩目。</p>\n\n\n<p>　　据方正宽带的负责人介绍，从6月25日起，凡在两个月之内报装方正宽带的用户，都将可获得方正宽带的各种超值礼品，其中季交以上用户均可获赠精美时尚水杯。而选择年交的用户还可以获赠更多精美礼品，包括月亮城影院月卡、方正宽带数字图书馆月卡、中国网吧院线月卡、Ework特权220条免费短信或73分钟免费国内长途；选择半年交的用户，则可以根据需要任选年交用户礼品中的两项。</p>\n\n<p>　　同时，为了配合暑期的各项活动，方正宽带还于近日启动了“2005年暑期宽带电影推介活动”，据介绍，这一活动的目的是为了丰富小区居民的业余文化娱乐生活。</p>\n\n<p>　　据悉，此次消夏露天电影播放活动自6月初在五里店南里小区“初战告捷”之后，还将陆续在六合园、依翠园、高家园、华盛家园、枣营南里、永乐居等小区内持续进行，预计整个活动于9月初结束。据方正宽带的负责人介绍，方宽以这种简单的方式走入社区居民的生活，以贴心的关怀服务于广大的居民，从小处着手、从点滴做起，其目的是为了让用户感受方正宽带“以人为本”的企业文化，拉近与宽带用户之间的距离，并与用户间形成良好的互动交流。\n</p>\n\n\t\n\t\t\n','','新浪科技','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73153,'中国计算机报：宽带多宽才够用','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t<p>　　文/晓波</p>\n\t\n\t<p>　　随着宽带应用的增多，用户需求更高的带宽</p>\n\n<p>　　FTTH技术正在进入大规模商用，PON正在抢夺传统的DSL接入市场</p>\n\n<p>　　PON速度对比表</p>\n\n\n<p>　　B-PON GE-PON ITU G-PON</p>\n\n<p>　　标准 ITU T G.983 IEEE 802.3ah ITU T G.984</p>\n\n<p>　　下行物理速度 622 Mb/s 1.25 Gb/s 2.4 Gb/s</p>\n\n<p>　　上行物理速度 156 Mb/s 1.25 Gb/s 1.2 Gb/s</p>\n\n<p>　　传输格式 ATM Ethernet GEM</p>\n\n<p>　　(Ethernet+TDM)</p>\n\n<p>　　随着互联网的快速发展和各种宽带应用的普及，用户对于接入带宽的需求迅速增加，宽带接入网络的部署发展迅猛。7月18日-23日，记者采访日立总部，并有机会了解日本在宽带方面的发展状况。通过和专家的交流，可以看到，随着宽带应用的增多，用户需求更高的带宽。为满足用户需求，刺激宽带发展，日本大量部署FTTH(光纤到户)系统，其中无源光网络(PON)解决方案更成为建设热点。可以看到，FTTH技术正在进入大规模商用，PON正在抢夺传统的DSL接入市场。</p>\n\n<p>　　早从2004年开始，FTTH这个看似遥远的东西规模进入市场，特别是日本和北美开始规模应用，发展非常迅速，从而成为低迷的光通信市场的亮点，甚至被业界公认为光通信重新崛起的最大驱动力。受国外的影响，我国在一些地区(如武汉)也开始了小规模的FTTH试验，一些运营商(如北京通信)甚至开始了FTTH的试商用。</p>\n\n<p>　　从需求角度分析，日立通信技术事业部总裁兼首席执行官青木荣司指出，宽带用户不再满足简单的上网聊天，为用户提供更多的宽带增值业务已显得越来越迫切。从另一方面看，宽带业务正成为拉动运营商收入增长的主要驱动力。宽带业务的收入占数据业务总收入的比例逐渐提高。与2003年相比，2004年中国宽带业务收入增长87亿元，在运营商主营业务收入的增量中比重超过30%。宽带收入增量成为固网运营商收入增量中的重要组成部分。从全球来看，宽带市场份额逐年上升是全球的趋势。同时，Triple Play(影像、语音、数据同步传输)成为近期宽带应用的热点。研究表明，Triple Play在提高欧美市场用户ARPU值的同时，用户离网率、用户生命周期及用户净现值等数据均体现出普通电视服务及IPTV业务所不具备的优势。从数据来看，Triple Play业务在2004年对提高欧美宽带运营商收入的作用非常明显，它已经成为宽带网上极具发展价值的应用服务类型。</p>\n\n<p>　　但是，这些新应用的开发，业务模式的创新，势必要求网络具有快速传输数据的功能。目前，DSL技术在宽带接入市场中占有主导地位。电信研究院总工程师蒋林涛认为，ADSL下行快上行慢，这样一种接入条件其实对对称业务开展很不利。例如，IPTV的频道切换就有问题，如果采用光纤到户的接入，很多问题就可以解决。</p>\n\n<p>　　世界各地的运营商们对FTTx及PON技术表现出了相当高的兴趣：美国电信巨头SBC通信公司启动了名为“LightSpeed”的宏伟计划，要在未来3年之内通过PON、以太网技术接入1800万户家庭，利用此全IP、全数字的高速网络切入影视业，最终在其光纤网络所覆盖的地区成为第二大视频服务提供商。</p>\n\n<p>　　目前，随着市场竞争的升级，运营商现阶段也期望通过PON这样的高投入、高产出的通信产品，服务于部分区域或部分客户项目，以获得长期性竞争优势。其一，通过PON技术领先的基本特征，实现业务类型丰富、交叉容量巨大的城域光传送网络到办公室或家庭的延伸，并通过丰富的业务模式挖掘客户增值潜力，提高运营收益。其二，在重点区域部署PON技术有利于获得最后一公里的“路权”优势，减少中间有源环节，便于直接将客户通过光纤媒质连接到运营商的现行运营网络。其三，通过引入PON技术降低接入网络运维成本。</p>\n\n<p>　　市场研究家们认为，无源光网络是一个快速增长的市场细分。据Infonetics Research研究数字显示在2004年该市场规模为5.25亿美元，而且将在2008年增长到21.5亿美元，年平均增长率达42%。北美和亚洲市场的增长尤其强劲。在接入网大规模铺设光缆和提供光纤宽带接入的时机已成熟，未来的接入网络将是光纤接入网的天下。目前，国内FTTH和PON技术还处于商用试验阶段，而如何更好地发展PON，则需要我们借鉴国外的成功经验，促进宽带的发展。当前，国内电信市场竞争日趋激烈，对于靠近客户最后一公里的争夺尤其如此。而PON无疑会成为固网运营商提升收益的重要手段。宽带多宽才够用? </p>\n\n<p>　　晓波  </p>\n\n<p>　　随着宽带应用的增多，用户需求更高的带宽</p>\n\n<p>　　FTTH技术正在进入大规模商用，PON正在抢夺传统的DSL接入市场</p>\n\n<p>　　PON速度对比表</p>\n\n<p>　　B-PON GE-PON ITU G-PON</p>\n\n<p>　　标准 ITU T G.983 IEEE 802.3ah ITU T G.984</p>\n\n<p>　　下行物理速度 622 Mb/s 1.25 Gb/s 2.4 Gb/s</p>\n\n<p>　　上行物理速度 156 Mb/s 1.25 Gb/s 1.2 Gb/s</p>\n\n<p>　　传输格式 ATM Ethernet GEM</p>\n\n<p>　　(Ethernet+TDM)</p>\n\n<p>　　随着互联网的快速发展和各种宽带应用的普及，用户对于接入带宽的需求迅速增加，宽带接入网络的部署发展迅猛。7月18日-23日，记者采访日立总部，并有机会了解日本在宽带方面的发展状况。通过和专家的交流，可以看到，随着宽带应用的增多，用户需求更高的带宽。为满足用户需求，刺激宽带发展，日本大量部署FTTH(光纤到户)系统，其中无源光网络(PON)解决方案更成为建设热点。可以看到，FTTH技术正在进入大规模商用，PON正在抢夺传统的DSL接入市场。</p>\n\n<p>　　早从2004年开始，FTTH这个看似遥远的东西规模进入市场，特别是日本和北美开始规模应用，发展非常迅速，从而成为低迷的光通信市场的亮点，甚至被业界公认为光通信重新崛起的最大驱动力。受国外的影响，我国在一些地区(如武汉)也开始了小规模的FTTH试验，一些运营商(如北京通信)甚至开始了FTTH的试商用。</p>\n\n<p>　　从需求角度分析，日立通信技术事业部总裁兼首席执行官青木荣司指出，宽带用户不再满足简单的上网聊天，为用户提供更多的宽带增值业务已显得越来越迫切。从另一方面看，宽带业务正成为拉动运营商收入增长的主要驱动力。宽带业务的收入占数据业务总收入的比例逐渐提高。与2003年相比，2004年中国宽带业务收入增长87亿元，在运营商主营业务收入的增量中比重超过30%。宽带收入增量成为固网运营商收入增量中的重要组成部分。从全球来看，宽带市场份额逐年上升是全球的趋势。同时，Triple Play(影像、语音、数据同步传输)成为近期宽带应用的热点。研究表明，Triple Play在提高欧美市场用户ARPU值的同时，用户离网率、用户生命周期及用户净现值等数据均体现出普通电视服务及IPTV业务所不具备的优势。从数据来看，Triple Play业务在2004年对提高欧美宽带运营商收入的作用非常明显，它已经成为宽带网上极具发展价值的应用服务类型。</p>\n\n<p>　　但是，这些新应用的开发，业务模式的创新，势必要求网络具有快速传输数据的功能。目前，DSL技术在宽带接入市场中占有主导地位。电信研究院总工程师蒋林涛认为，ADSL下行快上行慢，这样一种接入条件其实对对称业务开展很不利。例如，IPTV的频道切换就有问题，如果采用光纤到户的接入，很多问题就可以解决。</p>\n\n<p>　　世界各地的运营商们对FTTx及PON技术表现出了相当高的兴趣：美国电信巨头SBC通信公司启动了名为“LightSpeed”的宏伟计划，要在未来3年之内通过PON、以太网技术接入1800万户家庭，利用此全IP、全数字的高速网络切入影视业，最终在其光纤网络所覆盖的地区成为第二大视频服务提供商。</p>\n\n<p>　　目前，随着市场竞争的升级，运营商现阶段也期望通过PON这样的高投入、高产出的通信产品，服务于部分区域或部分客户项目，以获得长期性竞争优势。其一，通过PON技术领先的基本特征，实现业务类型丰富、交叉容量巨大的城域光传送网络到办公室或家庭的延伸，并通过丰富的业务模式挖掘客户增值潜力，提高运营收益。其二，在重点区域部署PON技术有利于获得最后一公里的“路权”优势，减少中间有源环节，便于直接将客户通过光纤媒质连接到运营商的现行运营网络。其三，通过引入PON技术降低接入网络运维成本。</p>\n\n<p>　　市场研究家们认为，无源光网络是一个快速增长的市场细分。据Infonetics Research研究数字显示在2004年该市场规模为5.25亿美元，而且将在2008年增长到21.5亿美元，年平均增长率达42%。北美和亚洲市场的增长尤其强劲。在接入网大规模铺设光缆和提供光纤宽带接入的时机已成熟，未来的接入网络将是光纤接入网的天下。目前，国内FTTH和PON技术还处于商用试验阶段，而如何更好地发展PON，则需要我们借鉴国外的成功经验，促进宽带的发展。当前，国内电信市场竞争日趋激烈，对于靠近客户最后一公里的争夺尤其如此。而PON无疑会成为固网运营商提升收益的重要手段。\n</p>\n\n\t\n\t\t\n','','中国计算机报','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73151,'中文通信代码注册热潮持续 日注册量创新高','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　中新网8月2日电 据“中文通信代码注册管理中心”最新消息，“中文通信代码”自2005年7月28日开始预注册以来，短短4日内5000名称便被抢注一空。企业抢注热情有增无减，仅在8月1日一天，注册数量便超过1500，宅急送、多乐士、深圳送花、广东特产、郑州纸艺、亚士漆、华润涂料等热门词汇已被预注册。</p>\n<p>　　“中文通信代码”全称为“电话、短信、网络、3G中文通信代码”，是一种现代化的\n通信标识，通过“中国总机”服务实现。如北京出租汽车24小时叫车的电话是010-68373399，难以记忆，而注册中文通信代码后，任何人只要记住“北京出租”就可以通过中国总机95001000直接电话接通叫车，或发送短信内容“北京出租”到95001000进行叫车。“中国总机”是由中国电信、中国移动、中国网通、中国联通共同支持的一项创新的通信增值服务。它融合了电话、无线域名、网络等多种创新服务于一身。任何企业均可通过注册“中文通信代码”，以中文名称(产品名、商标名、企业名等)代替电话号码、短信特服号及手机网址，建立方便迅捷的沟通渠道。中国总机让沟通变得更加方便、快捷和人性化。</p>\n<p>　　“中国总机”服务由占据了域名服务市场份额80%的中国万网、新网、商务中国、互易、世纪辰光、国政网、火速七大企业互联网服务商和鸿联九五(中信集团)、天下互联等业界知名企业联合推出，而中文通信代码的注册及管理工作则通过\"中文通信代码合注册管理中心\"统一受理。</p>\n<p>　　据“中国总机”的发起者商务中国表示，“中国总机”服务启动之时，广东地区便形成了“中文通信代码”的抢注热潮。这表明，中文通信符号更受国人的广泛欢迎，在广东、香港地区，中国传统文化对商业渗透力度较强，中文通信代码开创了将中文作为通信符号、商务沟通符号的先河，很好地实现了文化营销，可以预计，中国企业抢注\"中文通信代码\"的热潮还将持续。 </p>\n\t\n\t\t\n','','中国新闻网','',NULL,1126758498,1126758498,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73148,'网通国际月内彻底消失 北京办公楼另做他用','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　商报讯 (记者 李卉)“我们目前还在等待，但估计这个月内就会正式去集团报到，彻底离开亦庄办公楼了。”昨天，一位不愿透露姓名的网通国际分公司员工告诉记者。</p>\n<p>　　按照集团的统一部署，7月27日至31日为网通国际员工工作交接期；8月1日前，网通国际各部门的工作将被全部纳入网通集团的相关部门，网通国际员工将转到新部门上班。由于时间过于仓促，特别是很多业务层面的交接不可能在短时间内完成，昨天的网通国际并没有\n如想象中“人去楼空”，各部门的交接还在进行中。由于此次人员调整是以整建制划转的方式，因此不少完成了交接的员工每天依旧来亦庄上班，“等着和部门一起过去(集团)上班。”</p>\n<p>　　网通集团国际部总经理关若其在接受记者采访时表示，员工到岗有“管理职责到岗”和“人员到岗”之分，目前各部门的管理职责已基本到位，具体人员将会在本月内陆续到位。当记者追问网通国际在亦庄的办公楼将如何安排时，关若其含混地表示，“集团行政部门会有安排。”随后记者从有关渠道获悉，这个曾经见证网通国际辉煌过去的大楼将被集团另做他用。</p>\n<p>　　另据记者了解，此前业界风传的“网通国际三高管调入集团”尚未落实。除原国际分公司副总关若其早在7月20日前被正式任命为集团国际部总经理外，原网通国际总经理赵安建和原副总韦轶群的新任命目前还未正式下发。此前业界传此二人将分别出任网通集团监管事务部总经理和网通集团国际部副总经理。 </p>\n\t\n\t\t\n','','1124443590','',NULL,1126758497,1126758497,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73149,'北京数字信息亭可查交通违法信息(图)','','','','','','<P align=center></P>\r\n<P align=center><IMG style=\"WIDTH: 500px; HEIGHT: 333px\" alt=北京数字信息亭可查交通违法信息(图) hspace=0 src=\"../resource/img/h000/h00/img200508171851460495.jpg\" border=1><BR>8月2日，一名司机在北京街头的数字信息亭查询车辆交通违法记录和驾驶员积分信息。</P>\r\n<P align=left>&nbsp;　 当日，北京市司机可以通过遍布北京市城八区的数字信息亭，查询车辆交通违法记录和驾驶员积分信息。据介绍，数字信息亭提供的交通违法查询信息，与首都之窗交管局网站提供的查询信息一致,均来自北京市交管局数据库，可确保信息准确。 新华社发(张传东 摄) </P>','','新华网','','',1126758497,1127370631,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73204,'英特尔高级副总：未来五年计算将10倍速成长','','','','','','<P>　　作者:马文方 </P>\r\n<P>　　【赛迪网独家特稿】市场对计算的需求要求摩尔定律依旧保持不变，但因为功耗，处理器满足摩尔定律的方式已经从过去注重主频的提高转向多内核的并行计算。作为IT产业基石的处理器，这一根本性的改变将对整个产业特别是软件产业带来深刻的影响。 </P>\r\n<P>　　来华工作访问的英特尔公司高级副总裁兼数字企业事业部总经理帕特·基辛格，近日接受了记者的第四次独家专访。</P>\r\n<P align=center><IMG alt=英特尔高级副总：未来五年计算将10倍速成长 src=\"../resource/img/h000/h00/img200509221507450263.jpg\" border=1></P>\r\n<P align=center>　　英特尔公司高级副总裁兼数字企业事业部总经理帕特·基辛格</P>\r\n<P align=center><IMG alt=英特尔高级副总：未来五年计算将10倍速成长 src=\"../resource/img/h000/h00/img200509221507451962.jpg\" border=1>&nbsp;</P>\r\n<P align=center>　　英特尔公司高级副总裁兼数字企业事业部总经理帕特·基辛格 </P>\r\n<P>　　功耗加速处理器多内核化 </P>\r\n<P>　　记者：过去的一年多里，处理器的功耗问题成了影响性能提高的最大障碍。你认为影响功耗的主要因素有哪些？ </P>\r\n<P>　　基辛格：在Intel所有要综合考虑的设计因素中，功耗已经成为关键因素。首先，这种考虑体现在晶体管层面上，我们现在不仅强调晶体管的速度，也强调降低晶体管的功耗。当然，我们的设计策略不仅仅体现在电路上，也体现在逻辑和架构上。将摩尔定律用在降低功耗上，是过去十到十五年之间，摩尔定律发生的最大变化。 </P>\r\n<P>　　记者：Intel倾向于通过新的内核还是采用新的工艺来提升性能？ </P>\r\n<P>　　基辛格：我们正越来越关注双内核和多内核，业界正面临历史上计算性能提高最快的一个时期，从现在到2010年的5年中，计算性能将提高10倍，而在此之前的5年中，性能只提高了3~4倍。性能的大幅提高是计算转向多核技术的结果。 </P>\r\n<P>　　记者：去年，Intel说今年将推出集成10亿个晶体管的芯片，这个时间表有没有改变？ </P>\r\n<P>　　基辛格：我们正按计划于今年年底推出首款拥有10亿量级晶体管数的芯片Montecito，这款含有17亿个晶体管的双核芯片属于安腾家族。 </P>\r\n<P>　　记者：记得几年前业界就在热烈谈论10GHz芯片，说用不了几年就可以成为现实。 </P>\r\n<P>　　基辛格：在未来的发展中，我们仍然会致力于提高频率，但是频率提高的速率与过去相比要慢很多。我们现在还不能预测10GHz何时会出现。频率的提高将增加功耗，这正是我们关注的，换句话说，我们希望在获得更高性能的同时，频率的提高不像过去那样快。 </P>\r\n<P>　　新门槛涨至15亿美元 </P>\r\n<P>　　记者：以往，半导体制造技术的每一次升级换代都会带来主频的大幅提高，未来65纳米和45纳米对应的主频是多少？ </P>\r\n<P>　　基辛格：对于65纳米或者45纳米所对应的主频，今天我们还没有一个准确的说法。我们把注意力主要放在双内核、多内核和降低功耗方面，放在降低功耗的同时提高性能上。在提升主频方面没有非常明确的目标。新工艺的引入会对主频有所提升，但提升的幅度不像以往那样大，比如说加工技术从180纳米进入130纳米时，主频翻了一番；但从65纳米到45纳米时，主频可能只会提高10%~20%。 </P>\r\n<P>　　记者：三年前你告诉我，英特尔的核心竞争力既不在于优秀的设计团队，也不在于庞大的生产设施上，而是在两者的结合上。英特尔现在的研发重点转向体系架构，而制造的贡献似乎在变弱。这是否意味着Intel的核心竞争力又重新做了定位？ </P>\r\n<P>　　基辛格：没有变化。我们现在发生的主要转变只是优化的对象不同。过去，随着我们产品不断更新换代，功耗不断的提高。后来我们实现了在不断更新换代时，功耗始终保持恒定水平。这样，我们在制造上的重点就放在维持功耗水平不变的情况下对性能进行优化，比如说35瓦功耗的笔记本电脑处理器。我们致力于从90纳米到65纳米、再到45纳米的工艺升级换代过程中，在性能不断翻番的同时，不去改变处理器散热器的外形尺寸，这才是主要的转变。 </P>\r\n<P>　　我们没有改变对制造的关注，我们的策略仍然是在散热和性能最优化组合下，适时推出新的产品，实现规模化生产并提高生产的良品率，从而降低成本。 </P>\r\n<P>　　记者：45纳米以后，硅技术还能走多远？ </P>\r\n<P>　　基辛格：我们将继续每两年提升一次工艺(参见表1)。每代新工艺将集成度提高1倍，在90纳米上，虽然Montecito有一个很大的管芯，有17亿个晶体管，但主流产品的集成度为5亿个晶体管。频率方面，你会看到提升的速度却比较缓慢，主要是由于功耗所限，平均每代大约提升10%~20%。但是性能功耗比的提升非常快，每代新工艺将提高1倍。 </P>\r\n<P align=center><IMG alt=英特尔高级副总：未来五年计算将10倍速成长 src=\"../resource/img/h000/h00/img20050922150746284.jpg\" border=1></P>\r\n<P align=center>　　表1 半导体制造技术未来发展概貌 </P>\r\n<P>　　资料来源：基辛格提供 </P>\r\n<P>　　相同的功耗下，晶体管集成度可以增加1倍，这就是摩尔定律发生的转变——非常关注功耗，这将引导我们在不像以往那样快速提升主频的前提条件下，明显地提升计算性能。 </P>\r\n<P>　　记者：记得三年前你告诉我，半导体制造行业的门槛是每年在生产设施上的投入为10亿美元，现在这个行情涨了多少？还需要多长时间，别人就没有本钱跟你们竞争了？ </P>\r\n<P>　　基辛格：园片直径从200毫米到300毫米的升级非常昂贵，300毫米生产线的投资额大约需要30亿美元，之后缓慢上升，到了450毫米时，可能需要40亿美元。如果你要在半导体制造领域开展业务，那你就必须紧跟每一代的加工技术。 </P>\r\n<P>　　半导体工艺每两年就升级一次。如果每年没有15~20亿美元资金的投入，那就意味着你已经落后了。我相信，如果一家企业每年的投资少于15亿美元，那它就已经出局了。目前还能在这个领域继续开展业务的有三星、台基电、Intel以及其他为数不多的、年投资额在15亿美元的企业。 </P>\r\n<P>　　多内核将给软件厂商带来巨大挑战 </P>\r\n<P>　　记者：线程技术是并行计算中的重要技术之一，英特尔说超线程对性能的提升在17%左右，而IBM i系列首席科学家 Frank Soltis告诉我，IBM的并发多线程可提高效率30%，这种明显的差别是实现机理不同所致吗？ </P>\r\n<P>　　基辛格：首先应该考虑具体应用的类型，以及这种应用在多大程度上可以实现并行化。比如说，在处理器彼此之间没有任何资源分享的、单线程的双处理器系统中，如果有一个应用只能利用一个处理器的话，它的速度就不会有任何的提高；但如果这个应用可以充分并行化，那么，它的性能就可以提高一倍。在超线程系统中，有些应用的性能没有任何提高，有些应用的性能则可以提升40%。英特尔说的17%是对很多应用平均统计的结果。Soltis说的没有错，主要是要看哪类应用。 </P>\r\n<P>　　须要强调的是，超线程对性能的提升在很大程度上还取决于处理器厂商为软件厂商提供的软件工具。与其他公司相比，Intel拥有一套最为丰富的编译器、测试工具、调优工具等资源以及应用实验室，用于线程技术和并行系统。我们相信，这是我们转向多线程和多内核时具有的独一无二的财富。 </P>\r\n<P>　　记者：我们知道处理器的流水线如果超过40级效率不升反降，那么，线程的数量是否也存在一个极限值？ </P>\r\n<P>　　基辛格：线程的数量可以很多。我们已经有了双内核，很快将推出多内核，就是4~8个内核，我们还在研究更多内核的芯片。几年以后，一个芯片内会含有16、32甚至64个内核。你可以想象，几年以后，如果在单一的芯片中有64个内核，每个内核又有2~4个线程的话，我们会轻而易举地看到在一个芯片中拥有265个线程。 </P>\r\n<P>　　记者：可不可以这样理解，以往加工工艺的提高是为了提升主频而获得性能，而现在则是提高集成度以便容纳更多的内核，从而提升性能？ </P>\r\n<P>　　基辛格：你的理解是对的，我们要尽可能多地提高晶体管集成度和内核的数量。在功耗水平不变和频率稍有提高的情况下，我们要实现集成的内核和晶体管的数量翻番。 </P>\r\n<P>　　记者：多内核和多线程会对软件产业带来什么样的挑战？ </P>\r\n<P>　　基辛格：未来5年，硬件的发展速度将成倍地超过软件的进步。软件开发商已经习惯于处理单内核和单线程的问题，现在让他们编写多线程并行程序，在理念上是一个巨大的飞跃，也是一个艰难的转变。而目前来帮助他们进行多线程并行化开发的工具，大都比较差。所以对他们来说，这是一个非常艰巨的挑战。 </P>\r\n<P>　　记者：谁来帮助他们迎接这个挑战呢？ </P>\r\n<P>　　基辛格：我们现在正非常积极地与独立软件商以及应用开发商进行合作，来充分运用硬件多内核化变革带来的结果。我们有编译器、测试工具、调优工具等很多工具，还为软件厂商提供培训、课程以及支持等多种服务，还有调优实验室，来帮助软件厂商完成这一困难的转变。 </P>\r\n<P>　　记者：像微软这样按封装而不是按内核数收费的厂商来说，双内核影响还不大，但多内核实现后，他们能承受这种损失吗？ </P>\r\n<P>　　基辛格：我认为微软的收费模式是对的，而且会继续受益。当英特尔以非常快的速度不断提升内核的数量时，微软已经看到它的商业模式比一些按照内核收费的Unix厂商更具有竞争力。 </P>\r\n<P>　　记者：问题是当英特尔推出64个内核的芯片时，与单一内核的收费相比，在64内核芯片收费上，微软收的还是1份钱，而有些Unix厂商则收的是64份钱。未来，内核数将越来越多，微软抗得住吗？ </P>\r\n<P>　　基辛格：与Unix厂商主要定位在中高端企业级应用不太一样，微软一向把注意力放在市场规模很大的应用领域，而这些领域的内核数并不太多(参见表2)。 </P>\r\n<P align=center><IMG alt=英特尔高级副总：未来五年计算将10倍速成长 src=\"../resource/img/h000/h00/img200509221507463757.jpg\" border=1></P>\r\n<P align=center>　　表2 英特尔处理器内核发展路线与所在市场规模 </P>\r\n<P>　　资料来源：基辛格提供 </P>\r\n<P>　　5年内与Unix一决高下 </P>\r\n<P>　　记者：IBM表示移植到Power处理器上的主机技术都是经过多年应用验证的技术，Intel如何将相应的新技术加入到处理器中？ </P>\r\n<P>　　基辛格：是的，我们也把主机上的一些技术移植到我们的产品中，比如说ECC、虚拟化技术等技术，我们将在预定年底推出的代号为Montecito的安腾处理器中的部分型号上采用这些技术。我们将在安腾和至强MP上集成主机的可靠性。 </P>\r\n<P>　　记者：Intel未来会不会采用微分区技术？ </P>\r\n<P>　　基辛格：在这一领域我们有一些能力。我们选择了与IBM不同的路线，未来我们将在这一领域提供一些与IBM现有的做法完全不同的功能。 </P>\r\n<P>　　记者：随着IA处理器的性能不断提高，你认为IA服务器与RISC服务器在性能上一决高下还需要多长时间？ </P>\r\n<P>　　基辛格：在服务器领域，我们有两个产品系列：安腾注重性能、扩展性和可靠性，至强则侧重于性能、性能价格比和性能功耗比。我们有能力让我们的客户在数据中心这样的应用上得到满意。几乎每家厂商都选择转向Intel架构，不管是至强还是安腾，或者两者兼备，NEC、富士通、日立、优利、布尔、SGI、HP，除了IBM和Sun。IBM一直很强大，未来5年在争夺数据中心的战役上，是IBM用专有的Power、专有的操作系统AIX和专有的中间件赢，还是基于工业标准的安腾和至强赢？每天我们都获得令我们干劲倍增的消息。 </P>\r\n<P>　　记者：去年上半年，IBM从发布全新的Power 5处理器到推出p5服务器和AIX 5.3操作系统，前后只有两三个月的时间。由于Unix市场的垂直划分，得以同步地引入新技术。 </P>\r\n<P>　　尽管PC市场的水平划分无疑对新技术的成熟十分有利，但在新技术的引入方面则是异步的，比如说从x86平台上第一个处理器诞生到微软推出64位的Windows操作系统，时间相距达两年之久，还不要说应用软件厂商的延迟。Intel有没有办法缩短这种延迟？ </P>\r\n<P>　　基辛格：我当然不能同意你的说法。垂直划分市场的技术进步要慢于水平划分市场，他们只是把技术捆绑在一起，然后进行阶梯式的跳跃。而水平划分的市场则持续地推动技术的进步，兼容性容许我们在水平划分的每一个层面引入新的技术。 </P>\r\n<P>　　在很短的时间里，垂直划分的产业可能领先，但总的来说，水平划分的产业一直领先，因为竞争加速了技术的进步。在OS层面我们有Windows、Linux、HP-UX、Solaris、现在还有了Apple OS，还有VMWare(虚拟机软件)，我们相信这些产品的竞争将会加速技术的进步，就像你刚才关心的虚拟化，我相信在英特尔的平台上未来会有丰富的虚拟化技术，这是因为水平系统的竞争和很多机会，而其中最重要的是性能价格比或者性能功耗比，这通常是我们取胜的关键因素。 </P>\r\n<P>　　苹果转向英特尔与微软选择IBM </P>\r\n<P>　　记者：我个人认为，苹果放弃IBM的Power处理器转而采用Intel的处理器，更多地是想利用Mac OS的优势，借助Intel处理器进入PC市场，进而通过与PC系统厂商乃至微软的竞争来获取市场份额以支撑公司的业绩。你认为苹果这样做的目的是什么？ </P>\r\n<P>　　基辛格：Apple的CEO Steve说，英特尔有非常强的产品线，主要体现在强大的性能上和多核路线图上。他还认为，与IBM相比，英特尔是更好的技术合作伙伴。 </P>\r\n<P>　　你知道，Apple是Power最大的合作伙伴，而且是服务器方面唯一的合作伙伴。Steve说，IBM的路线图要比英特尔的弱，所以，选择了英特尔。他并没有说市场、品牌或者其他原因。 </P>\r\n<P>　　记者：Steve的说法大家已经知道了，我想听听你的看法。 </P>\r\n<P>　　基辛格：首先，我同意Steve的观点。再者，我们有更好的工厂，更好的制造技术，更好的产品路线图。我认为，我们还可以向Apple提供其他的好处，比如说在全球市场销售方面。我想，Apple是一家非常有激情的、想要做非常棒的产品的公司，他们认为能在英特尔的架构上建造更好的产品。</P>\r\n<P>　　记者：有趣的是在苹果转向英特尔平台之前，微软的游戏机Xbox却从英特尔的PⅢ平台迁移到IBM的Power平台。至此，Sony、微软和任天堂等三大游戏厂家的平台都建立在Power之上，微软此举是出于兼容还是性能上的考虑？ </P>\r\n<P>　　基辛格：无疑，Power是一个好架构，好的产品。但微软在迁移过程中将会碰到很多麻烦，比如说，如何把已有的Xbox游戏翻译过来，还有兼容性方面的挑战，他们也无法将竞争力提升到与PC一样。 </P>\r\n<P>　　我想，微软选择IBM Power主要是因为这个平台定价很有竞争力，这样可以满足微软推出新一代游戏机时与价格能够匹配。等到明年这个产品推出市场时，我将怀着浓厚的兴趣看看它是如何表现的。 </P>\r\n<P>　　记者：今年年初，英特尔确立了从芯片供应商向硬件平台供应商转变的战略，加之摩尔定律带来的晶体管集成度的迅速提高，未来PC这种通用计算平台可以在多大程度上实现SOC(单芯片系统)？ </P>\r\n<P>　　基辛格：SOC未来会很重要，这是因为更高的集成度，可以将很多东西集成到芯片中。但这并不表明，可以将整个PC主板放到一个芯片上。因为存在很多约束原因，比如说，PC中有些技术的进步要比其他技术快很多，再如，有些是由标准驱动的，有些是由模拟技术驱动的。总之，你会看到PC中芯片的数量在不断地减少，但并不会变成一个芯片。未来，你会看到非常强的基于英特尔技术的SOC产品线，将提供更低的成本，更低的功耗和更小的外形尺寸，所有这些都得益于我们的SOC技术。 </P>\r\n<P>　　记者手记：摩尔定律的魅力 </P>\r\n<P>　　今年是摩尔定律40周年。40年来，集成电路产业的发展与摩尔的预测严丝合缝，应该说是任何产业从未有过的奇迹，而40年前摩尔仅凭几年的数据且在集成度只有数千个晶体管的情况下，能总结出这一影响力远远超出集成电路产业的经验公式，不能说不是一个神话。 </P>\r\n<P>　　很大程度上，与其说是摩尔精确地找到了半导体制造业的发展规律，还不如说是摩尔准确地预测了市场的需求。 </P>\r\n<P>　　“每18个月晶体管集成度提高1倍”的摩尔定律发现的是集成度与时间的正比关系。实际上，多少年来还存在着计算性能与时间的正比关系，这是市场或者说用户需求的使然。 </P>\r\n<P>　　当功耗已成为不可逾越的障碍使得单纯提升频率的捷径遭遇穷途末路时，用户的需求使得芯片产业做出了几十年来最大的改变——转向多内核。 </P>\r\n<P>　　当并行计算替代主频成为提升计算性能的主要途径，摩尔定律也就找到了“延年益寿”的良方。因为仅从集成度的提升看摩尔定律，那么，由于物理的原因，摩尔定律的有效期还有十几年，而从计算性能的提升来看，芯片级(多内核)与系统级(多处理器)构成的并行技术将会在更大的时间尺度上满足用户的需求。 </P>\r\n<P>　　不过，通过多内核技术来提升计算性能并不像通过提高主频的方式那样省事儿，而且会给软件厂商带来相当大的麻烦。但是，天大的麻烦也得克服，因为，用户的需求在那儿摆着呢。 </P>','','1127372867','','',1127372889,1127373095,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73150,'宽带用户首次超过拨号用户 窄带还能活多久','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t<p>　　文/李志国</p>\n\t\n\t<p>　　中国的互联网用户已经过亿，宽带用户首次超过了拨号用户，曾经在1999年和2000年无比辉煌的窄带接入是否已走入暮年？窄带，还有翻身的机会吗？ </p>\n<p>　　7月21日，中国互联网络信息中心(CNNIC)在京发布的“第十六次中国互联网络发展状况统计报告”显示，中国的宽带用户第一次超过了拨号用户数量，拨号用户数已经呈现略微下降的趋势。 </p>\n\n<p>　　报告显示，中国宽带上网用户人数为5300万人，同半年前的调查相比，宽带上网用户人数半年增加了1020万人，增长率为23.8%，和上年同期相比增长71.0%。宽带上网用户首次超过了拨号上网用户人数，并首次超过了网民的一半，达到51%。拨号上网用户人数为4950万人，同半年前的调查相比，拨号上网用户人数半年减少290万人，增长率为-5.5%，和上年同期相比下降4.0%。 </p>\n<p>　　“当1999年我们在做拨号接入时，有人说拨号最多还可以做两年，到2001年有人又说拨号还可以做两年，而到了2003年还有人说拨号还可以继续再做两年。今天，拨号上网仍是主流，但被宽带取代是必然的。”这是263网络集团总裁黄明生在2004年10月份告诉记者的话。也许，黄明生没有想到的是，仅仅过了不到一年的时间，中国的宽带用户就已经超过了拨号上网用户。 </p>\n<p>　　从1996年国内出现窄带业务，到1999年、2000年窄带接入迎来“辉煌岁月”至今，窄带接入业务终于开始步入暮年。 </p>\n<p>　　但是，一项技术的消亡并不是一朝一夕的事情，现在，虽然宽带用户超过了窄带，但是，拨号上网用户仍然具有4950万人，这些用户要全部转成宽带用户需要一定的时间，而且，价格、应用等多种因素也决定了窄带用户仍然会继续存在一段时间，我们不妨借用黄明生的口气说，“窄带，还可以再做两年”。 </p>\n<p>　　<strong>窄带也能满足用户需求</strong> </p>\n<p>　　调查结果显示，在各种网民的上网目的中，获取信息是37.8%的网民选择；仅次于将休闲娱乐作为上网最主要目的网民的37.9%，也有10.3%的网民上网是用来学习与知识浏览。而且，在互联网的八大热门服务(超过1/3比例的选项)依次是：电子邮箱、浏览新闻、搜索引擎、浏览网页(非新闻类)、在线音乐(含下载)、即时通讯、论坛/BBS/讨论组和在线影视(含下载)。新闻与非新闻类的网页浏览、搜索引擎、电子邮箱、即时通讯以及论坛/BBS这些互联网的基本功能与服务仍然占据着网民最主要的网上活动内容。这些应用窄带完全可以胜任，应用决定市场，网民的这些需求决定了窄带将不会在几年时间内消亡。 </p>\n<p>　　<strong>价格是窄带最大的竞争力</strong> </p>\n<p>　　如果我们注意到这次互联网调查报告中，用户的上网费用就会发现，网民每月实际花费的上网费用(仅限于上网接入费用及上网电话费，不包括使用网络服务的费用)低于50元的最多，所占比例达到37.9%；其次是花费51～100元的网民，占31.2%；20.8%的网民每月花费的上网费用在101～200元；每月花费超过200元的网民只占10.1%。网民每月实际花费的上网费用主要集中在100元及以下。但是，据了解，目前全国宽带的包月费用基本都在50元以上，北京、上海等大城市的包月费用更是超过了100元。 </p>\n<p>　　<strong>网民每月上网费用分布</strong> </p>\n<p>　　而窄带的价格则大大低于宽带的费用，263网络集团就曾经推出了一个120元包年的套餐计划。 </p>\n<p>　　如果与近几次调查结果相比，我们就可以看出这样一个现象，每月上网花费在100元以下的网民比例继续增加，此次增幅为0.7%，达到69.1%，而每月上网花费超过100元的网民比例则继续降低，此次为30.9%。一方面是宽带用户的增加，窄带用户的减少，一方面是用户上网平均费用的降低，这种现象有点类似于移动通信的ARPU值变化——当用户数量发展到一定程度以后，新增加的用户多为低端用户，他们在选择接入方式的时候更具备多元性。而且，与国际上相比，中国的互联网普及率仍然很低。据统计，今年7月份全球网民数量是9.28亿，宽带用户1.5亿，全球平均普及率是14.5%，美国是67.8%，中国才7.9%，日本已经达到了60.6%，韩国是63.3%。所以说中国网民的数量虽然很大，增长空间还是非常大的，窄带用户数量出现反弹也不是没有可能。 </p>\n<p>　　<strong>乡村是窄带新市场</strong> </p>\n<p>　　失之桑榆 收之东隅。中国最广大的人口是在农村，窄带上网在逐渐被宽带挤出城市市场的同时，也有可能在农村市场重新焕发青春。因为，至少有三个因素在使这种可能变成必然。 </p>\n<p>　　其一，农村电信市场的发展。 </p>\n<p>　　目前，信息产业部正在大力推进农村电信的建设。2004年1月，《农村通信普遍服务试行方案》出台，以分片包干为特征的“村通工程”开始试点。 2004年8月，信息产业部宣布“村通工程”第二阶段试点正式启动，四大运营商各自又有了新的“责任田”。 2004年，信息产业部颁发《农村通信普遍服务——村通工程实施方案》明确规定：村村通工程的基本目标是在2005年底，全国至少有95%的行政村开通电话，2004年底则完成全部目标的40%左右。与此相对应的是，农村市场的互联网服务更是少的可怜。 </p>\n<p>　　其二，PC厂商开拓农村市场的战略。 </p>\n<p>　　联想和戴尔都先后推出了售价为2999元的乡村电脑，开始大力开拓广大的农村市场。杨元庆认为，美国2亿人口的电脑年销售量在4000万台左右，而中国13亿人口的电脑年销售量却只有1000万台，这是因为中国有一个很大的“冻土层”存在，中国电脑市场必须打破这个“冻土层”。PC市场重心从大中型城市向乡镇地区市场转移已经是不可逆转的形式，而后者将成为中国电脑市场未来5年内的主要增长点。 </p>\n<p>　　而现在是网络时代，不联网的计算机根本就体现不出自己的价值。很显然，电脑厂商在农村市场的成功，必将会带来网络用户的高速增长。我们也可以从非网民的原因上，看出电脑对网民数量的影响程度。 </p>\n<p>　　本次调查结果显示，非网民不上网的主要原因有：不懂电脑/网络，46.7%的非网民选择；没有上网设备，19.1%的非网民选择；没时间上网，17.7%的非网民选择；觉得上网没用/不需要，8.1%的非网民选择；认为上网费用贵，7.5%的非网民选择。可见，不懂电脑/网络是影响我国非网民不上网的最主要因素。 </p>\n<p>　　其三，宽带在农村市场的不可行性。 </p>\n<p>　　目前，如果在中国的农村市场发展宽带网络，几乎是不可能的。首先，从技术上讲，除了使用卫星之外，如果使用ADSL，超常的铜线就会让“宽带”变的比“窄带”还不如。而光纤到户等其它技术更是天方夜谭。窄带技术“落后”的另一面正是其网络的“成熟”，它在接入的便利性方面有着无可比拟的优势。我们甚至可以将拨号接入称之为“有线的移动”，在电信和网通铺开的坚实而且无处不在的固话网里，拨号接入有着更大的机动性和更广阔的区域，可以在有线网络里自由移动。 </p>\n<p>　　另外，相对于宽带的费用，窄带的价格对于乡村市场具有更大的吸引力。所以，可以说，窄带上网几乎是农村网民的唯一选择。 </p>\n\t\n\t\t\n','','中国计算机报','',NULL,1126758497,1126758497,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73146,'上海移动市话每分0.12元 资费大战一触即发','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　据上海青年报报道　新一轮的移动资费战正在向上海市场蔓延，继北京移动和北京联通的激烈对抗之后，上海移动通信市场的战火已经到了一触即发的地步。两大移动通信商的博弈正在上演。上海移动在继“29”、“39”套餐之后，再次出招亮出了“60”的牌，而此次拿全球通开刀的“60”套餐被竞争对手视之为“洪水猛兽”。隐忍待发的上海联通一边呼吁不要原始的价格战，一边开始了备战，应对方案已经出炉，只等一声令下就开始上市。</p>\n\n\n<p>　　移动：“60”套餐最具杀伤力</p>\n\n<p>　　没有新闻通告，而是通过大面积的广告攻势和渠道攻势，上海移动悄然发力。“全球通60”套餐，几日之内全城皆知，在几乎所有的上海移动用户都关注这一套餐的同时，其直接竞争对手上海联通却更为紧张。</p>\n\n<p>　　记者了解到，此次上海移动的“60”套餐达到了套餐内最低0.15元/分钟和套餐外最低0.12元/分钟的“实在”优惠。在此次接招之前，北京移动通信市场的战火已经燃起，在业内人士的眼里，北京和上海两大市场的资费战一脉相承。</p>\n\n<p>　　联通：不希望进行原始价格战</p>\n\n<p>　　“我们已经针对移动的‘60’套餐制订了一套方案，目前已经准备完毕。”上海联通总经理助理薛金福对记者表示。让上海联通此次隐忍待发的一个重要原因则是一个被封存已久的“竞合架构”，即联通的G网资费要比移动的资费低10%～15%，CDMA网资费与移动持平，CDMA1X网资费高于移动10%。</p>\n\n<p>　　而在双方总部要求“取消网内外差别定价”方案之后，上海移动针对高、中、低端市场的全面资费下调方案出台，上半年协商多时的竞合架构自然失去了意义。这是双方始料未及的。</p>\n\n<p>　　主管部门：应制止短视价格战</p>\n\n<p>　　作为主管部门，上海通信管理局市场监管处负责人认为，上海原有的相对健康、良性的资费市场是来之不易的。他表示，对于目前两大移动运营商的资费调整一定要看双方的动机、调整过程和结果，如果是仅仅针对竞争对手的、短视的利己主义的价格战是应该受到制止的。\n</p>\n\n\t\n\t\t\n','','1124443591','',NULL,1126758497,1126758497,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73147,'面对重组运营商身不由己 老百姓还是看价格问题','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　通信世界网 刘兵</p>\n<p>　　8月1日，又一轮电信重组传言落空。</p>\n<p>　　7月25日，一则被认为是电信重组方案\"终结版本\"的消息以短信、MSN等方式在中国移动浙江、四川、深圳等分公司员工内部流传。该消息原文为：\"电信的改革方案即电信重\n组方案已敲定，基本三分天下：移动＋卫通=中国移动；拆分联通G网和C网，南北拆分铁通，联通C网＋电信＋北铁通=中国电信；联通C网＋网通＋南铁通=中国联通；该方案已送国务院审批完毕，定于8月1日宣布。\" 8月1日此传言不攻自破。</p>\n<p>　　今年的4月份，国资委主任李荣融表示，\"电信业肯定要重组，不过不是简单的四合二或者几合二，或者说拆分联通\"。李荣融说，我国电信企业目前有6家，存在重复投资等问题，不利于电信业发展，同时对接下来的3G发展不利。所以，国资委正在积极研究如何将资源配置好。</p>\n<p>　　在3G服务正式推出之前，中国电信产业将进行大规模重组。于是关于重组的传言一直困扰着运营商。</p>\n<p>　　自从原中国电信拆分到现在，运营商的命运似乎一直都不得消停，面对重组，运营商们身不由己。前一次重组，小网通合并了，吉通消失了，后来又诞生了铁通，卫通，下一波重组不知又会是谁生谁灭。</p>\n<p>　　重组有重组的好处，但重组也是有代价的。刚刚过去的几天内，网通国际的重组已经给大家提供了一个范本，700名员工的去留引起了不小的震动，相比而言，六大运营商员工总数接近80万，单单人员的重组就是一个不小的挑战。</p>\n<p>　　据报道，中国电信产业的不确定性导致国外投资者在购买网通股份时逡巡不前。中国网通CEO田溯宁称，目前西班牙的Telefónica公司是唯一一家有\"勇气\"投资网通的国际电信公司。在此前，网通还曾经同新加坡电信、韩国电信以及日本的NTT等多家公司进行过谈判，但并没有达成一致。他说：\"这些厂商对于中国电信产业重组带来的不确定性心存顾虑，因此没有足够的\'勇气\'投资网通。当然这只是我个人的判断，但我想应该是一个重要的原因。在投资之前，投资者必须仔细衡量自身能否承担风险。\"面对重组，运营商有几多无奈。什么时候运营商有多一点自主权。</p>\n<p>　　为了避免重复建设而重组，其实重复建设不是一件完全的坏事，适度的重复建设是充分竞争的前提，充分竞争是市场需要的，毕竟现在的老百姓更多关心的是价格的问题，据我看来，目前电信市场的价格还是大有竞争空间的，电信资费还远没有达到合理的地价位。</p>\n<p>　　当然，关于重组的问题还是交于发改委们去考虑，老百姓更关心的是柴米油盐，其次才是通信，上网之事。如果回到“牛三斤”时代，也许并不是一件坏事，“费墨”先生不是逃到一个没有现代通信的国度去跺清静去了吗？(刘兵) </p>\n\t\n\t\t\n','','1124443591','',NULL,1126758497,1126758497,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73144,'诺基亚新增COO职位 康培凯今明年两次履新','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　天极网8月2日消息(记者 于艺婉)今天，诺基亚中国公司已经证实了中国公司董事长康培凯(Olli-Pekka Kallasvuo)将于明年6月1日接替约玛·奥利拉出任诺基亚公司CEO。同时，康培凯还将于今年10月1日就任公司总裁兼COO，诺基亚现任总裁佩卡阿拉·皮埃迪拉也将因“个人原因”于明年2月1日离任。</p>\n<p>　　在此次任命中，诺基亚新设了COO职位，据了解，诺基亚公司以往并未出现过该岗位。\n</p>\n<p>　　在今年2月底诺基亚在华20周年的庆典上，诺基亚公司董事长兼CEO约玛·奥利拉携管理层共同亮相，公司执行副总裁康培凯也位列其中，今年初他刚刚出任诺基亚中国公司董事长。2004年1月，他接受了移动电话事业部总经理的任命，他也曾有过长达10年的首席财务官经历。</p>\n<p>　　记者向诺基亚中国公司人士征询康培凯现有职位将做如何调整，对方表示目前还没有明确说法。</p>\n<p>　　去年底，约玛·奥利拉曾表示自己的任期将于今年秋天结束。诺基亚人士对于其2006年6月方离任的说法解释为：“从今年10月1日，康培凯是公司的总裁兼COO。他已经开始接手奥利拉的部分工作，只不过，CEO的任命要到明年6月。”</p>\n<p>　　康培凯在诺基亚已经工作了25年，也一直是公司的核心领导之一，分析人士称，他的上任不会使约玛·奥利拉原有的既定方针发生太大的变化。</p>\n<p>　　去年底，诺基亚首席战略官马蒂·奥拉胡塔、网络部门主管萨利·巴尔道夫女士和网络部全球业务主管居卡·伯格奎斯特相继辞职，当时诺基亚表示，人事变动并不都是坏事，它将使管理团队重新焕发活力。</p>\n<p>　　54岁的奥利拉在辞去诺基亚董事长兼CEO的职务，仍担当公司的非执行董事长。目前，诺基亚还未就2006年6月1日后公司董事长的任命进行说明。(完) </p>\n<p>&nbsp;　 <strong>相关报道：</strong></p>\n<p>&nbsp;　 </p>\n\t\n\t\t\n','','1124443593','',NULL,1126758496,1126758496,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73145,'高速宽带风暴席卷欧洲市场','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t\n\t\n\t<p>　　作者： 葛雅莉 </p>\n\n<p>　　【简　介】</p>\n\n<p>　　导语：从波克夏到柏林，人们纷纷接入宽带，欧洲的欧洲用户正在飞快地增长。宽带业务，不仅给欧洲电信业带来了福音，推动了互联网相关产品的勃勃发展。同时，宽带业\n务也正在悄悄地改变着欧洲人的工作、生活习惯。宽带，正在欧洲掀起一场“可怕”的风暴。  </p>\n\n<p>　　【eNet硅谷动力专稿】据普华永道的统计分析，2004年，西欧地区宽带用户人数增加了1400万，目前宽带总人数已达到了4400万，这比美国的宽带用户要多。在欧洲家庭，约有25%的拉入了高速宽带，宽带规模已相当巨大。位于伦敦的研究机构Ovum的分析师Charlotte Davies称，“宽带已成为欧洲的主流”。 </p>\n\n<p>　　宽带业务已成为欧洲的一个巨大市场，普华永道预测，2005年，欧洲用户用于有线和DSL接入的费用可达240亿美元，而到2008年会提高到420亿美元。更为重要的是，宽带将会成为网络经济的加速器。位于伦敦的大陆研究公司称，当英国用户从拔号向宽带升级时，有一半人的人是用于下载音乐、使用及时通讯或是在线拍买等活动。同时，在线广播和在线游戏的用户人数也增加了三倍多。约有四分之一的拔号上网用户在线购书和DVD，而宽带用户进行在线购物的人数也攀升了40%。雅虎欧洲部门的负责人Nick Hazell称：“宽带改变了用户的购物习惯，过去不可能的，今天已变为了现实。” </p>\n\n<p>　　宽带用户人数的增加，使欧洲各大公司受益良多。比如德国电信和英国电信的DSL订户人数增长速度远远超过了他们的预期。比如，法国电信，一内年DSL订户人数增长了65%，今年3月就达到了340万人，财季宽带业务收入达到了4.1亿美元。在荷兰，家庭宽带用户达到了47%。市场领头羊KPN公司第一季度的DSL收入同比增长了51%，达到了1.31亿美元。 </p>\n\n<p>　　宽带效应对专门从事音乐、游戏和赌博等数码内容和服务的公司产生了戏剧性的影响。Photoways公司，是欧洲最大的在线图像打印服务公司，该公司的CEO Michel de Guilhermier称：“没有宽带，就没有Photoways。”他指出，公司约98%的用户是宽带用户。几年前，公司最忙的一天是周一，那一天，用户都在办公室上传周末拍摄的照片。而现在，家庭宽带极为普遍，上网的高峰期为周日晚上。他透露，公司2004年的收入增长了三倍，今年的增长也会是如此。 </p>\n\n<p>　　同时，在线音乐网站的销售收入也创历史新高。拿德国电信公司的T-Online来说，其Musicload服务已有客户150万人，每个月的下载量超过了100万次。苹果电脑公司的iTunes音乐服务，已在欧洲的16个国家推广。今年6月，欧洲用户通过雅虎的新流媒体音乐服务，下载了1400万首歌曲。市场研究机构Forrester预测，到2008年，欧洲市场的在线音乐业务将达24亿美元的规模。eLabs组织的副总裁Barney Wragg称：“我们们意识到，接入视频流媒体的用户人数正在迅速上升。”</p>\n\n<p>　　此外，高速宽带接入正在改变着欧洲人的生活交流方式。当用户使用宽带时，他们都会使用互联网语音电话服务进行交流。Skype技术公司，主要提供从PC到PC的免费语音服务，目前，其在全球的订户已达到了4700万人，其中有82%的订户是宽带用户。Skype的竞争对手、美国的Vonage于今年5月在英国推出了月租为17.50美元的全时段语音电话服务。诸如英国电信、法国电信等运营商开始在服务中推出了打包的VoIP服务，对阻止传统语音服务的渗透。据市场研究机构IDC的分析，到2008年，欧洲市场的网络电话规模将达到42亿美元。普华永道门罗公园市欧洲技术中心的主管GregH. Garrison称：“宽带业务将成为电信业的杀手锏”。 </p>\n\n<p>　　此外，宽带业务也推出了电子商务的发展。eBay公司英国分公司的分类业务主管Richard </p>\n\n<p>　　Ambrose称，登陆eBay网站的宽带用户消费是其它用户的两倍多。而最主要的动力是丰富的图像和声音片断。有些网站提供3D图像，比如在英国的findaproperty.com上提供虚拟财产旅行业务。位于意大利米兰的Yoox.com则出售打折的时尚服装，允许用户进行定制。该网站的CEO Gabriele Tazzari称，用户十分喜爱这种交互式的活动。 </p>\n\n<p>　　这种交互式的活动，也推动了在线广告业务的发展。电影分销商、电话公司、汽车制造商以及其它的公司，利用宽带的高速优势，在旗帜广告中加入了动画、音乐甚至是视频内容。据DoubleClick公司2004年的统计发现，“富媒体”旗帜广告的点击率是静态广告点击率的近两倍多。i-Level PLC公司的战略主管 EdLing称：“富媒体广告的点击率之高，令人吃惊。”他指出，目前，交互式广告仅占在线广告的10%。普华永道预测，到2008年，宽带的加速普及将使欧洲的在线广告收入达到80亿美元。 </p>\n\n<p>　　下一波的发展甚至更加猛烈，更具破坏力。宽带用户开始建立自己的富媒体，从视频博客到播客等。在几年内，娱乐和通讯业务将会发生戏剧性的变化。</p>\n\n\t\n\t\t\n','','1124443592','',NULL,1126758496,1126758496,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73143,'重庆中学生发现移动梦网付费漏洞','','','','','','\n\n\n\n\t\n\t\n\t\n\t\n\t<p>　　文/罗 嘉</p>\n\t\n\t<p>　　本报讯  育才中学的马同学向本报反映，他发现移动公司的梦网上网业务有漏洞，按其发现的方式操作可破解收费程序，实现免费上网。</p>\n\n<p>　　昨天上午，小马给记者演示了发现漏洞的过程：登陆移动梦网，进入“爱情水晶球”(包月收费点播页面)，页面显示，如需订制请按确定，5元包月；然后点击该页面下方的“梦网页面”，回到首页，再按返回键，这样就又回到了“爱情水晶球”收费页面，将其保存\n到书签(相当于电脑网页的收藏夹)。</p>\n\n<p>　　下面是最关键的一步：打开书签，对显示的网址进行修改，将第二个http之前的字符全部删除，然后保存，再从保存的书签进入，手机屏立刻显现“爱情水晶球”网页内容(该内容只有定制用户才能看到)。</p>\n\n<p>　　马称，从上周发现这一漏洞后，试用过多次，每次进入后，上网定制收费提示和进入1861查询均未有收费记录。据介绍，该方法是前不久从网友的帖子中学到的，对大多数手机和收费网页适用。但也有不灵验时，比如他曾用一款TCL手机试过，但未获成功。</p>\n\n<p>　　马同学表示，发现这一收费漏洞后，他并未向外宣扬，他希望通过本报提醒移动公司及时修补该漏洞。</p>\n\n<p>　　记者随后将此情况向重庆移动客服热线1860反映，工作人员表示立即进行调查。\n</p>\n\n\t\n\t\t\n','','1124443593','',NULL,1126758496,1126758496,1,1,0,0);
INSERT INTO {$table_header}content_1 VALUES (73207,'test111111111111111111111','','','','','','<IMG alt=\"\" src=\"../resource/img/h000/h00/3c24e648e713da6946d4d4b9045b2c3d.jpg\" border=0> ','','','','',1127703636,1127703684,1,1,1,3);



DROP TABLE IF EXISTS {$table_header}content_2;

CREATE TABLE {$table_header}content_2 (
  `ContentID` int(10) NOT NULL auto_increment,
  `CreationDate` int(10) NOT NULL default '0',
  `ModifiedDate` int(10) NOT NULL default '0',
  `CreationUserID` int(8) NOT NULL default '0',
  `LastModifiedUserID` int(8) NOT NULL default '0',
  `ContributionUserID` int(8) NOT NULL default '0',
  `ContributionID` int(10) NOT NULL default '0',
  `SoftName` varchar(250) NOT NULL default '',
  `SoftSize` varchar(15) NOT NULL default '',
  `Language` varchar(10) NOT NULL default '',
  `SoftType` varchar(50) NOT NULL default '',
  `Environment` varchar(50) NOT NULL default '',
  `Star` int(2) NOT NULL default '0',
  `Developer` varchar(250) NOT NULL default '',
  `SoftKeywords` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `Download` text NOT NULL,
  `Photo` varchar(250) NOT NULL default '',
  `LocalUpload` varchar(250) NOT NULL default '',
  `CustomSoftLinks` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`ContentID`)
) TYPE=MyISAM;



INSERT INTO {$table_header}content_2 VALUES (103,1126758899,1126758899,1,1,0,0,'迷你系统工具箱 1.48','3359KB','简体中文','免费版/系统设置','Win9x/Me/NT/2000/XP',4,'http://www.microsword.net','','&nbsp;&nbsp;&nbsp;&nbsp;迷你系统工具箱是一款小巧的系统增强工具软件。它能进行系统优化设置、IE设置修复、系统和文件夹个性化设置，管理自启动程序等等。您不妨下载试试^_^  ','http://sq5.onlinedown.net/down/SysTools148.exe\rhttp://hld.onlinedown.net/down/SysTools148.exe\rhttp://wh.onlinedown.net:82/down/SysTools148.exe\rhttp://ftpwh.onlinedown.net:82/down/SysTools148.exe\rhttp://nc.onlinedown.net/down/SysTools148.exe\rhttp://sx.huajun.net/files/SysTools148.exe\rhttp://lctt.onlinedown.net/down/SysTools148.exe\rhttp://sccrc2.onlinedown.net:82/down/SysTools148.exe\rhttp://gzcnc.onlinedown.net:82/files/SysTools148.exe\rhttp://sccnc.onlinedown.net/down/SysTools148.exe\rhttp://cttnb.onlinedown.net/down/SysTools148.exe\rhttp://hecz.onlinedown.net/down/SysTools148.exe\rhttp://hbcrc.onlinedown.net:82/down/SysTools148.exe\rhttp://hld165.onlinedown.net/down/SysTools148.exe\rhttp://ctttl.onlinedown.net:82/down/SysTools148.exe\rhttp://wznetcom.onlinedown.com:81/down/SysTools148.exe\rhttp://zj.onlinedown.net:82/down/SysTools148.exe\rftp://cnc:10060@221.12.150.27/SysTools148.exe\rftp://cnc:10060@soft.10060.tv/SysTools148.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/SysTools148.exe\rhttp://ctttl.onlinedown.net:8080/down/SysTools148.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (104,1126758900,1126855598,1,1,0,0,'Windows Power Tools 5.0.2005','5524KB','英文','共享版/系统辅助','Win9x/Me/NT/2000/XP',4,'http://sensor.hypermart.net/','','　　包括了5个非常有用的系统工具: HyperWindows, HyperNet, Security Toolkit, Quick-Accelarator和RAM-Magnifier。HyperWindows：可以让你对系统进行优化从而使之运行地更快。HyperNet：提供了多种网络设置，使你的浏览、下载速度更快。 Security Toolkit：增强了系统的安全性，提供了多种安全设置。Quick-Accelerator：增强了系统启动速度。RAM-Magnifier：这个工具可以帮你改善内存使用状况，提高系统的稳定性。 ','http://www.dmisoftware.com/drptools.exe\nhttp://sq5.onlinedown.net/down/drptools.exe\nhttp://hld.onlinedown.net/down/drptools.exe\nhttp://wh.onlinedown.net:82/down/drptools.exe\nhttp://ftpwh.onlinedown.net:82/down/drptools.exe\nhttp://nc.onlinedown.net/down/drptools.exe\nhttp://sx.huajun.net/files/drptools.exe\nhttp://lctt.onlinedown.net/down/drptools.exe\nhttp://sccrc2.onlinedown.net:82/down/drptools.exe\nhttp://gzcnc.onlinedown.net:82/files/drptools.exe\nhttp://sccnc.onlinedown.net/down/drptools.exe\nhttp://cttnb.onlinedown.net/down/drptools.exe\nhttp://hecz.onlinedown.net/down/drptools.exe\nhttp://hbcrc.onlinedown.net:82/down/drptools.exe\nhttp://hld165.onlinedown.net/down/drptools.exe\nhttp://ctttl.onlinedown.net:82/down/drptools.exe\nhttp://wznetcom.onlinedown.com:81/down/drptools.exe\nhttp://zj.onlinedown.net:82/down/drptools.exe\nftp://cnc:10060@221.12.150.27/drptools.exe\nftp://cnc:10060@soft.10060.tv/drptools.exe\nftp://wzcnc:wzcnc@onlinedown.wzcnc.com/drptools.exe\nhttp://ctttl.onlinedown.net:8080/down/drptools.exe','../resource/img/h000/h00/img200509161526350.jpg','','','');
INSERT INTO {$table_header}content_2 VALUES (105,1126758900,1126855503,1,1,0,0,'金山毒霸 -引擎病毒库升级包 09.14','3609KB','简体中文','共享版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.duba.net/download/','','金山毒霸除网镖和旧版试用版外所8有版本-引擎病毒库升级包.. ','http://download.duba.net/download/downloadupdate/KS050914.EXE\nhttp://sq.onlinedown.net:82/down/KS050914.EXE\nhttp://wh.onlinedown.net:82/down/KS050914.EXE\nhttp://ftpwh.onlinedown.net:82/down/KS050914.EXE\nhttp://hlbr.onlinedown.net/files3/KS050914.EXE\nhttp://nc.onlinedown.net/down/KS050914.EXE\nhttp://sx.huajun.net/files/KS050914.EXE\nhttp://lctt.onlinedown.net/down/KS050914.EXE\nhttp://sccrc2.onlinedown.net:82/down/KS050914.EXE\nhttp://gzcnc.onlinedown.net:82/files/KS050914.EXE\nhttp://sccnc.onlinedown.net/down/KS050914.EXE\nhttp://crc.onlinedown.net:82/files/KS050914.EXE\nhttp://cttnb.onlinedown.net/down/KS050914.EXE\nhttp://jsnetcom.onlinedown.com/down/KS050914.EXE\nhttp://hld165.onlinedown.net/down/KS050914.EXE\nhttp://ctttl.onlinedown.net:82/down/KS050914.EXE\nhttp://wznetcom.onlinedown.com:81/down/KS050914.EXE\nhttp://zj.onlinedown.net:82/down/KS050914.EXE\nftp://cnc:10060@221.12.150.27/KS050914.EXE\nftp://cnc:10060@soft.10060.tv/KS050914.EXE\nftp://wzcnc:wzcnc@onlinedown.wzcnc.com/KS050914.EXE\nhttp://ctttl.onlinedown.net:8080/down/KS050914.EXE','../resource/img/h000/h00/img200509161525000.jpg','','','');
INSERT INTO {$table_header}content_2 VALUES (106,1126758900,1126758900,1,1,0,0,'飞鹰单据/票据/支票打印系统 3.0','1573KB','简体中文','共享版/打印工具','Win9x/Me/NT/2000/XP',4,'http://fly-eagle.nease.net/','','飞鹰软件工作室开发的通用单据打印程序，适用于各行业进行各类单据的打印，程序具有简单易用的特点，打印单据的参数一经设定可永久使用，由用户自定义打印内容、打印位置、字体、字体大小、字体颜色、每行打印数等参数，在实际使用过程中也可以方便重设打印参数。<br>\n为方便广大用户的使用，系统支持多套打印参数，在打印时根据打印单据的类型选择不同的单据即可，真正实现人性化的单据打印过程。<br>\n本系统支持打印参数的导出，同时支持打印数据的管理，在已建立数据库的情况下，打印完毕的数据将会自动写入数据库，用户可任意处理打印数据，并能按表格方式打印输出。  ','http://fly-eagle.nease.net/Res/flytable-setup.exe\rhttp://sq5.onlinedown.net/down/flytable-setup.exe\rhttp://hld.onlinedown.net/down/flytable-setup.exe\rhttp://wh.onlinedown.net:82/down/flytable-setup.exe\rhttp://ftpwh.onlinedown.net:82/down/flytable-setup.exe\rhttp://nc.onlinedown.net/down/flytable-setup.exe\rhttp://sx.huajun.net/files/flytable-setup.exe\rhttp://lctt.onlinedown.net/down/flytable-setup.exe\rhttp://sccrc2.onlinedown.net:82/down/flytable-setup.exe\rhttp://gzcnc.onlinedown.net:82/files/flytable-setup.exe\rhttp://sccnc.onlinedown.net/down/flytable-setup.exe\rhttp://cttnb.onlinedown.net/down/flytable-setup.exe\rhttp://hecz.onlinedown.net/down/flytable-setup.exe\rhttp://hbcrc.onlinedown.net:82/down/flytable-setup.exe\rhttp://hld165.onlinedown.net/down/flytable-setup.exe\rhttp://ctttl.onlinedown.net:82/down/flytable-setup.exe\rhttp://wznetcom.onlinedown.com:81/down/flytable-setup.exe\rhttp://zj.onlinedown.net:82/down/flytable-setup.exe\rftp://cnc:10060@221.12.150.27/flytable-setup.exe\rftp://cnc:10060@soft.10060.tv/flytable-setup.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/flytable-setup.exe\rhttp://ctttl.onlinedown.net:8080/down/flytable-setup.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (107,1126758901,1126758901,1,1,0,0,'Aimini P2P 1.6.3.3','2401KB','英文','共享版/文件管理','Win9x/Me/NT/2000/XP',4,'http://www.aimini.com/','','    多功能的文件共享与信息交流软件，P2P(peer-to-peer)点对点搜索和下载用户共享的所有类型的文件，用户之间能够直接进行连接，能够快速和简便的传输和操作异地文件，朋友之间通过高质量的音频和视频进行聊天，个人之间可以根据供求信息进行物品交换。本软件还能为各类资源厂商提供安全和高效的分发服务。 另外，本软件还包含了一个很酷的地址簿和一个很好的FTP客户工具。  ','http://www.aimini.net/download/setup_cns.exe\rhttp://sq5.onlinedown.net/down/setup_cns.exe\rhttp://hld.onlinedown.net/down/setup_cns.exe\rhttp://wh.onlinedown.net:82/down/setup_cns.exe\rhttp://ftpwh.onlinedown.net:82/down/setup_cns.exe\rhttp://nc.onlinedown.net/down/setup_cns.exe\rhttp://sx.huajun.net/files/setup_cns.exe\rhttp://lctt.onlinedown.net/down/setup_cns.exe\rhttp://sccrc2.onlinedown.net:82/down/setup_cns.exe\rhttp://gzcnc.onlinedown.net:82/files/setup_cns.exe\rhttp://sccnc.onlinedown.net/down/setup_cns.exe\rhttp://cttnb.onlinedown.net/down/setup_cns.exe\rhttp://hecz.onlinedown.net/down/setup_cns.exe\rhttp://hbcrc.onlinedown.net:82/down/setup_cns.exe\rhttp://hld165.onlinedown.net/down/setup_cns.exe\rhttp://ctttl.onlinedown.net:82/down/setup_cns.exe\rhttp://wznetcom.onlinedown.com:81/down/setup_cns.exe\rhttp://zj.onlinedown.net:82/down/setup_cns.exe\rftp://cnc:10060@221.12.150.27/setup_cns.exe\rftp://cnc:10060@soft.10060.tv/setup_cns.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/setup_cns.exe\rhttp://ctttl.onlinedown.net:8080/down/setup_cns.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (108,1126758901,1126758901,1,1,0,0,'Cache View 2.6.01','1461KB','英文','共享版/系统辅助','Win9x/Me/NT/2000/XP',4,'','','&nbsp;&nbsp;&nbsp;&nbsp;察看Netscape、Mozilla、IE缓存文件的工具。你可以打开缓存的文件，察看、复制或从缓存中删除他们，它可以为你重建文件名称和目录结构。可以将缓存列表导出到CSV格式文件。  ','http://www.progsoc.uts.edu.au/~timj/cv/dl/cview260.zip\rhttp://sq5.onlinedown.net/down/cview260.zip\rhttp://hld.onlinedown.net/down/cview260.zip\rhttp://wh.onlinedown.net:82/down/cview260.zip\rhttp://ftpwh.onlinedown.net:82/down/cview260.zip\rhttp://nc.onlinedown.net/down/cview260.zip\rhttp://sx.huajun.net/files/cview260.zip\rhttp://lctt.onlinedown.net/down/cview260.zip\rhttp://sccrc2.onlinedown.net:82/down/cview260.zip\rhttp://gzcnc.onlinedown.net:82/files/cview260.zip\rhttp://sccnc.onlinedown.net/down/cview260.zip\rhttp://cttnb.onlinedown.net/down/cview260.zip\rhttp://hecz.onlinedown.net/down/cview260.zip\rhttp://hbcrc.onlinedown.net:82/down/cview260.zip\rhttp://hld165.onlinedown.net/down/cview260.zip\rhttp://ctttl.onlinedown.net:82/down/cview260.zip\rhttp://wznetcom.onlinedown.com:81/down/cview260.zip\rhttp://zj.onlinedown.net:82/down/cview260.zip\rftp://cnc:10060@221.12.150.27/cview260.zip\rftp://cnc:10060@soft.10060.tv/cview260.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/cview260.zip\rhttp://ctttl.onlinedown.net:8080/down/cview260.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (109,1126758901,1126758901,1,1,0,0,'安铁诺防病毒软件网络版 1.0','37242KB','简体中文','共享版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.sanlen.com','','&nbsp;&nbsp;&nbsp;&nbsp;安铁诺病毒防御体系（网络版杀毒软件）采取主动式的防御模式，在网络中建立完整的，覆盖从服务器端到个人终端的所有安全节点的监控网络，同时将这些节点置于安全中心的控制下，采取集中控制，分布处理的模式。其独创的网络控制功能，防止病毒的交叉感染，将疫情置于可控范围之内，将病毒对企业的冲击降至最小。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;四大优势：<br>\n&nbsp;&nbsp;&nbsp;&nbsp;知病毒自动联防系统，一体化防范体系在网域内, 若某一节点检测到未知病毒, 则此节点立刻向其它节点发出通知, 并附加自动提取的未知病毒信息.使新的节点能更早检出该病毒。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;局域网内的协同杀毒，杜绝网络交叉感染。协同杀毒遏制病毒在局域网中的泛滥, 同时解决了令人头疼的交叉感染问题。此问题常导致许多公司中断生产，例如尼姆达病毒曾造成大面积的网域瘫痪。工作站在收到协同杀毒指令以后，立刻切断自己和局域网的连接，然后进行后台杀毒，确保本机完全清除病毒以后，再将自己连入局域网。从宏观上，最大可能地抑制了病毒传播，杜绝了交叉感染。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;大容量,基于协作的网络防毒子系统。最大支持57600个工作站节点和1024台服务器的协防网域系统，杜绝病毒自由扩散。加强防毒管理。并使全网整体更新升级，安装包的分发轻而易举。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;实时工作环境保护，保障工作连续性。发现病毒时，拦截并控制病毒，同时找出病毒来源并切断该来源(邮件发送者，不良网站，网上邻居，光盘，软盘，下载站点)，杜绝后续的侵扰，执行后台杀毒，然后给出详细报告。保证用户工作的连续性，公司的工作秩序不被侵扰，不因为杀毒而中断。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;三大核心理念：<br>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;层次化：纵深病毒防御，整体防御体系。安铁诺病毒防御体系着眼于企业整体病毒解决方案，对于企业的安全来讲，安全的强化应该是全面的，任何节点的脆弱都将导致系统整体的不安全性。安铁诺病毒防御体系包含了三个主要层次，网关级防御中心，服务器病毒防御，客户端病毒防御。我们对于网络各节点的安全，尤其是网络数据输入输出端的安全做了最大的强化，部署在网络各节点的神经敏感系统实时监控数据流量，同时过滤易受病毒感染的电子邮件系统和WEB服务。采用安铁诺先进的病毒清除引擎，彻底阻断病毒的传播趋势，最大化网络安全状态。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;集中化：集中管理，分布式实施。网络管理员通过移动控制台，只需一台计算机，就可以在网络中的任何位置实施对全网终端的防御体系控制，监控全网安全状态，实施对网络各节点的分布式管理，实施协同病毒扫描，在不中断工作的情况下完成病毒的清除工作，保障企业运作的正常运行。先进的分布式管理技术，可以因材施教的对全网不同节点的所有文件和内存进行全面病毒扫描。集中化的管理和分布式的处理模式大大简化了网络管理员的操作，再也不用为大规模病毒爆发焦头烂额了。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;智能化：未知病毒自动防护策略，病毒智能清除模式。安铁诺特有的安装分发机制，将网络版的安装彻底智能化，其自动识别系统可以为全网络每个节点配置单独的防御系统，从而彻底将网络管理员从中解放出来。其全自动升级系统可以实时从网络上下载更新文件，同时向网络其他节点发布更新通知，和更新操作，这样将全网的防御状态保持在最新，最完善的状态。<br>\n&nbsp;&nbsp;&nbsp;&nbsp;安铁诺自主开发的未知病毒引擎所采用的过滤和清除体系，已经成为一套行之有效的未知病毒防范策略，从根本上推进了未知病毒防御技术上的世界难题。&nbsp;  ','http://www.sanlen.com/soft/sp/Anti_net.zip\rhttp://sq5.onlinedown.net/down/Anti_net.zip\rhttp://hld.onlinedown.net/down/Anti_net.zip\rhttp://wh.onlinedown.net:82/down/Anti_net.zip\rhttp://ftpwh.onlinedown.net:82/down/Anti_net.zip\rhttp://nc.onlinedown.net/down/Anti_net.zip\rhttp://sx.huajun.net/files/Anti_net.zip\rhttp://lctt.onlinedown.net/down/Anti_net.zip\rhttp://sccrc2.onlinedown.net:82/down/Anti_net.zip\rhttp://gzcnc.onlinedown.net:82/files/Anti_net.zip\rhttp://sccnc.onlinedown.net/down/Anti_net.zip\rhttp://cttnb.onlinedown.net/down/Anti_net.zip\rhttp://hecz.onlinedown.net/down/Anti_net.zip\rhttp://hbcrc.onlinedown.net:82/down/Anti_net.zip\rhttp://hld165.onlinedown.net/down/Anti_net.zip\rhttp://ctttl.onlinedown.net:82/down/Anti_net.zip\rhttp://wznetcom.onlinedown.com:81/down/Anti_net.zip\rhttp://zj.onlinedown.net:82/down/Anti_net.zip\rftp://cnc:10060@221.12.150.27/Anti_net.zip\rftp://cnc:10060@soft.10060.tv/Anti_net.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Anti_net.zip\rhttp://ctttl.onlinedown.net:8080/down/Anti_net.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (110,1126758902,1126758902,1,1,0,0,'Code Co-op 4.6a','3881KB','英文','共享版/编程工具','Win9x/Me/NT/2000/XP',4,'http://www.relisoft.com','','&nbsp;&nbsp;&nbsp;&nbsp;多种开发语言项目管理工具，通过端到端的协作和版本控制工具，可以允许使用不同开发语言的程序员通过局域网、VPN、电子邮件来合作开发项目，无需服务器.  ','ftp://ftp.relisoft.com/co-op.exe\rhttp://sq5.onlinedown.net/down/co-op.exe\rhttp://hld.onlinedown.net/down/co-op.exe\rhttp://wh.onlinedown.net:82/down/co-op.exe\rhttp://ftpwh.onlinedown.net:82/down/co-op.exe\rhttp://nc.onlinedown.net/down/co-op.exe\rhttp://sx.huajun.net/files/co-op.exe\rhttp://lctt.onlinedown.net/down/co-op.exe\rhttp://sccrc2.onlinedown.net:82/down/co-op.exe\rhttp://gzcnc.onlinedown.net:82/files/co-op.exe\rhttp://sccnc.onlinedown.net/down/co-op.exe\rhttp://cttnb.onlinedown.net/down/co-op.exe\rhttp://hecz.onlinedown.net/down/co-op.exe\rhttp://hbcrc.onlinedown.net:82/down/co-op.exe\rhttp://hld165.onlinedown.net/down/co-op.exe\rhttp://ctttl.onlinedown.net:82/down/co-op.exe\rhttp://wznetcom.onlinedown.com:81/down/co-op.exe\rhttp://zj.onlinedown.net:82/down/co-op.exe\rftp://cnc:10060@221.12.150.27/co-op.exe\rftp://cnc:10060@soft.10060.tv/co-op.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/co-op.exe\rhttp://ctttl.onlinedown.net:8080/down/co-op.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (111,1126758902,1126758902,1,1,0,0,'钻石文件夹加密软件 2.0','3350KB','简体中文','共享版/系统安全','Win9x/Me/NT/2000/XP',4,'http://www.goldenfound.com/close','','&nbsp;&nbsp;&nbsp;&nbsp;《钻石文件夹加密》软件是一款专业的文件夹加密软件!具有人性化设计，界面友好简单易用的特点！本软件采用独创的TMFG高强度加密，保证数据安性。  ','http://www.goldenfound.com/close/diamond.exe\rhttp://sq.onlinedown.net:82/down/diamond.exe\rhttp://wh.onlinedown.net:82/down/diamond.exe\rhttp://ftpwh.onlinedown.net:82/down/diamond.exe\rhttp://hlbr.onlinedown.net/files3/diamond.exe\rhttp://nc.onlinedown.net/down/diamond.exe\rhttp://sx.huajun.net/files/diamond.exe\rhttp://lctt.onlinedown.net/down/diamond.exe\rhttp://sccrc2.onlinedown.net:82/down/diamond.exe\rhttp://gzcnc.onlinedown.net:82/files/diamond.exe\rhttp://sccnc.onlinedown.net/down/diamond.exe\rhttp://crc.onlinedown.net:82/files/diamond.exe\rhttp://cttnb.onlinedown.net/down/diamond.exe\rhttp://jsnetcom.onlinedown.com/down/diamond.exe\rhttp://hld165.onlinedown.net/down/diamond.exe\rhttp://ctttl.onlinedown.net:82/down/diamond.exe\rhttp://wznetcom.onlinedown.com:81/down/diamond.exe\rhttp://zj.onlinedown.net:82/down/diamond.exe\rftp://cnc:10060@221.12.150.27/diamond.exe\rftp://cnc:10060@soft.10060.tv/diamond.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/diamond.exe\rhttp://ctttl.onlinedown.net:8080/down/diamond.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (112,1126758902,1126758902,1,1,0,0,'伪装文件夹 1.25','3631KB','简体中文','免费版/系统安全','Win9x/Me/NT/2000/XP',4,'http://hws.512j.com','','&nbsp;&nbsp;&nbsp;&nbsp;非常简单,易用且安全的文件夹伪装工具,只要你会点鼠标就会使用本软件,它就像忍者施展变身术一样可以将你磁盘中的文件夹伪装成各种系统的文件夹,如将它变成回收站,它就拥有了回收站的外观和功能,别人进入它也只是进了回收站,从而达到隐藏该文件夹的目的.你不必担心你的文件夹伪装后,里面的文件会受到损坏,因为该软件只操作文件夹不操作里面的文件.是你隐藏你的重要文件或私隐文件必不可少的软件.最重要的是该软件完全是免费软件,拿到就用,不用注册什么的.<br>\n<br>\n&nbsp;&nbsp;操作:<br>\n&nbsp;&nbsp;&nbsp;&nbsp;1.正规操作,按面板的三步进行;<br>\n&nbsp;&nbsp;&nbsp;&nbsp;2.快捷操作,直接在选择文件夹框里选择文件夹后右键弹出菜单进行操作.  ','http://hws.533.net/download/weizhuang.exe\rhttp://sq.onlinedown.net:82/down/weizhuang.exe\rhttp://wh.onlinedown.net:82/down/weizhuang.exe\rhttp://ftpwh.onlinedown.net:82/down/weizhuang.exe\rhttp://hlbr.onlinedown.net/files3/weizhuang.exe\rhttp://nc.onlinedown.net/down/weizhuang.exe\rhttp://sx.huajun.net/files/weizhuang.exe\rhttp://lctt.onlinedown.net/down/weizhuang.exe\rhttp://sccrc2.onlinedown.net:82/down/weizhuang.exe\rhttp://gzcnc.onlinedown.net:82/files/weizhuang.exe\rhttp://sccnc.onlinedown.net/down/weizhuang.exe\rhttp://crc.onlinedown.net:82/files/weizhuang.exe\rhttp://cttnb.onlinedown.net/down/weizhuang.exe\rhttp://jsnetcom.onlinedown.com/down/weizhuang.exe\rhttp://hld165.onlinedown.net/down/weizhuang.exe\rhttp://ctttl.onlinedown.net:82/down/weizhuang.exe\rhttp://wznetcom.onlinedown.com:81/down/weizhuang.exe\rhttp://zj.onlinedown.net:82/down/weizhuang.exe\rftp://cnc:10060@221.12.150.27/weizhuang.exe\rftp://cnc:10060@soft.10060.tv/weizhuang.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/weizhuang.exe\rhttp://ctttl.onlinedown.net:8080/down/weizhuang.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (113,1126758902,1126758902,1,1,0,0,'PGWARE SuperRam 5.9.12.2005汉化版','2020KB','简体中文','汉化补丁/共享版/内存管理','Win9x/Me/NT/2000/XP',4,'','','    在Windows 系统中，你是不是觉得内存不够用？本人系统也是如此--使用得越久，系统就越慢。而使用 SuperRam 可以让你的个人电脑的内存释放出浪费的那一部分来提高计算机的性能。拥有更多的内存，你的计算机将会运行更快。 <br>\n参考文章: <br>\n智能化的内存管理工具 <br>\n  ','http://sq.onlinedown.net:82/down/H_PGWARESuperRam.exe\rhttp://wh.onlinedown.net:82/down/H_PGWARESuperRam.exe\rhttp://ftpwh.onlinedown.net:82/down/H_PGWARESuperRam.exe\rhttp://hlbr.onlinedown.net/files3/H_PGWARESuperRam.exe\rhttp://nc.onlinedown.net/down/H_PGWARESuperRam.exe\rhttp://sx.huajun.net/files/H_PGWARESuperRam.exe\rhttp://lctt.onlinedown.net/down/H_PGWARESuperRam.exe\rhttp://sccrc2.onlinedown.net:82/down/H_PGWARESuperRam.exe\rhttp://gzcnc.onlinedown.net:82/files/H_PGWARESuperRam.exe\rhttp://sccnc.onlinedown.net/down/H_PGWARESuperRam.exe\rhttp://crc.onlinedown.net:82/files/H_PGWARESuperRam.exe\rhttp://cttnb.onlinedown.net/down/H_PGWARESuperRam.exe\rhttp://jsnetcom.onlinedown.com/down/H_PGWARESuperRam.exe\rhttp://hld165.onlinedown.net/down/H_PGWARESuperRam.exe\rhttp://ctttl.onlinedown.net:82/down/H_PGWARESuperRam.exe\rhttp://wznetcom.onlinedown.com:81/down/H_PGWARESuperRam.exe\rhttp://zj.onlinedown.net:82/down/H_PGWARESuperRam.exe\rftp://cnc:10060@221.12.150.27/H_PGWARESuperRam.exe\rftp://cnc:10060@soft.10060.tv/H_PGWARESuperRam.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/H_PGWARESuperRam.exe\rhttp://ctttl.onlinedown.net:8080/down/H_PGWARESuperRam.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (114,1126758903,1126758903,1,1,0,0,'NOD32 Antivirus System  2.50.44 For Win9x/ME','8270KB','英文','共享版/杀毒软件','Win9x/Me',4,'http://www.nod32.com/','','　　国外很权威的防病毒软件评测给了NOD32很高的分数。产品线很长，从DOS，Windows 9x/Me，Windows NT/XP/2000，到Novell Netware Server、Linux、BSD等，都有提供。在线监测功能严密，防火墙可以预警尼姆达，并可清除之。可以对邮件进行实时监测，占用内存资源较少，清除病毒的速度效果都令人满意！  ','http://u4.eset.com/eval/win/v2/ne98enst.exe\rhttp://sq.onlinedown.net:82/down/ne98enst.exe\rhttp://wh.onlinedown.net:82/down/ne98enst.exe\rhttp://ftpwh.onlinedown.net:82/down/ne98enst.exe\rhttp://hlbr.onlinedown.net/files3/ne98enst.exe\rhttp://nc.onlinedown.net/down/ne98enst.exe\rhttp://sx.huajun.net/files/ne98enst.exe\rhttp://lctt.onlinedown.net/down/ne98enst.exe\rhttp://sccrc2.onlinedown.net:82/down/ne98enst.exe\rhttp://gzcnc.onlinedown.net:82/files/ne98enst.exe\rhttp://sccnc.onlinedown.net/down/ne98enst.exe\rhttp://crc.onlinedown.net:82/files/ne98enst.exe\rhttp://cttnb.onlinedown.net/down/ne98enst.exe\rhttp://jsnetcom.onlinedown.com/down/ne98enst.exe\rhttp://hld165.onlinedown.net/down/ne98enst.exe\rhttp://ctttl.onlinedown.net:82/down/ne98enst.exe\rhttp://wznetcom.onlinedown.com:81/down/ne98enst.exe\rhttp://zj.onlinedown.net:82/down/ne98enst.exe\rftp://cnc:10060@221.12.150.27/ne98enst.exe\rftp://cnc:10060@soft.10060.tv/ne98enst.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/ne98enst.exe\rhttp://ctttl.onlinedown.net:8080/down/ne98enst.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (115,1126758903,1126855573,1,1,0,0,'ZTreeWin 1.50rc2','1170KB','英文','共享版/文件管理','Win9x/Me/NT/2000/XP',4,'http://www.zedtek.com/','microsoft','&nbsp;&nbsp;&nbsp;&nbsp;ZTreeWin是一款文本方式的文件管理工具，支持Windows 95及以后的所有版本。其前身是DOS下的文件管理器XTreeGold，在当前的GUI模式下已经不复存在了，这是一款32位Windows程序，使用它将会给你带来无限的便捷。 ','http://www.zedtek.com/download/ztw150rc2.exe\nhttp://sq.onlinedown.net:82/down/ztw150rc2.exe\nhttp://wh.onlinedown.net:82/down/ztw150rc2.exe\nhttp://ftpwh.onlinedown.net:82/down/ztw150rc2.exe\nhttp://hlbr.onlinedown.net/files3/ztw150rc2.exe\nhttp://nc.onlinedown.net/down/ztw150rc2.exe\nhttp://sx.huajun.net/files/ztw150rc2.exe\nhttp://lctt.onlinedown.net/down/ztw150rc2.exe\nhttp://sccrc2.onlinedown.net:82/down/ztw150rc2.exe\nhttp://gzcnc.onlinedown.net:82/files/ztw150rc2.exe\nhttp://sccnc.onlinedown.net/down/ztw150rc2.exe\nhttp://crc.onlinedown.net:82/files/ztw150rc2.exe\nhttp://cttnb.onlinedown.net/down/ztw150rc2.exe\nhttp://jsnetcom.onlinedown.com/down/ztw150rc2.exe\nhttp://hld165.onlinedown.net/down/ztw150rc2.exe\nhttp://ctttl.onlinedown.net:82/down/ztw150rc2.exe\nhttp://wznetcom.onlinedown.com:81/down/ztw150rc2.exe\nhttp://zj.onlinedown.net:82/down/ztw150rc2.exe\nftp://cnc:10060@221.12.150.27/ztw150rc2.exe\nftp://cnc:10060@soft.10060.tv/ztw150rc2.exe\nftp://wzcnc:wzcnc@onlinedown.wzcnc.com/ztw150rc2.exe\nhttp://ctttl.onlinedown.net:8080/down/ztw150rc2.exe','../resource/img/h000/h00/img200509161526100.jpg','','','');
INSERT INTO {$table_header}content_2 VALUES (116,1126758903,1126767964,1,1,0,0,'SpeedFan 4.26','1401KB','英文','免费版/系统辅助','Win9x/Me/NT/2000/XP',4,'http://www.almico.com/speedfan.php','microsoft','<STRONG>本系统支持打印参数的导出</STRONG>，<FONT color=#f73809>同时支持打印数据的管理</FONT>，在已建立数据库的情况下，打印完毕的数据将会自动写入数据库，用户可任意处理打印数据，并能按表格方式打印输出。 ','http://www.almico.com/installspeedfan426.exe\nhttp://sq.onlinedown.net:82/down/installspeedfan426.exe\nhttp://wh.onlinedown.net:82/down/installspeedfan426.exe\nhttp://ftpwh.onlinedown.net:82/down/installspeedfan426.exe\nhttp://hlbr.onlinedown.net/files3/installspeedfan426.exe\nhttp://nc.onlinedown.net/down/installspeedfan426.exe\nhttp://sx.huajun.net/files/installspeedfan426.exe\nhttp://lctt.onlinedown.net/down/installspeedfan426.exe\nhttp://sccrc2.onlinedown.net:82/down/installspeedfan426.exe\nhttp://gzcnc.onlinedown.net:82/files/installspeedfan426.exe\nhttp://sccnc.onlinedown.net/down/installspeedfan426.exe\nhttp://crc.onlinedown.net:82/files/installspeedfan426.exe\nhttp://cttnb.onlinedown.net/down/installspeedfan426.exe\nhttp://jsnetcom.onlinedown.com/down/installspeedfan426.exe\nhttp://hld165.onlinedown.net/down/installspeedfan426.exe\nhttp://ctttl.onlinedown.net:82/down/installspeedfan426.exe\nhttp://wznetcom.onlinedown.com:81/down/installspeedfan426.exe\nhttp://zj.onlinedown.net:82/down/installspeedfan426.exe\nftp://cnc:10060@221.12.150.27/installspeedfan426.exe\nftp://cnc:10060@soft.10060.tv/installspeedfan426.exe\nftp://wzcnc:wzcnc@onlinedown.wzcnc.com/installspeedfan426.exe\nhttp://ctttl.onlinedown.net:8080/down/installspeedfan426.exe','../resource/img/h000/h00/img200509151326190.jpg','','73499,73475,73472','73465,73464,73463,73461,73457');
INSERT INTO {$table_header}content_2 VALUES (73,1126756354,1126756354,1,1,0,0,'Visual Zip Password Recovery 6.0 Beta 3','1037KB','英文','共享版/密码破解','Win9x/Me/NT/2000/XP',4,'http://www.regnow.com/softsell/visitor.cgi?product=6095-1&affiliate=10793&action=site&ref=http://www.zipcure.com/zippasswordcracker.html','','&nbsp;&nbsp;&nbsp;&nbsp;ZIP 压缩文件密码恢复软件，最大的特点是支持多处理器和网络运算，使得其能够发挥更快的速度去寻找你丢失的密码。使用图形操作界面，可自定最小与最大密码长度及数字、字母、符号来\'查\'密码。亦有中断密码查询及储存功能，下次要恢复前次的查询时，只需将储存的文件读入即可继续上次的查询，亦提供多种不同暴力查询模式，请勿用于不法用途。  ','http://www.zipcure.com/beta/vzr60b3.exe\rhttp://sq.onlinedown.net:82/down/vzr60b3.exe\rhttp://wh.onlinedown.net:82/down/vzr60b3.exe\rhttp://ftpwh.onlinedown.net:82/down/vzr60b3.exe\rhttp://hlbr.onlinedown.net/files3/vzr60b3.exe\rhttp://nc.onlinedown.net/down/vzr60b3.exe\rhttp://sx.huajun.net/files/vzr60b3.exe\rhttp://lctt.onlinedown.net/down/vzr60b3.exe\rhttp://sccrc2.onlinedown.net:82/down/vzr60b3.exe\rhttp://gzcnc.onlinedown.net:82/files/vzr60b3.exe\rhttp://sccnc.onlinedown.net/down/vzr60b3.exe\rhttp://crc.onlinedown.net:82/files/vzr60b3.exe\rhttp://cttnb.onlinedown.net/down/vzr60b3.exe\rhttp://jsnetcom.onlinedown.com/down/vzr60b3.exe\rhttp://hld165.onlinedown.net/down/vzr60b3.exe\rhttp://ctttl.onlinedown.net:82/down/vzr60b3.exe\rhttp://wznetcom.onlinedown.com:81/down/vzr60b3.exe\rhttp://zj.onlinedown.net:82/down/vzr60b3.exe\rftp://cnc:10060@221.12.150.27/vzr60b3.exe\rftp://cnc:10060@soft.10060.tv/vzr60b3.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/vzr60b3.exe\rhttp://ctttl.onlinedown.net:8080/down/vzr60b3.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (74,1126756354,1126756354,1,1,0,0,'McAfee VirusScan DAT 4581','6317KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.nai.com/','','　&nbsp;&nbsp;&nbsp;McAfee防毒软件, 除了操作介面更新外,也将该公司的WebScanX功能合在一起,增加了许多新功能! 除了帮你侦测和清除病毒，它还有VShield自动监视系统，会常驻在System Tray，当你从磁盘、网络上、E-mail夹文件中开启文件时便会自动侦测文件的安全性，若文件内含病毒，便会立即警告，并作适当的处理，而且支持鼠标右键的快速选单功能，并可使用密码将个人的设定锁住让别人无法乱改你的设定。附注：4.0.1版采用Dr Solomon\'s virus引擎，并且新增了侦测恶意的Java Applet和ActiveX程序的功能，介面也焕然一新。请记得病毒码是要经常更新的!  ','http://speedownload.nai.com/products/datfiles/4.x/nai/dat-4581.zip\rhttp://sq.onlinedown.net:82/down/dat-4581.zip\rhttp://wh.onlinedown.net:82/down/dat-4581.zip\rhttp://ftpwh.onlinedown.net:82/down/dat-4581.zip\rhttp://hlbr.onlinedown.net/files3/dat-4581.zip\rhttp://nc.onlinedown.net/down/dat-4581.zip\rhttp://sx.huajun.net/files/dat-4581.zip\rhttp://lctt.onlinedown.net/down/dat-4581.zip\rhttp://sccrc2.onlinedown.net:82/down/dat-4581.zip\rhttp://gzcnc.onlinedown.net:82/files/dat-4581.zip\rhttp://sccnc.onlinedown.net/down/dat-4581.zip\rhttp://crc.onlinedown.net:82/files/dat-4581.zip\rhttp://cttnb.onlinedown.net/down/dat-4581.zip\rhttp://jsnetcom.onlinedown.com/down/dat-4581.zip\rhttp://hld165.onlinedown.net/down/dat-4581.zip\rhttp://ctttl.onlinedown.net:82/down/dat-4581.zip\rhttp://wznetcom.onlinedown.com:81/down/dat-4581.zip\rhttp://zj.onlinedown.net:82/down/dat-4581.zip\rftp://cnc:10060@221.12.150.27/dat-4581.zip\rftp://cnc:10060@soft.10060.tv/dat-4581.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/dat-4581.zip\rhttp://ctttl.onlinedown.net:8080/down/dat-4581.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (75,1126756354,1126756354,1,1,0,0,'McAfee VirusScan SuperDAT 4581','7349KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.mcafee.com/0','','　　 McAfee防毒软件, 除了操作介面更新外,也将该公司的WebScanX功能合在一起,增加了许多新功能! 除了帮你侦测和清除病毒，它还有VShield自动监视系统，会常驻在System Tray，当你从磁盘、网络上、E-mail夹文件中开启文件时便会自动侦测文件的安全性，若文件内含病毒，便会立即警告，并作适当的处理，而且支持鼠标右键的快速选单功能，并可使用密码将个人的设定锁住让别人无法乱改你的设定。附注：4.0.1版采用Dr Solomon\'s virus引擎，并且新增了侦测恶意的Java Applet和ActiveX程序的功能，介面也焕然一新。请记得病毒码是要经常更新的!  ','http://speedownload.nai.com:80/products/datfiles/4.x/nai/sdat4581.exe\rhttp://sq.onlinedown.net:82/down/sdat4581.exe\rhttp://wh.onlinedown.net:82/down/sdat4581.exe\rhttp://ftpwh.onlinedown.net:82/down/sdat4581.exe\rhttp://hlbr.onlinedown.net/files3/sdat4581.exe\rhttp://nc.onlinedown.net/down/sdat4581.exe\rhttp://sx.huajun.net/files/sdat4581.exe\rhttp://lctt.onlinedown.net/down/sdat4581.exe\rhttp://sccrc2.onlinedown.net:82/down/sdat4581.exe\rhttp://gzcnc.onlinedown.net:82/files/sdat4581.exe\rhttp://sccnc.onlinedown.net/down/sdat4581.exe\rhttp://crc.onlinedown.net:82/files/sdat4581.exe\rhttp://cttnb.onlinedown.net/down/sdat4581.exe\rhttp://jsnetcom.onlinedown.com/down/sdat4581.exe\rhttp://hld165.onlinedown.net/down/sdat4581.exe\rhttp://ctttl.onlinedown.net:82/down/sdat4581.exe\rhttp://wznetcom.onlinedown.com:81/down/sdat4581.exe\rhttp://zj.onlinedown.net:82/down/sdat4581.exe\rftp://cnc:10060@221.12.150.27/sdat4581.exe\rftp://cnc:10060@soft.10060.tv/sdat4581.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/sdat4581.exe\rhttp://ctttl.onlinedown.net:8080/down/sdat4581.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (76,1126756355,1126756355,1,1,0,0,'Windows File Explorer 0.6 Build 1.127','2639KB','英文','免费版/文件管理','Win9x/Me/NT/2000/XP',4,'http://www.freesoftlabs.com','','你是不是会觉得 Windows 的文件管理功能太少了，用 Windows File Explorer 这个免费的软件来取代你原有的Windows 文件管理，该软件可以让你在一个页面同时开启两个文件管理的窗口，如此要做档案的复制及管理更加的方便，也具有图文件数据预览的功能，可预览的图档类型有:bmp， jpeg， png， gif， tiff， pcx， pbm， pgm， ppm， tga， dib， rle， wmf， emf， icons and cursors ..等等。  ','http://web.telia.com/~u58004883/FileExplorer.exe\rhttp://sq.onlinedown.net:82/down/FileExplorer.exe\rhttp://wh.onlinedown.net:82/down/FileExplorer.exe\rhttp://ftpwh.onlinedown.net:82/down/FileExplorer.exe\rhttp://hlbr.onlinedown.net/files3/FileExplorer.exe\rhttp://nc.onlinedown.net/down/FileExplorer.exe\rhttp://sx.huajun.net/files/FileExplorer.exe\rhttp://lctt.onlinedown.net/down/FileExplorer.exe\rhttp://sccrc2.onlinedown.net:82/down/FileExplorer.exe\rhttp://gzcnc.onlinedown.net:82/files/FileExplorer.exe\rhttp://sccnc.onlinedown.net/down/FileExplorer.exe\rhttp://crc.onlinedown.net:82/files/FileExplorer.exe\rhttp://cttnb.onlinedown.net/down/FileExplorer.exe\rhttp://jsnetcom.onlinedown.com/down/FileExplorer.exe\rhttp://hld165.onlinedown.net/down/FileExplorer.exe\rhttp://ctttl.onlinedown.net:82/down/FileExplorer.exe\rhttp://wznetcom.onlinedown.com:81/down/FileExplorer.exe\rhttp://zj.onlinedown.net:82/down/FileExplorer.exe\rftp://cnc:10060@221.12.150.27/FileExplorer.exe\rftp://cnc:10060@soft.10060.tv/FileExplorer.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/FileExplorer.exe\rhttp://ctttl.onlinedown.net:8080/down/FileExplorer.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (77,1126756355,1126756355,1,1,0,0,'Winzip 10.0 Beta Build 6604','5157KB','英文','共享版/压缩工具','Win9x/Me/NT/2000/XP',4,'http://www.winzip.com/','','&nbsp;&nbsp;&nbsp;&nbsp;被Vector Capital收购的Winzip近日发布了新的Winzip 10 beta.Vector Capital擅长使经营不善的技术公司起死回生－－它曾经在2003年买入Corel.WinZip是PC史上最流行的压缩软件，官方总下载量已经达到1亿4000万次。<br>\n<br>\n<br>\n最新的更新有:<br>\n*开始分化为两个版本：标准版和专业版<br>\n*新的界面，新的资源管理器，新的图标，三新.<br>\n*改进压缩的代码使其获得更高的压缩率<br>\n*简洁的向导<br>\n*允许刻录CD(专业版）<br>\n  ','http://sq.onlinedown.net:82/down/wz100beta.exe\rhttp://wh.onlinedown.net:82/down/wz100beta.exe\rhttp://ftpwh.onlinedown.net:82/down/wz100beta.exe\rhttp://hlbr.onlinedown.net/files3/wz100beta.exe\rhttp://nc.onlinedown.net/down/wz100beta.exe\rhttp://sx.huajun.net/files/wz100beta.exe\rhttp://lctt.onlinedown.net/down/wz100beta.exe\rhttp://sccrc2.onlinedown.net:82/down/wz100beta.exe\rhttp://gzcnc.onlinedown.net:82/files/wz100beta.exe\rhttp://sccnc.onlinedown.net/down/wz100beta.exe\rhttp://crc.onlinedown.net:82/files/wz100beta.exe\rhttp://cttnb.onlinedown.net/down/wz100beta.exe\rhttp://jsnetcom.onlinedown.com/down/wz100beta.exe\rhttp://hld165.onlinedown.net/down/wz100beta.exe\rhttp://ctttl.onlinedown.net:82/down/wz100beta.exe\rhttp://wznetcom.onlinedown.com:81/down/wz100beta.exe\rhttp://zj.onlinedown.net:82/down/wz100beta.exe\rftp://cnc:10060@221.12.150.27/wz100beta.exe\rftp://cnc:10060@soft.10060.tv/wz100beta.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/wz100beta.exe\rhttp://ctttl.onlinedown.net:8080/down/wz100beta.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (78,1126756355,1126756355,1,1,0,0,'Free History Eraser 4.5','419KB','英文','免费版/卸载工具','Win9x/Me/NT/2000/XP',4,'http://smartprotector.com/eraser/free-history-eraser.htm','','&nbsp;&nbsp;&nbsp;通过删除上网历史记录和使用过的文档，保护你的隐私。  ','http://smartprotector.com/eraser/downloads/historyeraser.exe\rhttp://sq.onlinedown.net:82/down/historyeraser.exe\rhttp://wh.onlinedown.net:82/down/historyeraser.exe\rhttp://ftpwh.onlinedown.net:82/down/historyeraser.exe\rhttp://hlbr.onlinedown.net/files3/historyeraser.exe\rhttp://nc.onlinedown.net/down/historyeraser.exe\rhttp://sx.huajun.net/files/historyeraser.exe\rhttp://lctt.onlinedown.net/down/historyeraser.exe\rhttp://sccrc2.onlinedown.net:82/down/historyeraser.exe\rhttp://gzcnc.onlinedown.net:82/files/historyeraser.exe\rhttp://sccnc.onlinedown.net/down/historyeraser.exe\rhttp://crc.onlinedown.net:82/files/historyeraser.exe\rhttp://cttnb.onlinedown.net/down/historyeraser.exe\rhttp://jsnetcom.onlinedown.com/down/historyeraser.exe\rhttp://hld165.onlinedown.net/down/historyeraser.exe\rhttp://ctttl.onlinedown.net:82/down/historyeraser.exe\rhttp://wznetcom.onlinedown.com:81/down/historyeraser.exe\rhttp://zj.onlinedown.net:82/down/historyeraser.exe\rftp://cnc:10060@221.12.150.27/historyeraser.exe\rftp://cnc:10060@soft.10060.tv/historyeraser.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/historyeraser.exe\rhttp://ctttl.onlinedown.net:8080/down/historyeraser.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (79,1126756356,1126756356,1,1,0,0,'Norton Antivirus 20050914-008-i32.exe','8899KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.symantec.com/','','&nbsp;&nbsp;&nbsp;&nbsp;Norton AntiVirus 是一套强而有力的防毒软件，它可帮你侦测上万种已知和未知的病毒，并且每当开机时，自动防护便会常驻在System Tray，当你从磁盘、网路上、E-mail 夹档中开启档案时便会自动侦测档案的安全性，若档案内含病毒，便会立即警告，并作适当的处理。另外它还附有「LiveUpdate」的功能，可帮你自动连上 Symantec 的 FTP Server 下载最新的病毒码，於下载完后自动完成安装更新的动作。<br>\n此病毒码适用与：<br>\nNAV 2000 for Win9x/NT/2000<br>\nNAV 2001 for Win95b/98/NT/2000/Me<br>\nNAV 2002 Professional Edition<br>\nNAV 2002 for Win98/Me/NT/2000/XP Home/XP Pro<br>\nNAV 4.0, 5.0 and 2000 for Win9x<br>\nNAV 4.0, 5.0 and 2000 for WinNT<br>\nNAV for Firewalls 1.5 or higher<br>\nNAV for Lotus Notes (Intel)<br>\nNAV for MS Exchange (Intel)<br>\nNorton SystemWorks (all versions)<br>\nNorton Utilities for Windows 95/98 (all versions)<br>\npcAnywhere32 7.5 and higher for WinNT<br>\n  ','http://www.symantec.com/avcenter/download/us-files/20050914-008-i32.exe\rftp://ftp.symantec.com/public/english_us_canada/antivirus_definitions/norton_antivirus/20050914-008-i32.exe\rhttp://securityresponse.symantec.com/avcenter/download/us-files/20050914-008-i32.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (80,1126756356,1126756356,1,1,0,0,'Norton Antivirus 20050914-008-x86.exe','11769KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.symantec.com/','','&nbsp;&nbsp;&nbsp;&nbsp;Norton AntiVirus 是一套强而有力的防毒软件，它可帮你侦测上万种已知和未知的病毒，并且每当开机时，自动防护便会常驻在System Tray，当你从磁盘、网路上、E-mail 夹档中开启档案时便会自动侦测档案的安全性，若档案内含病毒，便会立即警告，并作适当的处理。另外它还附有「LiveUpdate」的功能，可帮你自动连上 Symantec 的 FTP Server 下载最新的病毒码，於下载完后自动完成安装更新的动作。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>\n此病毒码适用与：<br>\nNAV 2000 for Win9x/NT/2000<br>\nNAV 2001 for Win95b/98/NT/2000/Me<br>\nNAV 2002 Professional Edition<br>\nNAV 2002 for Win98/Me/NT/2000/XP Home/XP Pro<br>\nNAV 3.0 & 4.0 for DOS/Win3x<br>\nNAV 4.0 for NetWare<br>\nNAV 4.0, 5.0 and 2000 for Win9x<br>\nNAV 4.0, 5.0 and 2000 for WinNT<br>\nNAV 6.0 & 7.x Corporate Edition<br>\nNAV for Gateways 2.x (WinNT/2000)<br>\nNAV for Internet Email Gateways 1.x (WinNT only)<br>\nNAV for Lotus Notes (Intel)<br>\nNAV for MS Exchange (Intel)<br>\nNorton NT Tools<br>\nNorton Utilities 2.0 for WinNT<br>\npcAnywhere32 7.5 and higher for WinNT<br>\n  ','http://www.symantec.com/avcenter/download/us-files/20050914-008-x86.exe\rftp://ftp.symantec.com/public/english_us_canada/antivirus_definitions/norton_antivirus/20050914-008-x86.exe\rhttp://securityresponse.symantec.com/avcenter/download/us-files/20050914-008-x86.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (81,1126756356,1126756356,1,1,0,0,'F-Secure Anti-Virus 2005.09.14 病毒码','8318KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.f-secure.com/','','    相当不错杀毒程序，提供多种的扫描方式，可单一扫描硬盘或是一个文件夹或文件，软件更提供密 码的保护性，并提供病毒的信息。  ','ftp://ftp.f-secure.com/anti-virus/updates/fsupdate.exe\rftp://ftp.europe.f-secure.com/anti-virus/updates/fsupdate.exe\rhttp://sq.onlinedown.net:82/down/fsupdate.exe\rhttp://wh.onlinedown.net:82/down/fsupdate.exe\rhttp://ftpwh.onlinedown.net:82/down/fsupdate.exe\rhttp://hlbr.onlinedown.net/files3/fsupdate.exe\rhttp://nc.onlinedown.net/down/fsupdate.exe\rhttp://sx.huajun.net/files/fsupdate.exe\rhttp://lctt.onlinedown.net/down/fsupdate.exe\rhttp://sccrc2.onlinedown.net:82/down/fsupdate.exe\rhttp://gzcnc.onlinedown.net:82/files/fsupdate.exe\rhttp://sccnc.onlinedown.net/down/fsupdate.exe\rhttp://crc.onlinedown.net:82/files/fsupdate.exe\rhttp://cttnb.onlinedown.net/down/fsupdate.exe\rhttp://jsnetcom.onlinedown.com/down/fsupdate.exe\rhttp://hld165.onlinedown.net/down/fsupdate.exe\rhttp://ctttl.onlinedown.net:82/down/fsupdate.exe\rhttp://wznetcom.onlinedown.com:81/down/fsupdate.exe\rhttp://zj.onlinedown.net:82/down/fsupdate.exe\rftp://cnc:10060@221.12.150.27/fsupdate.exe\rftp://cnc:10060@soft.10060.tv/fsupdate.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/fsupdate.exe\rhttp://ctttl.onlinedown.net:8080/down/fsupdate.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (82,1126756356,1126756356,1,1,0,0,'AntiVir VDF update 6.32.00.09','4386KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.avup.de/','','AntiVir提供以免受到电脑病毒的侵害，有效的保护个人电脑以及工作站的使用。 它可以侦测并移除超过 50,000种病毒，线上更新有助於保持最佳状态。  ','http://dl.antivir.de/down/vdf/fuse.zip\rhttp://sq.onlinedown.net:82/down/fuse.zip\rhttp://wh.onlinedown.net:82/down/fuse.zip\rhttp://ftpwh.onlinedown.net:82/down/fuse.zip\rhttp://hlbr.onlinedown.net/files3/fuse.zip\rhttp://nc.onlinedown.net/down/fuse.zip\rhttp://sx.huajun.net/files/fuse.zip\rhttp://lctt.onlinedown.net/down/fuse.zip\rhttp://sccrc2.onlinedown.net:82/down/fuse.zip\rhttp://gzcnc.onlinedown.net:82/files/fuse.zip\rhttp://sccnc.onlinedown.net/down/fuse.zip\rhttp://crc.onlinedown.net:82/files/fuse.zip\rhttp://cttnb.onlinedown.net/down/fuse.zip\rhttp://jsnetcom.onlinedown.com/down/fuse.zip\rhttp://hld165.onlinedown.net/down/fuse.zip\rhttp://ctttl.onlinedown.net:82/down/fuse.zip\rhttp://wznetcom.onlinedown.com:81/down/fuse.zip\rhttp://zj.onlinedown.net:82/down/fuse.zip\rftp://cnc:10060@221.12.150.27/fuse.zip\rftp://cnc:10060@soft.10060.tv/fuse.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/fuse.zip\rhttp://ctttl.onlinedown.net:8080/down/fuse.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (83,1126756356,1126756356,1,1,0,0,'Kaspersky Anti-Virus(AVP) 日病毒码09.15','536KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.Kaspersky.com','','&nbsp;&nbsp;&nbsp;&nbsp;AVP是俄罗斯软件公司的产品,是一个在国外评价极高杀毒软件。它也有常驻于System Tray的自动监视功能，可帮你自动监视从磁盘、网路上、E-mail 夹档中开启文件的安全性，亦有鼠标右键的快速选单，还附有 LiveUpdate 线上更新病毒码的功能。&nbsp;  ','http://downloads3.kaspersky-labs.com/updates_zip/daily.zip\rhttp://sq.onlinedown.net:82/down/daily.zip\rhttp://wh.onlinedown.net:82/down/daily.zip\rhttp://ftpwh.onlinedown.net:82/down/daily.zip\rhttp://hlbr.onlinedown.net/files3/daily.zip\rhttp://nc.onlinedown.net/down/daily.zip\rhttp://sx.huajun.net/files/daily.zip\rhttp://lctt.onlinedown.net/down/daily.zip\rhttp://sccrc2.onlinedown.net:82/down/daily.zip\rhttp://gzcnc.onlinedown.net:82/files/daily.zip\rhttp://sccnc.onlinedown.net/down/daily.zip\rhttp://crc.onlinedown.net:82/files/daily.zip\rhttp://cttnb.onlinedown.net/down/daily.zip\rhttp://jsnetcom.onlinedown.com/down/daily.zip\rhttp://hld165.onlinedown.net/down/daily.zip\rhttp://ctttl.onlinedown.net:82/down/daily.zip\rhttp://wznetcom.onlinedown.com:81/down/daily.zip\rhttp://zj.onlinedown.net:82/down/daily.zip\rftp://cnc:10060@221.12.150.27/daily.zip\rftp://cnc:10060@soft.10060.tv/daily.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/daily.zip\rhttp://ctttl.onlinedown.net:8080/down/daily.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (84,1126756357,1126756357,1,1,0,0,'jv16 PowerTools 2005 1.5.1.310','1394KB','英文','共享版/卸载工具','Win9x/Me/NT/2000/XP',4,'http://www.jv16.org/','','　　RegCleaner 的下一个版本。是一个可以用来清除Windows登录文件的工具。这个工具的好处是，当你执行这个工具后，会将Windows登录文件的登录资料以详细的清单显示，包括：软件名称、出版公司、很多无用的软件登录资料等等。你可以透过详细的清单显示利用RegCleaner来清除这些无用的登录资料。提供方便的清除方式，只需在要删除的登录资料内打勾，即可一次帮你自动清除。当你清除这些无用的登录资料后，你可以使用其它的登录文件重整工具来重整登录文件，可以使你的Windows登录文件大大的减肥，进而让系统执行的更顺畅。  ','http://www.macecraft.com/downloads/jv16pt_setup.exe\rhttp://sq.onlinedown.net:82/down/jv16pt_setup.exe\rhttp://wh.onlinedown.net:82/down/jv16pt_setup.exe\rhttp://ftpwh.onlinedown.net:82/down/jv16pt_setup.exe\rhttp://hlbr.onlinedown.net/files3/jv16pt_setup.exe\rhttp://nc.onlinedown.net/down/jv16pt_setup.exe\rhttp://sx.huajun.net/files/jv16pt_setup.exe\rhttp://lctt.onlinedown.net/down/jv16pt_setup.exe\rhttp://sccrc2.onlinedown.net:82/down/jv16pt_setup.exe\rhttp://gzcnc.onlinedown.net:82/files/jv16pt_setup.exe\rhttp://sccnc.onlinedown.net/down/jv16pt_setup.exe\rhttp://crc.onlinedown.net:82/files/jv16pt_setup.exe\rhttp://cttnb.onlinedown.net/down/jv16pt_setup.exe\rhttp://jsnetcom.onlinedown.com/down/jv16pt_setup.exe\rhttp://hld165.onlinedown.net/down/jv16pt_setup.exe\rhttp://ctttl.onlinedown.net:82/down/jv16pt_setup.exe\rhttp://wznetcom.onlinedown.com:81/down/jv16pt_setup.exe\rhttp://zj.onlinedown.net:82/down/jv16pt_setup.exe\rftp://cnc:10060@221.12.150.27/jv16pt_setup.exe\rftp://cnc:10060@soft.10060.tv/jv16pt_setup.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/jv16pt_setup.exe\rhttp://ctttl.onlinedown.net:8080/down/jv16pt_setup.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (85,1126756357,1126756357,1,1,0,0,'Ace Utilities 2.6.0.4026','1890KB','英文','共享版/卸载工具','Win9x/Me/NT/2000/XP',4,'http://www.acelogix.com/','','　　Ace Utilities是一个小巧而又功能强大，可以清理系统垃圾的工具。大家都有这个体会：当你的Windows使用久了, 你的计算机中就会累积大量的垃圾，使你的系统变得很慢。这些垃圾包括不必要的文件，坏掉的快捷方式 , 多余的副本文件 , 系统注册表的死项目 , 历史记录信息等。正是这些垃圾文件严重的影响了系统的性能。但是如果自己去手工修改的，不但很繁琐，而且一旦出错就可能系统崩溃、难以修复了。现在有了Ace Utilities，这些事情可以轻松搞定。  ','http://acelogix.fileburst.com/au.exe\rhttp://sq.onlinedown.net:82/down/Ace_au.exe\rhttp://wh.onlinedown.net:82/down/Ace_au.exe\rhttp://ftpwh.onlinedown.net:82/down/Ace_au.exe\rhttp://hlbr.onlinedown.net/files3/Ace_au.exe\rhttp://nc.onlinedown.net/down/Ace_au.exe\rhttp://sx.huajun.net/files/Ace_au.exe\rhttp://lctt.onlinedown.net/down/Ace_au.exe\rhttp://sccrc2.onlinedown.net:82/down/Ace_au.exe\rhttp://gzcnc.onlinedown.net:82/files/Ace_au.exe\rhttp://sccnc.onlinedown.net/down/Ace_au.exe\rhttp://crc.onlinedown.net:82/files/Ace_au.exe\rhttp://cttnb.onlinedown.net/down/Ace_au.exe\rhttp://jsnetcom.onlinedown.com/down/Ace_au.exe\rhttp://hld165.onlinedown.net/down/Ace_au.exe\rhttp://ctttl.onlinedown.net:82/down/Ace_au.exe\rhttp://wznetcom.onlinedown.com:81/down/Ace_au.exe\rhttp://zj.onlinedown.net:82/down/Ace_au.exe\rftp://cnc:10060@221.12.150.27/Ace_au.exe\rftp://cnc:10060@soft.10060.tv/Ace_au.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Ace_au.exe\rhttp://ctttl.onlinedown.net:8080/down/Ace_au.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (86,1126756358,1126756358,1,1,0,0,'江民杀毒软件KV2004 离线增量升级包09.14','1176KB','简体中文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.jiangmin.com','','&nbsp;&nbsp;&nbsp;&nbsp;\"从5岁的儿童到70岁的老人都能无障碍的使用KV 2004；封锁检查所有病毒可能入口，上网浏览、日常办公、收发邮件、信息交换与存储等用户操行电脑的一切行为均处于KV 2004的保护之下，无需用户干预，全自动清除病毒；如果不小心中了病毒，KV 2004确保所有的病毒都能得到安全彻底的清除。\"江民研发部总经理王磊向记者描述了异常美妙的技术前景。  ','http://218.56.43.205/lixianbao/KvUp20050914.exe\rhttp://sq.onlinedown.net:82/down/KvUp20050914.exe\rhttp://wh.onlinedown.net:82/down/KvUp20050914.exe\rhttp://ftpwh.onlinedown.net:82/down/KvUp20050914.exe\rhttp://hlbr.onlinedown.net/files3/KvUp20050914.exe\rhttp://nc.onlinedown.net/down/KvUp20050914.exe\rhttp://sx.huajun.net/files/KvUp20050914.exe\rhttp://lctt.onlinedown.net/down/KvUp20050914.exe\rhttp://sccrc2.onlinedown.net:82/down/KvUp20050914.exe\rhttp://gzcnc.onlinedown.net:82/files/KvUp20050914.exe\rhttp://sccnc.onlinedown.net/down/KvUp20050914.exe\rhttp://crc.onlinedown.net:82/files/KvUp20050914.exe\rhttp://cttnb.onlinedown.net/down/KvUp20050914.exe\rhttp://jsnetcom.onlinedown.com/down/KvUp20050914.exe\rhttp://hld165.onlinedown.net/down/KvUp20050914.exe\rhttp://ctttl.onlinedown.net:82/down/KvUp20050914.exe\rhttp://wznetcom.onlinedown.com:81/down/KvUp20050914.exe\rhttp://zj.onlinedown.net:82/down/KvUp20050914.exe\rftp://cnc:10060@221.12.150.27/KvUp20050914.exe\rftp://cnc:10060@soft.10060.tv/KvUp20050914.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/KvUp20050914.exe\rhttp://ctttl.onlinedown.net:8080/down/KvUp20050914.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (87,1126756358,1126756358,1,1,0,0,'光华反病毒软件离线升级包 v050916a','482KB','简体中文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.viruschina.com','','&nbsp;&nbsp;&nbsp;&nbsp;光华反病毒软件拥有自主的杀毒引擎，具有强大的技术核心，提出了一套完整的“全面查杀，封死通道”的立体反病毒新概念，开发出“查、杀、防”三套核心技术。<br>\n<br>\n具备强大的自动病毒隔离管理系统，内置绿色上网、游戏帐号和装备保护、QQ安全保护、木马搜索、注册表修复、反垃圾邮件等插件，并可无限扩展。保护系统核心数据。依靠光盘启动查杀，无需应急盘。为用户提供详尽的查毒报告、监视报告、运行报告，便捷的管理查看操作。<br>\n<br>\n光华反病毒软件为用户度身定做的贴心服务，针对游戏玩家的虚拟财产保护，针对网上银行的个人隐私与信用认证保密功能，针对即时通讯产品的信息安全保护和软件缺陷补丁等安全功能。<br>\n<br>\n产品人性化设计，操作界面简洁友好，产品在文档、界面布局、操作习惯、指示标志、图文并茂的产品说明等方面全方位贴近用户。<br>\n<br>\n服务便捷，升级迅速，让用户在第一时间享受到最可靠的安全服务，技术让用户放心，服务让用户省心。全天候的不间断技术服务支持，随时随地的线上服务应答，快速、自动、全面的升级服务。<br>\n  ','http://www.viruschina.com/html/v050916a.exe\rhttp://sq.onlinedown.net:82/down/v050916a.exe\rhttp://wh.onlinedown.net:82/down/v050916a.exe\rhttp://ftpwh.onlinedown.net:82/down/v050916a.exe\rhttp://hlbr.onlinedown.net/files3/v050916a.exe\rhttp://nc.onlinedown.net/down/v050916a.exe\rhttp://sx.huajun.net/files/v050916a.exe\rhttp://lctt.onlinedown.net/down/v050916a.exe\rhttp://sccrc2.onlinedown.net:82/down/v050916a.exe\rhttp://gzcnc.onlinedown.net:82/files/v050916a.exe\rhttp://sccnc.onlinedown.net/down/v050916a.exe\rhttp://crc.onlinedown.net:82/files/v050916a.exe\rhttp://cttnb.onlinedown.net/down/v050916a.exe\rhttp://jsnetcom.onlinedown.com/down/v050916a.exe\rhttp://hld165.onlinedown.net/down/v050916a.exe\rhttp://ctttl.onlinedown.net:82/down/v050916a.exe\rhttp://wznetcom.onlinedown.com:81/down/v050916a.exe\rhttp://zj.onlinedown.net:82/down/v050916a.exe\rftp://cnc:10060@221.12.150.27/v050916a.exe\rftp://cnc:10060@soft.10060.tv/v050916a.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/v050916a.exe\rhttp://ctttl.onlinedown.net:8080/down/v050916a.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (88,1126756358,1126756358,1,1,0,0,'VRV 新版病毒库升级文件(单机、网络客户端) 77T','6814KB','简体中文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.vrv.com.cn/','','&nbsp;&nbsp;&nbsp;&nbsp;信源反病毒体系的重要构成部分 HDGUARD&VRV ，是一种面向对象的全中文窗口杀毒软件，包含DOS及WINDOWS版本。独创“带毒杀毒”（无需干净DOS引导，即可杀毒）“多任务杀毒”（允许同时在多个窗口进行同步查杀病毒）。无误报、无损文件。\n　　升级步骤：1.将升级文件下载到 C：盘临时目录中（例如C:\\LinHao\\)，然后将 VRV杀毒软盘 去掉写保护并插入 A 驱动器。2.运行 VRVUP.EXE ，则自动开始对病毒防火墙和 VRV 杀毒软盘升级，升级完毕后请将软盘重新加上写保护。(如果A：中没有 VRV 杀毒软盘，VRVUP 程序将跳过 VRV 杀毒软盘升级过程）。VRVUP 程序为智能升级方案。   ','http://www.vrv.com.cn/update/vrvclient.exe\rhttp://sq.onlinedown.net:82/down/vrvclient.exe\rhttp://wh.onlinedown.net:82/down/vrvclient.exe\rhttp://ftpwh.onlinedown.net:82/down/vrvclient.exe\rhttp://hlbr.onlinedown.net/files3/vrvclient.exe\rhttp://nc.onlinedown.net/down/vrvclient.exe\rhttp://sx.huajun.net/files/vrvclient.exe\rhttp://lctt.onlinedown.net/down/vrvclient.exe\rhttp://sccrc2.onlinedown.net:82/down/vrvclient.exe\rhttp://gzcnc.onlinedown.net:82/files/vrvclient.exe\rhttp://sccnc.onlinedown.net/down/vrvclient.exe\rhttp://crc.onlinedown.net:82/files/vrvclient.exe\rhttp://cttnb.onlinedown.net/down/vrvclient.exe\rhttp://jsnetcom.onlinedown.com/down/vrvclient.exe\rhttp://hld165.onlinedown.net/down/vrvclient.exe\rhttp://ctttl.onlinedown.net:82/down/vrvclient.exe\rhttp://wznetcom.onlinedown.com:81/down/vrvclient.exe\rhttp://zj.onlinedown.net:82/down/vrvclient.exe\rftp://cnc:10060@221.12.150.27/vrvclient.exe\rftp://cnc:10060@soft.10060.tv/vrvclient.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/vrvclient.exe\rhttp://ctttl.onlinedown.net:8080/down/vrvclient.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (89,1126756359,1126756359,1,1,0,0,'VRV 新版病毒库升级文件(网络服务器端) 77T','6770KB','简体中文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.vrv.com.cn/','','&nbsp;&nbsp;&nbsp;&nbsp;信源反病毒体系的重要构成部分 HDGUARD&VRV ，是一种面向对象的全中文窗口杀毒软件，包含DOS及WINDOWS版本。独创“带毒杀毒”（无需干净DOS引导，即可杀毒）“多任务杀毒”（允许同时在多个窗口进行同步查杀病毒）。无误报、无损文件。<br>\n　　升级步骤：1.将升级文件下载到 C：盘临时目录中（例如C:\\LinHao\\)，然后将 VRV杀毒软盘 去掉写保护并插入 A 驱动器。2.运行 VRVUP.EXE ，则自动开始对病毒防火墙和 VRV 杀毒软盘升级，升级完毕后请将软盘重新加上写保护。(如果A：中没有 VRV 杀毒软盘，VRVUP 程序将跳过 VRV 杀毒软盘升级过程）。VRVUP 程序为智能升级方案。&nbsp;  ','http://www.vrv.com.cn/update/vrvserver.exe\rhttp://sq.onlinedown.net:82/down/vrvserver.exe\rhttp://wh.onlinedown.net:82/down/vrvserver.exe\rhttp://ftpwh.onlinedown.net:82/down/vrvserver.exe\rhttp://hlbr.onlinedown.net/files3/vrvserver.exe\rhttp://nc.onlinedown.net/down/vrvserver.exe\rhttp://sx.huajun.net/files/vrvserver.exe\rhttp://lctt.onlinedown.net/down/vrvserver.exe\rhttp://sccrc2.onlinedown.net:82/down/vrvserver.exe\rhttp://gzcnc.onlinedown.net:82/files/vrvserver.exe\rhttp://sccnc.onlinedown.net/down/vrvserver.exe\rhttp://crc.onlinedown.net:82/files/vrvserver.exe\rhttp://cttnb.onlinedown.net/down/vrvserver.exe\rhttp://jsnetcom.onlinedown.com/down/vrvserver.exe\rhttp://hld165.onlinedown.net/down/vrvserver.exe\rhttp://ctttl.onlinedown.net:82/down/vrvserver.exe\rhttp://wznetcom.onlinedown.com:81/down/vrvserver.exe\rhttp://zj.onlinedown.net:82/down/vrvserver.exe\rftp://cnc:10060@221.12.150.27/vrvserver.exe\rftp://cnc:10060@soft.10060.tv/vrvserver.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/vrvserver.exe\rhttp://ctttl.onlinedown.net:8080/down/vrvserver.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (90,1126756359,1126756359,1,1,0,0,'光华反病毒软件累积离线升级包 a050915a','16494KB','简体中文','共享版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.viruschina.com','','&nbsp;&nbsp;&nbsp;&nbsp;光华反病毒软件拥有自主的杀毒引擎，具有强大的技术核心，提出了一套完整的“全面查杀，封死通道”的立体反病毒新概念，开发出“查、杀、防”三套核心技术。<br>\n<br>\n具备强大的自动病毒隔离管理系统，内置绿色上网、游戏帐号和装备保护、QQ安全保护、木马搜索、注册表修复、反垃圾邮件等插件，并可无限扩展。保护系统核心数据。依靠光盘启动查杀，无需应急盘。为用户提供详尽的查毒报告、监视报告、运行报告，便捷的管理查看操作。<br>\n<br>\n光华反病毒软件为用户度身定做的贴心服务，针对游戏玩家的虚拟财产保护，针对网上银行的个人隐私与信用认证保密功能，针对即时通讯产品的信息安全保护和软件缺陷补丁等安全功能。<br>\n<br>\n产品人性化设计，操作界面简洁友好，产品在文档、界面布局、操作习惯、指示标志、图文并茂的产品说明等方面全方位贴近用户。<br>\n<br>\n服务便捷，升级迅速，让用户在第一时间享受到最可靠的安全服务，技术让用户放心，服务让用户省心。全天候的不间断技术服务支持，随时随地的线上服务应答，快速、自动、全面的升级服务。<br>\n  ','http://www.viruschina.com/html/a050915a.exe\rhttp://sq.onlinedown.net:82/down/a050915a.exe\rhttp://wh.onlinedown.net:82/down/a050915a.exe\rhttp://ftpwh.onlinedown.net:82/down/a050915a.exe\rhttp://hlbr.onlinedown.net/files3/a050915a.exe\rhttp://nc.onlinedown.net/down/a050915a.exe\rhttp://sx.huajun.net/files/a050915a.exe\rhttp://lctt.onlinedown.net/down/a050915a.exe\rhttp://sccrc2.onlinedown.net:82/down/a050915a.exe\rhttp://gzcnc.onlinedown.net:82/files/a050915a.exe\rhttp://sccnc.onlinedown.net/down/a050915a.exe\rhttp://crc.onlinedown.net:82/files/a050915a.exe\rhttp://cttnb.onlinedown.net/down/a050915a.exe\rhttp://jsnetcom.onlinedown.com/down/a050915a.exe\rhttp://hld165.onlinedown.net/down/a050915a.exe\rhttp://ctttl.onlinedown.net:82/down/a050915a.exe\rhttp://wznetcom.onlinedown.com:81/down/a050915a.exe\rhttp://zj.onlinedown.net:82/down/a050915a.exe\rftp://cnc:10060@221.12.150.27/a050915a.exe\rftp://cnc:10060@soft.10060.tv/a050915a.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/a050915a.exe\rhttp://ctttl.onlinedown.net:8080/down/a050915a.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (91,1126756359,1126756359,1,1,0,0,'海啸文件分割器 1.0532','3086KB','简体中文','免费版/文件分割','Win9x/Me/NT/2000/XP',4,'http://popocy.nease.net','','&nbsp;&nbsp;&nbsp;&nbsp;非常好用的一款分割和合并文件的工具，完全免费。它能够将各种类型的文件分割成指定大小，以便装于软盘中携带！分割和合并的数度快，可靠性高。  ','http://www.xiaowu.net/popocy/software/HXSplitV10.exe\rhttp://sq.onlinedown.net:82/down/HXSplitV10.exe\rhttp://wh.onlinedown.net:82/down/HXSplitV10.exe\rhttp://ftpwh.onlinedown.net:82/down/HXSplitV10.exe\rhttp://hlbr.onlinedown.net/files3/HXSplitV10.exe\rhttp://nc.onlinedown.net/down/HXSplitV10.exe\rhttp://sx.huajun.net/files/HXSplitV10.exe\rhttp://lctt.onlinedown.net/down/HXSplitV10.exe\rhttp://sccrc2.onlinedown.net:82/down/HXSplitV10.exe\rhttp://gzcnc.onlinedown.net:82/files/HXSplitV10.exe\rhttp://sccnc.onlinedown.net/down/HXSplitV10.exe\rhttp://crc.onlinedown.net:82/files/HXSplitV10.exe\rhttp://cttnb.onlinedown.net/down/HXSplitV10.exe\rhttp://jsnetcom.onlinedown.com/down/HXSplitV10.exe\rhttp://hld165.onlinedown.net/down/HXSplitV10.exe\rhttp://ctttl.onlinedown.net:82/down/HXSplitV10.exe\rhttp://wznetcom.onlinedown.com:81/down/HXSplitV10.exe\rhttp://zj.onlinedown.net:82/down/HXSplitV10.exe\rftp://cnc:10060@221.12.150.27/HXSplitV10.exe\rftp://cnc:10060@soft.10060.tv/HXSplitV10.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/HXSplitV10.exe\rhttp://ctttl.onlinedown.net:8080/down/HXSplitV10.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (92,1126756360,1126756360,1,1,0,0,'文件夹备份精灵 1.01.04','24KB','简体中文','免费版/备份工具','Win9x/Me/NT/2000/XP',4,'http://xhk.ik8.com','','&nbsp;&nbsp;&nbsp;&nbsp;此软件是一款文件夹备份工具，软件会自动比较每个文件的时间已确定该文件是否应该再次备份，这样就没有必要每次都重新备份所有的文件了，大大减少了日常备份的工作量。<br>\n>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;另外此软件在做备份操作时还可以过滤一些类型的文件，这一功能对于程序员来说是非常有用的，以后再备份源代码时，再也不用删除临时文件了，只要设置好不需要备份的文件类型就可以了。  ','http://xgstudio.home4u.china.com/DirBackup10104.zip\rhttp://sq.onlinedown.net:82/down/DirBackup10104.zip\rhttp://wh.onlinedown.net:82/down/DirBackup10104.zip\rhttp://ftpwh.onlinedown.net:82/down/DirBackup10104.zip\rhttp://hlbr.onlinedown.net/files3/DirBackup10104.zip\rhttp://nc.onlinedown.net/down/DirBackup10104.zip\rhttp://sx.huajun.net/files/DirBackup10104.zip\rhttp://lctt.onlinedown.net/down/DirBackup10104.zip\rhttp://sccrc2.onlinedown.net:82/down/DirBackup10104.zip\rhttp://gzcnc.onlinedown.net:82/files/DirBackup10104.zip\rhttp://sccnc.onlinedown.net/down/DirBackup10104.zip\rhttp://crc.onlinedown.net:82/files/DirBackup10104.zip\rhttp://cttnb.onlinedown.net/down/DirBackup10104.zip\rhttp://jsnetcom.onlinedown.com/down/DirBackup10104.zip\rhttp://hld165.onlinedown.net/down/DirBackup10104.zip\rhttp://ctttl.onlinedown.net:82/down/DirBackup10104.zip\rhttp://wznetcom.onlinedown.com:81/down/DirBackup10104.zip\rhttp://zj.onlinedown.net:82/down/DirBackup10104.zip\rftp://cnc:10060@221.12.150.27/DirBackup10104.zip\rftp://cnc:10060@soft.10060.tv/DirBackup10104.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/DirBackup10104.zip\rhttp://ctttl.onlinedown.net:8080/down/DirBackup10104.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (93,1126756360,1126756360,1,1,0,0,'Windows优化大师 6.82 Build 5.913','2876KB','简体中文','共享版/系统设置','Win9x/Me/NT/2000/XP',5,'http://www.wopti.net/','','   从桌面到网络，从系统信息检测到系统清理、维护，Windows优化大师都为您提供比较全面的解决方案。 \n   Windows优化大师 6.7 Build 5.708 更新如下： 1、改进了磁盘缓存优化。 2、网络系统优化中的IE及其他模块中增加了IE插件管理子模块。 3、改进了软件智能卸载。 (1)、提高了指定卸载分析对象的安全性。 (2)、取消了原有的可分析对象列表，增加了可分析对象树。 4、其它设置选项的系统文件备份与恢复增加了收藏夹备份与恢复功能。 5、改进了系统性能测试模块。 (1)、增加了针对LCD显示器坏点的测试模块。 (2)、增加了OpenGL性能测试模块。 (3)、增加了DirectX 7测试模块。 (4)、改进了现有的测试模块。 6、改进了驱动智能备份模块。 (1)、增加了驱动程序文件列表查看功能。 (2)、增加了驱动卸载功能。 7、改进了开机速度优化模块。 8、改进了系统信息检测。 (1)、改进了PCI设备检测模块。 (2)、改进了CPU检测。增加对P4 SmithField的识别、修正AMD Athlon 64制造工艺检测的一处错误、针对部分笔记本电脑改进了CPU速度检测。 (3)、修正了多IDE硬盘检测的问题。 (4)、改进了操作系统检测。 (5)、改进了性能提升建议模块。 9、改进了后台服务优化。 (1)、增加了后台服务设置的导出。 (2)、增加了后台服务设置的导入。 10、修正了备份恢复的一处Bug。 11、更新了ActiveX插件免疫库。 12、其它一些细小的改进和调整。 (1)、改进了软件主界面最大化及恢复处理。 (2)、增加了垃圾文件清理的可分析扫描的垃圾文件类型。\n  ','http://sq.onlinedown.net:82/down/WomV682Setup.zip\rhttp://wh.onlinedown.net:82/down/WomV682Setup.zip\rhttp://ftpwh.onlinedown.net:82/down/WomV682Setup.zip\rhttp://hlbr.onlinedown.net/files3/WomV682Setup.zip\rhttp://nc.onlinedown.net/down/WomV682Setup.zip\rhttp://sx.huajun.net/files/WomV682Setup.zip\rhttp://lctt.onlinedown.net/down/WomV682Setup.zip\rhttp://sccrc2.onlinedown.net:82/down/WomV682Setup.zip\rhttp://gzcnc.onlinedown.net:82/files/WomV682Setup.zip\rhttp://sccnc.onlinedown.net/down/WomV682Setup.zip\rhttp://crc.onlinedown.net:82/files/WomV682Setup.zip\rhttp://cttnb.onlinedown.net/down/WomV682Setup.zip\rhttp://jsnetcom.onlinedown.com/down/WomV682Setup.zip\rhttp://hld165.onlinedown.net/down/WomV682Setup.zip\rhttp://ctttl.onlinedown.net:82/down/WomV682Setup.zip\rhttp://wznetcom.onlinedown.com:81/down/WomV682Setup.zip\rhttp://zj.onlinedown.net:82/down/WomV682Setup.zip\rftp://cnc:10060@221.12.150.27/WomV682Setup.zip\rftp://cnc:10060@soft.10060.tv/WomV682Setup.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/WomV682Setup.zip\rhttp://ctttl.onlinedown.net:8080/down/WomV682Setup.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (94,1126756360,1126756360,1,1,0,0,'MSDE Manager 4.15','12829KB','英文','共享版/编程工具','Win9x/Me/NT/2000/XP',4,'http://www.valesoftware.com','','通过一个直观的界面管理MSDE/SQL数据库。  ','http://www.valesoftware.co.uk/download/msde.exe\rhttp://sq.onlinedown.net:82/down/msde.exe\rhttp://wh.onlinedown.net:82/down/msde.exe\rhttp://ftpwh.onlinedown.net:82/down/msde.exe\rhttp://hlbr.onlinedown.net/files3/msde.exe\rhttp://nc.onlinedown.net/down/msde.exe\rhttp://sx.huajun.net/files/msde.exe\rhttp://lctt.onlinedown.net/down/msde.exe\rhttp://sccrc2.onlinedown.net:82/down/msde.exe\rhttp://gzcnc.onlinedown.net:82/files/msde.exe\rhttp://sccnc.onlinedown.net/down/msde.exe\rhttp://crc.onlinedown.net:82/files/msde.exe\rhttp://cttnb.onlinedown.net/down/msde.exe\rhttp://jsnetcom.onlinedown.com/down/msde.exe\rhttp://hld165.onlinedown.net/down/msde.exe\rhttp://ctttl.onlinedown.net:82/down/msde.exe\rhttp://wznetcom.onlinedown.com:81/down/msde.exe\rhttp://zj.onlinedown.net:82/down/msde.exe\rftp://cnc:10060@221.12.150.27/msde.exe\rftp://cnc:10060@soft.10060.tv/msde.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/msde.exe\rhttp://ctttl.onlinedown.net:8080/down/msde.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (95,1126756361,1126756361,1,1,0,0,'PC-Cillin 2.838.01 Beta','7508KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.trendmicro.com/','','    可以保护您的计算机不 受传统引导型病毒、文件型病毒（或宏病毒）以及Java Applet等Internet病毒的侵害，是新一代防病毒软件。  ','http://www.trendmicro.com/ftp/products/pattern/cpr/lpt838.zip\rhttp://sq.onlinedown.net:82/down/lpt838.zip\rhttp://wh.onlinedown.net:82/down/lpt838.zip\rhttp://ftpwh.onlinedown.net:82/down/lpt838.zip\rhttp://hlbr.onlinedown.net/files3/lpt838.zip\rhttp://nc.onlinedown.net/down/lpt838.zip\rhttp://sx.huajun.net/files/lpt838.zip\rhttp://lctt.onlinedown.net/down/lpt838.zip\rhttp://sccrc2.onlinedown.net:82/down/lpt838.zip\rhttp://gzcnc.onlinedown.net:82/files/lpt838.zip\rhttp://sccnc.onlinedown.net/down/lpt838.zip\rhttp://crc.onlinedown.net:82/files/lpt838.zip\rhttp://cttnb.onlinedown.net/down/lpt838.zip\rhttp://jsnetcom.onlinedown.com/down/lpt838.zip\rhttp://hld165.onlinedown.net/down/lpt838.zip\rhttp://ctttl.onlinedown.net:82/down/lpt838.zip\rhttp://wznetcom.onlinedown.com:81/down/lpt838.zip\rhttp://zj.onlinedown.net:82/down/lpt838.zip\rftp://cnc:10060@221.12.150.27/lpt838.zip\rftp://cnc:10060@soft.10060.tv/lpt838.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/lpt838.zip\rhttp://ctttl.onlinedown.net:8080/down/lpt838.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (96,1126756361,1126756361,1,1,0,0,'FastReport 3.17.7','1576KB','英文','共享版/编程工具','Win9x/Me/NT/2000/XP',4,'http://www.fast-report.com/','','&nbsp;&nbsp;&nbsp;&nbsp;FastReport 是非常强大的报表控件，相比QuickReport，ReportBuilder更加灵活，又非常小巧，速度快。VCL版本支持Borland Delphi 2-6 and Borland C++Builder 1-6。CLX版本支持Delphi和Kylix。  ','http://www.fast-report.com/pbc_download/fr3demo.exe\rhttp://sq.onlinedown.net:82/down/fr3demo.exe\rhttp://wh.onlinedown.net:82/down/fr3demo.exe\rhttp://ftpwh.onlinedown.net:82/down/fr3demo.exe\rhttp://hlbr.onlinedown.net/files3/fr3demo.exe\rhttp://nc.onlinedown.net/down/fr3demo.exe\rhttp://sx.huajun.net/files/fr3demo.exe\rhttp://lctt.onlinedown.net/down/fr3demo.exe\rhttp://sccrc2.onlinedown.net:82/down/fr3demo.exe\rhttp://gzcnc.onlinedown.net:82/files/fr3demo.exe\rhttp://sccnc.onlinedown.net/down/fr3demo.exe\rhttp://crc.onlinedown.net:82/files/fr3demo.exe\rhttp://cttnb.onlinedown.net/down/fr3demo.exe\rhttp://jsnetcom.onlinedown.com/down/fr3demo.exe\rhttp://hld165.onlinedown.net/down/fr3demo.exe\rhttp://ctttl.onlinedown.net:82/down/fr3demo.exe\rhttp://wznetcom.onlinedown.com:81/down/fr3demo.exe\rhttp://zj.onlinedown.net:82/down/fr3demo.exe\rftp://cnc:10060@221.12.150.27/fr3demo.exe\rftp://cnc:10060@soft.10060.tv/fr3demo.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/fr3demo.exe\rhttp://ctttl.onlinedown.net:8080/down/fr3demo.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (97,1126756361,1126756361,1,1,0,0,'RegVac 4.02.08 汉化补丁','656KB','简体中文','汉化补丁/共享版/卸载工具','Win9x/Me/NT/2000/XP',4,'http://www.hanzify.org/?Go=SendMail::Software&ID=6076','','&nbsp;&nbsp;&nbsp;&nbsp;RegVac（ 注册表吸尘器 ）是一个专门清理注册表的多功能工具，内含 10 种主要工具，你可以经常利用这些工具对注册表文件作全身心的清洁。RegVac 没有太多的选项，也没有复杂的设置，操作界面也很直观，瞬间即可轻松上手。清理后建议再压缩压缩一下注册表，则更佳。<br>\n<br>\n　　注意：简体中文汉化补丁捆绑有《上网助手》和《DuDu 加速器》，在汉化过程中有选择界面。&nbsp;  ','http://sq.onlinedown.net:82/down/HB_RegVac40208_ljh.rar\rhttp://wh.onlinedown.net:82/down/HB_RegVac40208_ljh.rar\rhttp://ftpwh.onlinedown.net:82/down/HB_RegVac40208_ljh.rar\rhttp://hlbr.onlinedown.net/files3/HB_RegVac40208_ljh.rar\rhttp://nc.onlinedown.net/down/HB_RegVac40208_ljh.rar\rhttp://sx.huajun.net/files/HB_RegVac40208_ljh.rar\rhttp://lctt.onlinedown.net/down/HB_RegVac40208_ljh.rar\rhttp://sccrc2.onlinedown.net:82/down/HB_RegVac40208_ljh.rar\rhttp://gzcnc.onlinedown.net:82/files/HB_RegVac40208_ljh.rar\rhttp://sccnc.onlinedown.net/down/HB_RegVac40208_ljh.rar\rhttp://crc.onlinedown.net:82/files/HB_RegVac40208_ljh.rar\rhttp://cttnb.onlinedown.net/down/HB_RegVac40208_ljh.rar\rhttp://jsnetcom.onlinedown.com/down/HB_RegVac40208_ljh.rar\rhttp://hld165.onlinedown.net/down/HB_RegVac40208_ljh.rar\rhttp://ctttl.onlinedown.net:82/down/HB_RegVac40208_ljh.rar\rhttp://wznetcom.onlinedown.com:81/down/HB_RegVac40208_ljh.rar\rhttp://zj.onlinedown.net:82/down/HB_RegVac40208_ljh.rar\rftp://cnc:10060@221.12.150.27/HB_RegVac40208_ljh.rar\rftp://cnc:10060@soft.10060.tv/HB_RegVac40208_ljh.rar\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/HB_RegVac40208_ljh.rar\rhttp://ctttl.onlinedown.net:8080/down/HB_RegVac40208_ljh.rar','','','','');
INSERT INTO {$table_header}content_2 VALUES (98,1126756362,1126756362,1,1,0,0,'PC-Cillin 病毒码 2.837.00','7508KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.trendmicro.com/','','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;可以保护您的计算机不 受传统引导型病毒、文件型病毒（或宏病毒）以及Java Applet等Internet病毒的侵害，是新一代防病毒软件。  ','http://www.trendmicro.com/ftp/products/pattern/lpt837.zip\rhttp://sq.onlinedown.net:82/down/lpt837.zip\rhttp://wh.onlinedown.net:82/down/lpt837.zip\rhttp://ftpwh.onlinedown.net:82/down/lpt837.zip\rhttp://hlbr.onlinedown.net/files3/lpt837.zip\rhttp://nc.onlinedown.net/down/lpt837.zip\rhttp://sx.huajun.net/files/lpt837.zip\rhttp://lctt.onlinedown.net/down/lpt837.zip\rhttp://sccrc2.onlinedown.net:82/down/lpt837.zip\rhttp://gzcnc.onlinedown.net:82/files/lpt837.zip\rhttp://sccnc.onlinedown.net/down/lpt837.zip\rhttp://crc.onlinedown.net:82/files/lpt837.zip\rhttp://cttnb.onlinedown.net/down/lpt837.zip\rhttp://jsnetcom.onlinedown.com/down/lpt837.zip\rhttp://hld165.onlinedown.net/down/lpt837.zip\rhttp://ctttl.onlinedown.net:82/down/lpt837.zip\rhttp://wznetcom.onlinedown.com:81/down/lpt837.zip\rhttp://zj.onlinedown.net:82/down/lpt837.zip\rftp://cnc:10060@221.12.150.27/lpt837.zip\rftp://cnc:10060@soft.10060.tv/lpt837.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/lpt837.zip\rhttp://ctttl.onlinedown.net:8080/down/lpt837.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (99,1126756363,1126756363,1,1,0,0,'NJStar Communicator(南极星全球通) 2.51','8848KB','英文','共享版/中文平台','Win9x/Me/NT/2000/XP',4,'http://www.njstar.com/','','　　南极星全球通允许你查看并且输入中、日、韩文到任何桌面程序中,支持各种种32位版本的Windows(95/98/NT)和各种本地化版本的Windows(简体中文、繁体中文、日文、韩文),自动内码识别,可用各种输入方法(拼音、注音、双拼、仓颉等),自动按所查看文本的内码输入,可在MSOffice 97中输入,提供强大的内码转换工具,支持4.x版的IE和Netscape!升级版本，需要预先安装2.0版。内置了Email客户端软件NJStar ExpressMail，加入了韩文输入法，增加了虚拟键盘，自动将中日韩文邮件以GIF图片格式发送，经过改良的内码转换器Universal Code Convertor增加了自动监测内码及转换为GIF图片格式选项，支持IE5，修复了NT冲突及一些其他的问题。  ','http://japanology.arts.kuleuven.ac.be/mirrors/monash/njcom251.exe\rhttp://sq.onlinedown.net:82/down/njcom251.exe\rhttp://wh.onlinedown.net:82/down/njcom251.exe\rhttp://ftpwh.onlinedown.net:82/down/njcom251.exe\rhttp://hlbr.onlinedown.net/files3/njcom251.exe\rhttp://nc.onlinedown.net/down/njcom251.exe\rhttp://sx.huajun.net/files/njcom251.exe\rhttp://lctt.onlinedown.net/down/njcom251.exe\rhttp://sccrc2.onlinedown.net:82/down/njcom251.exe\rhttp://gzcnc.onlinedown.net:82/files/njcom251.exe\rhttp://sccnc.onlinedown.net/down/njcom251.exe\rhttp://crc.onlinedown.net:82/files/njcom251.exe\rhttp://cttnb.onlinedown.net/down/njcom251.exe\rhttp://jsnetcom.onlinedown.com/down/njcom251.exe\rhttp://hld165.onlinedown.net/down/njcom251.exe\rhttp://ctttl.onlinedown.net:82/down/njcom251.exe\rhttp://wznetcom.onlinedown.com:81/down/njcom251.exe\rhttp://zj.onlinedown.net:82/down/njcom251.exe\rftp://cnc:10060@221.12.150.27/njcom251.exe\rftp://cnc:10060@soft.10060.tv/njcom251.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/njcom251.exe\rhttp://ctttl.onlinedown.net:8080/down/njcom251.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (100,1126756363,1126756363,1,1,0,0,'易通电脑锁2005 4.4.5','3253KB','简体中文','共享版/系统安全','Win9x/Me/NT/2000/XP',4,'http://www.etongsoft.net','','&nbsp;&nbsp;&nbsp;&nbsp;易通电脑锁软件集电脑使用时间管理(电脑锁定、电脑关机、电脑正常使用状态)、定时系统控制操作(定时关机、重启、锁定等)、一键控制操作(一键关机、重启、锁定等)、系统保护与修复等一系列普通而实用的功能，是您电脑安全和使用管理的全新解决方案。<br>\n1.灵活的电脑使用时间管理：通过时间分段和累计使用时间两种时间控制方式对电脑的使用时间进行全方位的控制管理。时间分段控制为7 X 24小时的时间控制表。可随意地设置每天电脑使用时间段。累计使用时间控制提为每天累计使用电脑时间表，可随意地设置每天使用电脑的总时间。<br>\n2.全面的定时系统控制:系统为您提供了每月、每周、每天、每小时、自定时间、累计计时间、延时时间、键盘鼠标无操作时共八种时间控制方式。用户可根据自己需要进行设置。系统为您提供了定时关机、定时开机、定时重启、定时注销、定时锁定计算机、定时待机、定时休眠、定时执行或关闭你指定的程序、定时提醒等控制操作。<br>\n3.方便的一键控制操作:你可以随意地设置关闭计算机、重启计算机、锁定计算机、注销计算机、待机、休眠的热键，通过您设置的热键，就可以实现一键锁定计算机、一键关闭计算机、一键重启计算机、一键注销计算机、一键待机、一键休眠功能。<br>\n4.强大的系统保护与修复:快速、安全、全面地保护和修复IE/系统常见故障。  ','http://www.chinansl.com/down/clock2005.exe\rhttp://www.etongsoft.net/download/clock2005.rar\rhttp://sq.onlinedown.net:82/down/clock2005.exe\rhttp://wh.onlinedown.net:82/down/clock2005.exe\rhttp://ftpwh.onlinedown.net:82/down/clock2005.exe\rhttp://hlbr.onlinedown.net/files3/clock2005.exe\rhttp://nc.onlinedown.net/down/clock2005.exe\rhttp://sx.huajun.net/files/clock2005.exe\rhttp://lctt.onlinedown.net/down/clock2005.exe\rhttp://sccrc2.onlinedown.net:82/down/clock2005.exe\rhttp://gzcnc.onlinedown.net:82/files/clock2005.exe\rhttp://sccnc.onlinedown.net/down/clock2005.exe\rhttp://crc.onlinedown.net:82/files/clock2005.exe\rhttp://cttnb.onlinedown.net/down/clock2005.exe\rhttp://jsnetcom.onlinedown.com/down/clock2005.exe\rhttp://hld165.onlinedown.net/down/clock2005.exe\rhttp://ctttl.onlinedown.net:82/down/clock2005.exe\rhttp://wznetcom.onlinedown.com:81/down/clock2005.exe\rhttp://zj.onlinedown.net:82/down/clock2005.exe\rftp://cnc:10060@221.12.150.27/clock2005.exe\rftp://cnc:10060@soft.10060.tv/clock2005.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/clock2005.exe\rhttp://ctttl.onlinedown.net:8080/down/clock2005.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (101,1126756363,1126756363,1,1,0,0,'DOSBox 0.63','1025KB','简体中文','共享版/系统设置','Win9x/Me/NT/2000/XP',4,'http://dosbox.sourceforge.net/','','&nbsp;&nbsp;&nbsp;&nbsp;可以在任何WIN平台下运行DOS游戏，玩DOS的必备。 <br>\n　　使用方法 <br>\n　　1、安装 <br>\n　　2、运行 <br>\n　　3、在输入框状态下z:\\&gt; <br>\n　　z:\\&gt;mount c d:\\dos ===&gt;“z:\\&gt;”这个是提示符 “c”作为虚拟C盘 &quot;d:\\dos&quot;你要虚拟的文件夹位置。 <br>\n　　简洁的讲，你把你要虚拟的文件夹位置换掉上面的 D:\\DOS <br>\n　　4、在刚才的提示符下输入 c: ，这样就切换到虚拟的c盘，也就是你要的游戏目录 <br>\n　　5、运行C目录下的游戏，以后操作按DOS命令。 <br>\n  ','http://surfnet.dl.sourceforge.net/sourceforge/dosbox/DOSBox0.63-win32-installer.exe\rhttp://sq.onlinedown.net:82/down/DOSBox0.63-win32-installer.exe\rhttp://wh.onlinedown.net:82/down/DOSBox0.63-win32-installer.exe\rhttp://ftpwh.onlinedown.net:82/down/DOSBox0.63-win32-installer.exe\rhttp://hlbr.onlinedown.net/files3/DOSBox0.63-win32-installer.exe\rhttp://nc.onlinedown.net/down/DOSBox0.63-win32-installer.exe\rhttp://sx.huajun.net/files/DOSBox0.63-win32-installer.exe\rhttp://lctt.onlinedown.net/down/DOSBox0.63-win32-installer.exe\rhttp://sccrc2.onlinedown.net:82/down/DOSBox0.63-win32-installer.exe\rhttp://gzcnc.onlinedown.net:82/files/DOSBox0.63-win32-installer.exe\rhttp://sccnc.onlinedown.net/down/DOSBox0.63-win32-installer.exe\rhttp://crc.onlinedown.net:82/files/DOSBox0.63-win32-installer.exe\rhttp://cttnb.onlinedown.net/down/DOSBox0.63-win32-installer.exe\rhttp://jsnetcom.onlinedown.com/down/DOSBox0.63-win32-installer.exe\rhttp://hld165.onlinedown.net/down/DOSBox0.63-win32-installer.exe\rhttp://ctttl.onlinedown.net:82/down/DOSBox0.63-win32-installer.exe\rhttp://wznetcom.onlinedown.com:81/down/DOSBox0.63-win32-installer.exe\rhttp://zj.onlinedown.net:82/down/DOSBox0.63-win32-installer.exe\rftp://cnc:10060@221.12.150.27/DOSBox0.63-win32-installer.exe\rftp://cnc:10060@soft.10060.tv/DOSBox0.63-win32-installer.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/DOSBox0.63-win32-installer.exe\rhttp://ctttl.onlinedown.net:8080/down/DOSBox0.63-win32-installer.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (102,1126756363,1126756363,1,1,0,0,'Smart Undelete 2.3','521KB','英文','共享版/系统安全','Win9x/Me/NT/2000/XP',4,'http://www.smartundelete.com/','','是一款强大的数据恢复软件，能有效的找回已被删除的文件。易于使用，巧妙的恢复被删除的文件，甚至是那些你认为无法挽救的损失。  ','http://www.smartundelete.com/downloads/smart-undelete-setup.exe\rhttp://sq.onlinedown.net:82/down/smart-undelete-setup.exe\rhttp://wh.onlinedown.net:82/down/smart-undelete-setup.exe\rhttp://ftpwh.onlinedown.net:82/down/smart-undelete-setup.exe\rhttp://hlbr.onlinedown.net/files3/smart-undelete-setup.exe\rhttp://nc.onlinedown.net/down/smart-undelete-setup.exe\rhttp://sx.huajun.net/files/smart-undelete-setup.exe\rhttp://lctt.onlinedown.net/down/smart-undelete-setup.exe\rhttp://sccrc2.onlinedown.net:82/down/smart-undelete-setup.exe\rhttp://gzcnc.onlinedown.net:82/files/smart-undelete-setup.exe\rhttp://sccnc.onlinedown.net/down/smart-undelete-setup.exe\rhttp://crc.onlinedown.net:82/files/smart-undelete-setup.exe\rhttp://cttnb.onlinedown.net/down/smart-undelete-setup.exe\rhttp://jsnetcom.onlinedown.com/down/smart-undelete-setup.exe\rhttp://hld165.onlinedown.net/down/smart-undelete-setup.exe\rhttp://ctttl.onlinedown.net:82/down/smart-undelete-setup.exe\rhttp://wznetcom.onlinedown.com:81/down/smart-undelete-setup.exe\rhttp://zj.onlinedown.net:82/down/smart-undelete-setup.exe\rftp://cnc:10060@221.12.150.27/smart-undelete-setup.exe\rftp://cnc:10060@soft.10060.tv/smart-undelete-setup.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/smart-undelete-setup.exe\rhttp://ctttl.onlinedown.net:8080/down/smart-undelete-setup.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (117,1126775114,1126775114,1,1,0,0,'AntiVir Personal Edition 6.32.00.09','7241KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.avup.de/','','&nbsp;&nbsp;&nbsp;&nbsp;AntiVir的个人的版本提供以免受到电脑病毒的侵害，有效的保护个人电脑以及工作站的使用。 它可以检测并移除超过 50,000种病毒，支持网络更新。<br>\n具体功能如下:<br>\n--能准确检测和清除的病毒数超过5万种；<br>\n--在功能对比测试中各项指标位居前茅；<br>\n--实时病毒卫士能时刻监测各种文件操作；<br>\n--防护大型未知病毒；<br>\n--Internet更新向导更加容易更新；<br>\n--防护未知根目录病毒和主引导记录病毒<br>\n  ','http://www.avup.de/personal/en/avwinsfx.exe\rhttp://sq.onlinedown.net:82/down/avwinsfx.exe\rhttp://wh.onlinedown.net:82/down/avwinsfx.exe\rhttp://ftpwh.onlinedown.net:82/down/avwinsfx.exe\rhttp://hlbr.onlinedown.net/files3/avwinsfx.exe\rhttp://nc.onlinedown.net/down/avwinsfx.exe\rhttp://sx.huajun.net/files/avwinsfx.exe\rhttp://lctt.onlinedown.net/down/avwinsfx.exe\rhttp://sccrc2.onlinedown.net:82/down/avwinsfx.exe\rhttp://gzcnc.onlinedown.net:82/files/avwinsfx.exe\rhttp://sccnc.onlinedown.net/down/avwinsfx.exe\rhttp://crc.onlinedown.net:82/files/avwinsfx.exe\rhttp://cttnb.onlinedown.net/down/avwinsfx.exe\rhttp://jsnetcom.onlinedown.com/down/avwinsfx.exe\rhttp://hld165.onlinedown.net/down/avwinsfx.exe\rhttp://ctttl.onlinedown.net:82/down/avwinsfx.exe\rhttp://wznetcom.onlinedown.com:81/down/avwinsfx.exe\rhttp://zj.onlinedown.net:82/down/avwinsfx.exe\rftp://cnc:10060@221.12.150.27/avwinsfx.exe\rftp://cnc:10060@soft.10060.tv/avwinsfx.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/avwinsfx.exe\rhttp://ctttl.onlinedown.net:8080/down/avwinsfx.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (118,1126775114,1126775114,1,1,0,0,'NOD32 Antivirus System 2.50.44 for Win2000/NT/XP','8659KB','英文','共享版/杀毒软件','WinNT/2000/XP',4,'http://www.nod32.com/','','　　国外很权威的防病毒软件评测给了NOD32很高的分数。产品线很长，从DOS，Windows 9x/Me，Windows NT/XP/2000，到Novell Netware Server、Linux、BSD等，都有提供。在线监测功能严密，防火墙可以预警尼姆达，并可清除之。可以对邮件进行实时监测，占用内存资源较少，清除病毒的速度效果都令人满意！  ','http://u4.eset.com/eval/win/v2/nentenst.exe\rhttp://sq.onlinedown.net:82/down/nentenst.exe\rhttp://wh.onlinedown.net:82/down/nentenst.exe\rhttp://ftpwh.onlinedown.net:82/down/nentenst.exe\rhttp://hlbr.onlinedown.net/files3/nentenst.exe\rhttp://nc.onlinedown.net/down/nentenst.exe\rhttp://sx.huajun.net/files/nentenst.exe\rhttp://lctt.onlinedown.net/down/nentenst.exe\rhttp://sccrc2.onlinedown.net:82/down/nentenst.exe\rhttp://gzcnc.onlinedown.net:82/files/nentenst.exe\rhttp://sccnc.onlinedown.net/down/nentenst.exe\rhttp://crc.onlinedown.net:82/files/nentenst.exe\rhttp://cttnb.onlinedown.net/down/nentenst.exe\rhttp://jsnetcom.onlinedown.com/down/nentenst.exe\rhttp://hld165.onlinedown.net/down/nentenst.exe\rhttp://ctttl.onlinedown.net:82/down/nentenst.exe\rhttp://wznetcom.onlinedown.com:81/down/nentenst.exe\rhttp://zj.onlinedown.net:82/down/nentenst.exe\rftp://cnc:10060@221.12.150.27/nentenst.exe\rftp://cnc:10060@soft.10060.tv/nentenst.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/nentenst.exe\rhttp://ctttl.onlinedown.net:8080/down/nentenst.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (119,1126775115,1126775115,1,1,0,0,'Malicious Software Removal Tool 1.8 简体版','833KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.microsoft.com/downloads/details.aspx?displaylang=zh-cn&FamilyID=ad724ae0-e72d-4f54-9ab3-75b8eb148356','','&nbsp;&nbsp;&nbsp;&nbsp;此工具可以检查您的计算机是否被特定的流行恶意软件(包括Blaster、Sasser 和Mydoom)感染,并且帮助删除发现的任何变种.您还应该使用反病毒产品,以删除可能存在的任何其他恶意软件.此工具可帮助维护您的计算机;出现此工具,并非意味着您的计算机已受恶意软件的感染.安装本项目后,可能需要重新启动计算机.  ','http://download.microsoft.com/download/3/9/8/3982d61b-07a5-44cd-a7a7-1aa4565f0e93/Windows-KB890830-V1.8-CHS.exe\rhttp://sq.onlinedown.net:82/down/Windows-KB890830-V1.8-CHS.exe\rhttp://wh.onlinedown.net:82/down/Windows-KB890830-V1.8-CHS.exe\rhttp://ftpwh.onlinedown.net:82/down/Windows-KB890830-V1.8-CHS.exe\rhttp://hlbr.onlinedown.net/files3/Windows-KB890830-V1.8-CHS.exe\rhttp://nc.onlinedown.net/down/Windows-KB890830-V1.8-CHS.exe\rhttp://sx.huajun.net/files/Windows-KB890830-V1.8-CHS.exe\rhttp://lctt.onlinedown.net/down/Windows-KB890830-V1.8-CHS.exe\rhttp://sccrc2.onlinedown.net:82/down/Windows-KB890830-V1.8-CHS.exe\rhttp://gzcnc.onlinedown.net:82/files/Windows-KB890830-V1.8-CHS.exe\rhttp://sccnc.onlinedown.net/down/Windows-KB890830-V1.8-CHS.exe\rhttp://crc.onlinedown.net:82/files/Windows-KB890830-V1.8-CHS.exe\rhttp://cttnb.onlinedown.net/down/Windows-KB890830-V1.8-CHS.exe\rhttp://jsnetcom.onlinedown.com/down/Windows-KB890830-V1.8-CHS.exe\rhttp://hld165.onlinedown.net/down/Windows-KB890830-V1.8-CHS.exe\rhttp://ctttl.onlinedown.net:82/down/Windows-KB890830-V1.8-CHS.exe\rhttp://wznetcom.onlinedown.com:81/down/Windows-KB890830-V1.8-CHS.exe\rhttp://zj.onlinedown.net:82/down/Windows-KB890830-V1.8-CHS.exe\rftp://cnc:10060@221.12.150.27/Windows-KB890830-V1.8-CHS.exe\rftp://cnc:10060@soft.10060.tv/Windows-KB890830-V1.8-CHS.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Windows-KB890830-V1.8-CHS.exe\rhttp://ctttl.onlinedown.net:8080/down/Windows-KB890830-V1.8-CHS.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (120,1126775115,1126775115,1,1,0,0,'Malicious Software Removal Tool 1.8 英文版','831KB','英文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.microsoft.com/downloads/details.aspx?familyid=AD724AE0-E72D-4F54-9AB3-75B8EB148356&displaylang=en','','&nbsp;&nbsp;&nbsp;&nbsp;检查 Windows XP、Windows 2000 及 Windows Server 2003 计算机是否受到了各种特定的和流行的恶意软件的感染(包括 Blaster、Sasser 和 Mydoom)，并帮助删除感染。完成检测和删除过程后，该工具将显示一个报告，描述其执行结果，包括检测到的和删除的恶意软件(如果有)。另外，它会在 %WINDIR%\\debug 文件夹中创建一个名为 mrt.log 的日志文件。   ','http://download.microsoft.com/download/4/a/a/4aa524c6-239d-47ff-860b-5b397199cbf8/Windows-KB890830-V1.8-ENU.exe\rhttp://sq.onlinedown.net:82/down/Windows-KB890830-V1.8-ENU.exe\rhttp://wh.onlinedown.net:82/down/Windows-KB890830-V1.8-ENU.exe\rhttp://ftpwh.onlinedown.net:82/down/Windows-KB890830-V1.8-ENU.exe\rhttp://hlbr.onlinedown.net/files3/Windows-KB890830-V1.8-ENU.exe\rhttp://nc.onlinedown.net/down/Windows-KB890830-V1.8-ENU.exe\rhttp://sx.huajun.net/files/Windows-KB890830-V1.8-ENU.exe\rhttp://lctt.onlinedown.net/down/Windows-KB890830-V1.8-ENU.exe\rhttp://sccrc2.onlinedown.net:82/down/Windows-KB890830-V1.8-ENU.exe\rhttp://gzcnc.onlinedown.net:82/files/Windows-KB890830-V1.8-ENU.exe\rhttp://sccnc.onlinedown.net/down/Windows-KB890830-V1.8-ENU.exe\rhttp://crc.onlinedown.net:82/files/Windows-KB890830-V1.8-ENU.exe\rhttp://cttnb.onlinedown.net/down/Windows-KB890830-V1.8-ENU.exe\rhttp://jsnetcom.onlinedown.com/down/Windows-KB890830-V1.8-ENU.exe\rhttp://hld165.onlinedown.net/down/Windows-KB890830-V1.8-ENU.exe\rhttp://ctttl.onlinedown.net:82/down/Windows-KB890830-V1.8-ENU.exe\rhttp://wznetcom.onlinedown.com:81/down/Windows-KB890830-V1.8-ENU.exe\rhttp://zj.onlinedown.net:82/down/Windows-KB890830-V1.8-ENU.exe\rftp://cnc:10060@221.12.150.27/Windows-KB890830-V1.8-ENU.exe\rftp://cnc:10060@soft.10060.tv/Windows-KB890830-V1.8-ENU.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Windows-KB890830-V1.8-ENU.exe\rhttp://ctttl.onlinedown.net:8080/down/Windows-KB890830-V1.8-ENU.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (121,1126775115,1126775115,1,1,0,0,'Malicious Software Removal Tool 1.8 繁体版','833KB','繁体中文','免费版/杀毒软件','Win9x/Me/NT/2000/XP',4,'http://www.microsoft.com/downloads/details.aspx?familyid=AD724AE0-E72D-4F54-9AB3-75B8EB148356&displaylang=zh-tw','','&nbsp;&nbsp;&nbsp;&nbsp;此工具可以检查您的计算机是否被特定的流行恶意软件(包括Blaster、Sasser 和Mydoom)感染,并且帮助删除发现的任何变种.您还应该使用反病毒产品,以删除可能存在的任何其他恶意软件.此工具可帮助维护您的计算机;出现此工具,并非意味着您的计算机已受恶意软件的感染.安装本项目后,可能需要重新启动计算机.  ','http://download.microsoft.com/download/1/d/9/1d9d44de-60ee-4d7a-b2b7-844e700c7fe9/Windows-KB890830-V1.8-CHT.exe\rhttp://sq.onlinedown.net:82/down/Windows-KB890830-V1.8-CHT.exe\rhttp://wh.onlinedown.net:82/down/Windows-KB890830-V1.8-CHT.exe\rhttp://ftpwh.onlinedown.net:82/down/Windows-KB890830-V1.8-CHT.exe\rhttp://hlbr.onlinedown.net/files3/Windows-KB890830-V1.8-CHT.exe\rhttp://nc.onlinedown.net/down/Windows-KB890830-V1.8-CHT.exe\rhttp://sx.huajun.net/files/Windows-KB890830-V1.8-CHT.exe\rhttp://lctt.onlinedown.net/down/Windows-KB890830-V1.8-CHT.exe\rhttp://sccrc2.onlinedown.net:82/down/Windows-KB890830-V1.8-CHT.exe\rhttp://gzcnc.onlinedown.net:82/files/Windows-KB890830-V1.8-CHT.exe\rhttp://sccnc.onlinedown.net/down/Windows-KB890830-V1.8-CHT.exe\rhttp://crc.onlinedown.net:82/files/Windows-KB890830-V1.8-CHT.exe\rhttp://cttnb.onlinedown.net/down/Windows-KB890830-V1.8-CHT.exe\rhttp://jsnetcom.onlinedown.com/down/Windows-KB890830-V1.8-CHT.exe\rhttp://hld165.onlinedown.net/down/Windows-KB890830-V1.8-CHT.exe\rhttp://ctttl.onlinedown.net:82/down/Windows-KB890830-V1.8-CHT.exe\rhttp://wznetcom.onlinedown.com:81/down/Windows-KB890830-V1.8-CHT.exe\rhttp://zj.onlinedown.net:82/down/Windows-KB890830-V1.8-CHT.exe\rftp://cnc:10060@221.12.150.27/Windows-KB890830-V1.8-CHT.exe\rftp://cnc:10060@soft.10060.tv/Windows-KB890830-V1.8-CHT.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Windows-KB890830-V1.8-CHT.exe\rhttp://ctttl.onlinedown.net:8080/down/Windows-KB890830-V1.8-CHT.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (122,1126775115,1126775115,1,1,0,0,'BySoft FreeRAM 4.0.4.257','492KB','英文','免费版/内存管理','Win9x/Me/NT/2000/XP',4,'http://www.bysoft.com/','','　　FreeRAM是一套可手动或自动释放内存的工具，可以调整间隔时间，自动检查内存的下限，当内存到达下限时、它会自动处理非必要程序占用的内存，还提供内存状态与CPU的使用图表，提供多组SKIN可共更换。  ','http://free-st.t-com.hr/bysoft/BySoftFreeRAM32.exe\rhttp://sq.onlinedown.net:82/down/BySoftFreeRAM32.exe\rhttp://wh.onlinedown.net:82/down/BySoftFreeRAM32.exe\rhttp://ftpwh.onlinedown.net:82/down/BySoftFreeRAM32.exe\rhttp://hlbr.onlinedown.net/files3/BySoftFreeRAM32.exe\rhttp://nc.onlinedown.net/down/BySoftFreeRAM32.exe\rhttp://sx.huajun.net/files/BySoftFreeRAM32.exe\rhttp://lctt.onlinedown.net/down/BySoftFreeRAM32.exe\rhttp://sccrc2.onlinedown.net:82/down/BySoftFreeRAM32.exe\rhttp://gzcnc.onlinedown.net:82/files/BySoftFreeRAM32.exe\rhttp://sccnc.onlinedown.net/down/BySoftFreeRAM32.exe\rhttp://crc.onlinedown.net:82/files/BySoftFreeRAM32.exe\rhttp://cttnb.onlinedown.net/down/BySoftFreeRAM32.exe\rhttp://jsnetcom.onlinedown.com/down/BySoftFreeRAM32.exe\rhttp://hld165.onlinedown.net/down/BySoftFreeRAM32.exe\rhttp://ctttl.onlinedown.net:82/down/BySoftFreeRAM32.exe\rhttp://wznetcom.onlinedown.com:81/down/BySoftFreeRAM32.exe\rhttp://zj.onlinedown.net:82/down/BySoftFreeRAM32.exe\rftp://cnc:10060@221.12.150.27/BySoftFreeRAM32.exe\rftp://cnc:10060@soft.10060.tv/BySoftFreeRAM32.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/BySoftFreeRAM32.exe\rhttp://ctttl.onlinedown.net:8080/down/BySoftFreeRAM32.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (123,1126775116,1126775116,1,1,0,0,'流氓软件清理助手 1.34','308KB','简体中文','免费版/卸载工具','Win9x/Me/NT/2000/XP',4,'http://www.tommsoft.com/','','&nbsp;&nbsp;&nbsp;&nbsp;流氓软件清理助手，目前可以清理下列流氓软件：一搜工具条 完美网译通 CNIC中文上网 博采网摘 百度搜霸 3721上网助手 360搜 Dudu下载加速器 很棒小秘书 网络猪 划词搜索。  ','http://sq.onlinedown.net:82/down/RogueCleaner.rar\rhttp://wh.onlinedown.net:82/down/RogueCleaner.rar\rhttp://ftpwh.onlinedown.net:82/down/RogueCleaner.rar\rhttp://hlbr.onlinedown.net/files3/RogueCleaner.rar\rhttp://nc.onlinedown.net/down/RogueCleaner.rar\rhttp://sx.huajun.net/files/RogueCleaner.rar\rhttp://lctt.onlinedown.net/down/RogueCleaner.rar\rhttp://sccrc2.onlinedown.net:82/down/RogueCleaner.rar\rhttp://gzcnc.onlinedown.net:82/files/RogueCleaner.rar\rhttp://sccnc.onlinedown.net/down/RogueCleaner.rar\rhttp://crc.onlinedown.net:82/files/RogueCleaner.rar\rhttp://cttnb.onlinedown.net/down/RogueCleaner.rar\rhttp://jsnetcom.onlinedown.com/down/RogueCleaner.rar\rhttp://hld165.onlinedown.net/down/RogueCleaner.rar\rhttp://ctttl.onlinedown.net:82/down/RogueCleaner.rar\rhttp://wznetcom.onlinedown.com:81/down/RogueCleaner.rar\rhttp://zj.onlinedown.net:82/down/RogueCleaner.rar\rftp://cnc:10060@221.12.150.27/RogueCleaner.rar\rftp://cnc:10060@soft.10060.tv/RogueCleaner.rar\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/RogueCleaner.rar\rhttp://ctttl.onlinedown.net:8080/down/RogueCleaner.rar','','','','');
INSERT INTO {$table_header}content_2 VALUES (124,1126775116,1126775116,1,1,0,0,'Turbo Searcher 3.30.052705','1986KB','英文','共享版/文件管理','Win9x/Me/NT/2000/XP',4,'http://www.knownsoft.com/','','键入几个词再按回车键，你要的一切将立即列出。Turbo Searcher是一款快速进行文件搜索的工具，通常搜索时间仅为0.xxx秒，可以用文件名、文件夹、时间、大小等搜索任何文件，特别适用于搜索图片、音乐和影音文件，用户需要做的只是点击鼠标。提供如此强大的搜索ASCII、UNICODE字符串和HEX代码的搜索能力，可以从Windows资源管理其中启动，是windows文件搜索工具的完整替代工具。  ','http://www.knownsoft.com/Download/TS330.exe\rhttp://sq.onlinedown.net:82/down/TS330.exe\rhttp://wh.onlinedown.net:82/down/TS330.exe\rhttp://ftpwh.onlinedown.net:82/down/TS330.exe\rhttp://hlbr.onlinedown.net/files3/TS330.exe\rhttp://nc.onlinedown.net/down/TS330.exe\rhttp://sx.huajun.net/files/TS330.exe\rhttp://lctt.onlinedown.net/down/TS330.exe\rhttp://sccrc2.onlinedown.net:82/down/TS330.exe\rhttp://gzcnc.onlinedown.net:82/files/TS330.exe\rhttp://sccnc.onlinedown.net/down/TS330.exe\rhttp://crc.onlinedown.net:82/files/TS330.exe\rhttp://cttnb.onlinedown.net/down/TS330.exe\rhttp://jsnetcom.onlinedown.com/down/TS330.exe\rhttp://hld165.onlinedown.net/down/TS330.exe\rhttp://ctttl.onlinedown.net:82/down/TS330.exe\rhttp://wznetcom.onlinedown.com:81/down/TS330.exe\rhttp://zj.onlinedown.net:82/down/TS330.exe\rftp://cnc:10060@221.12.150.27/TS330.exe\rftp://cnc:10060@soft.10060.tv/TS330.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/TS330.exe\rhttp://ctttl.onlinedown.net:8080/down/TS330.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (125,1126775116,1126775116,1,1,0,0,'Serial Monitor 4.01','1491KB','英文','共享版/系统测试','Win9x/Me/NT/2000/XP',4,'http://www.hhdsoftware.com/sermon.html','','&nbsp;&nbsp;&nbsp;&nbsp;Serial Monitor是一款功能强大的串口监视、检测、分析工具，软件使用更加简单，尤其适合开发人员使用。  ','http://hhd.df.ru/Download/sermon.exe\rhttp://sq.onlinedown.net:82/down/sermon.exe\rhttp://wh.onlinedown.net:82/down/sermon.exe\rhttp://ftpwh.onlinedown.net:82/down/sermon.exe\rhttp://hlbr.onlinedown.net/files3/sermon.exe\rhttp://nc.onlinedown.net/down/sermon.exe\rhttp://sx.huajun.net/files/sermon.exe\rhttp://lctt.onlinedown.net/down/sermon.exe\rhttp://sccrc2.onlinedown.net:82/down/sermon.exe\rhttp://gzcnc.onlinedown.net:82/files/sermon.exe\rhttp://sccnc.onlinedown.net/down/sermon.exe\rhttp://crc.onlinedown.net:82/files/sermon.exe\rhttp://cttnb.onlinedown.net/down/sermon.exe\rhttp://jsnetcom.onlinedown.com/down/sermon.exe\rhttp://hld165.onlinedown.net/down/sermon.exe\rhttp://ctttl.onlinedown.net:82/down/sermon.exe\rhttp://wznetcom.onlinedown.com:81/down/sermon.exe\rhttp://zj.onlinedown.net:82/down/sermon.exe\rftp://cnc:10060@221.12.150.27/sermon.exe\rftp://cnc:10060@soft.10060.tv/sermon.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/sermon.exe\rhttp://ctttl.onlinedown.net:8080/down/sermon.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (126,1126775116,1126775116,1,1,0,0,'Rollup 1 for Windows 2000 SP4 更新汇总 英文版 (09.13)','31957KB','英文','免费版/系统加强','Win9x/Me/NT/2000/XP',4,'http://www.microsoft.com/downloads/details.aspx?displaylang=en&FamilyID=B54730CF-8850-4531-B52B-BF28B324C662','','&nbsp;&nbsp;&nbsp;&nbsp;Update Rollup 1是一个包括了Hotfix，安全补丁和关键更新在内的累积性补丁，将提高Win2000的易用性。　　 <br><br>\n<br><br>\n　　作为累积补丁，Update Rollup包括Windows 2000 SP4发布以来的所有安全更新，同时它还具有一些重要的非安全方面的更新。也就是说，无论你用何版本Windows 2000，只要安装 Windows 2000 Update Rollup，你就拥有了Windows 2000“从古至今”所有的补丁了，不会遗漏，也再没有新的了，就像一个十全补丁。　  ','http://download.microsoft.com/download/2/7/b/27b1d1a3-0299-4336-b88a-22b9f09817e2/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://sq.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://wh.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://ftpwh.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://hlbr.onlinedown.net/files3/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://nc.onlinedown.net/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://sx.huajun.net/files/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://lctt.onlinedown.net/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://sccrc2.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://gzcnc.onlinedown.net:82/files/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://sccnc.onlinedown.net/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://crc.onlinedown.net:82/files/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://cttnb.onlinedown.net/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://jsnetcom.onlinedown.com/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://hld165.onlinedown.net/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://ctttl.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://wznetcom.onlinedown.com:81/down/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://zj.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-ENU.EXE\rftp://cnc:10060@221.12.150.27/Windows2000-KB891861-v2-x86-ENU.EXE\rftp://cnc:10060@soft.10060.tv/Windows2000-KB891861-v2-x86-ENU.EXE\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Windows2000-KB891861-v2-x86-ENU.EXE\rhttp://ctttl.onlinedown.net:8080/down/Windows2000-KB891861-v2-x86-ENU.EXE','','','','');
INSERT INTO {$table_header}content_2 VALUES (127,1126775117,1126775117,1,1,0,0,'Rollup 1 for Windows 2000 SP4 更新汇总 繁体版（09.13）','31647KB','繁体中文','免费版/系统加强','Win9x/Me/NT/2000/XP',4,'http://www.microsoft.com/downloads/details.aspx?familyid=B54730CF-8850-4531-B52B-BF28B324C662&displaylang=zh-tw','','&nbsp;&nbsp;&nbsp;&nbsp;Update Rollup 1是一个包括了Hotfix，安全补丁和关键更新在内的累积性补丁，将提高Win2000的易用性。　　\n<br><br>\n　　作为累积补丁，Update Rollup包括Windows 2000 SP4发布以来的所有安全更新，同时它还具有一些重要的非安全方面的更新。也就是说，无论你用何版本Windows 2000，只要安装 Windows 2000 Update Rollup，你就拥有了Windows 2000“从古至今”所有的补丁了，不会遗漏，也再没有新的了，就像一个十全补丁。　  ','http://download.microsoft.com/download/9/b/f/9bfb624e-5adb-4efb-ae99-ad129ca5839a/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://sq.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://wh.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://ftpwh.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://hlbr.onlinedown.net/files3/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://nc.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://sx.huajun.net/files/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://lctt.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://sccrc2.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://gzcnc.onlinedown.net:82/files/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://sccnc.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://crc.onlinedown.net:82/files/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://cttnb.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://jsnetcom.onlinedown.com/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://hld165.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://ctttl.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://wznetcom.onlinedown.com:81/down/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://zj.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHT.EXE\rftp://cnc:10060@221.12.150.27/Windows2000-KB891861-v2-x86-CHT.EXE\rftp://cnc:10060@soft.10060.tv/Windows2000-KB891861-v2-x86-CHT.EXE\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Windows2000-KB891861-v2-x86-CHT.EXE\rhttp://ctttl.onlinedown.net:8080/down/Windows2000-KB891861-v2-x86-CHT.EXE','','','','');
INSERT INTO {$table_header}content_2 VALUES (128,1126775117,1126775117,1,1,0,0,'通用数据库前端管理平台 6.20','18168KB','简体中文','免费版/编程工具','Win9x/Me/NT/2000/XP',4,'','','&nbsp;&nbsp;&nbsp;&nbsp;数据库管理平台包含对多种数据源数据的连接和数据查看、操作、查询、数据导入导出以及图表反映、报表制作等功能。<br>\n　　累积开发人员多年的心血，系统有非常强大的数据库操作能力，无论是DBA、DBO还是最终用户，都能享受到该软件带来的许多便捷且人性化的功能。  ','http://sq.onlinedown.net:82/down/DM6.20Inst.rar\rhttp://wh.onlinedown.net:82/down/DM6.20Inst.rar\rhttp://ftpwh.onlinedown.net:82/down/DM6.20Inst.rar\rhttp://hlbr.onlinedown.net/files3/DM6.20Inst.rar\rhttp://nc.onlinedown.net/down/DM6.20Inst.rar\rhttp://sx.huajun.net/files/DM6.20Inst.rar\rhttp://lctt.onlinedown.net/down/DM6.20Inst.rar\rhttp://sccrc2.onlinedown.net:82/down/DM6.20Inst.rar\rhttp://gzcnc.onlinedown.net:82/files/DM6.20Inst.rar\rhttp://sccnc.onlinedown.net/down/DM6.20Inst.rar\rhttp://crc.onlinedown.net:82/files/DM6.20Inst.rar\rhttp://cttnb.onlinedown.net/down/DM6.20Inst.rar\rhttp://jsnetcom.onlinedown.com/down/DM6.20Inst.rar\rhttp://hld165.onlinedown.net/down/DM6.20Inst.rar\rhttp://ctttl.onlinedown.net:82/down/DM6.20Inst.rar\rhttp://wznetcom.onlinedown.com:81/down/DM6.20Inst.rar\rhttp://zj.onlinedown.net:82/down/DM6.20Inst.rar\rftp://cnc:10060@221.12.150.27/DM6.20Inst.rar\rftp://cnc:10060@soft.10060.tv/DM6.20Inst.rar\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/DM6.20Inst.rar\rhttp://ctttl.onlinedown.net:8080/down/DM6.20Inst.rar','','','','');
INSERT INTO {$table_header}content_2 VALUES (129,1126775117,1126775117,1,1,0,0,'Rollup 1 for Windows 2000 SP4 更新汇总 简体版 (09.13)','31634KB','简体中文','免费版/系统加强','Win9x/Me/NT/2000/XP',4,'http://www.microsoft.com/downloads/details.aspx?displaylang=zh-cn&FamilyID=B54730CF-8850-4531-B52B-BF28B324C662','','&nbsp;&nbsp;&nbsp;&nbsp;Update Rollup 1是一个包括了Hotfix，安全补丁和关键更新在内的累积性补丁，将提高Win2000的易用性。　　 <br>\n<br>\n　　作为累积补丁，Update Rollup包括Windows 2000 SP4发布以来的所有安全更新，同时它还具有一些重要的非安全方面的更新。也就是说，无论你用何版本Windows 2000，只要安装 Windows 2000 Update Rollup，你就拥有了Windows 2000“从古至今”所有的补丁了，不会遗漏，也再没有新的了，就像一个十全补丁。　  ','http://download.microsoft.com/download/7/e/9/7e969f31-e33d-45a2-9d1a-fecbcde29a0e/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://sq.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://wh.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://ftpwh.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://hlbr.onlinedown.net/files3/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://nc.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://sx.huajun.net/files/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://lctt.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://sccrc2.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://gzcnc.onlinedown.net:82/files/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://sccnc.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://crc.onlinedown.net:82/files/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://cttnb.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://jsnetcom.onlinedown.com/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://hld165.onlinedown.net/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://ctttl.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://wznetcom.onlinedown.com:81/down/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://zj.onlinedown.net:82/down/Windows2000-KB891861-v2-x86-CHS.EXE\rftp://cnc:10060@221.12.150.27/Windows2000-KB891861-v2-x86-CHS.EXE\rftp://cnc:10060@soft.10060.tv/Windows2000-KB891861-v2-x86-CHS.EXE\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/Windows2000-KB891861-v2-x86-CHS.EXE\rhttp://ctttl.onlinedown.net:8080/down/Windows2000-KB891861-v2-x86-CHS.EXE','','','','');
INSERT INTO {$table_header}content_2 VALUES (130,1126775117,1127913472,1,1,0,0,'“天亿”文件分割合并器 3.3','3298KB','简体中文','免费软件','Win9x/Me/NT/2000/XP',4,'','','&nbsp;&nbsp;&nbsp;&nbsp;\"天亿\"文件分割合并器是一款极好的文件分割合并工具，它能够将各种类型的文件分割成指定大小，您不妨试试。完全适用于:Win98/Me/2000/Nt/Xp/2003 ','http://sq.onlinedown.net:82/down/tyFileCut330.exe\nhttp://wh.onlinedown.net:82/down/tyFileCut330.exe\nhttp://ftpwh.onlinedown.net:82/down/tyFileCut330.exe\nhttp://hlbr.onlinedown.net/files3/tyFileCut330.exe\nhttp://nc.onlinedown.net/down/tyFileCut330.exe\nhttp://sx.huajun.net/files/tyFileCut330.exe\nhttp://lctt.onlinedown.net/down/tyFileCut330.exe\nhttp://sccrc2.onlinedown.net:82/down/tyFileCut330.exe\nhttp://gzcnc.onlinedown.net:82/files/tyFileCut330.exe\nhttp://sccnc.onlinedown.net/down/tyFileCut330.exe\nhttp://crc.onlinedown.net:82/files/tyFileCut330.exe\nhttp://cttnb.onlinedown.net/down/tyFileCut330.exe\nhttp://jsnetcom.onlinedown.com/down/tyFileCut330.exe\nhttp://hld165.onlinedown.net/down/tyFileCut330.exe\nhttp://ctttl.onlinedown.net:82/down/tyFileCut330.exe\nhttp://wznetcom.onlinedown.com:81/down/tyFileCut330.exe\nhttp://zj.onlinedown.net:82/down/tyFileCut330.exe\nftp://cnc:10060@221.12.150.27/tyFileCut330.exe\nftp://cnc:10060@soft.10060.tv/tyFileCut330.exe\nftp://wzcnc:wzcnc@onlinedown.wzcnc.com/tyFileCut330.exe\nhttp://ctttl.onlinedown.net:8080/down/tyFileCut330.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (131,1126854683,1126854683,1,1,0,0,'易用支票打印系统 3.051','6065KB','简体中文','共享版/打印工具','Win9x/Me/NT/2000/XP',4,'http://leidong.qyun.net','','&nbsp;&nbsp;&nbsp;&nbsp;易用支票打印系统是作者在数年的财务工作中经常使用到的票据填写经验上，编写出来的，具有高度的实践性。它是一款真正意义上的适用出纳工作需要的工具软件，充分满足了用户支票打印的需求。功能强大，操作简单，设置灵活，打印快速，位置准确，界面友好，充分实现了程序的高度智能化目标。<br>\n<br>\n软件特点: <br>\n1.单位信息储存,可直接调用；<br>\n2.小写数字直接转大写形式；<br>\n3.转账支票自动生成进账单；<br>\n4.收款人查询并选择快速方便(特别适用大型用户),只要输入任意一个字,就能查出含有该字的所有用户；<br>\n5.支持普通/平推式针式、激光和喷墨打印机；<br>\n6.可整体打印调整(元素全部选定)，也可分元素单独调整位置字体等；<br>\n7.可以批量打印支票；<br>\n8.数据可备份、恢复；<br>\n9.能把Excel文件中的数据导入到系统中，具备和第三方软件的接口功能；<br>\n10.开支票的同时自动可记录各类单据使用情况（支票保存、作废、查询、修改，删除等）；<br>\n11.打印的票据准确、规范；<br>\n&nbsp;&nbsp;&nbsp;3.05版新增功能<br>\n1、打印电汇单<br>\n2、自定义票据打印（可自定义8种票据）<br>\n3、提供详细的帮助系统和操作流程图。<br>\n联系我们&nbsp;&nbsp;如果您对支票打印软件感兴趣，请联系我们，让您轻松掌握支票打印技巧，为您创造效益，提高效率。 (LEIDONG_888@126.COM、LEIDONG_888@SOHU.COM) <br>\n  ','http://diy.qyun.net/leidong/soft/zp-setup_3.051.rar\rhttp://sq.onlinedown.net:82/down/zp-setup_3.051.rar\rhttp://wh.onlinedown.net:82/down/zp-setup_3.051.rar\rhttp://ftpwh.onlinedown.net:82/down/zp-setup_3.051.rar\rhttp://hlbr.onlinedown.net/files3/zp-setup_3.051.rar\rhttp://nc.onlinedown.net/down/zp-setup_3.051.rar\rhttp://sx.huajun.net/files/zp-setup_3.051.rar\rhttp://lctt.onlinedown.net/down/zp-setup_3.051.rar\rhttp://sccrc2.onlinedown.net:82/down/zp-setup_3.051.rar\rhttp://gzcnc.onlinedown.net:82/files/zp-setup_3.051.rar\rhttp://sccnc.onlinedown.net/down/zp-setup_3.051.rar\rhttp://crc.onlinedown.net:82/files/zp-setup_3.051.rar\rhttp://cttnb.onlinedown.net/down/zp-setup_3.051.rar\rhttp://jsnetcom.onlinedown.com/down/zp-setup_3.051.rar\rhttp://hld165.onlinedown.net/down/zp-setup_3.051.rar\rhttp://ctttl.onlinedown.net:82/down/zp-setup_3.051.rar\rhttp://wznetcom.onlinedown.com:81/down/zp-setup_3.051.rar\rhttp://zj.onlinedown.net:82/down/zp-setup_3.051.rar\rftp://cnc:10060@221.12.150.27/zp-setup_3.051.rar\rftp://cnc:10060@soft.10060.tv/zp-setup_3.051.rar\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/zp-setup_3.051.rar\rhttp://ctttl.onlinedown.net:8080/down/zp-setup_3.051.rar','','','','');
INSERT INTO {$table_header}content_2 VALUES (132,1126854684,1126854684,1,1,0,0,'音乐CD抓轨大师 1.12','6962KB','简体中文','共享版/光碟工具','Win9x/Me/NT/2000/XP',4,'http://www.flywing.cn','','是一款将音乐CD转化为MP3，WAV，WMA，OGG音频格式的软件，以使您能将CD上的音乐永久地保存到计算机硬盘或复制到MP3播放器上。并在转化过程中最大程度地保留原CD的音质。 <br>\n&nbsp;&nbsp;&nbsp;&nbsp;主要功能和特色：1、支持MP3，WAV，WMA，OGG多种音频格式。2、支持普通CD以及目前市面上较常见的HDCD（防盗拷CD）盘片。3、转化后无版权限制。4、提供ID3信息编辑器。5、提供CDDB功能。6、换肤功能。7、支持多光驱。  ','http://sq3.onlinedown.net/down/audio_cd_ripper.exe\rhttp://hld.onlinedown.net/down/audio_cd_ripper.exe\rhttp://wh.onlinedown.net:82/down/audio_cd_ripper.exe\rhttp://ftpwh.onlinedown.net:82/down/audio_cd_ripper.exe\rhttp://hlbr.onlinedown.net/files3/audio_cd_ripper.exe\rhttp://nc.onlinedown.net/down/audio_cd_ripper.exe\rhttp://sx.huajun.net/down/audio_cd_ripper.exe\rhttp://nn.onlinedown.net/down/audio_cd_ripper.exe\rhttp://sccrc.onlinedown.net:82/files2/audio_cd_ripper.exe\rhttp://gzcnc.onlinedown.net:82/files/audio_cd_ripper.exe\rhttp://sccnc.onlinedown.net/down/audio_cd_ripper.exe\rhttp://jsnetcom.onlinedown.com/down/audio_cd_ripper.exe\rhttp://hbcrc.onlinedown.net:82/down/audio_cd_ripper.exe\rhttp://ctttl.onlinedown.net:82/down/audio_cd_ripper.exe\rhttp://sxbctv.onlinedown.net/down/audio_cd_ripper.exe\rftp://cnc:10060@221.12.150.27/audio_cd_ripper.exe\rftp://cnc:10060@soft.10060.tv/audio_cd_ripper.exe\rhttp://snxa.onlinedown.net/down/audio_cd_ripper.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/audio_cd_ripper.exe\rhttp://ctttl.onlinedown.net:8080/down/audio_cd_ripper.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (133,1126854684,1126854684,1,1,0,0,'按键精灵 5.30','2774KB','简体中文','共享版/鼠标键盘','Win9x/Me/NT/2000/XP',4,'http://www.vrbrothers.com/cn','','　　特别适合网络游戏中制作自动练功的机器人，主要功能包括：1.定义一个热键，实现一系列的键盘按键动作、鼠标点击动作、鼠标移动动作、输入字符串动作、延迟动作。更多的插入动作以后也会扩充。2.实现动作的循环，每个动作都可以进行循环，你可以定义热键中止动作的循环，也可以自己定义循环的次数或者循环的时间。3.所有的热键都可以对指定的窗口有效，这样就不会出现切换了窗口还自动执行动作的情况。4.每个热键的动作都生成一个Script文件，高手可以自己编辑这个文件，实现功能强大的宏键。  ','http://sq3.onlinedown.net/down/qm5chs.exe\rhttp://hld.onlinedown.net/down/qm5chs.exe\rhttp://wh.onlinedown.net:82/down/qm5chs.exe\rhttp://ftpwh.onlinedown.net:82/down/qm5chs.exe\rhttp://hlbr.onlinedown.net/files3/qm5chs.exe\rhttp://nc.onlinedown.net/down/qm5chs.exe\rhttp://sx.huajun.net/down/qm5chs.exe\rhttp://nn.onlinedown.net/down/qm5chs.exe\rhttp://sccrc.onlinedown.net:82/files2/qm5chs.exe\rhttp://gzcnc.onlinedown.net:82/files/qm5chs.exe\rhttp://sccnc.onlinedown.net/down/qm5chs.exe\rhttp://jsnetcom.onlinedown.com/down/qm5chs.exe\rhttp://hbcrc.onlinedown.net:82/down/qm5chs.exe\rhttp://lctt.onlinedown.net/down/qm5chs.exe\rhttp://sxbctv.onlinedown.net/down/qm5chs.exe\rftp://cnc:10060@221.12.150.27/qm5chs.exe\rftp://cnc:10060@soft.10060.tv/qm5chs.exe\rhttp://snxa.onlinedown.net/down/qm5chs.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/qm5chs.exe\rhttp://ctttl.onlinedown.net:8080/down/qm5chs.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (134,1126854685,1126854685,1,1,0,0,'Yeepu软件系列 2.22','23900KB','简体中文','共享版/编程工具','Win9x/Me/NT/2000/XP',4,'http://www.yeepu.com','','   提高软件的开发效率和质量，让程序员解放出来，把精力专注于业务模块的开发。 软件优点： 1、支持三层分布式技术，支持广域网： 2、支持SQL Server或Access，也可支持Oracle 3、有Delphi的强大、语法。易学易用的开发工具，只要一分钟建一个输入界面。不用花时间学编程，费心写软件。 4、有什么软件有可以①自定义报表②自定义菜单③自定义字段④自定义权限⑤自定义统计⑥自定义输入界面。⑦自定义流程⑧提供代码 5、支持手机短信、E-Mail服务、 6、提供代码、安全可靠 7、减少编程代码； 8、增加代码的可靠性和健壮性； 9、更能保证一致性和模块化； 10、XP的效果，使软件更上一个档次 11、可以合并,也可以分开的免费15套软件：YeepuERP、Yeepu进销存、YeepuPOS、Yeepu考勤、Yeepu薪资、Yeepu石材、Yeepu裁床、Yeepu用餐、Yeepu物业、Yeepu理财、Yeepu货运、Yeepu文档、Yeepu会员管理、Yeepu客户、Yeepu房屋中介   ','http://sq3.onlinedown.net/down/YeepuSoft.exe\rhttp://hld.onlinedown.net/down/YeepuSoft.exe\rhttp://wh.onlinedown.net:82/down/YeepuSoft.exe\rhttp://ftpwh.onlinedown.net:82/down/YeepuSoft.exe\rhttp://hlbr.onlinedown.net/files3/YeepuSoft.exe\rhttp://nc.onlinedown.net/down/YeepuSoft.exe\rhttp://sx.huajun.net/down/YeepuSoft.exe\rhttp://nn.onlinedown.net/down/YeepuSoft.exe\rhttp://sccrc.onlinedown.net:82/files2/YeepuSoft.exe\rhttp://gzcnc.onlinedown.net:82/files/YeepuSoft.exe\rhttp://sccnc.onlinedown.net/down/YeepuSoft.exe\rhttp://jsnetcom.onlinedown.com/down/YeepuSoft.exe\rhttp://hbcrc.onlinedown.net:82/down/YeepuSoft.exe\rhttp://ctttl.onlinedown.net:82/down/YeepuSoft.exe\rhttp://sxbctv.onlinedown.net/down/YeepuSoft.exe\rftp://cnc:10060@221.12.150.27/YeepuSoft.exe\rftp://cnc:10060@soft.10060.tv/YeepuSoft.exe\rhttp://snxa.onlinedown.net/down/YeepuSoft.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/YeepuSoft.exe\rhttp://ctttl.onlinedown.net:8080/down/YeepuSoft.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (135,1126854685,1126854685,1,1,0,0,'费尔托斯特安全 2005 R2','5737KB','简体中文','共享版/系统安全','Win9x/Me/NT/2000',4,'http://www.filseclab.com','','    费尔托斯特安全(Twister Anti-TrojanVirus)是一款同时拥有反木马、反间谍和反病毒功能的强大电脑防护软件。支持Windows安全中心，支持右键扫描，支持对ZIP、RAR等主流压缩格式的全面多层级扫描，实时监控功能可以对硬盘、软盘、光盘、移动硬盘、网络驱动器、网站浏览、E-mail附件中的每一个文件活动进行实时监控，并且系统资源占用极小。采用SmartScan快速扫描技术，具有非凡的扫描速度。国际一流的网页病毒分析技术，拥有最出色的恶意网站识别能力。它的行为性智能分析和Windows信任验证技术可以准确辨别出隐藏在电脑中的其他未知木马和恶意程序，同时避免同类防木马软件中存在的严重“谎报”现象。它的“系统快速修复工具”可以对IE、Windows、注册表等常见故障进行一键修复。 “木马强力清除助手”可以轻松清除那些用普通防毒软件难以清除掉的顽固性木马和间谍程序。注册表实时监控能够高效阻止和修复木马病毒对注册表的恶意破坏。支持病毒库在线升级和自动升级，不断提升对新木马新病毒的反应能力。  ','http://sq3.onlinedown.net/down/twister_cn.zip\rhttp://hld.onlinedown.net/down/twister_cn.zip\rhttp://wh.onlinedown.net:82/down/twister_cn.zip\rhttp://ftpwh.onlinedown.net:82/down/twister_cn.zip\rhttp://hlbr.onlinedown.net/files3/twister_cn.zip\rhttp://nc.onlinedown.net/down/twister_cn.zip\rhttp://sx.huajun.net/files/twister_cn.zip\rhttp://hnpy.onlinedown.net/down/twister_cn.zip\rhttp://nn.onlinedown.net/down/twister_cn.zip\rhttp://sccrc.onlinedown.net:82/files/twister_cn.zip\rhttp://gzcnc.onlinedown.net:82/files/twister_cn.zip\rhttp://sccnc.onlinedown.net/down/twister_cn.zip\rhttp://jsnetcom.onlinedown.com/down/twister_cn.zip\rhttp://hbcrc.onlinedown.net:82/down/twister_cn.zip\rhttp://lctt.onlinedown.net/down/twister_cn.zip\rhttp://wx.onlinedown.net/down/twister_cn.zip\rhttp://zj.onlinedown.net:82/down/twister_cn.zip\rftp://cnc:10060@221.12.150.27/twister_cn.zip\rftp://cnc:10060@soft.10060.tv/twister_cn.zip\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/twister_cn.zip\rhttp://ctttl.onlinedown.net:8080/down/twister_cn.zip','','','','');
INSERT INTO {$table_header}content_2 VALUES (136,1126854685,1126854685,1,1,0,0,'白猫清理工 3.04','2150KB','简体中文','共享版/卸载工具','Win9x/Me/NT/2000/XP',4,'http://www.66169.com','','&nbsp;&nbsp;&nbsp;&nbsp;白猫清理工是一套计算机必备的系统增强、清理软件。软件界面简洁明了，操作安全可靠、简单方便。其主要功能：<br>\n1、彻底禁止各类网页病毒，完全抵御恶意网站更改主页，真正保证上网浏览安全;<br>\n2、安全地清除曾经运行过的程序地址，登陆过的网址，看过的电影，听过的音乐，欣赏过的图片等等的历史记录，有效的保护个人隐私；<br>\n3、安全地清除系统中已删除的和不必要的文件，无指向的快捷方式，多余的临时文件，系统注册表的无用子项目等；<br>\n4、自主决定开机自启动程序，减少内存占用，提高运行速度。  ','http://dl.hzsrf.com/league_soft/10227/bm_setup.exe\rhttp://soft.66169.com/league_soft/10227/bm_setup.exe\rhttp://sq3.onlinedown.net/down/bm_setup.exe\rhttp://hld.onlinedown.net/down/bm_setup.exe\rhttp://wh.onlinedown.net:82/down/bm_setup.exe\rhttp://ftpwh.onlinedown.net:82/down/bm_setup.exe\rhttp://hlbr.onlinedown.net/files3/bm_setup.exe\rhttp://nc.onlinedown.net/down/bm_setup.exe\rhttp://sx.huajun.net/files/bm_setup.exe\rhttp://hnpy.onlinedown.net/down/bm_setup.exe\rhttp://nn.onlinedown.net/down/bm_setup.exe\rhttp://sccrc.onlinedown.net:82/files/bm_setup.exe\rhttp://gzcnc.onlinedown.net:82/files/bm_setup.exe\rhttp://sccnc.onlinedown.net/down/bm_setup.exe\rhttp://jsnetcom.onlinedown.com/down/bm_setup.exe\rhttp://hbcrc.onlinedown.net:82/down/bm_setup.exe\rhttp://ctttl.onlinedown.net:82/down/bm_setup.exe\rhttp://wx.onlinedown.net/down/bm_setup.exe\rhttp://zj.onlinedown.net:82/down/bm_setup.exe\rftp://cnc:10060@221.12.150.27/bm_setup.exe\rftp://cnc:10060@soft.10060.tv/bm_setup.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/bm_setup.exe\rhttp://ctttl.onlinedown.net:8080/down/bm_setup.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (137,1126854685,1126854685,1,1,0,0,'电子图书制作利器-友益文书 6.3.1.2','1140KB','简体中文','共享版/安装制作','Win9x/Me/NT/2000/XP',4,'http://www.yyebook.com','','&nbsp;&nbsp;&nbsp;&nbsp;该软件是一款集资料管理、电子图书制作、多媒体课件制作等于一体的多功能软件...可用于管理htm网页、mht单一网页、word文档、excel文档、幻灯片、pdf、chm、exe、txt、rtf、GIF、JPG、ICO、TIF、BMP、Flash动画等格式的文件；支持背景音乐及视频播放；对所管理的资料可直接生成可执行文件，在任何机计算机上阅读。<br>\n<br>\n&nbsp;&nbsp;&nbsp;&nbsp;该软件采用视窗风格，目录树结构管理，所见即所得的设计理念，不需要复杂的转换、编译；使用，操作方便，可以自由地添加、删除目录树，可以随心所欲地编辑文档内容，改变字体大小和颜色。<br>\n<br>\n&nbsp;&nbsp;&nbsp;该软件不断吸收了同类软件的优点，同时在功能及设计上又具有独特的创新性，采用混合索引算法，数据存储采用自带的压缩格式，独特具有多重文本超链接功能，对导入的网页仍可编辑，支持Word文档、网页、文本等多种格式文档之间的转换。采用了多级分布式加密算法，界面支持皮肤等个性化的设计；生成可执行文件后文书仍可修改。  ','http://www.yyebook.com/yyws.rar\rhttp://sq.onlinedown.net:82/down/yyws.rar\rhttp://ks.onlinedown.net:82/down/yyws.rar\rhttp://hlbr.onlinedown.net/files3/yyws.rar\rhttp://nc.onlinedown.net/down/yyws.rar\rhttp://sx.huajun.net/files/yyws.rar\rhttp://hnpy.onlinedown.net/down/yyws.rar\rhttp://nn.onlinedown.net/down/yyws.rar\rhttp://lctt.onlinedown.net/down/yyws.rar\rhttp://sccrc2.onlinedown.net:82/down/yyws.rar\rhttp://gzcnc.onlinedown.net:82/files/yyws.rar\rhttp://sccnc.onlinedown.net/down/yyws.rar\rftp://newhuadownload:12345678@211.154.22.149/yyws.rar\rhttp://jsnetcom.onlinedown.com/down/yyws.rar\rhttp://hecz.onlinedown.net/down/yyws.rar\rhttp://ctttl.onlinedown.net:82/down/yyws.rar\rftp://cnc:10060@221.12.150.27/yyws.rar\rftp://cnc:10060@soft.10060.tv/yyws.rar\rhttp://snxa.onlinedown.net/down/yyws.rar\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/yyws.rar\rhttp://ctttl.onlinedown.net:8080/down/yyws.rar','','','','');
INSERT INTO {$table_header}content_2 VALUES (138,1126854686,1126854686,1,1,0,0,'电脑救援专家 7.3','1926KB','简体中文','试用版/磁盘工具','Win9x/Me/NT/2000/XP',4,'http://www.wasay.com/','','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您的计算机是否经常发生因操作不当，而造成莫大的损失及困扰？或者安装来路不明的软件，导致系统的错乱、当机？您还在使用浪费时间又占用硬盘空间的备份工具吗？您是否浪费许多钱却买到不会安装或使用上不便利的软件呢？\nPro Magic实时复原软件结合了市场上多种应用工具(如防毒软件、备份软件、反安装软件、多重开机)，满足您对系统防护的各项需求。电脑救援专家提供了哪些功能呢？\n1\t系统实时复原。不论因人为操作不当或系统发生错乱导致故障当机，只要您已安装Pro Magic，重新开机就能立即复原。\n2\t操作便利。全中文界面支持鼠标操作。 \n3\t程序反安装功能。保护的状态下让您能任意测试各类型的软件，只要您觉得新安装的软件不适用，只要重新开机立即还原，完全移除您所测试的软件。\n4\t保密功能。提供双重密码保护，防止他人使用您的计算机及避免重要数据外泄。\n5\t完全防护。不仅可以保护系统盘，也可以保护数据盘，对于数据盘的还原、储存不需要重新启动计算机，完全在窗口下进行。\n6\t多点还原。提供无限多点式还原及无限多点式进度储存功能，犹如时光回溯一般可以还原到前一次开机的状态，甚至还原到前一天、前一个月、前一年的状态。  ','http://vnet.onlinedown.net:82/down/ProMagicPlus7.rar\rhttp://ks.onlinedown.net:82/down/ProMagicPlus7.rar\rhttp://wh.onlinedown.net:82/down/ProMagicPlus7.rar\rhttp://ftpwh.onlinedown.net:82/down/ProMagicPlus7.rar\rhttp://hlbr.onlinedown.net/files3/ProMagicPlus7.rar\rhttp://nc.onlinedown.net/down/ProMagicPlus7.rar\rhttp://sx.huajun.net/files/ProMagicPlus7.rar\rhttp://nn.onlinedown.net/down/ProMagicPlus7.rar\rhttp://sccrc2.onlinedown.net:82/down/ProMagicPlus7.rar\rhttp://gzcnc.onlinedown.net:82/files/ProMagicPlus7.rar\rhttp://sccnc.onlinedown.net/down/ProMagicPlus7.rar\rftp://newhuadownload:12345678@211.154.22.149/ProMagicPlus7.rar\rhttp://jsnetcom.onlinedown.com/down/ProMagicPlus7.rar\rhttp://hecz.onlinedown.net/down/ProMagicPlus7.rar\rhttp://ctttl.onlinedown.net:82/down/ProMagicPlus7.rar\rftp://cnc:10060@221.12.150.27/ProMagicPlus7.rar\rftp://cnc:10060@soft.10060.tv/ProMagicPlus7.rar\rhttp://snxa.onlinedown.net/down/ProMagicPlus7.rar\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/ProMagicPlus7.rar\rhttp://ctttl.onlinedown.net:8080/down/ProMagicPlus7.rar','','','','');
INSERT INTO {$table_header}content_2 VALUES (139,1126854686,1126854686,1,1,0,0,'江民杀毒软件KV2005AAA 下载版','26358KB','简体中文','共享版/杀毒软件','Win9x/Me/NT/2000/XP',5,'http://www.jiangmin.com','','     KV2005是江民科技集十余年反病毒经验，根据病毒发展趋势和电脑用户的安全需求，由江民研发中心历经一年多的时间，耗资近千万元研发而成。新产品应用了三大创新技术并具有十大新鲜亮点，最新产品KV2005AAA新增未知病毒主动防御系统，独创木马一扫光和未知病毒克星，可有效防范所有木马病毒和绝大部分未知病毒。<br>\n<br>\n     <br>\n    三大技术：<br>\n   独创\"驱动级编程技术\"，与操作系统底层技术结合更紧密，兼容性更强，占用系统资源更小。 独创\"系统级深度防护技术\"，KV2005与操作系统互动防毒，彻底改变以往杀毒软件独立于操作系统和防火墙的单一应用模式，开创杀毒软件系统级病毒防护新纪元。独创\"立体联动防杀技术\"，KV2005杀毒软件与防火墙联动防毒、同步升级，防杀病毒更有效。<br>\n<br>\n   十大亮点：<br>\n   一、未知病毒克星：“未知病毒克星”综合了病毒的共同特征，基于病毒行为去检测和处理病毒。<br>\n   二、木马一扫光：木马一扫光监控所有对注册表的非法写入，发现有不明程序修改注册表则报警并由用户选择是否拦截<br>\n   三、安全警报：具有KV安全中心的KV2005是用户的安全助手，用户安装KV2005后，安全中心将实时用户提醒升级病毒库、开启实时监视系统，安装系统漏洞补丁，确保电脑安全。<br>\n   四、无毒聊天：KV2005新增即时通信监视功能，全面防杀通过QQ、MSN、泡泡、UC等即时通讯工具传播的病毒。<br>\n   五、无毒办公：KV2005的杀毒引擎平滑嵌入OFFICE、网际快车、网络蚂蚁、WINRAR、WINZIP等办公、下载、压缩工具软件中，实时保护相关操作安全无毒。<br>\n   六、无毒邮件：邮件监控系统更强劲，实时双向扫描收发邮件，有毒及时清除，确认无毒后放行。<br>\n   七、无毒网游：KV2005江民黑客防火墙更强大，保护各种网络游戏装备、保护虚拟财富。<br>\n   八、隐私保护：设置信用卡号、QQ、邮箱、游戏账号等私密信息为保护状态，在木马、黑客盗取私密信息并向外传输时，KV2005可有效扫截。<br>\n   九、U盘杀毒：KV杀毒软件率先支持用U盘制作应急启动盘和DOS杀毒伴侣，使无软驱PC用户在DOS下快速查杀病毒。<br>\n   十、率先支持SP2：全面兼容支持微软最新操作系统WINXP SP2，国内率先通过WINXP SP2安全中心认证。独创KV安全中心，安装KV2005后，不但XP SP2用户可以获得安全中心功能，其它所有操作系统均能实现安全中心功能，杀毒软件与操作系统完美结合深度防毒。  ','http://wx.onlinedown.net/down/kv2005download.exe\rhttp://sq.onlinedown.net/files/kv2005download.exe\rhttp://ks.onlinedown.net:82/down/kv2005download.exe\rhttp://wh.onlinedown.net:82/down/kv2005download.exe\rhttp://ftpwh.onlinedown.net:82/down/kv2005download.exe\rhttp://nc.onlinedown.net/down/kv2005download.exe\rhttp://hnpy.onlinedown.net/down/kv2005download.exe\rhttp://lctt.onlinedown.net/down/kv2005download.exe\rhttp://sccrc2.onlinedown.net:82/down/kv2005download.exe\rhttp://gzcnc.onlinedown.net:82/files/kv2005download.exe\rhttp://sccnc.onlinedown.net/down/kv2005download.exe\rhttp://crc.onlinedown.net:82/files/kv2005download.exe\rftp://newhuadownload:12345678@211.154.22.149/kv2005download.exe\rhttp://jsnetcom.onlinedown.com/down/kv2005download.exe\rhttp://hecz.onlinedown.net/down/kv2005download.exe\rhttp://lctt.onlinedown.net/down/kv2005download.exe\rftp://cnc:10060@221.12.150.27/kv2005download.exe\rftp://cnc:10060@soft.10060.tv/kv2005download.exe\rhttp://snxa.onlinedown.net/down/kv2005download.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/kv2005download.exe\rhttp://ctttl.onlinedown.net:8080/down/kv2005download.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (140,1126854686,1126854686,1,1,0,0,'变速精灵XP(SpeederXP) 1.75a','2276KB','简体中文','共享版/系统加强','Win9x/Me/NT/2000/XP',4,'http://www.vrbrothers.com/cn/speeder/','','&nbsp;&nbsp;&nbsp;&nbsp;采用最稳定、最先进的变速技术，不但可以改变游戏的速度，还可改变其它软件及windows本身的运行速度；同时能全面支持Windows95／98／me／2000／xp等多种操作系统；支持热键定义，您可以随时按下热键呼出窗口、加速、减速，或者立即调节到您设定的速度；软件退出后速度的改变仍然有效，直到您下一次重新启动计算机；线性无级变速，您可以随意拖动滑块，自由调节……<br>\n<br>\n加速后绝不会对CPU等硬件造成损害，让您有飞的感觉！  ','http://sq5.onlinedown.net/files/speeder_cn.exe\rhttp://hld.onlinedown.net/down/speeder_cn.exe\rhttp://wh.onlinedown.net:82/down/speeder_cn.exe\rhttp://ftpwh.onlinedown.net:82/down/speeder_cn.exe\rhttp://hlbr.onlinedown.net/files3/speeder_cn.exe\rhttp://nc.onlinedown.net/down/speeder_cn.exe\rhttp://sx.huajun.net/files/speeder_cn.exe\rhttp://lctt.onlinedown.net/down/speeder_cn.exe\rhttp://sccrc2.onlinedown.net:82/down/speeder_cn.exe\rhttp://gzcnc.onlinedown.net:82/files/speeder_cn.exe\rhttp://sccnc.onlinedown.net/down/speeder_cn.exe\rhttp://jsnetcom.onlinedown.com/down/speeder_cn.exe\rhttp://hecz.onlinedown.net/down/speeder_cn.exe\rhttp://ctttl.onlinedown.net:82/down/speeder_cn.exe\rhttp://wznetcom.onlinedown.com:81/down/speeder_cn.exe\rhttp://zj.onlinedown.net:82/down/speeder_cn.exe\rftp://cnc:10060@221.12.150.27/speeder_cn.exe\rftp://cnc:10060@soft.10060.tv/speeder_cn.exe\rftp://wzcnc:wzcnc@onlinedown.wzcnc.com/speeder_cn.exe\rhttp://ctttl.onlinedown.net:8080/down/speeder_cn.exe','','','','');
INSERT INTO {$table_header}content_2 VALUES (141,1126854686,1126855627,1,1,0,0,'超级兔子魔法设置 7.1','7433KB','简体中文','免费版/系统设置','Win9x/Me/NT/2000/XP',5,'http://www.pctutu.com','','2005-9-14&nbsp;&nbsp;超级兔子7.1<BR><BR>一、超级兔子上网精灵7.1<BR>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;可免疫600种IE插件<BR>&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;新增sina、sohu的iCast清除功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;新增将网页完整另存为图片的功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;&nbsp;新增清除IE自动完成的功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;5&nbsp;&nbsp;新增在线升级功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;6&nbsp;&nbsp;新增解除网页限制功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;7&nbsp;&nbsp;新增对百度贴吧、一搜部落搜索的支持<BR>&nbsp;&nbsp;&nbsp;&nbsp;8&nbsp;&nbsp;改进禁止漂浮广告功能的兼容性<BR><BR>二、超级兔子优化王7.1<BR>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;新增清除IE自动完成功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;新增统计文件夹大小功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;新增排除文件夹选项<BR>&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;&nbsp;新增多种删除文件方式的选项<BR>&nbsp;&nbsp;&nbsp;&nbsp;5&nbsp;&nbsp;新增界面最大化功能<BR>&nbsp;&nbsp;&nbsp;&nbsp;6&nbsp;&nbsp;全面更新专业卸载，<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;无需进入安全模式，只要重新启动即可完整卸载<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 网络猪 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 Dudu 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 搜狗直通车 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 百度超级搜霸 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 易趣购物 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 很棒小秘书 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 划词搜索 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;更新 360搜 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 太极天下搜索 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 网址极限 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 一搜工具条 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 娱乐心空 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 MMSAssist彩信通 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 iBar 卸载<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增 WinStdup 卸载<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;7&nbsp;&nbsp;专业卸载功能，完美卸载该软件的所有<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件及注册表，绝非其它插件卸载工具的<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;简单删除插件功能。共可卸载以下49种软件：<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IE插件<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RealPlayer<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;划词搜索<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网络猪<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;很棒小秘书<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中文搜索<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;小蜜蜂<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dudu下载加速器<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DMCast 桌面传媒<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新浪点点通<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新浪iGame 游戏总动园<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;17lele网游<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;完美网译通<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;搜一搜<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网易搜霸<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Alibaba 商机直通车<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;迷你讯雷<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;迷你PP<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;虎翼DIY吧<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;青娱乐<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5188彩信助手<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中文通<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联众世界<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;博采网摘<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IE伴郎<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8848天下搜索<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8848购物搜索<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;太极天下搜索<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;易趣购物<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;易趣工具条<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NetFish 网络钓鱼克星<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;搜狗直通车<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CopySo拷贝搜<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISC<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网址极限<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;娱乐心空<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MMSAssist彩信通<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iBar<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WinStdup<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3721上网助手<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3721网络实名<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3721搜索助手<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3721下载专家<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;360搜<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;一搜工具条<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CNNIC中文上网官方版<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CNNIC无忧上网<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;百度上网伴侣<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;百度搜霸<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;百度超级搜霸<BR><BR>三、超级兔子IE修复专家7.1<BR>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;可检测及清除10328种木马病毒<BR>&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;新增一项启动程序的检测报告生成<BR><BR>四、超级兔子魔法设置7.1<BR>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;修正屏幕保护设置的Bug<BR>&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;修正屏蔽按钮的Bug<BR>&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;&nbsp;&nbsp;改进桌面透明功能<BR><BR>五、超级兔子安全助手4.6<BR>&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;修正系统文件夹的伪装识别<BR><BR>六、完全免费，无需注册，无需设置IE主页，<BR>&nbsp;&nbsp;&nbsp;&nbsp;即可使用所有功能，提供免费在线升级<BR>&nbsp;&nbsp;&nbsp;&nbsp;不捆绑任何其它软件。<BR>','http://sq.onlinedown.net:82/down/magicset710.exe\nhttp://wh.onlinedown.net:82/down/magicset710.exe\nhttp://ftpwh.onlinedown.net:82/down/magicset710.exe\nhttp://hlbr.onlinedown.net/files3/magicset710.exe\nhttp://nc.onlinedown.net/down/magicset710.exe\nhttp://sx.huajun.net/files/magicset710.exe\nhttp://lctt.onlinedown.net/down/magicset710.exe\nhttp://sccrc2.onlinedown.net:82/down/magicset710.exe\nhttp://gzcnc.onlinedown.net:82/files/magicset710.exe\nhttp://sccnc.onlinedown.net/down/magicset710.exe\nhttp://crc.onlinedown.net:82/files/magicset710.exe\nhttp://cttnb.onlinedown.net/down/magicset710.exe\nhttp://jsnetcom.onlinedown.com/down/magicset710.exe\nhttp://hld165.onlinedown.net/down/magicset710.exe\nhttp://ctttl.onlinedown.net:82/down/magicset710.exe\nhttp://wznetcom.onlinedown.com:81/down/magicset710.exe\nhttp://zj.onlinedown.net:82/down/magicset710.exe\nftp://cnc:10060@221.12.150.27/magicset710.exe\nftp://cnc:10060@soft.10060.tv/magicset710.exe\nftp://wzcnc:wzcnc@onlinedown.wzcnc.com/magicset710.exe\nhttp://ctttl.onlinedown.net:8080/down/magicset710.exe','../resource/img/h000/h00/img200509161527050.jpg','','','');


DROP TABLE IF EXISTS {$table_header}content_3;

CREATE TABLE {$table_header}content_3 (
  `ContentID` int(10) NOT NULL auto_increment,
  `CreationDate` int(10) NOT NULL default '0',
  `ModifiedDate` int(10) NOT NULL default '0',
  `CreationUserID` int(8) NOT NULL default '0',
  `LastModifiedUserID` int(8) NOT NULL default '0',
  `ContributionUserID` int(8) NOT NULL default '0',
  `ContributionID` int(10) NOT NULL default '0',
  `Title` varchar(100) NOT NULL default '',
  `Author` varchar(50) NOT NULL default '',
  `Size` varchar(20) NOT NULL default '',
  `FlashSrc` varchar(250) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`ContentID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}content_3 VALUES (1,1127728099,1127729232,1,1,0,0,'怪怪水族馆','','6.54 MB','../resource/flash/h000/h00/flash200509261712040.swf','../resource/img/h000/h00/img200508241959201.jpg','\n\n一款与鱼打交道的游戏.游戏的秘诀在于投资,要想赚更多的钱就不要吝惜你的Money...','73685,73684');
INSERT INTO {$table_header}content_3 VALUES (2,1127728697,1127915518,1,1,0,0,'车元素','','','../resource/flash/h000/h00/flash200509261542230.swf','../resource/img/h000/h00/img200509161526100.jpg','\n\n诺基亚在美国手机市场屈居第四，不敌摩托罗拉和LG等强敌。摩托罗拉的Razr等流行酷炫机型吸引消费者趋之若鹜。Strategy Analytics.分析师Milton Keynes说：“诺基亚在西欧、北美洲流失版图，在日本可说是没有市场。当消费者买第一支手机时，可能是诺基亚，但当他们物色更精巧的手机时，往往转向青睐诺基亚的对手。” ','');
INSERT INTO {$table_header}content_3 VALUES (3,1127729924,1127915510,1,1,0,0,'全球通通全球','','','../resource/flash/h000/h00/flash200509261717460.swf','../resource/img/h000/h00/img200508241959202.jpg','\n\n诺基亚在美国手机市场屈居第四，不敌摩托罗拉和LG等强敌。摩托罗拉的Razr等流行酷炫机型吸引消费者趋之若鹜。Strategy Analytics.分析师Milton Keynes说：“诺基亚在西欧、北美洲流失版图，在日本可说是没有市场。当消费者买第一支手机时，可能是诺基亚，但当他们物色更精巧的手机时，往往转向青睐诺基亚的对手。” ','');
INSERT INTO {$table_header}content_3 VALUES (4,1127729995,1127915500,1,1,0,0,'安踏','','','../resource/flash/h000/h00/flash200509261546130.swf','../resource/img/h000/h00/img200508241952402.jpg','\n\n诺基亚在美国手机市场屈居第四，不敌摩托罗拉和LG等强敌。摩托罗拉的Razr等流行酷炫机型吸引消费者趋之若鹜。Strategy Analytics.分析师Milton Keynes说：“诺基亚在西欧、北美洲流失版图，在日本可说是没有市场。当消费者买第一支手机时，可能是诺基亚，但当他们物色更精巧的手机时，往往转向青睐诺基亚的对手。” ','');

DROP TABLE IF EXISTS {$table_header}content_4;
CREATE TABLE {$table_header}content_4 (
  `ContentID` int(10) NOT NULL auto_increment,
  `CreationDate` int(10) NOT NULL default '0',
  `ModifiedDate` int(10) NOT NULL default '0',
  `CreationUserID` int(8) NOT NULL default '0',
  `LastModifiedUserID` int(8) NOT NULL default '0',
  `ContributionUserID` int(8) NOT NULL default '0',
  `ContributionID` int(10) NOT NULL default '0',
  `Content` text NOT NULL,
  PRIMARY KEY  (`ContentID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}content_4 VALUES (1,1126851951,1126851951,1,1,0,0,'\n\n最新CMSware演示站推出，敬请期待！ ');
INSERT INTO {$table_header}content_4 VALUES (2,1126852028,1126852028,1,1,0,0,'\n\n新的风貌，新的开始，希望大家一如既往地支持本站！ ');
INSERT INTO {$table_header}content_4 VALUES (3,1126852047,1126852047,1,1,0,0,'\n\nCMSware，放飞你的理想！');

DROP TABLE IF EXISTS {$table_header}content_5;

CREATE TABLE {$table_header}content_5 (
  `ContentID` int(10) NOT NULL auto_increment,
  `CreationDate` int(10) NOT NULL default '0',
  `ModifiedDate` int(10) NOT NULL default '0',
  `CreationUserID` int(8) NOT NULL default '0',
  `LastModifiedUserID` int(8) NOT NULL default '0',
  `ContributionUserID` int(8) NOT NULL default '0',
  `ContributionID` int(10) NOT NULL default '0',
  `LinkName` varchar(50) NOT NULL default '',
  `LinkURL` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`ContentID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}content_5 VALUES (1,1126856013,1126856214,1,1,0,0,'CMSware官方站','http://www.cmsware.net');
INSERT INTO {$table_header}content_5 VALUES (2,1126856051,1126856051,1,1,0,0,'春秋战国论坛','http://www.cqzg.cn/');
INSERT INTO {$table_header}content_5 VALUES (3,1126856072,1126856072,1,1,0,0,'站长资讯','http://www.11k.net');
INSERT INTO {$table_header}content_5 VALUES (4,1126856094,1126856094,1,1,0,0,'SmartIPB论坛官方站','http://www.smartipb.com/');
INSERT INTO {$table_header}content_5 VALUES (5,1126856109,1126856109,1,1,0,0,'教育部大学生在线','http://www.univs.cn/');
INSERT INTO {$table_header}content_5 VALUES (6,1126856122,1126856122,1,1,0,0,'上海小熊在线','http://www.shbear.com/');
INSERT INTO {$table_header}content_5 VALUES (7,1126856134,1126856134,1,1,0,0,'中关村在线重庆站','http://www.it023.com/');
INSERT INTO {$table_header}content_5 VALUES (8,1126856142,1126856142,1,1,0,0,'蔫老虎在线','http://www.pcicp.com/');
INSERT INTO {$table_header}content_5 VALUES (9,1126856152,1126856152,1,1,0,0,'上海小熊在线','http://www.shbear.com/');
INSERT INTO {$table_header}content_5 VALUES (10,1126856163,1126856163,1,1,0,0,'教育部中国大学生在线','http://www.univs.cn/');
INSERT INTO {$table_header}content_5 VALUES (11,1126866664,1126866664,1,1,0,0,'TechWeb','http://www.techweb.com.cn');


DROP TABLE IF EXISTS {$table_header}content_6;

CREATE TABLE {$table_header}content_6 (
  `ContentID` int(10) NOT NULL auto_increment,
  `CreationDate` int(10) NOT NULL default '0',
  `ModifiedDate` int(10) NOT NULL default '0',
  `CreationUserID` int(8) NOT NULL default '0',
  `LastModifiedUserID` int(8) NOT NULL default '0',
  `ContributionUserID` int(8) NOT NULL default '0',
  `ContributionID` int(10) NOT NULL default '0',
  `PhotoName` varchar(250) NOT NULL default '',
  `PhotoURL` varchar(250) NOT NULL default '',
  `PhotoIntro` text NOT NULL,
  PRIMARY KEY  (`ContentID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}content_6 VALUES (1,1126923097,1126925680,1,1,0,0,'香港维多利亚湾','../resource/img/h000/h00/img200509171011110.jpg','\n\n<font color=\"#ff0000\">非常漂亮！<br/></font>奥运通信建设紧锣密鼓\n<p>　　7月29日，中国网通(集团)有限公司北京分公司与北京北辰实业集团公司签署战略合作协议，北京网通将为“国家会议中心”和“奥运会媒体村”提供全面周到的奥运通信服务。</p>\n<p>　　国家会议中心总建筑面积为53万平方米，奥运会期间将是主新闻中心(MPC)、国际广播中心(IBC)两个媒体中心的所在地。奥运会媒体村占地约40万平方米，根据国际奥运会媒体指南的要求，2008年约有21600名媒体人员采访报道北京奥运会，其通信系统将在奥运会期间为各国新闻媒体提供语音、数据、互联网接入等包括固定通信、移动通信和集群通信在内的全方位服务。</p>\n<p>　　中国网通集团副总经理兼北京市分公司总经理赵继东在签字仪式上承诺，国家会议中心和奥运会媒体村的通信系统工程将按照满足奥运会期间赛事基本需求和充分保证业主经营需求的原则进行建设。奥运会期间保证为新闻工作者、官员、运动员等提供安全可靠、高效畅通的通信保障，提供比以往任何一届奥运会都更加方便、快速和先进的通信服务。</p>');
INSERT INTO {$table_header}content_6 VALUES (8,1127099505,1127099505,1,1,0,0,'九寨风情','../resource/img/h000/h00/img200509191111180.jpg','\n\n很漂亮！');
INSERT INTO {$table_header}content_6 VALUES (9,1127099557,1127099557,1,1,0,0,'莲','../resource/img/h000/h00/img200509191112260.jpg','\n\n<strong>莲</strong>');
INSERT INTO {$table_header}content_6 VALUES (10,1127099800,1127099800,1,1,0,0,'法国风情','../resource/img/h000/h00/img200509191116310.jpg','\n\n');
INSERT INTO {$table_header}content_6 VALUES (11,1127099814,1127099814,1,1,0,0,'天山','../resource/img/h000/h00/img200509191116470.jpg','\n\n');
INSERT INTO {$table_header}content_6 VALUES (12,1127099836,1127099836,1,1,0,0,'长白山','../resource/img/h000/h00/img200509191117050.jpg','\n\n');
INSERT INTO {$table_header}content_6 VALUES (13,1127099932,1127099932,1,1,0,0,'锦绣河山','../resource/img/h000/h00/img200509191118370.jpg','\n\n');
INSERT INTO {$table_header}content_6 VALUES (14,1127099950,1127099950,1,1,0,0,'诗意','../resource/img/h000/h00/img200509191119000.jpg','\n\n');
INSERT INTO {$table_header}content_6 VALUES (15,1127099967,1127099967,1,1,0,0,'富士山','../resource/img/h000/h00/img200509191119190.jpg','\n\n');


DROP TABLE IF EXISTS {$table_header}content_fields;

CREATE TABLE {$table_header}content_fields (
  `ContentFieldID` int(8) NOT NULL auto_increment,
  `TableID` int(8) NOT NULL default '0',
  `FieldTitle` varchar(100) NOT NULL default '',
  `FieldName` varchar(20) default NULL,
  `FieldType` varchar(20) default NULL,
  `FieldSize` varchar(20) NOT NULL default '',
  `FieldInput` varchar(20) default NULL,
  `FieldDefaultValue` varchar(250) default NULL,
  `FieldInputFilter` varchar(20) default NULL,
  `FieldInputPicker` varchar(20) default NULL,
  `FieldInputTpl` varchar(250) default NULL,
  `FieldDescription` mediumtext,
  `FieldOrder` mediumint(8) NOT NULL default '0',
  `FieldListDisplay` tinyint(1) NOT NULL default '0',
  `IsMainField` tinyint(1) NOT NULL default '0',
  `IsTitleField` tinyint(1) default '0',
  `FieldSearchable` tinyint(1) default '0',
  `EnableContribution` tinyint(1) default '1',
  `EnableCollection` tinyint(1) default '1',
  `EnablePublish` tinyint(1) default '1',
  PRIMARY KEY  (`ContentFieldID`,`TableID`),
  UNIQUE KEY `ContentFiledID` (`ContentFieldID`),
  KEY `T_F` (`TableID`,`FieldListDisplay`)
) TYPE=MyISAM;


INSERT INTO {$table_header}content_fields VALUES (1,1,'标题','Title','varchar','250','text','http://cmsware/www/1127447494.html','','url_content','','新闻的标题',0,1,0,1,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (2,1,'作者','Author','varchar','20','text','','','content','','新闻的原作者',2,0,0,0,1,1,0,1);
INSERT INTO {$table_header}content_fields VALUES (3,1,'责任编辑','Editor','varchar','20','text','','','','','新闻编辑',8,0,0,0,1,1,0,1);
INSERT INTO {$table_header}content_fields VALUES (4,1,'新闻图片','Photo','varchar','250','text','','','upload','','',3,0,0,0,0,1,0,1);
INSERT INTO {$table_header}content_fields VALUES (5,1,'副标题','SubTitle','varchar','250','text','','','','','',6,0,0,0,1,1,0,1);
INSERT INTO {$table_header}content_fields VALUES (6,1,'新闻内容','Content','longtext','','RichEditor','','','','','',4,0,1,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (7,1,'关键字','Keywords','varchar','250','text','','','','','',5,0,0,0,1,0,0,1);
INSERT INTO {$table_header}content_fields VALUES (8,1,'来源网站','FromSite','varchar','250','text','','','','','',7,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (9,1,'简介','Intro','text','','textaera','','','','','',10,0,0,0,1,1,0,1);
INSERT INTO {$table_header}content_fields VALUES (10,1,'标题颜色','TitleColor','varchar','7','text','','','color','','',1,0,0,0,0,1,0,1);
INSERT INTO {$table_header}content_fields VALUES (21,1,'自定义相关文章 ','CustomLinks','contentlink','','select','','','','','',9,0,0,0,0,0,0,1);
INSERT INTO {$table_header}content_fields VALUES (19,2,'下载地址','Download','text','','textaera','','','','','',11,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (11,2,'软件介绍','Intro','text','','RichEditor','','','','','',10,0,1,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (12,2,'开 发 商','Developer','varchar','250','text','','','','','',9,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (13,2,'软件评级','Star','varchar','250','text','','','','','',7,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (14,2,'运行环境','Environment','varchar','50','text','','','','','',6,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (15,2,'软件类别','SoftType','varchar','50','text','','','','','',3,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (16,2,'软件语言','Language','varchar','10','text','','','','','',5,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (17,2,'软件大小','SoftSize','varchar','250','text','','','','','',4,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (18,2,'软件名称','SoftName','varchar','250','text','','','','','',0,1,0,1,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (20,2,'软件关键字','SoftKeywords','varchar','250','text','','','','','',8,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (22,2,'界面预览','Photo','varchar','250','text','','','upload','','',1,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (23,2,'本地上传','LocalUpload','varchar','250','text','','','upload_attach','','',2,0,0,0,1,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (24,2,'自定义相关软件 ','CustomSoftLinks','contentlink','250','text','','','','','',12,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (25,2,'自定义相关文章 ','CustomLinks','contentlink','250','text','','','','','',13,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (26,3,'Flash名称','Title','varchar','100','text','','','','','',0,1,0,1,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (27,4,'新闻快讯内容','Content','text','','RichEditor','','','','','',0,1,0,1,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (28,5,'链接名称','LinkName','varchar','50','text','','','','','',0,1,0,1,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (29,5,'链接地址','LinkURL','varchar','250','text','','','','','',0,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (30,6,'图片名称','PhotoName','varchar','250','text','','','','','',0,1,0,1,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (31,6,'图片地址','PhotoURL','varchar','250','text','','','upload','','',0,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (32,6,'图片简介','PhotoIntro','text','','RichEditor','','','','','',0,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (33,3,'Flash作者','Author','varchar','50','text','','','','','',1,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (34,3,'Flash文件大小','Size','varchar','20','text','','','','','',2,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (35,3,'Flash地址','FlashSrc','varchar','250','text','','','flash','','',4,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (36,3,'图片预览','Photo','varchar','250','text','','','upload','','',3,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (37,3,'Flash简介','Intro','text','','RichEditor','','','','','',5,0,0,0,0,1,1,1);
INSERT INTO {$table_header}content_fields VALUES (38,3,'相关Flash','CustomLinks','contentlink','','text','','','','','',6,0,0,0,0,1,1,1);


DROP TABLE IF EXISTS {$table_header}content_index;
CREATE TABLE {$table_header}content_index (
  `IndexID` int(10) NOT NULL auto_increment,
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `TableID` int(10) default NULL,
  `ParentIndexID` int(8) NOT NULL default '0',
  `Type` tinyint(1) NOT NULL default '1',
  `PublishDate` int(10) NOT NULL default '0',
  `SelfTemplate` varchar(250) NOT NULL default '',
  `SelfPSN` varchar(250) NOT NULL default '',
  `SelfPublishFileName` varchar(250) NOT NULL default '',
  `SelfPSNURL` varchar(250) NOT NULL default '',
  `SelfURL` varchar(250) NOT NULL default '',
  `State` tinyint(2) NOT NULL default '0',
  `URL` varchar(250) NOT NULL default '',
  `Top` smallint(5) NOT NULL default '0',
  `Pink` smallint(5) NOT NULL default '0',
  `Sort` smallint(5) NOT NULL default '0',
  PRIMARY KEY  (`IndexID`,`ContentID`,`NodeID`),
  UNIQUE KEY `IndexID` (`IndexID`),
  KEY `N_P` (`NodeID`,`State`,`Top`,`PublishDate`,`Sort`),
  KEY `N_S` (`NodeID`,`State`),
  KEY `PID` (`ParentIndexID`),
  KEY `Type` (`Type`),
  KEY `Top` (`Top`),
  KEY `Pink` (`Pink`)
) TYPE=MyISAM;



INSERT INTO {$table_header}content_index VALUES (73430,101,13,0,73430,1,1126756391,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126756363d73430.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73433,102,13,0,73433,1,1126756392,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126756363d73433.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73436,73143,2,0,73436,1,1126758496,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758496d73436.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73437,73144,2,0,73437,1,1126758497,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758496d73437.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73438,73145,2,0,73438,1,1126758498,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758496d73438.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73439,73146,2,0,73439,1,1126758500,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758497d73439.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73440,73147,2,0,73440,1,1126758501,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758497d73440.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73441,73148,2,0,73441,1,1126758502,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758497d73441.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73442,73149,2,0,73442,1,1126758503,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758497d73442.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73443,73150,2,0,73443,1,1126758504,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758497d73443.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73444,73151,2,0,73444,1,1126758506,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73444.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73445,73152,2,0,73445,1,1126758507,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73445.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73446,73153,2,0,73446,1,1126758508,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73446.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73447,73154,2,0,73447,1,1126758509,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73447.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73448,73155,2,0,73448,1,1126758510,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73448.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73449,73156,2,0,73449,1,1126758511,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73449.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73450,73157,2,0,73450,1,1126758512,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758498d73450.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73451,73158,2,0,73451,1,1126758514,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758499d73451.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73452,73159,2,0,73452,1,1126758515,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758499d73452.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73453,73160,23,0,73453,1,1126758516,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126758499d73453.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73454,73161,23,0,73454,1,1126758517,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126758499d73454.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73455,73162,23,0,73455,1,1126758518,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126758499d73455.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73456,73163,2,0,73456,1,1126758519,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758499d73456.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73457,73164,2,0,73457,1,1126758521,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758500d73457.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73458,73165,2,0,73458,1,1126758522,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758500d73458.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73459,73166,2,0,73459,1,1126758523,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758500d73459.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73460,73167,2,0,73460,1,1126758524,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758500d73460.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73461,73168,2,0,73461,1,1126758525,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758500d73461.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73462,73169,2,0,73462,1,1126758526,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758500d73462.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73463,73170,2,0,73463,1,1126758528,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758501d73463.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73464,73171,2,0,73464,1,1126758529,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758501d73464.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73465,73172,2,0,73465,1,1126758530,'','','','','',0,'{cmsware_admin}/www/2005-09-15/content.1126758501d73465.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73466,103,13,0,73466,1,1126758899,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758899d73466.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73469,104,6,0,73469,1,1126758901,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73469.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73472,105,6,0,73472,1,1126758902,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73472.html',0,3,0);
INSERT INTO {$table_header}content_index VALUES (73475,106,6,0,73475,1,1126758903,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73475.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73478,107,13,0,73478,1,1126758905,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758901d73478.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73481,108,13,0,73481,1,1126758906,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758901d73481.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73484,109,13,0,73484,1,1126758907,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758901d73484.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73487,110,13,0,73487,1,1126758909,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758902d73487.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73490,111,13,0,73490,1,1126758910,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758902d73490.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73493,112,13,0,73493,1,1126758911,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758902d73493.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73496,113,13,0,73496,1,1126758912,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/1126758902d73496.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73499,114,6,0,73499,1,1126758914,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73499.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73502,115,6,0,73502,1,1126758915,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73502.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73505,116,6,0,73505,1,1126758916,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73505.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73508,117,6,0,73508,1,1126775114,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73508.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73511,118,6,0,73511,1,1126775115,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73511.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73514,119,6,0,73514,1,1126775117,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73514.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73517,120,6,0,73517,1,1126775118,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73517.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73520,121,6,0,73520,1,1126775119,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73520.html',0,1,0);
INSERT INTO {$table_header}content_index VALUES (73523,122,6,0,73523,1,1126775120,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73523.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73526,123,6,0,73526,1,1126775122,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73526.html',0,2,0);
INSERT INTO {$table_header}content_index VALUES (73529,124,6,0,73529,1,1126775123,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73529.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73532,125,6,0,73532,1,1126775124,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73532.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73535,126,6,0,73535,1,1126775125,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73535.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73538,127,6,0,73538,1,1126775127,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73538.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73541,128,6,0,73541,1,1126775128,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73541.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73544,129,6,0,73544,1,1126775129,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73544.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73547,130,6,0,73547,1,1126775130,'','','','','',0,'{cmsware_admin}/www/download/2005-09-15/Soft6d73547.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73550,1,17,0,73550,1,1126851904,'','','','','',0,'{cmsware_admin}/publish/content.php/73550,0.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73553,131,7,0,73553,1,1126854683,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854683d73553.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73556,132,7,0,73556,1,1126854685,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854684d73556.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73559,133,7,0,73559,1,1126854686,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854684d73559.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73562,134,7,0,73562,1,1126854688,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854685d73562.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73565,135,7,0,73565,1,1126854689,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854685d73565.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73568,136,7,0,73568,1,1126854690,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854685d73568.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73571,137,7,0,73571,1,1126854691,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854685d73571.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73574,138,7,0,73574,1,1126854693,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854686d73574.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73577,139,7,0,73577,1,1126854694,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854686d73577.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73580,140,7,0,73580,1,1126854695,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854686d73580.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73583,141,7,0,73583,1,1126854696,'','','','','',0,'{cmsware_admin}/www/download/2005-09-16/1126854686d73583.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73586,1,18,0,73586,1,1126855992,'','','','','',0,'',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73593,8,18,0,73593,1,1126856136,'','','','','',0,'',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73594,9,18,0,73594,1,1126856145,'','','','','',0,'',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73595,10,18,0,73595,1,1126856155,'','','','','',0,'',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73596,73173,20,0,73596,1,1126863541,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73596.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73597,73174,20,0,73597,1,1126863542,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73597.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73598,73175,20,0,73598,1,1126863543,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73598.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73599,73176,20,0,73599,1,1126863544,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73599.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73600,73177,20,0,73600,1,1126863545,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73600.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73601,73178,20,0,73601,1,1126863546,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73601.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73602,73179,20,0,73602,1,1126863547,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73602.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73603,73180,20,0,73603,1,1126863548,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73603.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73604,73181,20,0,73604,1,1126863549,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73604.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73605,73182,20,0,73605,1,1126863550,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73605.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73606,73183,20,0,73606,1,1126863551,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73606.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73607,73184,20,0,73607,1,1126863552,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73607.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73608,73185,20,0,73608,1,1126863553,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73608.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73609,73186,20,0,73609,1,1126863554,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73609.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73610,73187,20,0,73610,1,1126863555,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863541d73610.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73611,73188,21,0,73611,1,1126863756,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863756d73611.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73612,73189,21,0,73612,1,1126863757,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863756d73612.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73613,73190,3,0,73613,1,1126863856,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863856d73613.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73614,73191,3,0,73614,1,1126863857,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863856d73614.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73615,73192,3,0,73615,1,1126863858,'','','','','',0,'{cmsware_admin}/www/2005-09-16/1126863856d73615.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73616,73193,23,0,73616,1,1126863859,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73616.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73617,73194,22,0,73617,1,1126863860,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73617.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73618,73195,22,0,73618,1,1126863861,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73618.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73619,73196,22,0,73619,1,1126863862,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73619.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73620,73197,22,0,73620,1,1126863863,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73620.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73621,73198,22,0,73621,1,1126863864,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73621.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73622,73199,22,0,73622,1,1126863865,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73622.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73623,73200,22,0,73623,1,1126863866,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73623.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73624,73201,22,0,73624,1,1126863867,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73624.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73625,73202,22,0,73625,1,1126863868,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73625.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73626,73203,22,0,73626,1,1126863869,'','','','','',0,'{cmsware_admin}/www/h000/h73/1126863856d73626.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73642,11,18,0,73642,1,1126866651,'','','','','',0,'',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73643,1,26,0,73643,1,1126923044,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1126923097d73643.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73670,1,27,0,73643,2,1126941241,'','','','','',0,'',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73671,8,26,0,73671,1,1127099421,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099505d73671.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73672,9,26,0,73672,1,1127099507,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099557d73672.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73673,10,26,0,73673,1,1127099559,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099800d73673.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73674,11,26,0,73674,1,1127099801,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099814d73674.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73675,12,26,0,73675,1,1127099816,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099836d73675.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73676,13,26,0,73676,1,1127099838,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099932d73676.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73677,14,26,0,73677,1,1127099933,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099950d73677.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73678,15,26,0,73678,1,1127099952,'','','','','',0,'{cmsware_admin}/www/photo/h000/h73/photo.1127099967d73678.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73679,73204,2,0,73679,1,1127372889,'','','','','',0,'{cmsware_admin}/www/2005-09-22/content.1127372889d73679.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73680,73205,2,0,73680,1,1127373628,'','','','','',0,'{cmsware_admin}/www/2005-09-22/content.1127373628d73680.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73681,73206,2,0,73681,1,1127373764,'','','','','',0,'{cmsware_admin}/www/2005-09-22/content.1127373764d73681.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73684,1,32,0,73684,1,1127728037,'','','','','',0,'{cmsware_admin}/www/flash/2005/09/flash.1127728099d73684.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73685,2,32,0,73685,1,1127728661,'','','','','',0,'{cmsware_admin}/www/flash/2005/09/flash.1127728697d73685.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73686,3,32,0,73686,1,1127729889,'','','','','',0,'{cmsware_admin}/www/flash/2005/09/flash.1127729924d73686.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73687,4,32,0,73687,1,1127729954,'','','','','',0,'{cmsware_admin}/www/flash/2005/09/flash.1127729995d73687.html',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73694,73190,34,0,73694,0,1127895480,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126863856d73694.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73695,73191,34,0,73695,0,1127895481,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126863856d73695.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73696,73192,34,0,73696,0,1127895481,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126863856d73696.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73697,73143,35,0,73697,0,1127896108,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758496d73697.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73698,73144,35,0,73698,0,1127896108,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758496d73698.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73699,73145,35,0,73699,0,1127896108,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758496d73699.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73700,73146,35,0,73700,0,1127896110,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758497d73700.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73701,73147,35,0,73701,0,1127896111,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758497d73701.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73702,73148,35,0,73702,0,1127896112,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758497d73702.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73703,73149,35,0,73703,0,1127896112,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758497d73703.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73704,73150,35,0,73704,0,1127896113,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758497d73704.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73705,73151,35,0,73705,0,1127896114,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73705.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73706,73152,35,0,73706,0,1127896115,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73706.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73707,73153,35,0,73707,0,1127896115,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73707.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73708,73154,35,0,73708,0,1127896117,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73708.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73709,73155,35,0,73709,0,1127896118,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73709.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73710,73156,35,0,73710,0,1127896119,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73710.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73711,73157,35,0,73711,0,1127896120,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758498d73711.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73712,73158,35,0,73712,0,1127896121,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758499d73712.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73713,73159,35,0,73713,0,1127896122,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758499d73713.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73714,73163,35,0,73714,0,1127896124,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758499d73714.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73715,73164,35,0,73715,0,1127896124,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758500d73715.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73716,73165,35,0,73716,0,1127896124,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758500d73716.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73717,73166,35,0,73717,0,1127896125,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758500d73717.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73718,73167,35,0,73718,0,1127896125,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758500d73718.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73719,73168,35,0,73719,0,1127896126,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758500d73719.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73720,73169,35,0,73720,0,1127896134,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758500d73720.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73721,73170,35,0,73721,0,1127896134,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758501d73721.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73722,73171,35,0,73722,0,1127896135,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758501d73722.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73723,73172,35,0,73723,0,1127896135,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1126758501d73723.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73724,73204,35,0,73724,0,1127896136,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1127372889d73724.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73725,73205,35,0,73725,0,1127896142,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1127373628d73725.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73726,73206,35,0,73726,0,1127896143,'','','','','',0,'{cmsware_admin}/www/2005-09-28/1127373764d73726.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73731,73173,36,0,73731,0,1127912554,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73731.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73732,73174,36,0,73732,0,1127912555,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73732.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73733,73175,36,0,73733,0,1127912556,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73733.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73734,73176,36,0,73734,0,1127912557,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73734.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73735,73177,36,0,73735,0,1127912557,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73735.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73736,73178,36,0,73736,0,1127912558,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73736.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73737,73179,36,0,73737,0,1127912558,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73737.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73738,73180,36,0,73738,0,1127912558,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73738.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73739,73181,36,0,73739,0,1127912558,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73739.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73740,73182,36,0,73740,0,1127912558,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73740.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73741,73183,36,0,73741,0,1127912559,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73741.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73742,73184,36,0,73742,0,1127912559,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73742.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73743,73185,36,0,73743,0,1127912559,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73743.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73744,73186,36,0,73744,0,1127912559,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73744.wml',0,0,0);
INSERT INTO {$table_header}content_index VALUES (73745,73187,36,0,73745,0,1127912560,'','','','','',0,'{cmsware_admin}/www/wap/2005-09-28/1126863541d73745.wml',0,0,0);


DROP TABLE IF EXISTS {$table_header}content_table;

CREATE TABLE {$table_header}content_table (
  `TableID` int(8) NOT NULL auto_increment,
  `Name` varchar(100) default NULL,
  `DSNID` int(8) NOT NULL default '0',
  PRIMARY KEY  (`TableID`),
  UNIQUE KEY `TableID` (`TableID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}content_table VALUES (1,'新闻系统模型',1);
INSERT INTO {$table_header}content_table VALUES (2,'下载系统模型',1);
INSERT INTO {$table_header}content_table VALUES (3,'Flash系统模型',0);
INSERT INTO {$table_header}content_table VALUES (4,'新闻快讯',0);
INSERT INTO {$table_header}content_table VALUES (5,'友情链接',0);
INSERT INTO {$table_header}content_table VALUES (6,'图片系统模型',0);

DROP TABLE IF EXISTS {$table_header}contribution_1;

CREATE TABLE {$table_header}contribution_1 (
  `ContributionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `OwnerID` int(8) default NULL,
  `State` int(5) default '0',
  `Title` varchar(250) NOT NULL default '',
  `TitleColor` varchar(7) NOT NULL default '',
  `Author` varchar(20) NOT NULL default '',
  `Editor` varchar(20) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `SubTitle` varchar(250) NOT NULL default '',
  `Content` longtext NOT NULL,
  `Keywords` varchar(250) NOT NULL default '',
  `FromSite` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  `ContributionDate` int(10) NOT NULL default '0',
  PRIMARY KEY  (`ContributionID`,`CateID`),
  UNIQUE KEY `ContributionID` (`ContributionID`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}contribution_2;

CREATE TABLE {$table_header}contribution_2 (
  `ContributionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `OwnerID` int(8) default NULL,
  `State` int(2) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  `ContributionDate` int(10) default NULL,
  `SoftName` varchar(250) NOT NULL default '',
  `SoftSize` varchar(15) NOT NULL default '',
  `Language` varchar(10) NOT NULL default '',
  `SoftType` varchar(50) NOT NULL default '',
  `Environment` varchar(50) NOT NULL default '',
  `Star` int(2) NOT NULL default '0',
  `Developer` varchar(250) NOT NULL default '',
  `SoftKeywords` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `Download` text NOT NULL,
  `Photo` varchar(250) NOT NULL default '',
  `LocalUpload` varchar(250) NOT NULL default '',
  `CustomSoftLinks` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`ContributionID`,`CateID`),
  UNIQUE KEY `ContributionID` (`ContributionID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}contribution_3;

CREATE TABLE {$table_header}contribution_3 (
  `ContributionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `OwnerID` int(8) default NULL,
  `State` int(5) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  `ContributionDate` int(10) default NULL,
  `Title` varchar(100) NOT NULL default '',
  `Author` varchar(50) NOT NULL default '',
  `Size` varchar(20) NOT NULL default '',
  `FlashSrc` varchar(250) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`ContributionID`,`CateID`),
  UNIQUE KEY `ContributionID` (`ContributionID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}contribution_4;

CREATE TABLE {$table_header}contribution_4 (
  `ContributionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `OwnerID` int(8) default NULL,
  `State` int(5) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  `ContributionDate` int(10) default NULL,
  `Content` text NOT NULL,
  PRIMARY KEY  (`ContributionID`,`CateID`),
  UNIQUE KEY `ContributionID` (`ContributionID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}contribution_5;

CREATE TABLE {$table_header}contribution_5 (
  `ContributionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `OwnerID` int(8) default NULL,
  `State` int(5) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  `ContributionDate` int(10) default NULL,
  `LinkName` varchar(50) NOT NULL default '',
  `LinkURL` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`ContributionID`,`CateID`),
  UNIQUE KEY `ContributionID` (`ContributionID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}contribution_6;

CREATE TABLE {$table_header}contribution_6 (
  `ContributionID` int(10) NOT NULL auto_increment,
  `CateID` int(8) NOT NULL default '0',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `ApprovedDate` int(10) default NULL,
  `OwnerID` int(8) default NULL,
  `State` int(5) default NULL,
  `NodeID` int(8) NOT NULL default '0',
  `SubNodeID` varchar(250) NOT NULL default '',
  `IndexNodeID` varchar(250) NOT NULL default '',
  `ContributionDate` int(10) default NULL,
  `PhotoName` varchar(250) NOT NULL default '',
  `PhotoURL` varchar(250) NOT NULL default '',
  `PhotoIntro` text NOT NULL,
  PRIMARY KEY  (`ContributionID`,`CateID`),
  UNIQUE KEY `ContributionID` (`ContributionID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}contribution_note;

CREATE TABLE {$table_header}contribution_note (
  `NoteID` int(8) NOT NULL auto_increment,
  `ContributionID` int(10) NOT NULL default '0',
  `CateID` int(8) NOT NULL default '0',
  `Note` text,
  `NoteUserID` int(8) default NULL,
  `NoteUserName` varchar(50) default NULL,
  `NoteDate` int(10) NOT NULL default '0',
  PRIMARY KEY  (`NoteID`,`ContributionID`,`CateID`),
  UNIQUE KEY `NoteID` (`NoteID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}extra_publish;
CREATE TABLE {$table_header}extra_publish (
  `PublishID` int(8) NOT NULL auto_increment,
  `NodeID` int(8) NOT NULL default '0',
  `PublishName` varchar(100) default NULL,
  `SelfPSN` varchar(250) default NULL,
  `SelfPSNURL` varchar(250) default NULL,
  `PublishFileName` varchar(100) default NULL,
  `Tpl` varchar(250) default NULL,
  `Intro` text,
  `CreationUserID` int(8) default NULL,
  `LastModifiedUserID` int(8) default NULL,
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  PRIMARY KEY  (`PublishID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}extra_publish VALUES (2,2,'test','','','input_test.html','/input/test.html','',1,1,1127447504,1127832348);


DROP TABLE IF EXISTS {$table_header}group;

CREATE TABLE {$table_header}group (
  `gId` mediumint(8) NOT NULL auto_increment,
  `gName` varchar(50) NOT NULL default '',
  `gPass` varchar(32) NOT NULL default '0',
  `gPublishAuth` varchar(50) NOT NULL default '',
  `gInfo` text NOT NULL,
  `gIsAdmin` tinyint(1) NOT NULL default '0',
  `canLoginAdmin` tinyint(1) NOT NULL default '0',
  `canLogin` tinyint(1) NOT NULL default '1',
  `canChangePW` tinyint(1) NOT NULL default '1',
  `canTpl` tinyint(1) NOT NULL default '0',
  `canNode` tinyint(1) NOT NULL default '0',
  `canCollection` tinyint(1) NOT NULL default '0',
  `ParentGID` mediumint(8) NOT NULL default '0',
  `canMakeG` tinyint(1) NOT NULL default '0',
  `canMakeU` tinyint(1) NOT NULL default '0',
  `CreationUserID` mediumint(8) NOT NULL default '0',
  UNIQUE KEY `gId` (`gId`)
) TYPE=MyISAM;



INSERT INTO {$table_header}group VALUES (2,'Guest','','','',0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO {$table_header}group VALUES (1,'管理员','','','',1,1,0,0,1,1,0,0,0,0,0);
INSERT INTO {$table_header}group VALUES (3,'编辑','0','','',0,1,0,0,0,0,0,0,0,0,0);
INSERT INTO {$table_header}group VALUES (4,'高级编辑','0','','',0,1,0,0,0,0,0,0,0,0,0);


DROP TABLE IF EXISTS {$table_header}keywords;

CREATE TABLE {$table_header}keywords (
  `kId` mediumint(8) NOT NULL auto_increment,
  `keyword` varchar(250) NOT NULL default '',
  `kReplace` varchar(250) NOT NULL default '',
  `IsGlobal` tinyint(1) default '1',
  `NodeScope` text,
  UNIQUE KEY `kId` (`kId`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}log_admin;

CREATE TABLE {$table_header}log_admin (
  `LogID` int(10) NOT NULL auto_increment,
  `uName` char(50) default NULL,
  `IP` char(15) default NULL,
  `Action` char(100) default NULL,
  `ActionURL` char(250) default NULL,
  `Time` int(10) default NULL,
  PRIMARY KEY  (`LogID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}log_login;
CREATE TABLE {$table_header}log_login (
  `LogID` int(10) NOT NULL auto_increment,
  `uName` char(50) default NULL,
  `IP` char(15) default NULL,
  `Time` int(10) default NULL,
  PRIMARY KEY  (`LogID`)
) TYPE=MyISAM;




DROP TABLE IF EXISTS {$table_header}plugin_base_comment;

CREATE TABLE {$table_header}plugin_base_comment (
  `CommentID` int(10) NOT NULL auto_increment,
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `Author` varchar(100) default NULL,
  `CreationDate` int(10) default NULL,
  `Ip` varchar(15) default NULL,
  `Comment` text,
  `Approved` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`CommentID`),
  KEY `IndexID` (`IndexID`),
  KEY `NodeID` (`NodeID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}plugin_base_comment VALUES (41,73625,73202,22,'匿名',1127053625,'127.0.0.1','10年风雨同舟 华为GSM服务全球8000用户 (1)',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (40,73583,141,7,'匿名',1127036798,'127.0.0.1','Great!',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (28,73568,136,7,'匿名',1126855046,'127.0.0.1','ddd',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (44,73686,3,32,'匿名',1127916344,'127.0.0.1','asdfasdf',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (42,73463,73170,2,'匿名',1127553855,'127.0.0.1','sdsadf',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (32,73625,73202,22,'匿名',1126922350,'127.0.0.1','hahah\n',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (33,73556,132,7,'匿名',1127035780,'127.0.0.1','adasf',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (43,73450,73157,2,'匿名',1127559066,'127.0.0.1','奥运',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (35,73502,115,6,'匿名',1127035992,'127.0.0.1','asdfasdfasdf',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (36,73625,73202,22,'匿名',1127036100,'127.0.0.1','波音英特尔联手打造空中无线宽带网  \n以下网友留言只代表网友个人观点，不代表本网观点 立即发表评论 \n',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (25,73547,130,6,'匿名',1126778964,'127.0.0.1','asdfasdfasdf',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (26,73547,130,6,'匿名',1126778993,'127.0.0.1','\n 寻找差距\n\n　　中国电信进行此次测试的目的非常明确：为下一步17市的IPTV方案实施选型、探路。但是在测试过程中却暴露出IPTV解决方案与实际需求之间的差距。\n\n　　在目前现有的五种视频编码标准中，MPEG2仍是主流。但是从发展的眼光看，H.264和VC1将逐渐接替MPEG2。所以在此次测试中，上海电信研究院将能否支持端到端的H.264/VC1编码作为考察的一项重点，但是结果却差强人意，一些解决方案的头端和机顶盒设备不支持H.264编码。另外，不支持组播时移功能、系统纠错能力差、增值业务能力弱等问题也普遍存在。\n\n　　一位曾参加测试的上海电信研究院工作人员告诉记者，测试结果并不是让电信方面十分满意，特别是在软件功能和互联互通性方面，还差得很远，很有可能会影响到下一步IPTV试商用网的部署速度。\n\n　　IPTV是很多设备提供商看好的下一块蛋糕，在目前仍缺少大规模应用的情况下，已经涌入了大大小小数百家企业。有专家认为产业整合将很快席卷IPTV设备市场，只有尽快形成强大的产业链和成熟的技术解决方案，才有可能将IPTV这块蛋糕做大。\n ',1);
INSERT INTO {$table_header}plugin_base_comment VALUES (27,73544,129,6,'匿名',1126847666,'127.0.0.1','hello',1);


DROP TABLE IF EXISTS {$table_header}plugin_base_count;
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
  `TableID` int(5) NOT NULL default '0',
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `CID` (`ContentID`),
  KEY `TID` (`TableID`)
) TYPE=MyISAM;



INSERT INTO {$table_header}plugin_base_count VALUES (6,1,3,6,1127273451,73625,73202,22,3,1);
INSERT INTO {$table_header}plugin_base_count VALUES (4,1,1,4,1127273445,73626,73203,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127104321,73611,73188,21,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (5,5,5,5,1126950228,73612,73189,21,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73596,73173,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73597,73174,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73598,73175,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73599,73176,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73600,73177,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73601,73178,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73602,73179,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73603,73180,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127111324,73604,73181,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73605,73182,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73606,73183,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73607,73184,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73608,73185,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73609,73186,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126864365,73610,73187,20,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73595,10,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73594,9,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73593,8,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73592,7,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73591,6,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73590,5,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73589,4,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73588,3,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73587,2,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73586,1,18,0,5);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73553,131,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73556,132,7,1,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73559,133,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73562,134,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73565,135,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73568,136,7,1,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73571,137,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73574,138,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73577,139,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73580,140,7,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (4,4,4,4,1127012637,73583,141,7,1,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73550,1,17,0,4);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73551,2,17,0,4);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126852069,73552,3,17,0,4);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126859427,73469,104,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73472,105,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73475,106,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73499,114,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73502,115,6,1,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73505,116,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73508,117,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73511,118,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73514,119,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73517,120,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73520,121,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73523,122,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73526,123,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73529,124,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73541,128,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73466,103,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73433,102,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73430,101,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73538,127,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73535,126,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73532,125,6,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73496,113,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73493,112,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73490,111,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73487,110,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73484,109,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73481,108,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73478,107,13,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (9,3,9,9,1127553844,73465,73172,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,2,3,3,1127559037,73464,73171,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (4,1,1,4,1127805775,73463,73170,2,1,1);
INSERT INTO {$table_header}plugin_base_count VALUES (5,3,5,5,1127558943,73462,73169,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (4,1,4,4,1127370350,73461,73168,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370353,73460,73167,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,1,2,3,1127915493,73459,73166,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370358,73458,73165,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370360,73457,73164,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370363,73456,73163,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370365,73452,73159,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370368,73451,73158,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,2,3,3,1127559071,73450,73157,2,1,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370373,73449,73156,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (5,4,4,5,1127805834,73680,73205,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370377,73447,73154,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (16,3,3,16,1127918628,73681,73206,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126865157,73616,73193,23,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (6,6,6,6,1126972343,73455,73162,23,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73454,73161,23,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370382,73445,73152,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370384,73444,73151,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370386,73443,73150,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127370388,73442,73149,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73441,73148,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73436,73143,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73440,73147,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73439,73146,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73438,73145,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73437,73144,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73544,129,6,1,2);
INSERT INTO {$table_header}plugin_base_count VALUES (6,4,4,6,1127555710,73547,130,6,2,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73427,100,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73424,99,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73421,98,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73418,97,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73415,96,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73412,95,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73409,94,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73406,93,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73403,92,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73400,91,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73397,90,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73394,89,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73391,88,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73388,87,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73385,86,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73382,85,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73379,84,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73376,83,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73373,82,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73370,81,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73367,80,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73364,79,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73361,78,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73358,77,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73355,76,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73352,75,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73349,74,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73346,73,4,0,2);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127273454,73624,73201,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,2,2,3,1127273471,73623,73200,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,3,3,3,1127273480,73622,73199,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,2,2,3,1127706684,73621,73198,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (2,1,1,2,1127706687,73620,73197,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,1,1,3,1127273486,73619,73196,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126865173,73618,73195,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (5,1,5,5,1126940416,73617,73194,22,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126972261,73453,73160,23,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1126974794,73613,73190,3,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (7,1,1,7,1127034363,73614,73191,3,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73615,73192,3,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73711,73157,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73709,73155,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73710,73156,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73708,73154,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73707,73153,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73705,73151,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73704,73150,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73703,73149,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73702,73148,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73706,73152,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73701,73147,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73698,73144,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73700,73146,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73699,73145,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73697,73143,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (5,1,1,5,1127918971,73676,13,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (14,2,2,14,1127918807,73677,14,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (3,3,3,3,1127110756,73678,15,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (2,2,2,2,1127137197,73675,12,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (3,3,3,3,1127137203,73672,9,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (3,3,3,3,1127137202,73673,10,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (3,1,3,3,1127461994,73674,11,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (42,6,42,42,1127921329,73684,1,32,0,3);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73446,73153,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73448,73155,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (3,2,2,3,1127805442,73679,73204,2,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (6,1,6,6,1127381653,73643,1,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (6,1,6,6,1127381645,73671,8,26,0,6);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73694,73190,34,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (1,1,1,1,1127895489,73695,73191,34,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73712,73158,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73713,73159,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (13,6,13,13,1127918975,73686,3,32,1,3);
INSERT INTO {$table_header}plugin_base_count VALUES (14,9,14,14,1127919042,73687,4,32,0,3);
INSERT INTO {$table_header}plugin_base_count VALUES (23,7,23,23,1127921335,73685,2,32,0,3);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73696,73192,34,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73714,73163,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73715,73164,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73716,73165,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73717,73166,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73718,73167,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73719,73168,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73720,73169,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73721,73170,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73722,73171,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73723,73172,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73724,73204,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73725,73205,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73726,73206,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73727,73207,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73728,73212,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73729,73213,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73730,73214,35,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73731,73173,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73732,73174,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73733,73175,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73734,73176,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73735,73177,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73736,73178,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73737,73179,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73738,73180,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73739,73181,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73740,73182,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73741,73183,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73742,73184,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73743,73185,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73744,73186,36,0,1);
INSERT INTO {$table_header}plugin_base_count VALUES (0,0,0,0,0,73745,73187,36,0,1);


DROP TABLE IF EXISTS {$table_header}plugin_base_setting;

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


INSERT INTO {$table_header}plugin_base_setting VALUES (1,0,'/org.cmsware.demo/comment/comment.html',1,15,1000,1,0,0,0,0,0,'/org.cmsware.demo/search/search_result.html','/org.cmsware.demo/search/search.html',10,'Title,Content');
INSERT INTO {$table_header}plugin_base_setting VALUES (2,0,'/org.cmsware.demo/comment/comment.html',1,15,1000,1,0,0,0,0,0,'/org.cmsware.demo/search/search_result.html','/org.cmsware.demo/search/search.html',15,'SoftName');
INSERT INTO {$table_header}plugin_base_setting VALUES (6,0,'/org.cmsware.demo/comment/comment.html',1,15,1000,1,0,0,0,0,0,'/org.cmsware.demo/search/search_result.html','/org.cmsware.demo/search/search.html',15,'PhotoName');
INSERT INTO {$table_header}plugin_base_setting VALUES (3,0,'/org.cmsware.demo/comment/comment.html',1,15,1000,1,0,0,0,0,0,'/org.cmsware.demo/search/search_result.html','/org.cmsware.demo/search/search.html',15,'Title,Intro,Author');


DROP TABLE IF EXISTS {$table_header}plugin_bbsi_access;

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
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}plugin_bbsi_setting;
CREATE TABLE {$table_header}plugin_bbsi_setting (
  `ForegroundPath` varchar(250) NOT NULL default '',
  `BBS` varchar(50) NOT NULL default '',
  `DenyTpl` varchar(250) NOT NULL default ''
) TYPE=MyISAM;


INSERT INTO {$table_header}plugin_bbsi_setting VALUES ('','','/dynamic/error.html');

DROP TABLE IF EXISTS {$table_header}plugins;

CREATE TABLE {$table_header}plugins (
  `pId` int(10) NOT NULL auto_increment,
  `pName` varchar(250) NOT NULL default '',
  `Path` varchar(250) NOT NULL default '',
  `Info` text NOT NULL,
  `LicenseKey` text,
  `AccessGroup` text,
  `AccessUser` text,
  PRIMARY KEY  (`pId`)
) TYPE=MyISAM;


INSERT INTO {$table_header}plugins VALUES (1,'基础插件','base','评论/计数','','[,1,]','[,,]');
INSERT INTO {$table_header}plugins VALUES (2,'会员接口','bbsInterface','实现与各类论坛的接口','','[,1,]','[,,]');

DROP TABLE IF EXISTS {$table_header}psn;
CREATE TABLE {$table_header}psn (
  `PSNID` int(10) NOT NULL auto_increment,
  `Name` varchar(20) default NULL,
  `PSN` varchar(250) default NULL,
  `URL` varchar(250) default NULL,
  `Description` mediumtext NOT NULL,
  `PermissionReadG` text NOT NULL,
  PRIMARY KEY  (`PSNID`),
  UNIQUE KEY `PSNID` (`PSNID`),
  UNIQUE KEY `Name` (`Name`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}pubadminmasks;
CREATE TABLE {$table_header}pubadminmasks (
  `pId` mediumint(8) NOT NULL auto_increment,
  `pName` varchar(50) NOT NULL default '',
  `pInfo` varchar(250) NOT NULL default '',
  `NodeList` text NOT NULL,
  `NodeExtraPublish` text NOT NULL,
  `NodeSetting` text NOT NULL,
  `ContentRead` text NOT NULL,
  `ContentWrite` text NOT NULL,
  `ContentApprove` text NOT NULL,
  `ContentPublish` text NOT NULL,
  `AuthInherit` text NOT NULL,
  UNIQUE KEY `pAId` (`pId`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}publish_1;
CREATE TABLE {$table_header}publish_1 (
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PublishDate` int(10) default NULL,
  `URL` varchar(250) default NULL,
  `Title` varchar(250) NOT NULL default '',
  `TitleColor` varchar(7) NOT NULL default '',
  `Author` varchar(20) NOT NULL default '',
  `Editor` varchar(20) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `SubTitle` varchar(250) NOT NULL default '',
  `Content` longtext NOT NULL,
  `Keywords` varchar(250) NOT NULL default '',
  `FromSite` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text,
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `ContentID` (`ContentID`),
  KEY `PublishDate` (`PublishDate`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}publish_2;

CREATE TABLE {$table_header}publish_2 (
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PublishDate` int(10) default NULL,
  `URL` varchar(250) default NULL,
  `SoftName` varchar(250) NOT NULL default '',
  `SoftSize` varchar(15) NOT NULL default '',
  `Language` varchar(10) NOT NULL default '',
  `SoftType` varchar(50) NOT NULL default '',
  `Environment` varchar(50) NOT NULL default '',
  `Star` int(2) NOT NULL default '0',
  `Developer` varchar(250) NOT NULL default '',
  `SoftKeywords` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `Download` text NOT NULL,
  `Photo` varchar(250) NOT NULL default '',
  `LocalUpload` varchar(250) NOT NULL default '',
  `CustomSoftLinks` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `ContentID` (`ContentID`),
  KEY `PublishDate` (`PublishDate`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}publish_3;

CREATE TABLE {$table_header}publish_3 (
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PublishDate` int(10) default NULL,
  `URL` varchar(250) default NULL,
  `Title` varchar(100) NOT NULL default '',
  `Author` varchar(50) NOT NULL default '',
  `Size` varchar(20) NOT NULL default '',
  `FlashSrc` varchar(250) NOT NULL default '',
  `Photo` varchar(250) NOT NULL default '',
  `Intro` text NOT NULL,
  `CustomLinks` text NOT NULL,
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `ContentID` (`ContentID`),
  KEY `PublishDate` (`PublishDate`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}publish_4;

CREATE TABLE {$table_header}publish_4 (
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PublishDate` int(10) default NULL,
  `URL` varchar(250) default NULL,
  `Content` text NOT NULL,
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `ContentID` (`ContentID`),
  KEY `PublishDate` (`PublishDate`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}publish_5;

CREATE TABLE {$table_header}publish_5 (
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PublishDate` int(10) default NULL,
  `URL` varchar(250) default NULL,
  `LinkName` varchar(50) NOT NULL default '',
  `LinkURL` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `ContentID` (`ContentID`),
  KEY `PublishDate` (`PublishDate`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}publish_6;

CREATE TABLE {$table_header}publish_6 (
  `IndexID` int(10) NOT NULL default '0',
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PublishDate` int(10) default NULL,
  `URL` varchar(250) default NULL,
  `PhotoName` varchar(250) NOT NULL default '',
  `PhotoURL` varchar(250) NOT NULL default '',
  `PhotoIntro` text NOT NULL,
  PRIMARY KEY  (`IndexID`),
  KEY `NodeID` (`NodeID`),
  KEY `ContentID` (`ContentID`),
  KEY `PublishDate` (`PublishDate`)
) TYPE=MyISAM;

 

DROP TABLE IF EXISTS {$table_header}publish_log;

CREATE TABLE {$table_header}publish_log (
  `logID` int(8) NOT NULL auto_increment,
  `ContentID` int(10) NOT NULL default '0',
  `NodeID` int(10) NOT NULL default '0',
  `PSN` varchar(50) default NULL,
  `FileName` varchar(100) default NULL,
  `TYPE` varchar(20) default NULL,
  `URL` varchar(250) default NULL,
  PRIMARY KEY  (`logID`,`ContentID`,`NodeID`),
  UNIQUE KEY `logID` (`logID`),
  KEY `C_P_F` (`ContentID`,`PSN`,`FileName`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}resource;

CREATE TABLE {$table_header}resource (
  `ResourceID` int(10) NOT NULL auto_increment,
  `NodeID` int(10) NOT NULL default '0',
  `ParentID` int(10) NOT NULL default '0',
  `Type` tinyint(1) default '1',
  `Category` varchar(20) NOT NULL default '',
  `Name` varchar(250) default NULL,
  `Path` varchar(250) NOT NULL default '',
  `Size` int(10) default NULL,
  `Info` varchar(250) NOT NULL default '',
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  `Src` varchar(250) NOT NULL default '',
  `Title` varchar(250) NOT NULL default '',
  `CreationUserID` int(8) NOT NULL default '0',
  PRIMARY KEY  (`ResourceID`,`NodeID`),
  KEY `Path` (`Path`),
  KEY `Name` (`Name`),
  KEY `Src` (`Src`),
  KEY `Category` (`Category`),
  KEY `CUID` (`CreationUserID`)
) TYPE=MyISAM;



INSERT INTO {$table_header}resource VALUES (324,0,0,1,'img','img200509191119190.jpg','img/h000/h00/img200509191119190.jpg',231208,'1024*768',1127099959,1127099959,'','',0);
INSERT INTO {$table_header}resource VALUES (323,0,0,1,'img','img200509191119000.jpg','img/h000/h00/img200509191119000.jpg',95374,'1024*768',1127099940,1127099940,'','',0);
INSERT INTO {$table_header}resource VALUES (322,0,0,1,'img','img200509191118370.jpg','img/h000/h00/img200509191118370.jpg',34233,'800*600',1127099917,1127099917,'','',0);
INSERT INTO {$table_header}resource VALUES (321,0,0,1,'img','img200509191117050.jpg','img/h000/h00/img200509191117050.jpg',154369,'800*600',1127099825,1127099825,'','',0);
INSERT INTO {$table_header}resource VALUES (320,0,0,1,'img','img200509191116470.jpg','img/h000/h00/img200509191116470.jpg',165246,'1024*768',1127099807,1127099807,'','',0);
INSERT INTO {$table_header}resource VALUES (319,0,0,1,'img','img200509191116310.jpg','img/h000/h00/img200509191116310.jpg',96377,'1024*768',1127099791,1127099791,'','',0);
INSERT INTO {$table_header}resource VALUES (318,0,0,1,'img','img200509191112260.jpg','img/h000/h00/img200509191112260.jpg',397052,'1024*768',1127099546,1127099546,'','',0);
INSERT INTO {$table_header}resource VALUES (317,0,0,1,'img','img200509191111180.jpg','img/h000/h00/img200509191111180.jpg',1908046,'1600*1200',1127099479,1127099479,'','',0);
INSERT INTO {$table_header}resource VALUES (310,0,0,1,'img','img200509171011110.jpg','img/h000/h00/img200509171011110.jpg',25648,'400*267',1126923071,1126923071,'','',0);
INSERT INTO {$table_header}resource VALUES (309,0,0,1,'img','img200509161713350.jpg','img/h000/h00/img200509161713350.jpg',2744,'125*90',1126862015,1126862015,'','',0);
INSERT INTO {$table_header}resource VALUES (308,0,0,1,'img','img200509161648160.jpg','img/h000/h00/img200509161648160.jpg',3646,'120*90',1126860496,1126860496,'','',0);
INSERT INTO {$table_header}resource VALUES (307,0,0,1,'img','img200509161648020.jpg','img/h000/h00/img200509161648020.jpg',3114,'120*90',1126860482,1126860482,'','',0);
INSERT INTO {$table_header}resource VALUES (305,0,0,1,'img','img200509161645340.jpg','img/h000/h00/img200509161645340.jpg',2510,'120*90',1126860334,1126860334,'','',0);
INSERT INTO {$table_header}resource VALUES (304,0,0,1,'img','img200509161527050.jpg','img/h000/h00/img200509161527050.jpg',29390,'393*220',1126855625,1126855625,'','',0);
INSERT INTO {$table_header}resource VALUES (303,0,0,1,'img','img200509161526350.jpg','img/h000/h00/img200509161526350.jpg',4061,'55*55',1126855595,1126855595,'','',0);
INSERT INTO {$table_header}resource VALUES (302,0,0,1,'img','img200509161526100.jpg','img/h000/h00/img200509161526100.jpg',3478,'140*105',1126855571,1126855571,'','',0);
INSERT INTO {$table_header}resource VALUES (301,0,0,1,'img','img200509161525000.jpg','img/h000/h00/img200509161525000.jpg',4794,'55*55',1126855500,1126855500,'','',0);
INSERT INTO {$table_header}resource VALUES (142,0,0,1,'img','img200508132016350.jpg','img/h000/h00/img200508132016350.jpg',55597,'460*456',1123935396,1123935396,'','',0);
INSERT INTO {$table_header}resource VALUES (143,0,0,1,'img','502bd5b82b4d732c217c98e07b00f858.jpg','img/h000/h00/502bd5b82b4d732c217c98e07b00f858.jpg',NULL,'',1123935407,1123935407,'','',0);
INSERT INTO {$table_header}resource VALUES (397,0,0,1,'img','img200509221507400134.jpg','img/h000/h00/img200509221507400134.jpg',18709,'300*450',1127372861,1127372861,'http://image.techweb.com.cn/h00/h46/img200509162158470.jpg','',0);
INSERT INTO {$table_header}resource VALUES (538,0,0,1,'flash','flash200509271757450.swf','flash/h000/h00/flash200509271757450.swf',8750,'',1127815065,1127815065,'','120180gn526.swf',1);
INSERT INTO {$table_header}resource VALUES (399,0,0,1,'img','img200509221507450263.jpg','img/h000/h00/img200509221507450263.jpg',10628,'269*230',1127372865,1127372865,'http://image.techweb.com.cn/h00/h46/img200509162158110.jpg','',0);
INSERT INTO {$table_header}resource VALUES (218,0,0,1,'img','img200508151142350.jpg','img/h000/h00/img200508151142350.jpg',3318,'124*92',1124077355,1124077355,'','',0);
INSERT INTO {$table_header}resource VALUES (220,0,0,1,'img','img200508171851460495.jpg','img/h000/h00/img200508171851460495.jpg',30641,'500*333',1124275906,1124275906,'http://image.techweb.com.cn/h00/h46/img200508022331220.jpg','',0);
INSERT INTO {$table_header}resource VALUES (426,0,0,1,'img','037b1e10a9faed5cd950477d0850c67c.jpg','img/h000/h00/037b1e10a9faed5cd950477d0850c67c.jpg',NULL,'',1127461657,1127461657,'','',0);
INSERT INTO {$table_header}resource VALUES (400,0,0,1,'img','img200509221507451962.jpg','img/h000/h00/img200509221507451962.jpg',9979,'283*247',1127372866,1127372866,'http://image.techweb.com.cn/h00/h46/img200509162158111.jpg','',0);
INSERT INTO {$table_header}resource VALUES (225,0,0,1,'img','img200508241951290.jpg','img/h000/h00/img200508241951290.jpg',55597,'460*456',1124884289,1124884289,'','',0);
INSERT INTO {$table_header}resource VALUES (401,0,0,1,'img','img20050922150746284.jpg','img/h000/h00/img20050922150746284.jpg',30479,'525*188',1127372866,1127372866,'http://image.techweb.com.cn/h00/h46/img200509162158112.jpg','',0);
INSERT INTO {$table_header}resource VALUES (402,0,0,1,'img','img200509221507463757.jpg','img/h000/h00/img200509221507463757.jpg',30479,'525*188',1127372867,1127372867,'http://image.techweb.com.cn/h00/h46/img200509162158173.jpg','',0);
INSERT INTO {$table_header}resource VALUES (230,0,0,1,'img','img200508241952402.jpg','img/h000/h00/img200508241952402.jpg',2881,'120*90',1124884360,1124884360,'','',0);
INSERT INTO {$table_header}resource VALUES (241,0,0,1,'img','img200508241959201.jpg','img/h000/h00/img200508241959201.jpg',3318,'124*92',1124884760,1124884760,'','',0);
INSERT INTO {$table_header}resource VALUES (243,0,0,1,'img','img200508241959202.jpg','img/h000/h00/img200508241959202.jpg',2741,'127*92',1124884760,1124884760,'','',0);
INSERT INTO {$table_header}resource VALUES (412,0,0,1,'img','img200509221508480133.jpg','img/h000/h00/img200509221508480133.jpg',31569,'450*338',1127372929,1127372929,'http://image.techweb.com.cn/h00/h46/img200509162159190.jpg','',0);
INSERT INTO {$table_header}resource VALUES (298,0,0,1,'img','img200509151326190.jpg','img/h000/h00/img200509151326190.jpg',25648,'400*267',1126761980,1126761980,'','',0);
INSERT INTO {$table_header}resource VALUES (537,0,0,1,'flash','flash200509271757040.swf','flash/h000/h00/flash200509271757040.swf',4655,'',1127815024,1127815024,'','12050822.swf',1);
INSERT INTO {$table_header}resource VALUES (487,0,0,1,'img','934c38f5d68edb30127b88382b0ed0f3.jpg','img/h000/h00/934c38f5d68edb30127b88382b0ed0f3.jpg',NULL,'',1127558572,1127558572,'','',0);
INSERT INTO {$table_header}resource VALUES (488,0,0,1,'img','7ac2b69fb65fd69e317bac594802e78a.jpg','img/h000/h00/7ac2b69fb65fd69e317bac594802e78a.jpg',16216,'Array',1127560017,1127560017,'','',1);
INSERT INTO {$table_header}resource VALUES (533,30,0,1,'flash','flash200509261712040.swf','flash/h000/h00/flash200509261712040.swf',4655,'',1127725924,1127725924,'','12050822.swf',1);
INSERT INTO {$table_header}resource VALUES (534,30,0,1,'flash','flash200509261717460.swf','flash/h000/h00/flash200509261717460.swf',4307,'',1127726266,1127726266,'','000.swf',1);
INSERT INTO {$table_header}resource VALUES (526,30,0,1,'flash','flash200509261542230.swf','flash/h000/h00/flash200509261542230.swf',21037,'',1127720543,1127720543,'','gj590105912.swf',1);
INSERT INTO {$table_header}resource VALUES (527,2,0,1,'flash','flash200509261546130.swf','flash/h000/h00/flash200509261546130.swf',5618,'',1127720773,1127720773,'','120600407.swf',1);


DROP TABLE IF EXISTS {$table_header}resource_ref;
CREATE TABLE {$table_header}resource_ref  (
  `NodeID` int(10) NOT NULL default '0',
  `IndexID` int(10) NOT NULL default '0',
  `ResourceID` int(10) NOT NULL default '0',
  `CollectionKey` char(32) NOT NULL default '',
  KEY `I_R` (`IndexID`,`ResourceID`),
  KEY `N_I_R` (`NodeID`,`IndexID`,`ResourceID`),
  KEY `R_C` (`ResourceID`,`CollectionKey`)
) TYPE=MyISAM;


INSERT INTO {$table_header}resource_ref VALUES (1,1,225,'');
INSERT INTO {$table_header}resource_ref VALUES (2,119,218,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73139,142,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73139,143,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73442,220,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73451,308,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73453,307,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73459,309,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73462,305,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73465,412,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73679,399,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73679,400,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73679,401,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73679,402,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73680,397,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73681,302,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73681,310,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73681,426,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73681,487,'');
INSERT INTO {$table_header}resource_ref VALUES (2,73682,489,'');
INSERT INTO {$table_header}resource_ref VALUES (6,73469,303,'');
INSERT INTO {$table_header}resource_ref VALUES (6,73472,301,'');
INSERT INTO {$table_header}resource_ref VALUES (6,73502,302,'');
INSERT INTO {$table_header}resource_ref VALUES (6,73505,298,'');
INSERT INTO {$table_header}resource_ref VALUES (7,73583,304,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73643,310,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73671,317,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73672,318,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73673,319,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73674,320,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73675,321,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73676,322,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73677,323,'');
INSERT INTO {$table_header}resource_ref VALUES (26,73678,324,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73684,241,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73684,533,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73685,302,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73685,526,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73686,243,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73686,534,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73687,230,'');
INSERT INTO {$table_header}resource_ref VALUES (32,73687,527,'');


DROP TABLE IF EXISTS {$table_header}sessions;

CREATE TABLE {$table_header}sessions (
  `sId` varchar(32) NOT NULL default '',
  `sIpAddress` varchar(16) NOT NULL default '',
  `sUserName` varchar(32) NOT NULL default '',
  `sUId` int(8) NOT NULL default '0',
  `sLogInTime` int(10) NOT NULL default '0',
  `sRunningTime` int(10) NOT NULL default '0',
  PRIMARY KEY  (`sId`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}site;

CREATE TABLE {$table_header}site (
  `NodeID` int(10) NOT NULL auto_increment,
  `NodeGUID` varchar(250) default NULL,
  `TableID` int(8) NOT NULL default '0',
  `ParentID` int(10) default NULL,
  `RootID` int(10) NOT NULL default '0',
  `InheritNodeID` int(8) NOT NULL default '0',
  `NodeType` tinyint(1) NOT NULL default '1',
  `NodeSort` tinyint(5) NOT NULL default '0',
  `Name` varchar(250) default NULL,
  `ContentPSN` varchar(250) default NULL,
  `ContentURL` varchar(250) default NULL,
  `ResourcePSN` varchar(250) default NULL,
  `ResourceURL` varchar(250) default NULL,
  `PublishMode` tinyint(1) default '1',
  `IndexTpl` varchar(250) default NULL,
  `IndexName` varchar(250) NOT NULL default '',
  `ContentTpl` varchar(250) default NULL,
  `ImageTpl` varchar(250) default NULL,
  `SubDir` varchar(20) default NULL,
  `PublishFileFormat` varchar(250) default NULL,
  `IsComment` tinyint(1) default '0',
  `CommentLength` int(10) default NULL,
  `IsPrint` tinyint(1) default '0',
  `IsGrade` tinyint(1) default '0',
  `IsMail` tinyint(1) default '0',
  `Disabled` tinyint(1) NOT NULL default '0',
  `AutoPublish` tinyint(1) NOT NULL default '1',
  `IndexPortalURL` varchar(250) NOT NULL default '',
  `ContentPortalURL` varchar(250) NOT NULL default '',
  `Pager` varchar(20) NOT NULL default '',
  `Editor` varchar(50) default NULL,
  `WorkFlow` int(8) NOT NULL default '0',
  `PermissionManageG` text NOT NULL,
  `PermissionManageU` text NOT NULL,
  `PermissionReadG` text NOT NULL,
  `PermissionReadU` text NOT NULL,
  `PermissionWriteG` text NOT NULL,
  `PermissionWriteU` text NOT NULL,
  `PermissionApproveG` text NOT NULL,
  `PermissionApproveU` text NOT NULL,
  `PermissionPublishG` text NOT NULL,
  `PermissionPublishU` text NOT NULL,
  `PermissionInherit` text NOT NULL,
  `CreationUserID` int(8) NOT NULL default '0',
  UNIQUE KEY `NodeID` (`NodeID`),
  KEY `P_D` (`ParentID`,`Disabled`),
  KEY `D` (`Disabled`),
  KEY `InheritNodeID` (`InheritNodeID`)
) TYPE=MyISAM;


INSERT INTO {$table_header}site VALUES (1,'com.cmsware.demo',1,0,0,0,1,5,'资讯中心','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/index.html','index.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',0);
INSERT INTO {$table_header}site VALUES (2,'com.cmsware.demo.news.hard_news',1,1,0,0,1,0,'重要消息','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','Y-m-d','content.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','news_editor.php',4,'','','','','','','','','','','0',0);
INSERT INTO {$table_header}site VALUES (3,'com.cmsware.demo.news.it',1,1,0,0,1,0,'IT资讯','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','news_editor.php',0,'','','','','','','','','','','0',0);
INSERT INTO {$table_header}site VALUES (4,'com.cmsware.demo.download',2,0,0,0,1,4,'下载中心','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/index.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html','','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',3,'','','','','','','','','','','0',0);
INSERT INTO {$table_header}site VALUES (5,'com.cmsware.demo.wap',1,0,0,0,1,0,'WAP','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/wap/index.wml','index_{NodeID}.wml','/wap/content.wml','','Y-m-d','{TimeStamp}d{ContentID}.wml',0,NULL,0,0,0,0,1,'','http://cmsware/publish/content.php/{IndexID},{Page}.html','wap.php','news_editor.php',3,'3','','','','','','','','','','0',0);
INSERT INTO {$table_header}site VALUES (19,'',1,0,0,0,1,0,'技术论坛',NULL,NULL,'','',2,'','index.html','','','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://www.cmsware.net/bbs','','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (6,'',2,4,0,0,1,0,'PHP源码','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index.download.php_{NodeID}.html','/org.cmsware.demo/download/content.html','','Y-m-d','Soft{NodeID}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (7,NULL,2,4,0,0,1,0,'ASP源码','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (8,'',2,4,0,0,1,0,'CGI 源码','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html','','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (9,NULL,2,4,0,0,1,0,'JSP 源码','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (10,NULL,2,4,0,0,1,0,'.NET 源码','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (11,NULL,2,4,0,0,1,0,' 服务器类','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',3,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (12,NULL,2,4,0,0,1,0,'素材模板','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (13,NULL,2,4,0,0,1,0,'常用工具','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',3,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (14,NULL,2,4,0,0,1,0,'书籍教程','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (15,NULL,2,4,0,0,1,0,'其他源码','{PSN:1}/download','{PSN-URL:1}/download','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/download/list.html','index_{NodeID}.html','/org.cmsware.demo/download/content.html',NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,1,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','download_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (16,NULL,3,1,0,0,1,0,'新闻快讯',NULL,NULL,NULL,NULL,2,NULL,'index.html',NULL,NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,1,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (17,'com.cmsware.download.news',4,4,0,0,1,0,'新闻快讯',NULL,NULL,'','',2,'','index.html','','','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (18,'com.cmsware.download.links',5,4,0,0,1,0,'友情链接',NULL,NULL,'','',2,'','index.html','','','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'','','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (25,'com.cmsware.demo.photo',6,0,0,0,1,3,'图库中心','{PSN:1}/photo','{PSN-URL:1}/photo','{PSN:1}/photo','{PSN-URL:1}/photo',1,'/org.cmsware.demo/photo/index.html','index.html','/org.cmsware.demo/photo/content.html','','auto','photo.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (20,'',1,1,0,0,1,0,'财经资讯','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','news_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (21,'',1,1,0,0,1,0,'软件编程','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','auto','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','news_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (22,'',1,1,0,0,1,0,'网络技术','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','auto','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','news_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (23,NULL,1,1,0,0,1,0,'网络文学','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','auto','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','news_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (24,NULL,1,1,0,0,1,0,'生活休闲','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/org.cmsware.demo/news/list.html','index_{NodeID}.html','/org.cmsware.demo/news/content.html','/org.cmsware.demo/news/image.html','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','news_editor.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (26,NULL,6,25,0,0,1,0,'自然风景','{PSN:1}/photo','{PSN-URL:1}/photo','{PSN:1}/photo','{PSN-URL:1}/photo',1,'/org.cmsware.demo/photo/list.html','index_{NodeID}.html','/org.cmsware.demo/photo/content.html',NULL,'auto','photo.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (27,NULL,6,25,0,0,1,0,'个人相册','{PSN:1}/photo','{PSN-URL:1}/photo','{PSN:1}/photo','{PSN-URL:1}/photo',1,'/org.cmsware.demo/photo/list.html','index_{NodeID}.html','/org.cmsware.demo/photo/content.html',NULL,'auto','photo.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (28,'com.cmsware.demo.search',1,0,0,0,1,1,'搜索',NULL,NULL,'','',2,'','index.html','','','Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'{cmsware_admin}publish/search.php?o=pro','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (29,NULL,1,0,0,0,1,0,'Flash中心',NULL,NULL,NULL,NULL,1,NULL,'index.html',NULL,NULL,'Y-m-d','{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,1,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','auto.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (30,'com.cmsware.demo.flash',3,0,0,0,1,2,'Flash中心','{PSN:1}/flash','{PSN-URL:1}/flash','{PSN:1}/flash','{PSN-URL:1}/flash',1,'/org.cmsware.demo/flash/index.html','index.html','/org.cmsware.demo/flash/content.html','','Y/m','flash.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (31,NULL,3,30,0,0,1,0,'音乐MTV','{PSN:1}/flash','{PSN-URL:1}/flash','{PSN:1}/flash','{PSN-URL:1}/flash',1,'/org.cmsware.demo/flash/list.html','flash_{NodeID}.html','/org.cmsware.demo/flash/content.html',NULL,'Y/m','flash.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (32,NULL,3,30,0,0,1,0,'Flash游戏','{PSN:1}/flash','{PSN-URL:1}/flash','{PSN:1}/flash','{PSN-URL:1}/flash',1,'/org.cmsware.demo/flash/list.html','flash_{NodeID}.html','/org.cmsware.demo/flash/content.html',NULL,'Y/m','flash.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (33,NULL,3,30,0,0,1,0,'故事小品','{PSN:1}/flash','{PSN-URL:1}/flash','{PSN:1}/flash','{PSN-URL:1}/flash',1,'/org.cmsware.demo/flash/list.html','flash_{NodeID}.html','/org.cmsware.demo/flash/content.html',NULL,'Y/m','flash.{TimeStamp}d{ContentID}.html',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','default.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (34,'',1,5,0,3,2,0,'IT资讯','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/wap/list.wml','index_{NodeID}.wml','/wap/content.wml','','Y-m-d','{TimeStamp}d{ContentID}.wml',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','wap.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (35,'',1,5,0,2,2,0,'重要消息','{PSN:1}','{PSN-URL:1}','{PSN:1}','{PSN-URL:1}',1,'/wap/list.wml','index_{NodeID}.wml','/wap/content.wml','','Y-m-d','{TimeStamp}d{ContentID}.wml',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','wap.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (36,NULL,1,5,0,20,2,0,'财经资讯','{PSN:1}/wap','{PSN-URL:1}/wap','{PSN:1}/wap','{PSN-URL:1}/wap',1,'/wap/list.wml','index_{NodeID}.wml','/wap/content.wml',NULL,'Y-m-d','{TimeStamp}d{ContentID}.wml',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','wap.php','default.php',0,'','','','','','','','','','','0',1);
INSERT INTO {$table_header}site VALUES (37,NULL,1,5,0,24,2,0,'生活休闲','{PSN:1}/wap','{PSN-URL:1}/wap','{PSN:1}/wap','{PSN-URL:1}/wap',1,'/wap/list.wml','index_{NodeID}.wml','/wap/content.wml',NULL,'Y-m-d','{TimeStamp}d{ContentID}.wml',0,NULL,0,0,0,0,2,'http://cmsware/publish/index.php/{NodeID},{Page}.html','http://cmsware/publish/content.php/{IndexID},{Page}.html','wap.php','default.php',0,'','','','','','','','','','','0',1);


DROP TABLE IF EXISTS {$table_header}sys;

CREATE TABLE {$table_header}sys (
  `id` int(10) NOT NULL auto_increment,
  `varName` varchar(50) NOT NULL default '',
  `varValue` text NOT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `var` (`varName`)
) TYPE=MyISAM;


INSERT INTO {$table_header}sys VALUES (2,'backupPath','../backup');
INSERT INTO {$table_header}sys VALUES (5,'hostname','');
INSERT INTO {$table_header}sys VALUES (6,'sysname','{cmsware_admin}');
INSERT INTO {$table_header}sys VALUES (7,'version','CMSware 2.5 Plus Stable');
INSERT INTO {$table_header}sys VALUES (8,'templatePath','../templates');
INSERT INTO {$table_header}sys VALUES (9,'smtp_host','');
INSERT INTO {$table_header}sys VALUES (10,'smtp_username','');
INSERT INTO {$table_header}sys VALUES (11,'smtp_password','');
INSERT INTO {$table_header}sys VALUES (12,'smtp_from_email','');
INSERT INTO {$table_header}sys VALUES (13,'smtp_auth','');
INSERT INTO {$table_header}sys VALUES (14,'upImgType','png|gif|jpeg|jpg');
INSERT INTO {$table_header}sys VALUES (15,'upImgSize','10000');
INSERT INTO {$table_header}sys VALUES (16,'upAttachType','zip|rar|doc|xls|txt');
INSERT INTO {$table_header}sys VALUES (17,'upAttachSize','1000');
INSERT INTO {$table_header}sys VALUES (20,'tasktimeout','1127965924');
INSERT INTO {$table_header}sys VALUES (21,'sitename','');
INSERT INTO {$table_header}sys VALUES (29,'uploadPath','');
INSERT INTO {$table_header}sys VALUES (30,'ResourceNum','319');
INSERT INTO {$table_header}sys VALUES (31,'upload_flash_num','32');
INSERT INTO {$table_header}sys VALUES (32,'upload_attach_num','44');
INSERT INTO {$table_header}sys VALUES (33,'uploadUrl','');
INSERT INTO {$table_header}sys VALUES (34,'upFlashSize','10000');
INSERT INTO {$table_header}sys VALUES (101,'openTask','');
INSERT INTO {$table_header}sys VALUES (102,'ResourcePath','../resource');
INSERT INTO {$table_header}sys VALUES (103,'localImgIgnoreURL','{localhost}{127.0.0.1}{{cmsware_admin_host}}');
INSERT INTO {$table_header}sys VALUES (104,'publishResourceNum','10840');
INSERT INTO {$table_header}sys VALUES (105,'is_safe_mode','0');
INSERT INTO {$table_header}sys VALUES (106,'ftp_server','0');
INSERT INTO {$table_header}sys VALUES (107,'ftp_server_port','0');
INSERT INTO {$table_header}sys VALUES (108,'ftp_user_name','0');
INSERT INTO {$table_header}sys VALUES (109,'ftp_user_pass','0');
INSERT INTO {$table_header}sys VALUES (110,'ftp_cms_admin_path','0');
INSERT INTO {$table_header}sys VALUES (111,'language','chinese_gb');
INSERT INTO {$table_header}sys VALUES (112,'DisplayNodeID','1');
INSERT INTO {$table_header}sys VALUES (113,'CollectionPageNum','15');
INSERT INTO {$table_header}sys VALUES (114,'ContentPageNum','15');
INSERT INTO {$table_header}sys VALUES (115,'SearchPageNum','15');
INSERT INTO {$table_header}sys VALUES (116,'sessionTimeout','120');
INSERT INTO {$table_header}sys VALUES (117,'isLogLogin','1');
INSERT INTO {$table_header}sys VALUES (118,'isLogAdmin','1');
INSERT INTO {$table_header}sys VALUES (119,'DisplayPublishCount','1');
INSERT INTO {$table_header}sys VALUES (120,'LoginTryTime','15');
INSERT INTO {$table_header}sys VALUES (121,'LoginTryCount','5');
INSERT INTO {$table_header}sys VALUES (122,'enable_gzip','0');
INSERT INTO {$table_header}sys VALUES (123,'AutoPageLen','2000');
INSERT INTO {$table_header}sys VALUES ('','EnableWaterMark','0');
INSERT INTO {$table_header}sys VALUES ('','WaterMarkImgPath', '../html/WaterMark.gif');
INSERT INTO {$table_header}sys VALUES ('','WaterMarkPosition', '1');
INSERT INTO {$table_header}sys SET `varName`='EnableCLWaterMark';
INSERT INTO {$table_header}sys SET `varName`='ContentViewMode', `varValue`='1';
INSERT INTO {$table_header}sys SET `varName`='CollectionViewMode', `varValue`='1';
INSERT INTO {$table_header}sys SET `varName`='ContributionViewMode', `varValue`='1';
INSERT INTO {$table_header}sys SET `varName`='DefaultResourcePSN';
INSERT INTO {$table_header}sys SET `varName`='DefaultResourcePSNURL';
INSERT INTO {$table_header}sys SET `varName`='DefaultContentPSN';
INSERT INTO {$table_header}sys SET `varName`='DefaultContentPSNURL';
INSERT INTO {$table_header}sys SET `varName`='DialogFitXP', `varValue`='0';
INSERT INTO {$table_header}sys SET `varName`='EnableEditorWaterMark', `varValue`='1';
INSERT INTO {$table_header}sys (`varName`, `varValue`) VALUES ('AutoRefreshTree', '0');


DROP TABLE IF EXISTS {$table_header}tasks;

CREATE TABLE {$table_header}tasks (
  `TaskID` varchar(32) NOT NULL default '',
  `TaskData` longblob NOT NULL,
  `TaskTime` int(10) NOT NULL default '0',
  KEY `TID` (`TaskID`)
) TYPE=MyISAM;

 
DROP TABLE IF EXISTS {$table_header}tpl_cate;

CREATE TABLE {$table_header}tpl_cate (
  `TCID` int(10) NOT NULL auto_increment,
  `CateName` varchar(50) default NULL,
  `ParentTCID` int(10) default '0',
  `ReadG` text,
  `WriteG` text,
  `ManageG` text,
  `ReadU` text,
  `WriteU` text,
  `ManageU` text,
  `Inherit` tinyint(1) default '0',
  `CreationUserID` int(8) default NULL,
  PRIMARY KEY  (`TCID`),
  KEY `ParentTCID` (`ParentTCID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}tpl_data;

CREATE TABLE {$table_header}tpl_data (
  `TID` int(11) NOT NULL auto_increment,
  `TCID` int(10) NOT NULL default '0',
  `TplName` varchar(50) default NULL,
  `TplType` int(3) NOT NULL default '0',
  `CreationUserID` int(5) default NULL,
  `LastModifiedUserID` int(5) default NULL,
  `CreationDate` int(10) default NULL,
  `ModifiedDate` int(10) default NULL,
  PRIMARY KEY  (`TID`),
  KEY `NodeID` (`TCID`)
) TYPE=MyISAM;


DROP TABLE IF EXISTS {$table_header}tpl_vars;
CREATE TABLE {$table_header}tpl_vars (
  `Id` int(6) unsigned NOT NULL auto_increment,
  `VarTitle` varchar(250) default NULL,
  `VarName` varchar(50) default NULL,
  `VarValue` text,
  `IsGlobal` tinyint(1) NULL DEFAULT 1,
  `NodeScope` text NULL,
  PRIMARY KEY  (`Id`)
) TYPE=MyISAM  ;

 
INSERT INTO `{$table_header}tpl_vars` VALUES (1, '前台动态程序URL', 'PUBLISH_URL', '{cmsware_admin}publish/', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (3, '论坛URL', 'BBS_URL', '{cmsware_admin}www/bbs/', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (4, '论坛注册链接', 'BBS_Register', '{cmsware_admin}www/bbs/register.php', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (5, '论坛忘记密码链接', 'BBS_LostPass', '{cmsware_admin}www/bbs/sendpwd.php', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (6, '论坛登录接口', 'BBS_Login', '{cmsware_admin}www/bbs/login.php', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (7, '论坛用户名表单名', 'BBS_Username', 'loginuser', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (8, '论坛用户密码表单名', 'BBS_Pass', 'loginpwd', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (9, '论坛注销链接', 'BBS_Logout', '{cmsware_admin}www/bbs/login.php?action=quit', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (10, '论坛Referer表单名', 'BBS_Referer', 'jumpurl', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (11,'图片存储目录','IMG_URL','{cmsware_admin}www/images/', 1,'');
INSERT INTO `{$table_header}tpl_vars` VALUES (12,'模板图片路径','Skin_Images','{cmsware_admin}www/skin/', 1,'');
 
DROP TABLE IF EXISTS {$table_header}user;

CREATE TABLE {$table_header}user (
  `uId` mediumint(10) NOT NULL auto_increment,
  `uGId` mediumint(8) NOT NULL default '0',
  `uName` varchar(50) NOT NULL default '',
  `uPass` varchar(32) NOT NULL default '',
  `uInfo` text NOT NULL,
  `LastLoginDate` int(10) NOT NULL default '0',
  `ApproveNum` int(8) NOT NULL default '0',
  `ContributionNum` int(8) NOT NULL default '0',
  `CallBackNum` int(8) NOT NULL default '0',
  `NoContributionNum` int(8) NOT NULL default '0',
  `CreationUserID` mediumint(8) NOT NULL default '0',
  UNIQUE KEY `uId` (`uId`),
  UNIQUE KEY `uName` (`uName`),
  KEY `uGId` (`uGId`)
) TYPE=MyISAM;



DROP TABLE IF EXISTS {$table_header}workflow;

CREATE TABLE {$table_header}workflow (
  `wID` int(8) NOT NULL auto_increment,
  `Name` varchar(30) default NULL,
  `Intro` text,
  PRIMARY KEY  (`wID`),
  UNIQUE KEY `wID` (`wID`)
) TYPE=MyISAM;


INSERT INTO `{$table_header}workflow` VALUES (2,'一级审核','投稿->编辑->审核发布');
INSERT INTO `{$table_header}workflow` VALUES (3,'二级审核','投稿->编辑->高级编辑->审核发布');
INSERT INTO `{$table_header}workflow` VALUES (4,'投稿即发布',"");


DROP TABLE IF EXISTS {$table_header}workflow_record;

CREATE TABLE {$table_header}workflow_record (
  `OpID` int(8) NOT NULL auto_increment,
  `wID` int(8) default NULL,
  `Executor` int(8) default NULL,
  `OpName` varchar(50) default NULL,
  `StateBeforeOp` varchar(100) default NULL,
  `StateAfterOp` varchar(100) default NULL,
  `AppendNote` int(1) default '0',
  `OpIntro` text,
  PRIMARY KEY  (`OpID`),
  UNIQUE KEY `OpID` (`OpID`),
  KEY `wID` (`wID`)
) TYPE=MyISAM;


INSERT INTO `{$table_header}workflow_record` VALUES (3,3,3,'设置为“正在编辑”','1/103','100',0,'将用户的投稿设置为“正在编辑“状态');
INSERT INTO `{$table_header}workflow_record` VALUES (4,3,3,'通过审核','100','101',0,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (5,3,3,'打回作者','100/1/103','3',1,'');
INSERT INTO `{$table_header}workflow_record` VALUES (6,3,4,'设置为“正在编辑”','101','102',0,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (7,3,4,'打回给作者','102/101','3',1,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (8,3,4,'打回给编辑','102/101','103',1,'');
INSERT INTO `{$table_header}workflow_record` VALUES (9,3,4,'通过终审','102','2',0,'完成稿件的审核,稿件被导入内容库,等待发布');
INSERT INTO `{$table_header}workflow_record` VALUES (10,3,3,'撤回','101','100',0,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (11,4,0,'投稿自动发布','1','2',0,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (12,2,3,'设置为“正在编辑”','1','100',0,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (13,2,3,'打回作者','100/1','3',1,NULL);
INSERT INTO `{$table_header}workflow_record` VALUES (14,2,3,'通过终审','100','2',0,NULL);


DROP TABLE IF EXISTS {$table_header}workflow_state;

CREATE TABLE {$table_header}workflow_state (
  `ID` int(8) NOT NULL auto_increment,
  `Name` char(30) default NULL,
  `State` int(5) default NULL,
  `System` int(1) default '0',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `ID` (`ID`),
  UNIQUE KEY `State` (`State`)
) TYPE=MyISAM;


INSERT INTO {$table_header}workflow_state VALUES (1,'新增',0,1);
INSERT INTO {$table_header}workflow_state VALUES (2,'删除',-1,1);
INSERT INTO {$table_header}workflow_state VALUES (3,'已投稿',1,1);
INSERT INTO {$table_header}workflow_state VALUES (4,'被打回',3,1);
INSERT INTO {$table_header}workflow_state VALUES (5,'已录用',2,1);
INSERT INTO {$table_header}workflow_state VALUES (9,'正在编辑(编辑)',100,0);
INSERT INTO {$table_header}workflow_state VALUES (11,'审核通过(编辑)',101,0);
INSERT INTO {$table_header}workflow_state VALUES (12,'正在编辑(高级编辑)',102,0);
INSERT INTO {$table_header}workflow_state VALUES (13,'打回编辑(高级编辑)',103,0);





INSERT INTO {$table_header}plugins VALUES ('', 'CMSwareOAS', 'oas', '在CMSware中整合CWPS', '', '[,1,]', '[,,]');

DROP TABLE IF EXISTS {$table_header}plugin_oas_access;
CREATE TABLE {$table_header}plugin_oas_access (
  `AccessID` int(10) NOT NULL auto_increment,
  `AccessType` tinyint(1) default '1',
  `OwnerID` int(10) default NULL,
  `AccessInherit` text,
  `Info` text,
  PRIMARY KEY  (`AccessID`),
  UNIQUE KEY `AccessID` (`AccessID`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}plugin_oas_setting;
CREATE TABLE {$table_header}plugin_oas_setting (
  `key` varchar(32) NOT NULL default '',
  `value` text NOT NULL,
  PRIMARY KEY  (`key`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}plugin_oas_sessions;
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

DROP TABLE IF EXISTS {$table_header}plugin_oas_permission;
CREATE TABLE {$table_header}plugin_oas_permission (
  `PermissionKey` varchar(32) NOT NULL default '',
  `PermissionInfo` varchar(250) NOT NULL default '',
  `Reserved` tinyint(1) default '0',
  `OrderKey` int(5) NOT NULL default '0',
  PRIMARY KEY  (`PermissionKey`),
  UNIQUE KEY `PermissionKey` (`PermissionKey`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}plugin_oas_access_map;
CREATE TABLE {$table_header}plugin_oas_access_map (
  `AccessID` int(10) NOT NULL default '0',
  `PermissionKey` varchar(32) NOT NULL default '',
  `AccessNodeIDs` text,
  PRIMARY KEY  (`AccessID`,`PermissionKey`)
) TYPE=MyISAM;

DROP TABLE IF EXISTS {$table_header}plugins_oas_user;
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
