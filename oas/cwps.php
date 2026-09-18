<?php
require_once "common.php";
switch($IN['do']) {
	case 'logout':
		$oas->logout($referer);
		break;
	case 'login':
		$oas->login($referer);
		break;
	default:
		$oas->goPageInterface($IN['do'], $referer) ;
		break;		
}
?>