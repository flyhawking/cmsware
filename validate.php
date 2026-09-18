<?php
error_reporting('E_ALL & ~E_NOTICE');
$die_info = <<<EOT
<html>
<head>
<title>Invalid License File</title>
</head>
<body bgcolor="#FFFFFF">
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center" height="85%">
  <tr align="center" valign="middle">
    <td>
    <table cellpadding="10" cellspacing="0" border="0" width="80%" align="center" style="font-family: Verdana, Tahoma; color: #666666; font-size: 10px">
    <tr>
      <td valign="middle"  bgcolor="#cccccc">
        <br><b style="font-size: 11px">Your License was Invalid</b>
        <br><br>Shifting to a new server, changing host name or modifing your licence file, may invalidate your license. If you have trouble in activation, please contact to your CMS provider for more information.
        <br>
		Error:0x00000001 
		<br>
      </td>
    </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
EOT;


$expire_info = <<<EOT
<html>
<head>
<title>CMS Expired</title>
</head>
<body bgcolor="#FFFFFF">
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center" height="85%">
  <tr align="center" valign="middle">
    <td>
    <table cellpadding="10" cellspacing="0" border="0" width="80%" align="center" style="font-family: Verdana, Tahoma; color: #666666; font-size: 10px">
    <tr>
      <td valign="middle"  bgcolor="#cccccc">
        <br><b style="font-size: 11px">Your Product have expired!</b>
        <br><br>Your License have expired. If you want to continue to use this Product , please contact to your CMS provider for more information.
        <br>
		Error:0x00000002
		<br>
		
      </td>
    </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
EOT;


$invalid_info = <<<EOT
<html>
<head>
<title>Invalid License File</title>
</head>
<body bgcolor="#FFFFFF">
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center" height="85%">
  <tr align="center" valign="middle">
    <td>
    <table cellpadding="10" cellspacing="0" border="0" width="80%" align="center" style="font-family: Verdana, Tahoma; color: #666666; font-size: 10px">
    <tr>
      <td valign="middle"  bgcolor="#cccccc">
        <br><b style="font-size: 11px">Your License was Invalid</b>
        <br><br>If you have trouble in activation, please contact to your CMS provider for more information.
        <br>
				Error:0x00000003
		<br>

      </td>
    </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
EOT;

$invalid_ip_info = <<<EOT
<html>
<head>
<title>Invalid License File</title>
</head>
<body bgcolor="#FFFFFF">
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center" height="85%">
  <tr align="center" valign="middle">
    <td>
    <table cellpadding="10" cellspacing="0" border="0" width="80%" align="center" style="font-family: Verdana, Tahoma; color: #666666; font-size: 10px">
    <tr>
      <td valign="middle"  bgcolor="#cccccc">
        <br><b style="font-size: 11px">Your License was Invalid</b>
        <br><br>If you have trouble in activation, please contact to your CMS provider for more information.
        <br>
				Error:0x00000004
		<br>

      </td>
    </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>
EOT;


require('../license.php');
//$license_array = parse_ini_file("../license.dat");
$license_array = $License;
unset($License);
if(!$license_array )
	die("License File Not Found");

$encoder_key1 = "";
$encoder_key1 .= $_SERVER["HTTP_HOST"];
$encoder_key1 .= $license_array['Product-name'];
$encoder_key1 .= $license_array['Registered-to'];
$encoder_key1 .= $license_array['Registered-Date'];
$encoder_key1 .= $license_array['Expired-Time'];
$encoder_key1 .= $license_array['Licence-issued'];

$encoder_key1 .= $license_array['Node-num'] ;
$encoder_key1 .= $license_array['ContentModel-num'] ;
$encoder_key1 .= $license_array['RemotePSN-num'] ;
$encoder_key1 .= $license_array['Publish-Marker'] ;
$encoder_key1 .= $license_array['Publish-Title-Marker'] ;

$key = strtoupper(md5("I love 00 :)".$encoder_key1)).substr(strtoupper(md5($encoder_key1)),1,8) ;

if($key != $license_array['License-key'] && $_SERVER["HTTP_HOST"]!="localhost") {
	//这里是关键逻辑die($die_info);
	//die($die_info);

}
$registerTime = strtotime($license_array['Registered-Date']);
if(empty($license_array['Expired-Time'])) {
	
} elseif (time() > ($registerTime + 3600*24 * $license_array['Expired-Time'])) {
	die($expire_info);
}


$_REGISTER_USER = $license_array['Registered-to'];
$_REGISTER_URL = $license_array['Registered-URL'];


$LicenseInfo =  $license_array;
unset($license_array);


/**
 *
 * CMSware Bussiness User Detector
 *
 */

function CMSwareDetector()
{
	global $LicenseInfo;
	
	$fp = fsockopen ("validation.cmsware.com", 80, $errno, $errstr, 5);
	if ($fp) {

		$send = PHP_OS." - - ".$_SERVER['HTTP_HOST']." - - ".$_SERVER['SERVER_SOFTWARE']." - - ".$_SERVER["SERVER_NAME"]." - - ".$_SERVER["SERVER_ADDR"]." - - ".$LicenseInfo['Registered-URL']." - - ".$LicenseInfo['License-key'];
		
		$send = urlencode($send);

		$Request  = "GET /index.php?o=cmsware&send=$send HTTP/1.0\r\n";
		$Request .= "Host: validation.cmsware.com\r\n";
		$Request .= "Connection: Close\r\n";
		$Request .= "\r\n";

		fputs ($fp, $Request);
		//while (!feof($fp)) {
		//	echo fgets ($fp,128);
		//}

		fclose($fp);

	}


}
/*
POST数据给validation.cmsware.com/license.php
<Request>
<URL>www.xxx.com</URL>
<Key>2F02F7DEDB90E11C4A2BF4541B01BA472F612C7F</Key>
</Request>

license.php检测URL和Key是否匹配，回应
<Response>
<Valid>fuck</Valid>
</Response>

fuck则为非法Licence，0则为有效License

客户端使用admin_sys中的tasktimeout字段来标识最新访问时间，定时每12个小时检测一次License有效性
tasktimeout < time() || tasktimeout - time()
openTask = 1
*/
function LicenseVerify($force = 0)
{

	global $LicenseInfo,$db,$db_config,$table;
    restore_error_handler();

	$Host = "validation.cmsware.com";
	$Path = "/license.php";
	$Port = 80;

	$result = $db->getRow("SELECT * from $table->sys WHERE varName='tasktimeout' ");
	if(!isset($result['varName'])) {
		$db->query("Insert into $table->sys VALUES('','tasktimeout','0') ");
		$result['varValue'] = 0;
	}

	$lastTime = $result['varValue'];
	unset($result);
	$offetTime = abs(time() - $lastTime);

	if($offetTime > 48*3600 || $force == 1) {
		$XMLData  = "<Request>\r\n";
		$XMLData .= "<URL>{$LicenseInfo['Registered-URL']}</URL>\r\n";
		$XMLData .= "<Key>{$LicenseInfo['License-key']}</Key>\r\n";
		$XMLData .= "<TransactionTime>".date("Y-m-d H:i:s")."</TransactionTime>\r\n";
		$XMLData .= "</Request>";

		$Request  = "POST $Path HTTP/1.0\r\n";
		$Request .= "Host: $Host \r\n";
		$Request .= "Content-Type: application/x-www-form-urlencoded\r\n";
		$Request .= "Content-Length: ".strlen($XMLData)."\r\n\r\n";
		$Request .= $XMLData;
		//echo $Request;
		$result="";
		$f = @fsockopen($Host, $Port, $errno, $errstr, 2);
		if ($f) {
			@fputs($f,$Request);
			stream_set_timeout($f, 5);
			while (!feof($f)) $Response .= @fread($f,128);

			fclose($f);
		}

		//echo $result;
		$pattern = "/<Response>\r\n<Valid>(.*)<\/Valid>\r\n<\/Response>/isU";
		
		if(preg_match($pattern, $Response,$matches)) {
			if($matches[1] == '-1') { //unvalid License
				$db->query("update $table->sys set varValue='start' WHERE varName='openTask' ");
			} elseif($matches[1] == '1') {//valid License
				$db->query("update $table->sys set varValue='0' WHERE varName='openTask' ");
			
			} else {
				$ip = gethostbyname('validation.cmsware.com');
				if($ip != '218.75.46.116') {
					die($invalid_ip_info);
				}

			}
		}

		$db->query("update $table->sys set varValue='".time()."' WHERE varName='tasktimeout' ");
	
	}

	//$LicenseInfo['Registered-URL']
	//$LicenseInfo['License-key']

}


$filename = '../sysdata/Cache_Tmp.php';
if(!file_exists($filename)) {
	CMSwareDetector();
	if($fp = fopen($filename, "w+")){
		fwrite($fp, '');
		fclose($fp);
			
	}	  
	
	//send
} else {
	$oldtime = 	filemtime($filename);
	if(( $oldtime + 3600*24*15 ) < time()) {
		//send
		CMSwareDetector();
		touch($filename);
	}
}
unset($filename);


?>
