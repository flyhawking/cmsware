<?php
require_once 'common.php';
/*License验证*/
require('../license.php');
$license_array = $License;
unset($License);
if($license_array['Module-FileManager']!=1)
			goback('license_Module_FileManager_disabled');
/*License验证*/
require_once INCLUDE_PATH."admin/psn_admin.class.php";

if(!$sys->isAdmin()) {
	goback('access_deny_module_file');

}

$psn = new psn_admin();
switch($IN[o]) {
	case 'tree':

		$TPL->assign('PSNList', $psn->getAllPSN());
		$TPL->display('tree_file.html');

		break;
	case 'file_xml':
		$psnInfo = $psn->getPSNInfo($IN[PSNID]);
	
		$psn->connect($psnInfo[PSN]);
		//debug($psn->listFile());
			
		if($IN[extra] == 'updir') {
			
			$path = pathinfo($IN[PATH]);
			if($path[dirname] == "\\") $path[dirname]='';
			$fileList = $psn->listFile($path[dirname]);
			$IN[PATH] = $path[dirname];
			//debug($path);
		
		}else {
			$fileList = $psn->listFile($IN[PATH]);
		
		}
		$length = 0;
		foreach($fileList as $key=>$var) {
			$filelength = strlen($var[name]);
			if($filelength > $length ) $length  = $filelength;

		}
		$psn->close();
		$TPL->assign('PSNID', $IN[PSNID]);
		$TPL->assign('PATH', $IN[PATH]);
		$TPL->assign('DirList', $fileList);
		//debug($fileList);

		header("Content-Type: text/xml; charset=gb2312\n");
		$now = gmdate('D, d M Y H:i:s') . ' GMT';
		header('Expires: ' . $now);
 		$TPL->display('file_xml.xml');
		break;
	case 'list':
		$psnInfo = $psn->getPSNInfo($IN[PSNID]);
		//debug($psnInfo);
		$psn->connect($psnInfo[PSN]);
		//debug($psn->listFile());
			
		if($IN[extra] == 'updir') {
			
			$path = pathinfo($IN[PATH]);
			if($path[dirname] == "\\") $path[dirname]='';
			$fileList = $psn->listFile($path[dirname]);
			$IN[PATH] = $path[dirname];
			//debug($path);
		
		}else {
			$fileList = $psn->listFile($IN[PATH]);
		
		}
		$length = 0;
		foreach($fileList as $key=>$var) {
			$filelength = strlen($var[name]);
			if($filelength > $length ) $length  = $filelength;

		}
		$psn->close();
		$TPL->assign('PSNID', $IN[PSNID]);
		$TPL->assign('PSNURL', $psnInfo[URL]);
		$TPL->assign('PATH', $IN[PATH]);
		$TPL->assign('fileList', $fileList);
		//debug($fileList);
		$TPL->display('file_fileList.html');
		break;
	case 'del':
		//debug($IN);
		$psnInfo = $psn->getPSNInfo($IN[PSNID]);
		$psn->connect($psnInfo[PSN]);
			
		if(!empty($IN[multi]) && !empty($IN[pData]) ) {
			foreach($IN[pData] as $var) {
					$result = $psn->delFile($IN[PATH],$var);				
			}
			$psn->close();
			if($result)
				showmessage('psn_delFile_ok', $referer);
			else
				showmessage('psn_delFile_fail', $referer);

		} else {
			
			if($psn->delFile($IN[PATH],$IN[targetFile])) {
				$psn->close();
				showmessage('psn_delFile_ok', $referer);
			} else {
				$psn->close();
				showmessage('psn_delFile_fail', $referer);
			
			}
			
		}

		break;


}

?>