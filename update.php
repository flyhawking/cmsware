<?php
//$Id: update.php,v 1.18 2006/06/25 14:51:57 Administrator Exp $
set_magic_quotes_runtime(0);

if(substr(phpversion(), 0 ,1) == 5) 	{ 
	define("PHP_VERSION_5", true); 
	@ini_set('zend.ze1_compatibility_mode', '1');// for PHP 5 compatibility
} else	define("PHP_VERSION_5", false);


function getUpdateList()
{
		$dir=dir('./install');
		$dir->rewind();
		while($file=$dir->read()) {
			if( $file=="." || $file=="..") {
				continue;
			} elseif( is_dir('./install'. $file)) {
				continue;
						
			}elseif(preg_match("/update(.*)to(.*).sql/isU",$file,$matches)) {
				$dirlist[] = array(
					'file'=>$file,
					'pre_version'=> $matches[1],
					'update_version'=> $matches[2],
				);
			}
			
		}
		$dir->close();
		return $dirlist;	
}

$update_version = '2.7';

$updateLists = array(
	
	array(
		'file'=> "update2.6.2.0328to2.7.sql",
		'pre_version'=> "2.6.2.0328",
		'update_version'=> "2.7",	
	),
	array(
		'file'=> "update2.6.2to2.6.2.20060212.sql",
		'pre_version'=> "2.6.2",
		'update_version'=> "2.6.2.20060212",	
	),
	array(
		'file'=> "update2.6.1.20060101to2.6.2.sql",
		'pre_version'=> "2.6.1.20060101",
		'update_version'=> "2.6.2",	
	),
	array(
		'file'=> "fixbug20060125.sql",
		'pre_version'=> "",
		'update_version'=> "fixbug20060125",	
	),
	array(
		'file'=> "update2.6to2.6.1.20060101.sql",
		'pre_version'=> "2.6.0.1022",
		'update_version'=> "2.6.1.20060101",	
	),
	array(
		'file'=> "update2.5.2.0913to2.6.1022.sql",
		'pre_version'=> "2.5.2.0913",
		'update_version'=> "2.6.0.1022",	
	),
	array(
		'file'=> "update2.5.1to2.5.2.0913.sql",
		'pre_version'=> "2.5.1",
		'update_version'=> "2.5.2.0913",	
	),
	array(
		'file'=> "update2.5stable0810to2.5.1stable0816.sql",
		'pre_version'=> "2.5stable0810",
		'update_version'=> "2.5.1stable0816",	
	),
	array(
		'file'=> "update2.5stable0803to2.5stable0810.sql",
		'pre_version'=> "2.5stable0803",
		'update_version'=> "2.5stable0810",	
	),
	array(
		'file'=> "update2.5RC6to2.5stable0803.sql",
		'pre_version'=> "2.5RC6",
		'update_version'=> "2.5stable0803",	
	),
	array(
		'file'=> "update2.5RC5to2.5RC6.sql",
		'pre_version'=> "2.5RC5",
		'update_version'=> "2.5RC6",	
	),
	array(
		'file'=> "update2.1to2.5.sql",
		'pre_version'=> "2.1",
		'update_version'=> "2.6(2.5.2.1001)",	
	),
	array(
		'file'=> "update2.0to2.1.sql",
		'pre_version'=> "2.0",
		'update_version'=> "2.1",	
	),
	array(
		'file'=> "update1.1to2.0.sql",
		'pre_version'=> "1.1",
		'update_version'=> "2.0",	
	),
	array(
		'file'=> "update1.0.0905to1.1.sql",
		'pre_version'=> "1.0.0905",
		'update_version'=> "1.1",	
	),


);

//$updateLists = getUpdateList();
 foreach($updateLists as $key=>$var) {
	if($update_version == $var[update_version]) {
		$version_ui .= "<option value='".$var['file']."' selected>".$var[pre_version]." -> ".$var[update_version]."</option>";
	
	} else{
		$version_ui .= "<option value='".$var['file']."' >".$var[pre_version]."->".$var[update_version]."</option>";
	
	}


}







define('INCLUDE_PATH','./include/');
define('KTPL_DIR', INCLUDE_PATH.'lib/kTemplate/');
define('IN_IWPC',true);
define('SYS_PATH', './');
define('CACHE_DIR','./sysdata/');
define('KDB_DIR',INCLUDE_PATH.'lib/kDB/');
define('MODULES_DIR','./modules/');
define('ADMIN_DIR','./');
define('SETTING_DIR','./setting/');
define('CMSWARE_VERSION', "CMSware 2.7");
define('LANG_PATH', SYS_PATH.'language/');

$diableDebug = false;
function runquery($sql) {
	global $db;

	$sql = str_replace("\r", "\n", $sql);
	$ret = array();
	$num = 0;
	foreach(explode(";\n", trim($sql)) as $query) {
		$queries = explode("\n", trim($query));
		foreach($queries as $query) {
			$ret[$num] .= $query[0] == '#' ? NULL : $query;
		}
		$num++;
	}
	unset($sql);

	foreach($ret as $query) {
		$query = trim($query);
		if($query) {
			if(substr($query, 0, 12) == 'CREATE TABLE') {
				$name = preg_replace("/CREATE TABLE ([a-z0-9_]+) .*/is", "\\1", $query);
				$output.='建立数据表 '.$name.' ... <font color="#0000EE">成功</font><br>';
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
require_once INCLUDE_PATH."data.class.php";
require_once INCLUDE_PATH."functions.php";
require_once SYS_PATH."config.php";
$SYS_CONFIG['language'] = empty($SYS_CONFIG['language']) ? 'chinese_gb' : $SYS_CONFIG['language'];
require_once LANG_PATH.$SYS_CONFIG['language'].'/charset.inc.php';
header("Content-Type: text/html; charset=".CHARSET);

$charset = CHARSET;

$ADMIN_PATH = ADMIN_NAME;

$_UI = <<<EOT
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset={$charset}">
<style>
		BODY, TABLE { font-family: verdana, arial; font-size:12px; line-height:150% }

		.title      { background-image: url(tile_back.gif); font-family:arial; font-size:18px; color:white; font-weight:bold; height:40px }

		.table1     { border:1px solid #999999 }

		.table2     { border:1px dotted #999999 }

		.menustrip  { font-color:black; background-color:#EEEEEE; font-size:12px; height:24px }

		a:link, a:visited, a:active  { color:#000055 }

		a:hover                      { color:#333377;text-decoration:underline }

		.header     { border-bottom:1px dashed #999999; font-family:Verdana, Arial; font-weight:bold; color:#4C77B6; font-size:20px; background-color:#FEFEFE; letter-spacing:-1px }

		.item     { border-bottom:1px dashed #999999; font-family:"Verdana", "Arial"; font-weight:bold; color:#000000; font-size:18px; background-color:#FEFEFE; letter-spacing:-1px }


</style>
<title>CMSware升级程序 </title>

<script language="JavaScript" type="text/JavaScript">
 function startupdate()
{
	document.clientform.update.value="   升级ing...     ";
	document.clientform.update.disabled=true;
	document.clientform.submit();
 }
 </script>
</head>

<body bgcolor="#FFFFFF" topmargin='5' leftmargin='0'>

	<FORM METHOD=POST ACTION="update.php?o=doing" name="clientform">
	
<p>&nbsp;</p><table width='95%' align='center' cellpadding='4' cellspacing='0'>
  <tr> 
    <td class='header'> CMSware升级程序</td>
  </tr>
  <tr> 
    <td > 请选择你要升级的版本：
<select name="updateSql">
$version_ui
</select>。<br>
直接输入需要执行的升级SQL文件名:<input type="text" name="updateSqlFilename">
<br> <p> 注意事项：</p>
      <ol>
        <li>运行该升级程序前，请确认你已经使用升级包文件覆盖了你原有的CMSware 程序文件。</li>
        <li>升级完毕后，请删除此升级程序文件。</li>
      </ol></td>
  </tr>
  <tr> 
    <td  align='center' class='header'>&nbsp; </td>
  </tr>
  <tr> 
    <td  align='center'>
<input type="submit" name="update" value=" 开 始 升 级 " onclick="startupdate();" id="update">
    </td>
  </tr>
</table>
		</FORM>

<br>
</body>
</html>
EOT;



$_UI_OK = <<<EOT
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset={$charset}">
<style>
		BODY, TABLE { font-family: verdana, arial; font-size:12px; line-height:150% }

		.title      { background-image: url(tile_back.gif); font-family:arial; font-size:18px; color:white; font-weight:bold; height:40px }

		.table1     { border:1px solid #999999 }

		.table2     { border:1px dotted #999999 }

		.menustrip  { font-color:black; background-color:#EEEEEE; font-size:12px; height:24px }

		a:link, a:visited, a:active  { color:#000055 }

		a:hover                      { color:#333377;text-decoration:underline }

		.header     { border-bottom:1px dashed #999999; font-family:Verdana, Arial; font-weight:bold; color:#4C77B6; font-size:20px; background-color:#FEFEFE; letter-spacing:-1px }

		.item     { border-bottom:1px dashed #999999; font-family:"Verdana", "Arial"; font-weight:bold; color:#000000; font-size:18px; background-color:#FEFEFE; letter-spacing:-1px }


</style>
<title>CMSware升级程序({$pre_version} -&gt; {$update_version})</title>

<script language="JavaScript" type="text/JavaScript">
<!--
function finish()
{
	window.location="{$ADMIN_PATH}/index.php"
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" topmargin='5' leftmargin='0'>
<p>&nbsp;</p><table width='95%' align='center' cellpadding='4' cellspacing='0'>
  <tr> 
    <td class='header' align=center height=30> 恭喜你！你的CMSware成功升级到新版本.</td>
  </tr>
  <tr> 
    <td height=20 ></td>
  </tr>
	
<tr> 
    <td  align='center'>
<input type="submit" name="update" value=" 点 击 登 陆 后 台 " onclick="finish();" id="update">
    </td>
  </tr>
</table>
<br>
</body>

</html>

EOT;


$IN = parse_incoming();
if($IN['o'] == 'doing') {
			$_POST['updateSql'] = !empty($_POST['updateSqlFilename']) ? $_POST['updateSqlFilename'] : $_POST['updateSql'];
			require_once KDB_DIR.'kDB.php';
			$db = new kDB($db_config['db_driver']);
			if(mysql_connect($db_config['db_host'], $db_config['db_user'], $db_config['db_password'])) {

				if(mysql_select_db($db_config['db_name'])) {
					if($sql_handle = fopen('./install/'.$_POST['updateSql'],'r')) { //读取SQL，预备执行sql
						$table_header = $db_config['table_pre'];
						$sql_query = fread ($sql_handle, filesize ('./install/'.$_POST['updateSql']));
						fclose ($sql_handle);

						if($_POST['updateSql']=="update2.6.1.20060101to2.6.2.sql" || $_POST['updateSql']=="fixbug20060125.sql") {
							$sql_query.="\r\ncreate table the_tmp_resource_ref as (select distinct * from {$table_header}resource_ref);";
							$sql_query.="\r\ntruncate table {$table_header}resource_ref;";
							$sql_query.="\r\ninsert into {$table_header}resource_ref  select * from the_tmp_resource_ref;";
							$sql_query.="\r\ndrop table the_tmp_resource_ref;\r\n";

						}
						$sql_query = str_replace('{$table_header}', $table_header, $sql_query);

						//echo $sql_query;exit;					
					} else  {
						
						die("Unable to read ./install/".$_POST['updateSql']);
					}


					if($_POST['updateSql']=='update2.6.1.20060101to2.6.2.sql') {//自动创建索引
						include_once(CACHE_DIR.'Cache_ContentModel.php');
						foreach($CONTENT_MODEL_INFO as $key=>$var) {
							if(!empty($var['TableID'])) {
								$publish_table = $db_config['table_pre'].$db_config['table_publish_pre']."_".$var['TableID'];
								$collection_table = $db_config['table_pre'].$db_config['table_collection_pre']."_".$var['TableID'];
								
								//Publish表处理
								$result = mysql_query("SHOW CREATE TABLE $publish_table ");
								$row = mysql_fetch_array($result);
								$publish_scm = $row[1];
								if(!strpos($publish_scm, "KEY `PublishDate` (`PublishDate`)" )) {
									mysql_query("ALTER TABLE $publish_table  ADD INDEX `PublishDate` (`PublishDate`)");
								}
									//echo $publish_scm;
							//Collection表处理
								$result = mysql_query("SHOW CREATE TABLE $collection_table ");
								$row = mysql_fetch_array($result);
								$publish_scm = $row[1];
								
								if(!strpos($publish_scm, "KEY `Src` (`Src`)" )) {
									mysql_query("ALTER TABLE $collection_table  ADD INDEX `Src` (`Src`(250))");
								}
								


							}
						}
					}


					if($output=runquery($sql_query)){

						@unlink(CACHE_DIR.'Cache_SYS_ENV.php');
						@unlink(CACHE_DIR.'Cache_PSN.php');
						@unlink(CACHE_DIR.'Cache_CateList.php');
								if($config_handle = fopen('./install/config.ini','r')) {//生成config.php
									$config_php = fread ($config_handle, filesize ('./install/config.ini'));
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

									$handle = fopen('config.php','w');
									@flock($handle,3);  
									fwrite($handle,$config_php);
									fclose($handle);							
								} else {
									die("Unable to read ./install/config.ini");
								}

						
						
						exit($_UI_OK);
					}else {
						die("<h1>升级失败</h1>");
					}				
				} 
			}
} else {
	if(!is_writable('config.php')) {
		exit("警告：你的config.php不可写，请设置为可写后再运行update.php");
	}
	exit($_UI);
}




?>