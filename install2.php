<?php
/**
* Copyright (C) 1999-2006 Sagatec Technology Ltd (CMSware). All rights reserved.
* This source file is part of the CMSware Content Management System.
* 
* This is NOT a freeware,use is subject to license terms
* For pricing of this licence please contact us via e-mail to market@cmsware.net.
* Further contact information is available at http://www.cmsware.net/.
* 
* $Id: install.php,v 1.38 2006/08/15 15:24:42 Administrator Exp $
* 
* CMSware Main Configuration File
* 
*/

define ('DEBUG_MODE','2');
define ('Error_Display','html');
define('IN_SYS', 1);
set_magic_quotes_runtime(0);

$phpVersion = substr(phpversion(), 0 ,1);

if($phpVersion == 5) 	define("PHP_VERSION_5", true);
else	define("PHP_VERSION_5", false);

define('INCLUDE_PATH','./include/');
define('KTPL_DIR', INCLUDE_PATH.'lib/kTemplate/');
define('KDB_DIR',INCLUDE_PATH.'lib/kDB/');
define('SYS_PATH', './');
define('ROOT_PATH', './');
define('CACHE_DIR','./sysdata/');
define('LIB_PATH', INCLUDE_PATH.'lib/');
define('LANG_PATH', ROOT_PATH.'language/');
define('CLASS_PATH', ROOT_PATH.'classes/');

require_once LIB_PATH."file.class.php";


require_once SYS_PATH."config.php";
require_once KTPL_DIR . 'kTemplate.class.php';
require_once INCLUDE_PATH."data.class.php";
require_once INCLUDE_PATH."functions.php";
require_once INCLUDE_PATH."file.class.php";
//require_once INCLUDE_PATH."Error.php";
//require_once INCLUDE_PATH."exception.class.php";
require_once INCLUDE_PATH."Error.php";
define('ADMIN_DIR','./'.ADMIN_NAME.'/');
define("INSTALL_DATA_PATH", dirname(__FILE__)."/install");

$SYS_CONFIG['language'] = empty($SYS_CONFIG['language']) ? 'chinese_gb' : $SYS_CONFIG['language'];
require_once LANG_PATH.$SYS_CONFIG['language'].'/charset.inc.php';

header('Content-Type: text/html; charset='.CHARSET);


$LANG_INSTALL = load_lang(LANG_PATH.$SYS_CONFIG['language'].'/lang_install.php');

if ( file_exists(CACHE_DIR.'install.lock11') )
{
	exit(sprintf($LANG_INSTALL['install_locked'], CACHE_DIR."install.lock"));
}
$charset = CHARSET;
new Error();
$File = & get_singleton("FileSystem.File");

require_once KDB_DIR.'kDB.php';
$version = 'CMSware 2.6.2 Plus ';

if(isset($PHP_SELF))
	$_SERVER["PHP_SELF"] = $PHP_SELF;
$info = pathinfo($_SERVER["PHP_SELF"]);

//Fixed \/ dirname
$info["dirname"] = $info["dirname"]=="\\" ? "" : $info["dirname"] ;

if($_SERVER["SERVER_PORT"] != 80) {
	$CMSWARE_ADMIN_URL = 'http://'.$_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$info["dirname"]."/";
	$CMSWARE_ADMIN_HOST = $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"];
} else {
	$CMSWARE_ADMIN_URL = 'http://'.$_SERVER["SERVER_NAME"].$info["dirname"]."/";
	$CMSWARE_ADMIN_HOST = $_SERVER["SERVER_NAME"];

}

function dataFilter($_data)
{	global $CMSWARE_ADMIN_URL;

	$_data = str_replace("{CMS_ROOT_URL}",  $CMSWARE_ADMIN_URL, $_data);
	return $_data;
}


 //$db->setDebug(1);
//from ipb
$IN = parse_incoming();

$TPL = new kTemplate();
$TPL->template_dir = SYS_PATH.'skin/install2/';
$TPL->compile_dir = SYS_PATH.'sysdata/templates_c/';
$TPL->cache_dir = SYS_PATH.'sysdata/cache/';
$TPL->assign('version', $version);
$TPL->assign('charset', $charset);
$TPL->assign('phpself', $_SERVER["PHP_SELF"]);
//global variable  manipulation END


if($SYS_CONFIG['ftp_mode']===1) {
	$SYS_CONFIG['ftp_cms_admin_path'] = File::_ftp_realpath($SYS_CONFIG['ftp_cms_admin_path'], "../");
}


function dir_writeable($dir) {
	if(!is_dir($dir)) {
		@mkdir($dir, 0777);
	}
	if(is_dir($dir)) {
		if($fp = @fopen("$dir/%%test.test", 'w')) {
			@fclose($fp);
			@unlink("$dir/%%test.test");
			$writeable = 1;
		} else {
			$writeable = 0;
		}
	}
	return $writeable;
}

function is_safe_mode() {
	//return true;
	$dir = "./sysdata/%%install/";
	@mkdir($dir, 0777);

	if(is_dir($dir)) {
		if($fp = @fopen("$dir/%%test.test", 'w')) {
			@fclose($fp);
			@unlink("$dir/%%test.test");
			@rmdir($dir);
			$safe_mode = 0;

		} else {
			$safe_mode = 1;
		}
	} else {
		$safe_mode = 1;
		
	}

	return $safe_mode;

}
function mysql5x_varchar($s) {
	//return "varchar(".(floor($s/2)).")";
	return "varchar(".$s.")";
}
function runquery($sql) {
	global $db,$output,$CMSWARE_ADMIN_URL,$CMSWARE_ADMIN_HOST,$db_config, $LANG_INSTALL;
	$sql = str_replace("{cmsware_admin}", $CMSWARE_ADMIN_URL, $sql);
	$sql = str_replace("{cmsware_admin_host}", $CMSWARE_ADMIN_HOST, $sql);
	
	
	
	// check mysql version first.
	$serverVersion = mysql_get_server_info(); 
	$mysql_version = explode('.', $serverVersion); 
	
	
	//compatible for MySQL 5.x
	if($mysql_version[0] > 4) {
		/*
		$sql = str_replace("''", 'NULL', $sql);
		$sql = str_replace("NOT NULL default ''", 'default NULL', $sql);
		$sql = str_replace("NOT NULL", '', $sql);
		*/
	}


	if (($mysql_version[0] == 4 && $mysql_version[1] > 0) || $mysql_version[0] > 4)  {
		
		if($db_config['db_charset'] == 'gb2312') $db_config['db_charset'] = 'gbk';
		
		mysql_query("SET NAMES '".$db_config['db_charset']."' ");	


	}



	$ret = array();
	$num = 0;
	foreach(explode(";\r\n", trim($sql)) as $query) {
		$queries = explode("\r\n", trim($query));
		//print_r($queries);
		foreach($queries as $query) {
			$ret[$num] .= $query[0] == '#' ? NULL : $query;
		}
		$num++;
	}
	unset($sql);

	foreach($ret as $query) {
		//echo $query;
		if($query) {
			if(substr($query, 0, 12) == 'CREATE TABLE') {
				$name = preg_replace("/CREATE TABLE ([a-z0-9_]+) .*/is", "\\1", $query);

				if (($mysql_version[0] == 4 && $mysql_version[1] > 0) || $mysql_version[0] > 4)  {
					$query .=" DEFAULT CHARSET=".$db_config['db_charset']." ";
				}

				$output.= sprintf($LANG_INSTALL['create_table_ok'], $name);
			}
			$pattern = "/ALTER TABLE[\s]+`([^`]*)`[\s]+(DROP|ADD|CHANGE)[\s]+[^`]+`([^`]*)`/isU";
			preg_match($pattern, $query, $matches);
			/** 
				Array
				(
					[0] => ALTER TABLE `cmsware_collection_category`  ADD COLUMN `IndexNodeID`
					[1] => cmsware_collection_category
					[2] => ADD
					[3] => IndexNodeID
				)

			 */
			//print_r($matches);
			if(!empty($matches[0])) {

				
				$exists = mysql_field_exists($matches[1], $matches[3]);
				//echo "----------".$exists."----------";
				$action = strtoupper($matches[2]);
				if($action == 'ADD' && !$exists){
					$Que = mysql_query($query);
				} elseif($action == 'DROP' && $exists) {
 					$Que = mysql_query($query);
					//echo $query."\n";

				} elseif($action == 'CHANGE' && $exists) {
					$Que = mysql_query($query);
					//echo $query."\n";

				} else continue;
			} else {
				$Que = mysql_query($query);
 			}

			if(!$Que) {
				halt1('MySQL Query Error', $query);
			}

		}
	}
	return $Que;
}

function mysql_field_exists($table, $fieldname)
{
	global $db_config;
 	$fields = mysql_list_fields($db_config['db_name'],$table);
	 
	$columns = mysql_num_fields($fields);
	
	$return = false;
	for ($i = 0; $i < $columns; $i++) {

		$field_name = mysql_field_name($fields, $i);
		if($field_name == $fieldname) 	{
			$return = true;
			break;
		}

	}	
	return $return;
}

function halt1($message = '', $sql = '') {
	$timestamp = time();
	$errmsg = '';

	$dberror = mysql_error();
	$dberrno = mysql_errno();
	if($message) {
		$errmsg = "<b>SYS info</b>: $message\n\n";
	}
	$errmsg .= "<b>Time</b>: ".gmdate("Y-n-j g:ia", $timestamp + ($GLOBALS["timeoffset"] * 3600))."\n";
	$errmsg .= "<b>Script</b>: ".$GLOBALS[PHP_SELF]."\n\n";
	if($sql) {
		$errmsg .= "<b>SQL</b>: ".htmlspecialchars($sql)."\n";
	}
	$errmsg .= "<b>Error</b>:  $dberror\n";
	$errmsg .= "<b>Errno.</b>:  $dberrno";

	echo "</table></table></table></table></table>\n";
	echo "<p style=\"font-family: Verdana, Tahoma; font-size: 11px; background: #FFFFFF;\">";
	echo nl2br($errmsg);

	echo '</p>';
}

$_writeable = true;
function unwriteable($msg)
{	global $_writeable, $LANG_INSTALL;
	$_writeable = false;
	print(sprintf($LANG_INSTALL['unwriteable_file'], $msg));
}

if(!dir_writeable('./sysdata/templates_c')) {
	printf($LANG_INSTALL['unwriteable_templates_c']);
	printf("<UL>");
	printf("<LI>/sysdata");	
	printf("<LI>/sysdata/templates_c");	
	printf("<LI>/sysdata/sysinfo");	
	printf("<LI>/sysdata/automini");	
	printf("<LI>/templates");	
	printf("<LI>/backup");	
	printf("<LI>/resource");	
	printf("<LI>/www");	
	printf("</UL>");
	exit;
}

if(!is_writeable(ROOT_PATH.'config.php')) {
	die($LANG_INSTALL['unwriteable_config']);
}

if(!is_writable(ROOT_PATH."setting/cms.ini.php"))  unwriteable("/setting/cms.ini.php");
if(!is_writable(ROOT_PATH."setting/crawler.ini.php")) unwriteable("/setting/crawler.ini.php");
if(!is_writable(ROOT_PATH."backup")) unwriteable("/backup/");
if(!is_writable(ROOT_PATH."resource")) unwriteable("/resource/");
if(!is_writable(ROOT_PATH."sysdata")) unwriteable("/sysdata/");
if(!is_writable(ROOT_PATH."sysdata/automini")) unwriteable("/sysdata/automini/");
if(!is_writable(ROOT_PATH."sysdata/cache")) unwriteable("/sysdata/cache/");
if(!is_writable(ROOT_PATH."sysdata/sysinfo")) unwriteable("/sysdata/sysinfo/");
if(!is_writable(ROOT_PATH."sysdata/templates_c")) unwriteable("/sysdata/templates_c/");
if(!is_writable(ROOT_PATH."sysdata/tmp")) unwriteable("/sysdata/tmp/");
if(!is_writable(ROOT_PATH."publish/tmp") && is_dir(ROOT_PATH."publish/tmp")) unwriteable("/publish/tmp/");


if(!$_writeable) die($LANG_INSTALL['please_set_writeable']);

//---------------------------------------------------------
if($IN[o] == 'init') {
	$TPL->display('installshow.html'); 
	exit;
}
if(!isset($IN[step]))
	$IN[step]= 0 ;

switch ($IN[step]) {
	case '0':
		if(is_safe_mode() && !file_exists(CACHE_DIR.".ftp")) {
			$TPL->display('safe_mode_warning.html');
		} else {
			$TPL->display('install.html');
		}
		break;
	case 'phpinfo':
		phpinfo();
		break;
	case 'ftp_mode':
		if($config_php = $File->read( ROOT_PATH.'install/config.ini')) {//生成config.php
 			$config_php = str_replace('[ftp_mode]', 1, $config_php);
			$config_php = str_replace('[ftp_host]', $IN['ftp_host'], $config_php);
			$config_php = str_replace('[ftp_port]', $IN['ftp_port'], $config_php);
			$config_php = str_replace('[ftp_username]', $IN['ftp_username'],$config_php);
			$config_php = str_replace('[ftp_password]', $IN['ftp_password'],$config_php);
			$config_php = str_replace('[ftp_cms_admin_path]', $IN['ftp_cms_admin_path'],$config_php);
 
 			$config_php = str_replace('[cmsware_db_host]', $db_config['db_host'], $config_php);
			$config_php = str_replace('[cmsware_db_user]', $db_config['db_user'],$config_php);
			$config_php = str_replace('[cmsware_db_password]', $db_config['db_password'],$config_php);
			$config_php = str_replace('[cmsware_db_name]', $db_config['db_name'],$config_php);
			$config_php = str_replace('[cmsware_db_table_pre]', $db_config['table_pre'],$config_php);
			$config_php = str_replace('[cmsware_db_charset]', $db_config['db_charset'],$config_php);

			$enable_validcode = extension_loaded('gd') ? 1 : 0;
			$config_php = str_replace('[enable_validcode]', $enable_validcode,$config_php);

			$File->write(ROOT_PATH.'config.php', $config_php);
			$File->write(CACHE_DIR.'.ftp', '1');
		} else {
			die("Unable to read ./install/config.ini");
		}
		header("Location: install.php ");
		break;
	case '1':
			$operation=PHP_OS;
			$webserver=$_SERVER['SERVER_SOFTWARE'];
			$php=phpversion();
			
			if (extension_loaded('gd')) {
				if(function_exists('gd_info'))	$gd_info = gd_info();
				$gd = $gd_info["GD Version"];
			} else $gd = "";

			if(@ini_get(file_uploads)) {
				$upload_max_size = @ini_get(upload_max_filesize);
 			} else 	$upload_max_size = 0;

			if(is_writable('config.php')) $config_writable = 1 ;		
			else $config_writable = 0 ;

 
			$TPL->assign('operation',$operation);
			$TPL->assign('webserver',$webserver);
			$TPL->assign('php',$php);
 			$TPL->assign('gd',$gd);
			$TPL->assign('ftp',$ftp);
			$TPL->assign('save_path',$save_path);
			$TPL->assign('safe_mode', $safe_mode);
			$TPL->assign('templatespath',$templatespath);
			$TPL->assign('Resourcepath',$Resourcepath);
			$TPL->assign('smartypath',$TPLpath);
			$TPL->assign('backuppath',$backuppath);
			$TPL->assign('installpath',$installpath);
			$TPL->assign('upload_max_size',$upload_max_size);
			$TPL->display('env.html');
			break;
// 	case 'installtype':
// 			$TPL->display('install_type.html');
//			break;
 	case 'installtype_submit':
			$TPL->assign('installType',$IN['installType']);
		 
			$TPL->assign('db_host',$db_config[db_host]);
			$TPL->assign('db_user',$db_config[db_user]);
			$TPL->assign('db_password',$db_config[db_password]);
			$TPL->assign('db_name',$db_config[db_name]);
			$TPL->assign('table_header',$db_config[table_pre]);
			$TPL->display('install_db.html');
			
 			break;
  	case 'create_table':

 			$TPL->assign('installType',$IN['installType']);
			$db = new kDB($db_config['db_driver']);
			$db_config['db_driver']   = 'db';	//db,adodb,mdb
			$db_config['db_type']     = 'mysql';
			$db_config['db_host']     = $IN[database_host];	
			$db_config['db_user']     = $IN[database_user];	
			$db_config['db_password'] = $IN[database_password];	
			$db_config['db_name']     = $IN[database_name];	
			$db_config['table_pre']     = $IN[database_header];
			$db_config['db_charset']     = $db_config['db_charset'];
			$db_config['table_content_pre']     = 'content';	
			$db_config['table_contribution_pre']     = 'contribution';	
			$db_config['table_collection_pre']     = 'collection';	
			$server_host = $_SERVER["HTTP_HOST"];
			
//			if($IN['installType'] == 'typical') {
//				$sql_file = "./install/typical_install.sql";
//			} else {
//				$sql_file = "./install/base.sql";
//		
//			}

			$sql_file = ROOT_PATH."install/core.sql";

			if(mysql_connect($db_config['db_host'], $db_config['db_user'], $db_config['db_password'])) {

				if(mysql_select_db($db_config['db_name'])) {
					if($sql_query = $File->read($sql_file)) { //读取SQL，预备执行sql
						$table_header = $db_config['table_pre'];	
	 					$sql_query = str_replace('{$table_header}', $table_header, $sql_query);
 					} else  {					
						die("Unable to read  $sql_file ");
					}
					
					if($IN['overwrite'] != 1) {
						$sysExit = false;	
						$sql = "SHOW TABLES  FROM {$IN[database_name]}";
						$recordSet= mysql_query($sql);
						$pattern="/^{$IN[database_header]}.+/is";
						if($recordSet) {
							while($row = mysql_fetch_array($recordSet, MYSQL_BOTH)) {
								if(preg_match($pattern, $row[0])) {
									$sysExit=true;	
									break;
								}
							}						
						}

						if($sysExit){
							echo "<script>\n						if(confirm(\" ".$LANG_INSTALL['confirm_overwrite_install']." \")){window.location=\"?overwrite=1&step=create_table&database_host={$IN[database_host]}&database_name={$IN[database_name]}&database_header={$IN[database_header]}&database_user={$IN[database_user]}&database_password={$IN[database_password]}&installType={$IN[installType]}\";
								}else {
									history.go(-1);
								}</script>\n";
							exit;
						}
					
					}


					if(runquery($sql_query)){
						if($config_php = $File->read(ROOT_PATH.'install/config.ini')) {//生成config.php
 							$config_php = str_replace('[cmsware_db_host]', $db_config['db_host'], $config_php);
							$config_php = str_replace('[cmsware_db_user]', $db_config['db_user'],$config_php);
							$config_php = str_replace('[cmsware_db_password]', $db_config['db_password'],$config_php);
							$config_php = str_replace('[cmsware_db_name]', $db_config['db_name'],$config_php);
							$config_php = str_replace('[cmsware_db_table_pre]', $db_config['table_pre'],$config_php);
							$config_php = str_replace('[cmsware_db_charset]', $db_config['db_charset'],$config_php);

							$config_php = str_replace('[ftp_mode]', $SYS_CONFIG['ftp_mode'], $config_php);
							$config_php = str_replace('[ftp_host]', $SYS_CONFIG['ftp_host'], $config_php);
							$config_php = str_replace('[ftp_port]', $SYS_CONFIG['ftp_port'], $config_php);
							$config_php = str_replace('[ftp_username]', $SYS_CONFIG['ftp_username'],$config_php);
							$config_php = str_replace('[ftp_password]', $SYS_CONFIG['ftp_password'],$config_php);
							$config_php = str_replace('[ftp_cms_admin_path]', $SYS_CONFIG['ftp_cms_admin_path'],$config_php);
							
							$enable_validcode = extension_loaded('gd') ? 1 : 0;
							$config_php = str_replace('[enable_validcode]', $enable_validcode,$config_php);

							$File->write('config.php', $config_php);						
						} else {
							die("Unable to read ./install/config.ini");
						}

						$TPL->assign('output',$output);
						$TPL->display('create_admin.html');
					}else {
						halt1($LANG_INSTALL['create_table_fail'],$sql_query);
						$TPL->assign('errmsg', $LANG_INSTALL['create_table_fail']);
						$TPL->display('installmsg.html');
					}				
				} elseif($IN[autoCreateDB] == '1') {
					if(mysql_query("CREATE  DATABASE `".$db_config['db_name']."`")) {
						$output.= sprintf($LANG_INSTALL['auto_create_db_success'], $db_config['db_name']);  
						if(mysql_select_db($db_config['db_name'])) {
						
							//**************************************************
							if($sql_query = $File->read($sql_file)) { //读取SQL，预备执行sql
								$table_header = $db_config['table_pre'];
  								$sql_query = str_replace('{$table_header}', $table_header, $sql_query);
							} else  {						
								die("Unable to read $sql_file ");
							}




							if($output.=runquery($sql_query)){
								if($config_php = $File->read(ROOT_PATH.'install/config.ini')) {//生成config.php
 									$config_php = str_replace('[cmsware_db_host]', $db_config['db_host'], $config_php);
									$config_php = str_replace('[cmsware_db_user]', $db_config['db_user'],$config_php);
									$config_php = str_replace('[cmsware_db_password]', $db_config['db_password'],$config_php);
									$config_php = str_replace('[cmsware_db_name]', $db_config['db_name'],$config_php);
									$config_php = str_replace('[cmsware_db_table_pre]', $db_config['table_pre'],$config_php);
									$config_php = str_replace('[cmsware_db_charset]', $db_config['db_charset'],$config_php);

									$config_php = str_replace('[ftp_mode]', $SYS_CONFIG['ftp_mode'], $config_php);
									$config_php = str_replace('[ftp_host]', $SYS_CONFIG['ftp_host'], $config_php);
									$config_php = str_replace('[ftp_port]', $SYS_CONFIG['ftp_port'], $config_php);
									$config_php = str_replace('[ftp_username]', $SYS_CONFIG['ftp_username'],$config_php);
									$config_php = str_replace('[ftp_password]', $SYS_CONFIG['ftp_password'],$config_php);
									$config_php = str_replace('[ftp_cms_admin_path]', $SYS_CONFIG['ftp_cms_admin_path'],$config_php);

									$enable_validcode = extension_loaded('gd') ? 1 : 0;
									$config_php = str_replace('[enable_validcode]', $enable_validcode,$config_php);

									$File->write('config.php', $config_php);						
								} else {
									die("Unable to read ./install/config.ini");
								}

								$TPL->assign('output',$output);
								$TPL->display('create_admin.html');
							}else {
								halt1($LANG_INSTALL['create_table_fail'],$sql_query);
								$TPL->assign('errmsg', $LANG_INSTALL['create_table_fail']);
								$TPL->display('installmsg.html');
 							}	
							//**************************************************
						}
					
					} else {
						halt1($LANG_INSTALL['create_table_fail'],$sql_query);
						$TPL->assign('errmsg', sprintf($LANG_INSTALL['create_db_fail'], $new_db_name));
						$TPL->display('installmsg.html');
				}

					
				
				} else {
					$TPL->assign('errmsg', sprintf($LANG_INSTALL['connect_db_fail'], $db_config['db_name']));
					$TPL->display('installmsg.html');
					exit;	
				}		
			}
 		break;
			

	case 'create_admin'://建立管理员
 			$TPL->assign('installType',$IN['installType']);
			if(mysql_connect($db_config['db_host'], $db_config['db_user'], $db_config['db_password'])) {
				if(mysql_select_db($db_config['db_name'])) {
					$user_pass=md5($IN[password]);
					$sql="INSERT INTO {$db_config['table_pre']}user VALUES (1, 1, '{$IN[root]}', '{$user_pass}', '{$IN[root]}', 0, 0, 0, 0, 0, 0)";
					
					if(mysql_query($sql)) {
						if(isset($PHP_SELF))
							$_SERVER["PHP_SELF"] = $PHP_SELF;
						$info = pathinfo($_SERVER["PHP_SELF"]);


 						if($info["dirname"] == "\\") $info["dirname"]="";

						if($_SERVER["SERVER_PORT"] != 80) {
							$URL = 'http://'.$_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$info["dirname"].'/www';
						} else
							$URL = 'http://'.$_SERVER["SERVER_NAME"].$info["dirname"].'/www';

						$TPL->assign('URL', $URL);

						$TPL->assign('output', $LANG_INSTALL['create_admin_success']);
						$TPL->display('create_psn.html');
					}else {
						$TPL->assign('errmsg',$LANG_INSTALL['create_admin_fail'].mysql_error());
						$TPL->display('installmsg.html');
					}				
				}

			
			}

	
 		break;
	case 'create_psn'://建立psn

		$ds = & get_singleton("CMS.DataSource");
		$db = &$ds->getConnection();
 		$TPL->assign('installType',$IN['installType']);
		
		$sql="INSERT INTO {$db_config['table_pre']}psn VALUES (1, '{$IN[Name]}', 'relate::{$IN[PATH]}', '{$IN[URL]}', NULL,NULL)";

		if($db->query($sql)) {
			$xpath = array(
				"Sites"=>array("Site"=>"__auto__"),
			);
			$xml_parser = & get_singleton("XML.SimpleXMLParser");
			$return = $xml_parser->parseFile(INSTALL_DATA_PATH.'/site_install.xml', $xpath);


			$TPL->assign('sites', $return['Sites']['Site']);			
			$TPL->display('install_select_site.html');
			break;



			if($IN['installType'] == 'typical') {		 
				$File->write(ROOT_PATH.'sysdata/.install', 'lock the installer');						
				if(file_exists(CACHE_DIR."Cache_SYS_ENV.php")) unlink(CACHE_DIR.'Cache_SYS_ENV.php');
				if(file_exists(CACHE_DIR."Cache_PSN.php")) unlink(CACHE_DIR.'Cache_PSN.php');
				if(file_exists(CACHE_DIR."Cache_CateList.php")) unlink(CACHE_DIR.'Cache_CateList.php');
				if(file_exists(CACHE_DIR.".ftp")) unlink(CACHE_DIR.".ftp");
				$TPL->assign('output', $LANG_INSTALL['install_success']);
				$TPL->display('install_end.html');
			} else {

					
			}
		}else {
			$TPL->assign('errmsg', sprintf($LANG_INSTALL['create_psn_fail'], mysql_error()));
			$TPL->display('installmsg.html');
		}				

 		break;
	case 'install_site_submit':
		$ds = & get_singleton("CMS.DataSource");
		$db = &$ds->getConnection();
		//默认安装空白站点
 		$IN['SiteUID'] = empty($IN['SiteUID']) ? "CMSware_Site_Blank" : $IN['SiteUID'];

		//自动加载/解压安装包
		if(!is_dir(INSTALL_DATA_PATH."/site/".$IN['SiteUID'])) {
			if(is_file(INSTALL_DATA_PATH."/site/".$IN['SiteUID'].".zip")) {
				$Zip = & get_singleton("FileSystem.Zip");
				$Zip->setZipName(INSTALL_DATA_PATH."/site/".$IN['SiteUID'].".zip");
				logger("extract :".INSTALL_DATA_PATH."/site/".$IN['SiteUID'].".zip");
				$Zip->extract("./install/site");
				//print_r($Zip->error_string);
				

			} else {
				trigger_error(INSTALL_DATA_PATH."/site/".$IN[SiteUID]." not exists!", E_USER_WARNING );
			}	
		}  

		//=====================开始安装{{{
		$xmlparser = & get_singleton("XML.SimpleXMLParser");

		$xpath = array(
				'CMS:content-models'=> array("TableID"=>array()),
				'CMS:Node'=>array(),
				'CMS:content-index'=>array(),
				'CMS:content'=>array("file"=>array()),
				'CMS:resource'=>array(),
				'CMS:resource-ref'=>array(),
				'CMS:www-file'=>array(),
		);

		$site_info = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/site.xml", $xpath);		
		
		//初始化设置站点包的编码
		$charset = $xmlparser->getXMLFileEncoding(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/site.xml");
		switch($charset) {
			case 'utf-8':
				$db_charset = 'utf8';
				break;
			case 'gb2312':
			case 'gbk':
			default:
				$db_charset = 'gbk';
				break;
		}
		$db->query("SET character_set_client='$db_charset'");


		//导入内容模型
		$content_model = & get_singleton("CMS.ContentModel");

		foreach($site_info['CMS:content-models']['TableID'] as $var) {			
			$xmlfile = INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/model/model_".$var.".xml";

			$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}content_{$var}");
			$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}publish_{$var}");
			$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}collection_{$var}");
			$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}contribution_{$var}");
			$content_model->importFromFile($xmlfile) ;
		}

		//导入节点附加字段
		$nodeObj = & get_singleton("CMS.Node");

		$xpath = array( 
			"CMS:NodeFields"=>array('CMS:NodeField'=> "__auto__")
			);
		$node_info = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/node_fields.xml", $xpath);			
		foreach($node_info["CMS:NodeFields"]['CMS:NodeField'] as $node_field_var) {
			$nodeObj->addField($node_field_var);
		}

		//导入节点
		$nodeObj = & get_singleton("CMS.Node");

		$xpath = array( 
			"CMS:Nodes"=>array('CMS:Node'=> "__auto__")
			);
		$node_info = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/node.xml", $xpath);			
		foreach($node_info["CMS:Nodes"]['CMS:Node'] as $node_var) {
			$nodeObj->flushData();
			foreach($node_var as $field_name=>$field_value) {
				$nodeObj->addData($field_name, dataFilter($field_value));
			}
			$nodeObj->add();
		}
		//导入内容索引
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:ContentIndexs"=>array('CMS:ContentIndex'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/content_index.xml", $xpath);

		foreach($content_index["CMS:ContentIndexs"]['CMS:ContentIndex'] as $content_index_var) {
			$dataGateway->flushData();
			foreach($content_index_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}content_index");
		}

		//导入内容
		$xpath = array( 
			"CMS:Contents"=>array('CMS:Content'=> "__auto__")
			);

		foreach($site_info['CMS:content-models']['TableID'] as $TableID) {//遍历内容模型	
			$xmlfile = INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/content_".$TableID.".xml";
			$contents = $xmlparser->parseFile($xmlfile, $xpath);

			foreach($contents["CMS:Contents"]['CMS:Content'] as $content_var) {//遍历内容
				$dataGateway->flushData();
				foreach($content_var as $field_name=>$field_value) {
					$dataGateway->addData($field_name, dataFilter($field_value));
				}

				//print_r($dataGateway->insData);exit;
				$dataGateway->dataInsert("{$db_config['table_pre']}content_{$TableID}");
			}

		}

		//导入附加发布
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:ExtraPublishs"=>array('CMS:ExtraPublish'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/extra_publish.xml", $xpath);

		foreach($content_index["CMS:ExtraPublishs"]['CMS:ExtraPublish'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}extra_publish");
		}

		//导入资源
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:Resources"=>array('CMS:Resource'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/resource.xml", $xpath);

		foreach($content_index["CMS:Resources"]['CMS:Resource'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}resource");
		}
		//导入资源-内容关联
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:ResourceRefs"=>array('CMS:ResourceRef'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/resource_ref.xml", $xpath);

		foreach($content_index["CMS:ResourceRefs"]['CMS:ResourceRef'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}resource_ref");
		}

		//导入评论
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:plugin_base_comments"=>array('CMS:plugin_base_comment'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/plugin_base_comment.xml", $xpath);

		foreach($content_index["CMS:plugin_base_comments"]['CMS:plugin_base_comment'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}plugin_base_comment");
		}
		//导入基础插件设置
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:plugin_base_settings"=>array('CMS:plugin_base_setting'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/plugin_base_setting.xml", $xpath);

		foreach($content_index["CMS:plugin_base_settings"]['CMS:plugin_base_setting'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}plugin_base_setting");
		}

		//导入计数
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:plugin_base_counts"=>array('CMS:plugin_base_count'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/plugin_base_count.xml", $xpath);

		foreach($content_index["CMS:plugin_base_counts"]['CMS:plugin_base_count'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}plugin_base_count");
		}


//		//导入采集分类规则
//		$dataGateway = & get_singleton("CMS.DataGateway");
//		$xpath = array( 
//			"CMS:CollectionCates"=>array('CMS:CollectionCate'=> "__auto__")
//			);
//		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/collection_cate.xml", $xpath);
//
//		foreach($content_index["CMS:CollectionCates"]['CMS:CollectionCate'] as $data_var) {
//			$dataGateway->flushData();
//			foreach($data_var as $field_name=>$field_value) {
//				$dataGateway->addData($field_name, dataFilter($field_value));
//			}
//			$dataGateway->dataInsert("{$db_config['table_pre']}collection_category");
//		}
//
//		//导入采集规则
//		$dataGateway = & get_singleton("CMS.DataGateway");
//		$xpath = array( 
//			"CMS:CollectionRules"=>array('CMS:CollectionRule'=> "__auto__")
//			);
//		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/collection_rules.xml", $xpath);
//
//		foreach($content_index["CMS:CollectionRules"]['CMS:CollectionRule'] as $data_var) {
//			$dataGateway->flushData();
//			foreach($data_var as $field_name=>$field_value) {
//				$dataGateway->addData($field_name, dataFilter($field_value));
//			}
//			$dataGateway->dataInsert("{$db_config['table_pre']}collection_rules");
//		}


		//导入模板变量
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:tpl_vars"=>array('CMS:tpl_var'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/tpl_vars.xml", $xpath);

		foreach($content_index["CMS:tpl_vars"]['CMS:tpl_var'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}tpl_vars");
		}

		//导入替换关键字
		$dataGateway = & get_singleton("CMS.DataGateway");
		$xpath = array( 
			"CMS:Keywords"=>array('CMS:Keyword'=> "__auto__")
			);
		$content_index = $xmlparser->parseFile(INSTALL_DATA_PATH."/site/".$IN[SiteUID]."/keywords.xml", $xpath);

		foreach($content_index["CMS:Keywords"]['CMS:Keyword'] as $data_var) {
			$dataGateway->flushData();
			foreach($data_var as $field_name=>$field_value) {
				$dataGateway->addData($field_name, dataFilter($field_value));
			}
			$dataGateway->dataInsert("{$db_config['table_pre']}keywords");
		}
		//=====================结束安装}}}


		//得到可安装的内容模型列表
		$xmlparser = & get_singleton("XML.SimpleXMLParser");
		$xpath = array(
				'models'=> array(
					'model'=> array('name', 'TableID', 'file'),	
					),	
		);

		$models = $xmlparser->parseFile(ROOT_PATH."install/model.xml", $xpath);
		$TPL->assign_by_ref('models',$models['models']['model']);
		
		//得到可安装的插件列表
		$xpath = array(
				'plugins'=> array(
					'plugin'=> array('name', 'PluginUID', 'file'),	
					),	
		);
		$plugins = $xmlparser->parseFile(ROOT_PATH."install/plugins.xml", $xpath);
		$TPL->assign_by_ref('plugins',$plugins['plugins']['plugin']);
		
		//得到已安装的内容模型IDs
		$InstalledTableIDs = array();
		$result = $db->Execute("select TableID from {$db_config['table_pre']}content_table ");
		if($result) {
			while(!$result->EOF) {
				$InstalledTableIDs[] = $result->fields['TableID'];
				$result->MoveNext();
			}
		}
		$TPL->assign_by_ref('InstalledTableIDs', $InstalledTableIDs);

		//得到可安装的采集规则列表
		$xpath = array(
				'collections'=> array(
					'collection'=> array('name', 'file'),	
					),	
		);

		$collections = $xmlparser->parseFile(ROOT_PATH."install/collection.xml", $xpath);
		$TPL->assign_by_ref('collections',$collections['collections']['collection']);

		//得到安装的站点名称
		$xpath = array(
			"Sites"=>array("Site"=>"__auto__"),
		);
		$xml_parser = & get_singleton("XML.SimpleXMLParser");
		$return = $xml_parser->parseFile(INSTALL_DATA_PATH.'/site_install.xml', $xpath);
		foreach($return['Sites']['Site'] as $var) {
			if($var['SiteUID'] == $IN['SiteUID'])	
				$output .= sprintf($LANG_INSTALL['install_site_success'], $var['Name']);

		}
		$TPL->assign('output', $output);

		$TPL->display('install_model.html');			
		break;
	case 'create_model'://建立内容模型,建立全文检索插件
		$ds = & get_singleton("CMS.DataSource");
		$db = &$ds->getConnection();
		
		//安装内容模型
		$content_model = & get_singleton("CMS.ContentModel");
		$xmlparser = & get_singleton("XML.SimpleXMLParser");
		
		if(!empty($IN[models])) {
			foreach($IN[models] as $xmlfile) {

				$xmlfile = ROOT_PATH."install/model/".$xmlfile;
				//logger($xmlfile );
				$model_info = $xmlparser->parseFile($xmlfile, array('Name','TableID'));
				$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}content_".$model_info['TableID']);
				$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}publish_".$model_info['TableID']);
				$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}collection_".$model_info['TableID']);
				$db->query("DROP TABLE IF EXISTS {$db_config['table_pre']}contribution_".$model_info['TableID']);

				if($content_model->importFromFile($xmlfile)) {
					$output_msg .= sprintf($LANG_INSTALL['create_content_model_success'], $model_info['Name']);
				}
			}	
		}

		//安装插件
		$xpath = array(
				'plugins'=> array(
					'plugin'=> array('name', 'PluginUID', 'file'),	
					),	
		);

		$plugins = $xmlparser->parseFile(ROOT_PATH."install/plugins.xml", $xpath);

		$table_header = $db_config['table_pre'];
		if(!empty($IN[plugins])) {
			foreach($plugins['plugins']['plugin'] as $var) {
				if(in_array($var['PluginUID'], $IN[plugins])) {

					$sql_query = $File->read(ROOT_PATH."install/".$var['file']);
 					$sql_query = str_replace('{$table_header}', $table_header, $sql_query);

					if(runquery($sql_query)) 
						$output_msg .= sprintf($LANG_INSTALL['create_plugin_success'], $var['name']);
				}
				 
			}	
		}

		//安装采集分类
		$xpath = array(
				'collections'=> array(
					'collection'=> array('name', 'TableID','file'),	
					),	
		);

		$collections = $xmlparser->parseFile(ROOT_PATH."install/collection.xml", $xpath);
		
		$collection_cate = & get_singleton("CMS.CollectionCate");
		$content_model =  & get_singleton("CMS.ContentModel");
		foreach($collections['collections']['collection'] as $var) {
				if(in_array($var['file'], $IN[collections])) {
					$content = $File->read(ROOT_PATH."install/collection/".$var['file']);
					$ruleData = $collection_cate->parseRuleXML($content);
					$collection_cate->flushData();
					$collection_cate->addData($ruleData['CateRules']);
					$collection_cate->addData("Name", $var['name']);
					$collection_cate->addData("TableID", $var['TableID']);
					if($collection_cate->add()) {
						$CateID = $collection_cate->db_insert_id;
						$tableFieldInfo = $content_model->getTableFieldsInfo($var['TableID']);

						foreach($tableFieldInfo as $f_key=>$f_var) {	 
							$collection_cate->flushData();
							$collection_cate->addData('Rule', $ruleData['ContentModelRules'][$f_var['FieldName']]);				
							$collection_cate->addData('CateID', $CateID);				
							$collection_cate->addData('ContentFieldID', $f_var['ContentFieldID']);				
							$collection_cate->addData('TableID', $var[TableID]);					
							$collection_cate->addRule();
						}					
					}
		
				}

				$output_msg .= sprintf($LANG_INSTALL['install_collection_rule_success'], $var['name']);
			 
		}	

		$File->del(CACHE_DIR."Cache_SYS_ENV.php");
		$File->del(CACHE_DIR."Cache_PSN.php");
		$File->del(CACHE_DIR."Cache_CateList.php");
		$File->del(CACHE_DIR.".ftp");

		$output_msg.=$LANG_INSTALL['cmsware_install_success'];

		$TPL->assign('output',$output_msg);
		$TPL->display('install_finish.html');
 		break;

	case "end":
		if(!empty($IN['delInstaller'])) {
			$File->del(SYS_PATH."install.php");
			$File->del(SYS_PATH."update.php");
		}
		$File->write(CACHE_DIR.'install.lock', "lock the installer");
		header("Location: ./index.php");

	default:
		$TPL->display('install.html');
		break;
}

?>
