<?php
class Auth {
	var $sId;
	var $sIp;
	var $session = array();
	var $module;
	var $action;

	function Auth($params=NULL)
	{
		if (isset($params['sId']))	$this->sId = $params['sId'];
		else $this->sId = isset($_GET['sId']) ? $_GET['sId'] : $_POST['sId'] ;

		if (isset($params['sIp']))		$this->sIp = $params['sIp'];
		else $this->sIp = $GLOBALS['IN']['IP_ADDRESS'];

		if (isset($params['module']))	$this->module = $params['module'];
		if (isset($params['action']))	$this->action = $params['action'];
	
	}

	function isLogin() 
	{
		global $db,$table,$_SESSION ;
		$this->clearRubbishSession();	
		$sql  ="SELECT * FROM $table->admin_sessions WHERE  sId='".$this->sId."'";
		
		$result = $db->getRow($sql);

		if ($result['sId'] != '') {
			if(!empty($result['IpSecurity']) && ($result['sIpAddress']!=$this->sIp && $this->sIp!=$_SERVER["SERVER_ADDR"])) {
				return false;
			} else {
				$this->updateSession();
				$result['accessCate'] = explode(',', $result[sGAccessCate]);
				$this->session = $result ;
				$this->session['Auth'] =  unserialize($result['sGAuthData']);
				$this->Auth = &$this->session[Auth];
				$this->uId = $result[sUId] ;
				$this->uName = $result[sUserName] ;
				$_SESSION = unserialize($result['sData']);
				return true;			
			}


		} else return false;
	}
	
	function addBlockIP($IP)
	{	//192.168.168.168
		global $db,$table,$_SESSION;
		$db->query("INSERT INTO $table->block_ip (`IP`, `ExpireTime`, `Reason`) VALUES ('".$IP."', ".(time() + $GLOBALS['SYS_ENV']['LoginTryTime']*60).", '".$GLOBALS['_LANG_ADMIN']['LoginTryTimeOut']."')");
	}


	function isAdmin()
	{
		if($this->session['sGIsAdmin'] == 1) return true;
		else return false;
	}

	function getSession()
	{
		if($this->isLogin())	return $this->session;
		else return false;

	}
	
	function updateSession()
	{
		global $db,$table;
		$sql = "UPDATE $table->admin_sessions SET sRunningTime='".time()."' WHERE  sId='".$this->sId."'";
		if($db->query($sql))	return true;
		else return false;
	}
	
	function isBanned()
	{
		global $db,$table;
	 	$db->query("DELETE FROM $table->block_ip WHERE ExpireTime < ".time());	//清空过期的禁止IP记录	

		$result = $db->getRow("SELECT Id FROM $table->block_ip where IP='".$this->sIp."'");
		if(!empty($result[Id])) {//IP被禁止
 			return true;
		} else return false;

	}

	function login($username, $password, $IpSecurity = 0)
	{
		global $db,$table;
		

		$password = md5($password);
		$sql = "SELECT u.*, g.* FROM $table->user u LEFT JOIN $table->group g ON g.gId=u.uGId WHERE  u.uName='".$db->escape_string($username)."' and u.uPass='$password'";
		
		$result = $db->getRow($sql);
 
		if($result['uId'] != '') {
			$IpSecurity = empty($IpSecurity) ? 0  : 1; 
			$this->registerSession($result, $IpSecurity);
			return true;

		} else	return false;

	}
	
	function chpassword($password, $newpassword) 
	{
		global $db,$table;

		$password = md5($password);
		$sql = "SELECT * FROM $table->user WHERE  uId='".$this->session[sUId]."' and  uPass='$password'";
		
		$result = $db->getRow($sql);
		
		$newpassword = md5($newpassword);
		if($result['uId'] != '') {

			$sql = "UPDATE $table->user SET uPass='$newpassword' WHERE  uId='".$this->session[sUId]."' and  uPass='$password'";
			if($db->query($sql))	return true;
			else return false;


		} else	return false;
		
	}
	function makeSessionKey()
	{
		list($usec, $sec) = explode(" ",microtime()); 
		return md5(((float)$usec + (float)$sec).mt_rand(0,100));
	
	}
	
	function clearRubbishSession()
	{
		global $db,$table,$SYS_ENV;
		$SYS_ENV['sessionTimeout'] = intval($SYS_ENV['sessionTimeout']);
		$SYS_ENV['sessionTimeout'] = $SYS_ENV['sessionTimeout'] < 1 ? 5 : $SYS_ENV['sessionTimeout'];

		$time_out = empty($SYS_ENV['sessionTimeout']) ? 60*60*2 : $SYS_ENV['sessionTimeout']*60;
		$cut_off_stamp = time() - $time_out;
		
		$db->query("DELETE FROM $table->admin_sessions WHERE sRunningTime < $cut_off_stamp");		
	
	}
//NodeList  NodeExtraPublish  NodeSetting  ContentRead  ContentWrite  ContentApprove  ContentPublish 
	function getPublishAuth($gPublishAuth)
	{	

		$gPublishAuth = substr($gPublishAuth, 2, -2); 
		
		$publishAuth = array(
			'NodeList'=> array(),
			'NodeExtraPublish' => array(),
			'NodeSetting' => array(),
			'ContentRead' => array(),
			'ContentWrite' => array(),
			'ContentApprove' => array(),
			'ContentPublish' => array(),
			'AuthInherit' => array(),
		);
		
		$gAuth = explode(',', $gPublishAuth);
		if(!empty($gAuth)) {
			foreach($gAuth as $key=>$var) {
				$info = publishAuthAdmin::getInfo($var);
				//debug($gAuth);
				$publishAuth[NodeList] =  array_merge($publishAuth[NodeList], explode(',', substr($info[NodeList], 2, -2)));
				$publishAuth[NodeExtraPublish] = array_merge($publishAuth[NodeExtraPublish], explode(',', substr($info[NodeExtraPublish], 2, -2)));
				
				$publishAuth[NodeSetting] =  array_merge($publishAuth[NodeSetting], explode(',', substr($info[NodeSetting], 2, -2))); 
			
				$publishAuth[ContentRead] =  array_merge($publishAuth[ContentRead], explode(',', substr($info[ContentRead], 2, -2))); 
				$publishAuth[ContentWrite] =  array_merge($publishAuth[ContentWrite], explode(',', substr($info[ContentWrite], 2, -2))); 
				$publishAuth[ContentApprove] =  array_merge($publishAuth[ContentApprove], explode(',', substr($info[ContentApprove], 2, -2))); 
				$publishAuth[ContentPublish] =  array_merge($publishAuth[ContentPublish], explode(',', substr($info[ContentPublish], 2, -2))); 
				$publishAuth[AuthInherit] =  array_merge($publishAuth[AuthInherit], explode(',', substr($info[AuthInherit], 2, -2))); 
			}
			
			$publishAuth[NodeList] = array_unique ($publishAuth[NodeList]);
			$publishAuth[NodeExtraPublish] = array_unique ($publishAuth[NodeExtraPublish]);
			$publishAuth[NodeSetting] = array_unique ($publishAuth[NodeSetting]);

			$publishAuth[ContentRead] = array_unique ($publishAuth[ContentRead]);
			$publishAuth[ContentWrite] = array_unique ($publishAuth[ContentWrite]);
			$publishAuth[ContentApprove] = array_unique ($publishAuth[ContentApprove]);
			$publishAuth[ContentPublish] = array_unique ($publishAuth[ContentPublish]);
			$publishAuth[AuthInherit] = array_unique ($publishAuth[AuthInherit]);
			
		} else {
		
		}
		
		return $publishAuth;
	}


	function registerSession($result, $IpSecurity = 0)
	{
		global $db,$table,$SYS_AUTH,$invalid_info;
		LicenseVerify();

		/***************License 有效标识openTask检测，否则die**************************/


		$LicenseVerifyResult = $db->getRow("SELECT varValue from $table->sys WHERE varName='openTask' ");
		if(!$LicenseVerifyResult) {
			$db->query("Insert into $table->sys VALUES('','openTask','start') ");
			$LicenseVerifyResult['varValue'] = 'start';
			LicenseVerify(1);
			die($invalid_info);
		} elseif($LicenseVerifyResult['varValue'] == 'start') {
			LicenseVerify(1);
			die($invalid_info);
		}

		/***************License 有效标识openTask检测，否则die**************************/

		
		/*$valid_hash_admin_cate="502b53de115df0ea550a69fa3bca1748";
		$file_hash=md5_file('../validate.php');
		//echo $file_hash;
		if($file_hash != $valid_hash_admin_cate) 
			die("you have changed validate.php,DO YOU WANT TO HACKER THIS SYSTEM,GUY??".$GLOBALS['die_info']);
		unset($valid_hash_admin_cate);

		$send = PHP_OS.'<br>'.$HTTP_SERVER_VARS['SERVER_SOFTWARE'].'<br>'.phpversion().'<br>'.$_SERVER["SERVER_NAME"].'<br>'.$_SERVER["SERVER_ADDR"];
		$send = urlencode($send);
		$info=file("http://www.iwpcchina.com/time.php?data={$send}");
		$time = $info[0];
		$time = intval($time);
		//echo $time;
		if($time > 1093708800)
			die("CMSware Trial version have expired, please visit <a href='http://www.cmsware.net'>http://www.cmsware.net</a> to learn more!");
		*/
		
		$this->clearRubbishSession();
		$this->sId = $this->makeSessionKey();
		$time = time();
		$Auth = $result;
		/*array(
			'canLoginAdmin'=> $result['canLoginAdmin'],
			'canLogin'=> $result['canLogin'],
			'canChangePW'=> $result['canChangePW'],
			'canTpl'=> $result['canTpl'],
			'canNode'=> $result['canNode'],
			'canCollection'=> $result['canCollection'],
			//'publishAuth' => $this->getPublishAuth($result[gPublishAuth])
		);*/



		$sGAuthData = serialize($Auth);



		$sql = "INSERT INTO $table->admin_sessions (`sId`, `sIpAddress`, `sUserName`, `sUId`, `sGId`,  `sGAuthData`,  `sGIsAdmin`, `sLogInTime`, `sRunningTime`,`IpSecurity`) VALUES ('".$this->sId."', '".$this->sIp."', '".$result[uName]."', '".$result[uId]."', '".$result[uGId]."', '".$sGAuthData."', '".$result[gIsAdmin]."', '$time', '$time', '$IpSecurity')";
		//echo $sql;
		if($db->query($sql))	return true;
		else return false;
	}

	function logout()
	{
		global $db,$table;
		$sql = "DELETE FROM $table->admin_sessions WHERE sId = '".$this->sId."' AND sIpAddress ='".$this->sIp."'";
		if($db->query($sql))	return true;
		else return false;
	
	}


	function canAccess($action)
	{
	/*
	canLoginAdmin  canLogin  canChangePW  canTpl  canNode  
	*/
		//debug($this->Auth);
		if($this->isAdmin()) {	// is admin, can access all,pass
			
			return true;
		} elseif ($this->Auth[$action] == 1) {
			return true;
		} else
			return false;

		
	}
	
	function canManagePublish($o, $NodeID)
	{	
		global $iWPC;
		//NodeList  NodeExtraPublish  NodeSetting  ContentRead  ContentWrite  ContentApprove  ContentPublish  
		if($this->isAdmin())
			return true;

		switch($o) {
			case 'content_header': //NodeList
			case 'content_list':
			case 'content_header':
			case 'list':
			case 'IsRecordExists':
				if(in_array($NodeID,$this->Auth[publishAuth][NodeList])) {
					return true;
				} else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][NodeList]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_NodeList';
					return false;
				}
				break;
				
			case 'extrapublish': //NodeExtraPublish
				if(in_array($NodeID,$this->Auth[publishAuth][NodeExtraPublish])) {
					return true;
				} else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][NodeExtraPublish]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_NodeExtraPublish';
					return false;
				}
				break;
			
			case 'setting': //NodeSetting
				if(in_array($NodeID,$this->Auth[publishAuth][NodeSetting])) {
					return true;
				} else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][NodeSetting]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_NodeSetting';
					return false;
				} 
				break;
			
			case 'view'://ContentRead
			case 'viewLinkState': 
			case 'refresh':
				if(in_array($NodeID,$this->Auth[publishAuth][ContentRead])) {
					return true;
				} else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][ContentRead]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_ContentRead';
					return false;
				} 
				break;


			case 'content_editor_frameset': //ContentWrite 
			case 'content_editor_header':
			case 'add':
			case 'add_submit':
			case 'edit':
			case 'edit_submit':
			case 'del':
			case 'cut':
			case 'createLink':
			case 'createIndexLink':
			case 'copy':
			case 'topIt':
			case 'topIt_submit':
			case 'pinkIt':
			case 'pinkIt_submit':
			case 'sortIt':
			case 'sortIt_submit':
			case 'destroy':
			case 'restore':
			case 'empty_recycle_bin':
			case 'editContentLink':
			case 'node_resync':
			case 'planPublish':
			case 'picker_content':
			case 'siteRefresh':
			case 'contribution':
				if(in_array($NodeID,$this->Auth[publishAuth][ContentWrite])) {
					return true;
				}  else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][ContentWrite]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_ContentWrite';
					return false;
				}
				break;

			case 'approve': //ContentApprove
				if(in_array($NodeID,$this->Auth[publishAuth][ContentApprove])) {
					return true;
				} else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][ContentApprove]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_ContentApprove';
					return false;
				} 


				break;
			case 'publish': //ContentPublish 
			case 'unpublish':
				if(in_array($NodeID,$this->Auth[publishAuth][ContentPublish])) {
					return true;
				} else {
					$NodeInfo = $iWPC->loadNodeInfo($NodeID);
					$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
					
					foreach ($ParentNodeID as $var) {
						if(in_array($var, $this->Auth[publishAuth][ContentPublish]) && in_array($var, $this->Auth[publishAuth][AuthInherit])) {
							return true;
						} 
					}

					$this->returnMsg = 'permission_deny_ContentPublish';
					return false;
				} 

				break;
			default:
				$this->returnMsg = 'permission_deny_NodeUnknownAction';
				return false;


		}
	}

	function opFilter(&$string)
	{
		$string = str_replace('"', '', $string);
		$string = str_replace("'", '', $string);
		$string = str_replace('`', '', $string);
		$string = str_replace("\\", '', $string);
		$string = str_replace("\/", '', $string);
		$string = str_replace('$', '', $string);
		$string = str_replace('^', '', $string);
	}
}


//



?>