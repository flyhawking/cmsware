<?php
//$Id: init.php,v 1.26 2006/06/20 14:52:42 Administrator Exp $
set_magic_quotes_runtime(0);
define('SAFE_MODE', ini_get('safe_mode'));
if(!SAFE_MODE)	set_time_limit(0);

if(substr(phpversion(), 0 ,1) == 5) 	{ 
	define("PHP_VERSION_5", true); 
	@ini_set('zend.ze1_compatibility_mode', '1');// for PHP 5 compatibility
} else	define("PHP_VERSION_5", false);


define ('DEBUG_MODE', 2);
switch(DEBUG_MODE){
	case 0: //Bug-Free
		error_reporting(0);break;
	case 1: //Release-Candidate
		error_reporting(E_ERROR | E_WARNING | E_PARSE);break;
	case 2: //Alpha/Beta
		error_reporting(E_ALL ^ E_NOTICE);break;
	case 3: //Testing
		error_reporting(E_ALL);break;
	default: //If User Meddles With Debug_Mode
		error_reporting(E_ALL ^ E_NOTICE);break;
}
define('DS', '/');

define("ROOT_PATH", "../");
define("ADMIN_PATH", "./");

define('INCLUDE_PATH', ROOT_PATH.'include'.DS);
define('PLUGIN_PATH', ROOT_PATH.'plugins'.DS);
define('KTPL_DIR', INCLUDE_PATH.'lib'.DS.'kTemplate'.DS);
define('LANG_PATH', ROOT_PATH.'language'.DS);
define('SYS_PATH', ROOT_PATH);
define('CACHE_DIR', ROOT_PATH.'sysdata'.DS);
define('KDB_DIR', INCLUDE_PATH.'lib'.DS.'kDB'.DS);
define('MODULES_DIR', ADMIN_PATH.'modules'.DS);
define('EDITORS_DIR', ADMIN_PATH.'editor'.DS);
define('ADMIN_DIR', ADMIN_PATH);
define('SETTING_DIR', ROOT_PATH.'setting'.DS);
define('CLS_PATH', ROOT_PATH .'classes'.DS);
define('CLASS_PATH', ROOT_PATH .'classes'.DS);
define('LIB_PATH', INCLUDE_PATH.'lib'.DS);

define('IN_IWPC',true);
define('IN_SYS',true);

define('CMSWARE_VERSION', "CMSware 2.6.2 Plus");
define('BUILD_VERSION', "2.6.2.20060120");

$diableDebug = false;
$SYS_AUTH = array(
	'sys_login'=>0,
	'sys_logout'=>1,
	'sys_view'=>1,
	'sys_chpassword'=>0,
	'sys_chpassword_submit'=>0,
	'sys_setting'=>0,


);

$ContentModelReservedFieldName = array('IndexID','ContentID','NodeID','ParentIndexID','Type','PublishDate','Template',
'State','URL','Top','Pink','Sort','CreationDate','ModifiedDate','CreationUserID','LastModifiedUserID',
'ContributionUserID','ContributionID','ApprovedDate','TableID','ParentID','Name');

$_Error_vars = ''; //错误变量数组
$_DISPLAY_HELP = explode(' ', $_COOKIE['cmsware_collapse']);
require_once LIB_PATH."file.class.php";
?>