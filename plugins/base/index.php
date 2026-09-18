<?php
if(!defined('IN_CMSWARE')) {
   exit('Access Denied');
}

require_once(PLUGIN_PATH.'include/setting.class.php');
require_once(INCLUDE_PATH.'admin/site_admin.class.php');

$site = new site_admin();
switch($action) {
	case 'menu':
		$NodeInfo = $site->getAll4Tree();
		$TPL->assign('NodeInfo', $NodeInfo);
		$TPL->display('tree.html');
		break;
	case 'tree_xml':
		if(!empty($IN[NodeID])) {
			$NodeInfo = $site->getAll4Tree($IN[NodeID]);
			$TPL->assign('NodeInfo', $NodeInfo);
			header("Content-Type: text/xml; charset=".CHARSET."\n");
			$now = gmdate('D, d M Y H:i:s') . ' GMT';
		    header('Expires: ' . $now);
			$TPL->display('tree_xml.xml');
		} 
		break;
	case 'setting':
		//include_once(CACHE_DIR.'Cache_ContentModel.php');
		//require_once INCLUDE_PATH."admin/content_table_admin.class.php";
 		$TPL->assign("ContentModels", PluginSetting::getAll());
		$TPL->display("setting.html");
		break;
	case 'setting_add':
 		$TPL->assign("setting", PluginSetting::getInfo($IN['TableID']));
		$TPL->display("setting_add.html");
		break;
	case 'setting_edit':
		//include_once(CACHE_DIR.'Cache_ContentModel.php');
		//require_once INCLUDE_PATH."admin/content_table_admin.class.php";
 		$TPL->assign("setting", PluginSetting::getInfo($IN['TableID']));
		$TPL->display("setting_edit.html");
		break;
	case 'setting_submit':
		$setting = new PluginSetting();
		$setting->flushData();
		$setting->addData('TableID', $IN['TableID']);
		$setting->filterData($IN);
	//	$setting->debugData();
 		if($setting->update()) { 
			showmessage('update_setting_ok', $referer);
		} else
			showmessage('update_setting_fail', $referer);
		break;
	case 'comment_setting':
		$sc = &$BeanFactory->getBean('SettingCache');
		$commentSetting = $sc->load('plugin_base_comment');

  		$TPL->assign_by_ref("setting", $commentSetting);
		$TPL->display("comment.setting.html");
		break;
	case 'comment_setting_submit':
		$SettingCache = array();
		$SettingCache['enableComment'] = $IN['enableComment'] ;//开启评论
		$SettingCache['enableCommentApprove'] = $IN['enableCommentApprove'];//开启评论审核
		$SettingCache['usernameMaxLength'] = $IN['usernameMaxLength'];
		$SettingCache['contentMinLength'] = $IN['contentMinLength'];
		$SettingCache['contentMaxLength'] = $IN['contentMaxLength'];
		$SettingCache['filterMode'] = $IN['filterMode'];//0-不启用评论字词过滤, 1-禁止发布,2-使用特殊字符替换
		$SettingCache['replaceWord'] = $IN['replaceWord'];//特殊字符
		$SettingCache['filterWords'] = $IN['filterWords'];

		$sc = &$BeanFactory->getBean('SettingCache');
		if($sc->make('plugin_base_comment', $SettingCache)) {
			showmessage('comment_setting_ok', $referer);
		
		} else {
			showmessage('comment_setting_fail', $referer);
		
		}
		break;

 

}
?>