<?php
require_once 'init.php';
require_once ROOT_PATH."config.php";
require_once  ROOT_INCLUDE_PATH.'functions.php';
$debugger = new Debug();
$debugger->startTimer();

require_once( ROOT_INCLUDE_PATH.'data.class.php');
include_once SETTING_DIR."cms.ini.php";
include_once INCLUDE_PATH."cms.func.php";
include_once INCLUDE_PATH."cms.class.php";
include_once INCLUDE_PATH."admin/psn_admin.class.php";
require_once KTPL_DIR . 'kTemplate.class.php';
require_once KDB_DIR.'kDB.php';
$db = new kDB($db_config['db_driver']);
$db->connect($db_config);
$db->setDebug(1);
$db->setFetchMode('assoc');
$db->setCacheDir(SYS_PATH.'sysdata/cache/');

$SYS_CONFIG['language'] = empty($SYS_CONFIG['language']) ? 'chinese_gb' : $SYS_CONFIG['language'];
require_once LANG_PATH.$SYS_CONFIG['language'].'/charset.inc.php';


 
$IN = parse_incoming();
$iWPC = new iWPC();

if(!$IN[referer]) 	$referer =  _addslashes($_SERVER[HTTP_REFERER]);
else 	$referer = $IN[referer];



$TPL = new kTemplate();
$TPL->template_dir = SYS_PATH.'templates'.DS;
$TPL->compile_dir = CACHE_DIR.'templates_c'.DS;
$TPL->cache_dir = CACHE_DIR.'cache/';
$TPL->assign_by_ref('referer', $referer);
$TPL->assign('URL_SELF', 'http://'.$_SERVER["HTTP_HOST"].$_SERVER['PHP_SELF']);
$TPL->assign('cmsware_version', VERSION);
$TPL->assign('cms_version', VERSION);

require(ROOT_PATH.'license.php');
$license_array = $License;
unset($License);

include_once(CACHE_DIR.'Cache_SYS_ENV.php');
include_once(CACHE_DIR.'Cache_CateList.php');
include_once(CACHE_DIR.'Cache_ContentModel.php');
$TPL->assign_by_ref('SYS_ENV', $SYS_ENV);
$TPL->assign_by_ref('NODE_LIST', $NODE_LIST);
$TPL->assign_by_ref('CONTENT_MODEL_INFO', $CONTENT_MODEL_INFO);


$SYS_ENV['language'] = $SYS_CONFIG['language'];



$SYS_ENV['CMSware_Mark'] = str_replace('{date}', date('Y-m-d H:i:s', time()), $license_array['Publish-Marker']);
$SYS_ENV['CMSware_Mark'] = str_replace('{version}', CMSWARE_VERSION, $SYS_ENV['CMSware_Mark']);
if(empty($SYS_ENV['CMSware_Mark']) || !strpos($SYS_ENV['CMSware_Mark'], CMSWARE_VERSION) ) {
	$TPL->add_meta_mark = false;
}

if(!class_exists('TplVarsAdmin')) {
	require_once  ROOT_INCLUDE_PATH.'admin/TplVarsAdmin.class.php';
}
$tpl_vars = TplVarsAdmin::getAll();
foreach($tpl_vars as $key=>$var) {
	if($var['IsGlobal']) {//全局模板变量
		$TPL->assign($var['VarName'], $var['VarValue']);	
	} 
}

$bFactory = &Spring::getInstance("spring.appcontext.php");
$settingCache = &$bFactory->getBean('SettingCache');

$tmp_array = $settingCache->load("plugin_oas_setting");
if(is_array($tmp_array)) $OAS_SETTING = array_merge($OAS_SETTING, $tmp_array);


if(!empty($OAS_SETTING['CWPS_SelfIndexURL'])) {
	
	$OAS_SETTING['PageInterface']['Portal'] = $OAS_SETTING['CWPS_SelfIndexURL'];
	$OAS_SETTING['PageInterface']['Login'] = $OAS_SETTING['CWPS_SelfIndexURL'];
	$OAS_SETTING['PageInterface']['IsLogin'] = $OAS_SETTING['CWPS_SelfIndexURL']."?do=isLogin";
	$OAS_SETTING['PageInterface']['Logout'] = $OAS_SETTING['CWPS_SelfIndexURL']."?do=logout";
	$OAS_SETTING['PageInterface']['Register'] = $OAS_SETTING['CWPS_SelfIndexURL']."?do=register";
	$OAS_SETTING['PageInterface']['EditProfile'] = $OAS_SETTING['CWPS_SelfIndexURL']."?do=editProfile";
	 
} else {
	$OAS_SETTING['PageInterface']['Portal'] = $OAS_SETTING['CWPS_RootURL']."/index.php";
	$OAS_SETTING['PageInterface']['Login'] = $OAS_SETTING['CWPS_RootURL']."/index.php";
	$OAS_SETTING['PageInterface']['IsLogin'] = $OAS_SETTING['CWPS_RootURL']."/index.php?do=isLogin";
	$OAS_SETTING['PageInterface']['Logout'] = $OAS_SETTING['CWPS_RootURL']."/index.php?do=logout";
	$OAS_SETTING['PageInterface']['Register'] = $OAS_SETTING['CWPS_RootURL']."/index.php?do=register";
	$OAS_SETTING['PageInterface']['EditProfile'] = $OAS_SETTING['CWPS_RootURL']."/index.php?do=editProfile";
}

$OAS_SETTING['CWPS_RootURL'] = substr($OAS_SETTING['CWPS_RootURL'],-1) != "/" ? $OAS_SETTING['CWPS_RootURL']."/" : $OAS_SETTING['CWPS_RootURL'];
$OAS_SETTING['OAS_RootURL'] = substr($OAS_SETTING['OAS_RootURL'],-1) != "/" ? $OAS_SETTING['OAS_RootURL']."/" : $OAS_SETTING['OAS_RootURL'];

$TPL->assign("CWPS_URL", $OAS_SETTING['CWPS_RootURL']);
$TPL->assign("OAS_URL", $OAS_SETTING['OAS_RootURL']);
$TPL->assign_by_ref('OAS_SETTING', $OAS_SETTING);

define('PLUGINS_PATH', ROOT_PATH.'plugins/'.PLUGIN.'/');
require_once PLUGINS_PATH.'include/access.class.php';
require_once PLUGINS_PATH.'plugin.config.php';
require_once PLUGINS_PATH.'include/oas.php';
		
$oas = new OAS($OAS_SETTING);

$Access =  new Access($oas);

$TPL->assign_by_ref('UserSession', $Access->oas->session);
$UserSession = &$Access->oas->session;
$TPL->cache_use_sub_dirs = $OAS_SETTING['EnableCacheUseSubDirs'];
?>