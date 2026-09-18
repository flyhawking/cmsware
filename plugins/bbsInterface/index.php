<?php
if(!defined('IN_CMSWARE')) {
   exit('Access Denied');
}

require('../license.php');
$license_array = $License;
unset($License);
if($license_array['Module-bbsInterface'] != 1) {
	goback("plugin_deny");
}

require_once(PLUGIN_PATH.'include/setting.class.php');

function getSupportBBSList()
{
		$dir=dir(PLUGIN_PATH.'bbs');
		$dir->rewind();
		while($file=$dir->read()) {
			if( $file=="." || $file=="..") {
				continue;
			} elseif( is_dir(PLUGIN_PATH .'bbs/'. $file)) {
				$dirlist[] = $file;			
			}else {
				continue;
			}
			
		}
		$dir->close();
		return $dirlist;	
}

switch($action) {
	case 'menu':
		$TPL->display("menu.html");
		break;
	case 'setting':
		$TPL->assign("supportBBS", getSupportBBSList());
		$TPL->assign("Info", PluginSetting::getInfo());
		$TPL->display("setting.html");
		break;
	case 'setting_submit':
		$setting = new PluginSetting();
		$setting->flushData();
		$setting->addData("ForegroundPath",$IN['ForegroundPath']);
		$setting->addData("BBS",$IN[BBS]);
		$setting->addData("DenyTpl",$IN[DenyTpl]);

		if($setting->update()) { 
			showmessage('update_setting_ok', $referer);
		} else
			showmessage('update_setting_fail', $referer);
		break;

}
?>