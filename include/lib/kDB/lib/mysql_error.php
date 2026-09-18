<?php

if(!defined('IN_SYS')) {
        exit('Access Denied');
}

$timestamp = time();
$errmsg = '';

$dberror = $this->error();
$dberrno = $this->errno();

if($dberrno == 1114) {

?>
<html>
<head><title>Max onlines reached</title></head>
<body>
<table cellpadding="0" cellspacing="0" border="0" width="500" height="90%" align="center" style="font-family: Verdana, Tahoma;font-size: 9px;color: #000000">
<tr><td height="50%">&nbsp;</td></tr><tr><td valign="middle" align="center" bgcolor="#EAEAEA">
<br><b style="font-size: 11px;">Forum onlines reached the upper limit</b><br><br><br>Sorry, the number of online visitors has reached the upper limit.<br>Please wait for someone else going offline or visit us in idle hours.<br><br></td>
</tr><tr><td height="50%">&nbsp;</td></tr></table>
</body>
</html>
<?

	exit;

} else {
	
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

	trigger_error ($errmsg, E_USER_ERROR);
/*$info = debug_backtrace();


						print( "-- Backtrace --<br/><i>" );
						foreach( $info as $trace ) {
							if( ($trace["function"] != "_internalerrorhandler") && ($trace["file"] != __FILE__ )) {
								print( $trace["file"] );
								print( "(".$trace["line"]."): " );
								if( $trace["class"] != "" )
									print( $trace["class"]."." );
								print( $trace["function"] );
								print( "<br/>" );
							}
						}
						print( "</i>" );
*/
//exit;

}

?>