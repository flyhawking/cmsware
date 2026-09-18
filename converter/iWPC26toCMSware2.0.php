<?php
set_magic_quotes_runtime(0);
set_time_limit(5000);
header('Content-Type: text/html; charset=gb2312');
$version = "CMSware 2.0";
$Header = <<<EOT
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
		input  {  font-family:Verdana, Arial; font-size:12px; background-color:#FEFEFE; letter-spacing:-1px }

</style>
<title>iWPC2.6 -> $version 数据转换程序</title>
EOT;

$_UI = <<<EOT
<script language="JavaScript" type="text/JavaScript">
<!--
function startConverter()
{
	update.value="   转换ing...     ";
	update.disabled=true;
	window.location= window.location + "?o=doing&step=1"
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" topmargin='5' leftmargin='0'>
<p>&nbsp;</p><table width='95%' align='center' cellpadding='4' cellspacing='0'>
  <tr> 
    <td class='header'> iWPC2.6 -> $version 数据转换程序</td>
  </tr>
  <tr> 
    <td > <br>说明：
      <ol>
	<li>该转换程序用于将你的iWPC2.6数据导入$version 。</li>
<li>该转换程序将导入iWPC2.6的分类数据、内容数据以及评论、计数数据 。</li>
	<li>转换完毕后，请删除此转换程序文件。</li>
      </ol></td>
  </tr>
  <tr> 
    <td  align='center' class='header'>&nbsp; </td>
  </tr>
	<tr>
	<td>


			<CENTER>{info}</CENTER>
  

  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="display:{display}">

	  <tr> 
    <td  align='center'>
<input type="button" name="update" value=" 开 始 转 换 " onclick="startConverter();" id="update">
    </td>
  </tr>
  </table>
 


	</td>
	</tr>

</table>
<br>
</body>
</html>
EOT;



$_UI_OK = <<<EOT
<script language="JavaScript" type="text/JavaScript">
<!--
function finish()
{
	window.location="../index.php"
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" topmargin='5' leftmargin='0'>
<p>&nbsp;</p><table width='95%' align='center' cellpadding='4' cellspacing='0'>
  <tr> 
    <td class='header' align=center height=30> 恭喜你！你的iWPC数据成功导入 $version .</td>
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




define('INCLUDE_PATH','../include/');
define('KTPL_DIR', INCLUDE_PATH.'lib/kTemplate/');
define('IN_IWPC',true);
define('SYS_PATH', '../');
define('CACHE_DIR','../sysdata/');
define('KDB_DIR',INCLUDE_PATH.'lib/kDB/');
define('MODULES_DIR','../modules/');
define('ADMIN_DIR','../');
define('SETTING_DIR','../setting/');
define('CMSWARE_VERSION', "CMSware 1.1");
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
			$Que = mysql_query($query);
			if(!$Que) {
				halt1('MySQL Query Error', $query);
			}

		}
	}
	return $Que;
}

function nextStep($url)
{
	die("<meta http-equiv=\"refresh\" content=\"2;url='{$url}'\">");


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
require_once "iwpc_config.php";
require_once "iwpc.class.php";

$IN = parse_incoming();
echo $Header;
if($IN['o'] == 'doing') {
	require_once KDB_DIR.'kDB.php';
	$db = new kDB($iwpc_db_config['db_driver']);
	$db->connect($iwpc_db_config);
	$iwpc26 = new iWPC26();
	switch($IN['step']) {
		case '1'://convert cate
			$offset = empty( $IN['offset']) ?  100 : $IN['offset'];
			$num= $iwpc26->getCateNum();
			$pagenum=ceil($num/$offset);
			if(empty($IN[Page]))
				$Page = 1;
			else
				$Page = $IN[Page];

			$start=($Page-1)*$offset;
			$CateInfo = $iwpc26->getCateLimit($start, $offset);
 			
			$db->close();
			$db->connect($db_config);

			foreach($CateInfo as $key=>$var) {
				$iwpc26->flushData();
				$iwpc26->addData('NodeID', $var['cId']);
				$iwpc26->addData('TableID', 1);
				$iwpc26->addData('ParentID', $var['cFId']);
				$iwpc26->addData('RootID', $var['cRId']);
				$iwpc26->addData('Name', $var['cName']);
				$iwpc26->addData('AutoPublish', 0);
				$iwpc26->addData('ResourcePSN', '{PSN:1}/upload');
				$iwpc26->addData('ResourceURL', '{PSN-URL:1}/upload');

				$iwpc26->addData('ContentTpl', '/default/content.html');
				$iwpc26->addData('ImageTpl', '/default/image.html');
				
				$iwpc26->addData('ContentPSN', '{PSN:1}/'.$var['cPath']);
				$iwpc26->addData('ContentURL', '{PSN-URL:1}/'.$var['cPath']);
				$iwpc26->addData('IndexName', 'index.html');
				$iwpc26->addData('SubDir', 'Y-m-d');
				$iwpc26->addData('PublishFileFormat', '{ContentID}.html');
				

				
				
				//$iwpc26->debugData();
				$iwpc26->addCate();

				echo '<br>转换分类数据表.................'.$var['cName'];
			}
			$Page++;
			if($num > ($start+$offset)) {
				nextStep($_SERVER['PHP_SELF']."?o=doing&step=1&offset={$offset}&Page={$Page}");
			
			} else {
				nextStep($_SERVER['PHP_SELF']."?o=doing&step=2&offset={$offset}");
			
			}
			break;
		case '2'://convert content
 			$offset = empty( $IN['offset']) ?  100 : $IN['offset'];
			$num= $iwpc26->getContentNum();
			$pagenum=ceil($num/$offset);
			if(empty($IN[Page]))
				$Page = 1;
			else
				$Page = $IN[Page];

			$start=($Page-1)*$offset;
			$ContentInfo = $iwpc26->getContentLimit($start, $offset);
 			
			$db->close();
			$db->connect($db_config);
 
			foreach($ContentInfo as $key=>$var) {
				$iwpc26->flushData();
 				$iwpc26->addData('Title', $var['mTitle']);
				$iwpc26->addData('TitleColor', $var['mHighLight']);
				$iwpc26->addData('Author', $var['mAuthor']);
				$iwpc26->addData('Editor', $var['mOfferMan']);
				$iwpc26->addData('Photo', $var['mPhoto']);
				$iwpc26->addData('Content', $var['mContent']);
				$iwpc26->addData('Keywords', $var['mKeywords']);
				$iwpc26->addData('FromSite', $var['mFromSite']);
				$iwpc26->addData('Intro', $var['mIntro']);
				$iwpc26->addData('CreationDate', time());
				$iwpc26->addData('ModifiedDate', time());
				$iwpc26->addData('CreationUserID', 1);
				$iwpc26->addData('LastModifiedUserID', 1);
				//$iwpc26->debugData();
				$iwpc26->addContent();

				
				$ContentID = $iwpc26->db_insert_id;
				$iwpc26->flushData();
				$iwpc26->addData('IndexID', $var['mId']);
				$iwpc26->addData('ContentID', $ContentID);
				$iwpc26->addData('NodeID', $var['mFId']);
				$iwpc26->addData('PublishDate', $var['mPublishTime']);
				$iwpc26->addData('Type', 1);
				$iwpc26->addData('ParentIndexID', $var['mId']);
				$iwpc26->addData('Top', $var['mIsTop']);
				$iwpc26->addData('Pink', $var['mIsRecommend']);
				$iwpc26->addIndex();

				$iwpc26->flushData();
				$iwpc26->addData('IndexID', $var['mId']);
				$iwpc26->addData('ContentID', $ContentID);
				$iwpc26->addData('NodeID', $var['mFId']);
 				$iwpc26->addData('Hits_Total', $var['mHits']);
				$iwpc26->addData('CommentNum', $var['mCommentNum']);
 				$iwpc26->addCount();
				
				echo '<br>转换内容数据表.................'.$var['mTitle'];

			}
			
			$Page++;
			if($num > ($start+$offset)) {
				nextStep($_SERVER['PHP_SELF']."?o=doing&step=2&offset={$offset}&Page={$Page}");
			
			} else {
				nextStep($_SERVER['PHP_SELF']."?o=doing&step=3&offset={$offset}");
			
			}
			break;
 		case '3'://convert comment
			$offset = empty( $IN['offset']) ?  100 : $IN['offset'];
			$num= $iwpc26->getCommentNum();
			$pagenum=ceil($num/$offset);
			if(empty($IN[Page]))
				$Page = 1;
			else
				$Page = $IN[Page];

			$start=($Page-1)*$offset;
			$CommentInfo = $iwpc26->getCommentLimit($start, $offset);
 			
			$db->close();
			$db->connect($db_config);

			foreach($CommentInfo as $key=>$var) {
				$iwpc26->flushData();
				$iwpc26->addData('CommentID', $var['id']);
 				$iwpc26->addData('IndexID', $var['mId']);				
				$iwpc26->addData('Author', $var['author']);
				$iwpc26->addData('Ip', $var['ip']);				
				$iwpc26->addData('CreationDate', $var['time']);				
				$iwpc26->addData('Comment', $var['comment']);				

				//$iwpc26->debugData();
				$iwpc26->addComment();

				echo '<br>转换评论数据表.................'.$var['ip'];
			}
			$Page++;
			if($num > ($start+$offset)) {
				nextStep($_SERVER['PHP_SELF']."?o=doing&step=3&offset={$offset}&Page={$Page}");
			
			} else {
				nextStep($_SERVER['PHP_SELF']."?o=doing&step=4&offset={$offset}");
			
			}

			break;

		case '4':
			exit($_UI_OK);
			break;
	}
			
} else {
	$iwpc_connected = false;
	if(mysql_connect($iwpc_db_config['db_host'], $iwpc_db_config['db_user'], $iwpc_db_config['db_password'])) {
		if(mysql_select_db($iwpc_db_config['db_name'])) {
			$iwpc_connected = true;

		} 
	}

	if($iwpc_connected) {
		$info = "<H3><FONT   COLOR=\"#3300FF\">OK! iWPC数据库连接成功！可以开始进行数据转换</FONT></H3>";
		$display = "";
	} else {
		$info = "<H3><FONT   COLOR=\"#FF3300\">Error! iWPC数据库连接失败！请重新设置你的iwpc_config.php</FONT></H3>";
		$display="none";
	
	
	}
	
	$_UI = str_replace("{info}", $info, $_UI);
	$_UI = str_replace("{display}", $display, $_UI);
	exit($_UI);
}




?>