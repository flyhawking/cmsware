<?php
require_once "common.php";

$TPL->caching = true;
$TPL->cache_lifetime = '3600';  
$cache_id = "main";
		
$tplname = "/TPL-LITE/style/".$SYS_ENV['SiteStyle']."/oas/main.html";
if($TPL->caching && $TPL->is_cached($tpl, $cache_id)) {
		$TPL->run_cache($tpl, $cache_id);
} else {
	require_once INCLUDE_PATH."data.class.php";
	require_once INCLUDE_PATH."data.remote.class.php";


	require_once INCLUDE_PATH.'image.class.php';
	require_once INCLUDE_PATH."file.class.php";
	if (!extension_loaded('ftp')) {
		require_once INCLUDE_PATH."ftp.class.php";
	}
	require_once INCLUDE_PATH."Error.php";
	require_once INCLUDE_PATH."exception.class.php";
	require_once INCLUDE_PATH."admin/psn_admin.class.php";
	require_once INCLUDE_PATH."admin/dsn_admin.class.php";
	include_once SETTING_DIR."cms.ini.php";
	include_once(CACHE_DIR.'Cache_SYS_ENV.php');		
	include_once(CACHE_DIR.'Cache_PSN.php');		
	include_once(CACHE_DIR.'Cache_CateList.php');
	require_once INCLUDE_PATH."admin/publishAdmin.class.php";
	require_once INCLUDE_PATH."admin/content_table_admin.class.php";
	require_once INCLUDE_PATH."admin/tplAdmin.class.php";
	require_once INCLUDE_PATH."admin/psn_admin.class.php";
	require_once INCLUDE_PATH."admin/site_admin.class.php";		
	require_once INCLUDE_PATH."admin/dsn_admin.class.php";
	require_once INCLUDE_PATH."cms.class.php";
	require_once INCLUDE_PATH."cms.func.php";
	$TPL->registerPreFilter('CMS_Parser');
	$TPL->run_cache($tplname, $cacheId); 

}



?>