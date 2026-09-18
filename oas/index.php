<?php
require_once "common.php";

//print_r($Access->oas->session);

//处理路径变量或是用URL的Get方式传入参数，同时允许传入五个自定义变量在模板中使用
if ( empty($_SERVER["PATH_INFO"]) || strpos($_SERVER["SERVER_SOFTWARE"], "IIS")   ) {

	$IN['NodeID'] = empty($IN['nodeid']) ? intval($IN['NodeID']) : intval($IN['nodeid']);  
	$IN['page']   = intval($IN['page']);  //处理页号为整型

} else {
    $PATH_INFO=substr($_SERVER["PATH_INFO"],1,strrpos($_SERVER["PATH_INFO"],'.')-1);
    list($IN['NodeID'],  $IN['page'], $IN['Custom1'], $IN['Custom2'], $IN['Custom3'], $IN['Custom4'], $IN['Custom5']) = explode(',', $PATH_INFO);

}


if(empty($IN['NodeID'])) {
	header("Location: main.php");
}

$NodeID = $IN['NodeID'];
$Page = empty($IN['page']) ? 0 : $IN['page'];

$NodeInfo = $iWPC->loadNodeInfo($NodeID);

if(!$NodeInfo) {
	die('InValid NodeID , can not find it ');
}

if(in_array(basename(__FILE__), $EnableAccessInterceptorOAS)) {
	//验证首页访问权限
	if(!$Access->canAccess($NodeID,'ReadIndex')) {
		$TPL->assign('deny_code', $Access->deny_code);
		$TPL->display($OAS_SETTING['AccessDenyTpl']);
		exit;
	} 
}



$TPL->caching = true;
$TPL->cache_lifetime = $OAS_SETTING['IndexPageCacheTime'];

$tplname = $NodeInfo['IndexTpl'];

//缓存的文件ID用传入参数变量做识别
$cacheId = $NodeID."_".$Page."_".$IN['Custom1']."_".$IN['Custom2']."_".$IN['Custom3']."_".$IN['Custom4']."_".$IN['Custom5']."_".$tplname;

if($TPL->is_cached($tplname, $cacheId)) {
	$TPL->run_cache($tplname, $cacheId);

} else {
	require_once INCLUDE_PATH."data.class.php";
	require_once INCLUDE_PATH."data.remote.class.php";

	require_once KTPL_DIR . 'kTemplate.class.php';
	require_once INCLUDE_PATH.'image.class.php';
	require_once INCLUDE_PATH."file.class.php";
	if (!extension_loaded('ftp')) {
		require_once INCLUDE_PATH."ftp.class.php";
	}
	require_once INCLUDE_PATH."Error.php";
	require_once INCLUDE_PATH."exception.class.php";
	require_once INCLUDE_PATH."admin/psn_admin.class.php";
 	include_once SETTING_DIR."cms.ini.php";
//$db->setDebug(1);
	include_once(CACHE_DIR.'Cache_SYS_ENV.php');
	include_once(CACHE_DIR.'Cache_PSN.php');
	include_once(CACHE_DIR.'Cache_CateList.php');









	require_once INCLUDE_PATH."admin/publishAdmin.class.php";
	require_once INCLUDE_PATH."admin/content_table_admin.class.php";
	require_once INCLUDE_PATH."admin/tplAdmin.class.php";
	require_once INCLUDE_PATH."admin/psn_admin.class.php";
	require_once INCLUDE_PATH."admin/site_admin.class.php";
	require_once INCLUDE_PATH."cms.class.php";
	require_once INCLUDE_PATH."cms.func.php";


	$SYS_ENV[tpl_pagelist][page] = $Page;
	$SYS_ENV[tpl_pagelist][filename] = $NodeInfo['IndexPortalURL'];


	$NodeInfo = $iWPC->loadNodeInfo($NodeID);
	$TPL->assign('NodeInfo', $NodeInfo);
					$TPL->assign('Custom1', $IN['Custom1']);  //自定义传入变量1
					$TPL->assign('Custom2', $IN['Custom2']); 
					$TPL->assign('Custom3', $IN['Custom3']); 
					$TPL->assign('Custom4', $IN['Custom4']); 
					$TPL->assign('Custom5', $IN['Custom5']); 

 		foreach($tpl_vars as $key=>$var) {//模板变量赋值

				if($var['IsGlobal'] == 1) continue;
				elseif(preg_match("/,".$NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
					$TPL->assign($var['VarName'], $var['VarValue']);	
				} else {
					foreach(explode('%', $NodeInfo['ParentNodeID']) as $varIn) {
						if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
							$TPL->assign($var['VarName'], $var['VarValue']);	
						}
					}
				}
		 

 		}

	if(!empty( $tplname)) {
			
			if(!file_exists($TPL->template_dir. $tplname)) {
				new Error("Error: The index template  \'{$TPL->template_dir}{ $tplname}\' does not exits, Please Set it First to run.");
				return false;
			}

	} else {
			new Error("Error: You have not set the index template, Please Set it First.");
			return false;
		
	} 





	$TPL->registerPreFilter('CMS_Parser');
	$TPL->run_cache($tplname, $cacheId); 
	
				
	

}
include('debug.php');
?>