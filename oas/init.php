<?php
define('VERSION', "CMSware 2.6.2 Plus ");
define('CMSWARE_VERSION', "CMSware 2.6.2 Plus ");
set_magic_quotes_runtime(0);
define('SAFE_MODE', ini_get('safe_mode'));
if(!SAFE_MODE)	set_time_limit(50);
$magic_quotes_gpc = get_magic_quotes_gpc();

if(substr(phpversion(), 0 ,1) == 5) 	{ 
	define("PHP_VERSION_5", true); 
	@ini_set('zend.ze1_compatibility_mode', '1');// for PHP 5 compatibility
} else	define("PHP_VERSION_5", false);

require_once "./config.php";


define('DS', '/');

if(!is_dir($ROOT_PATH.'plugins')) die("please set the <b>\$ROOT_PATH</b> in  ".dirname(__FILE__)."/config.php correctly!");

define('ROOT_PATH', $ROOT_PATH);
define('SYS_PATH', ROOT_PATH);
define('SETTING_DIR', ROOT_PATH.'setting'.DS);
define('ROOT_INCLUDE_PATH', ROOT_PATH.'include'.DS);
define('INCLUDE_PATH', SYS_PATH.'include'.DS);
define('KTPL_DIR', ROOT_INCLUDE_PATH.'lib'.DS.'kTemplate'.DS);
define('IN_SYS', true);
define('CACHE_DIR', SYS_PATH.'sysdata'.DS);
define('KDB_DIR', ROOT_INCLUDE_PATH.'lib'.DS.'kDB'.DS);
define('Error_Display', 'text'); //文本报错模式
define('CLS_PATH', ROOT_PATH .'classes'.DS);
define('LIB_PATH', INCLUDE_PATH.'lib'.DS);
define('LANG_PATH', ROOT_PATH.'language'.DS);
define('OAS_PATH', "./");
define('PLUGIN_PATH', ROOT_PATH.'plugins'.DS);

require_once LIB_PATH."file.class.php";
require_once LIB_PATH."Spring.php";
$BeanFactory = new Spring("spring.appcontext.php");
include_once SETTING_DIR."global.php";

?>