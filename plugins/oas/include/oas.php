<?php
/**
 * OAS Interface
 * @package oas
 * @access public
 */
class OAS {
 	var $sId;
	var $fromCWPS = false; //数据是否来源于CWPS

	/**
	 * Cookie路径
	 * @var string  
	 */
	var $cookiepath = '';

	/**
	 * Cookie作用域
	 * @var string  
	 */
	var $cookiedomain = '';

	/**
	 * 用户Session数组,主要保存用户id,组id和其他附加数据,提供给CMSware会员权限接口进行权限验证
	 * @var   array  
	 */
	var $session = array();
	var $guest_session = array(
			'UserID'=> '0',
			'UserName'=> 'Guest',
			'Password'=> '',
			'GroupName'=> 'Guest',
			'GroupID'=> 1,
			'Credit'=> 0, //可是是用户威望,积分等
		
		);
	
	/**
	 * 当前时间
	 * @var int 
	 */
	var $timestamp = '';
	var $table_session = '';

	

	function OAS(&$OAS_SETTING) 
	{
 		global $plugin_table;

		$this->table_session = $plugin_table['oas']['sessions'];
		$this->setting = &$OAS_SETTING;

		//session_start();
		//如果非UserSession则设置session为GuestSession
		//$_SESSION = empty($_SESSION[GroupID]) ? $this->guest_session : $_SESSION;

		$this->cookie_name_sid = $this->setting['CookiePre'].'sid';
 		$this->sId = isset($_GET['sId']) ? $_GET['sId'] : (isset($_POST['sId']) ? $_POST['sId'] : (isset($_SESSION['sId']) ? $_SESSION['sId'] : $_COOKIE[$this->cookie_name_sid]) ); 
		
		$this->Ip = $GLOBALS['IN']['IP_ADDRESS'];

		$this->OnlineHold = $OAS_SETTING['OnlineHold'];

		$this->cookiepath = $OAS_SETTING['CookiePath'];
		$this->cookiedomain = $OAS_SETTING['CookieDomain'];
		$this->CheckIP = $OAS_SETTING['CheckIP'];
		$this->timestamp = time();

 
		if(substr($this->sId, 0, 6) == 'CWPS::') {
			$this->sId = substr($this->sId, 6);
			$this->fromCWPS = true;
			if(!isset($_COOKIE[$this->cookie_name_sid])) {
				setcookie($this->cookie_name_sid, $this->sId, $this->timestamp + $this->OnlineHold, $this->cookiepath,  $this->cookiedomain);
			}
			
				
		}

		$this->session = $this->guest_session;

		$this->init();
		
		if($this->isLogin()) {
			$this->ActiveCWPSSession($this->setting['CWPS_SessionActiveTime']);
		}
		 /*if(!$this->isLogin() && !$this->fromCWPS) {
 			$this->login();//跳转到CWPS进行登陆
			//$auth->isLoginCWPS();//判断是否在CWPS登陆

		}else if(!$auth->isLogin() && $auth->fromCWPS) { //CWPS返回isLoginCWPS调用的结果
			echo "你没有登陆";
		} else {
			$auth->ActiveCWPSSession($SYS_ENV['sessionActiveTime']);
			echo "<b>".$auth->session['UserName']."</b> is Logined<a href=?o=logout >logout</a>";
		}*/

	}
	
 
	function init()
	{
		global $plugin_table, $db;


		if(!empty($this->sId)) {         //如用户id存在
 			
			$check_ip_sql = $this->CheckIP ? " AND Ip='{$this->Ip}'" : "" ;
			$result = $db->getRow("SELECT * FROM {$this->table_session} WHERE sId='{$this->sId}'".$check_ip_sql);
 
        	if(empty($result['sId'])) { 
				//sid not valid, maybe the session expired, now we check whether the cookies is valid
				$this->session = $this->guest_session;
				$this->clearCookies();

			} else { // valid session
				$this->session = $result;
				$this->session['SessionData'] = unserialize($result['SessionData']);
				
				$this->activeSession();
				return true;
			}
		} 



		if(!$this->isLogin()) {
			$this->tryLogin($this->sId, $this->Ip);
		}
 

	}

	function activeSession()
	{
		global $db,$table;
		 
		$sql = "UPDATE {$this->table_session} SET RunningTime='".time()."' WHERE  sId='".$this->sId."'";
		if($db->query($sql)) return true;
		else return false;
		 
	}

	function registerSession($result)
	{
		global $table,$db;
		$time = time();
		
		//guest session,update to user session
		$resultSession = $db->getRow("SELECT * FROM {$this->table_session}  where sId='".$this->sId."' AND Ip='{$this->Ip}'");
		if(!empty($resultSession['sId'])) {

			$sql = "update {$this->table_session} set `UserName`='{$result['UserName']}', `UserID`='{$result['UserID']}', `GroupID`='{$result['GroupID']}', `LogInTime`='$time', `RunningTime`='$time', SessionData='".$result[SessionData]."' where sId='".$this->sId."' AND Ip='{$this->Ip}'";

			if($db->query($sql))	{
				$this->session = array_merge($resultSession, $result);
				setcookie($this->cookie_name_sid, $this->sId, $this->timestamp + $this->OnlineHold, $this->cookiepath,  $this->cookiedomain);
				return true;
			}
			
		}

		$this->sId = $result[sId];
		$this->session = $result;
		$this->session['sId'] = $this->sId;

				
		$sql = "INSERT INTO {$this->table_session} (`sId`, `UserName`, `UserID`, `GroupID`, `LogInTime`, `RunningTime`, `Ip`, `SessionData`) VALUES ('{$this->sId}', '{$result['UserName']}', '{$result['UserID']}', '{$result['GroupID']}', '$time', '$time', '{$this->Ip}', '".$result[SessionData]."' )";

		if($db->query($sql))	{
			setcookie($this->cookie_name_sid, $this->sId, $this->timestamp + $this->OnlineHold, $this->cookiepath,  $this->cookiedomain);
			
			return true;
		} else return false;
	}

	function clearRubbishSession()
	{
		global $db,$table;

		$cut_off_stamp = $this->timestamp - $this->OnlineHold  ;

		$db->query("DELETE FROM {$this->table_session} WHERE RunningTime < $cut_off_stamp");

	}
	
 

	function clearCookies() 
	{
		setcookie($this->cookie_name_sid, '', $this->timestamp - 86400 * 365, $this->cookiepath,  $this->cookiedomain);

	}


	function isLogin()
	{
		if (empty($this->session['UserID'])) {
			return false;
		} else return true;

	}

	function ActiveCWPSSession($activeTime)
	{
		
		if((time() - $this->session['CWPS_SessionActiveTime']) < $activeTime) return true; //定时$activeTime执行ActiveCWPSSession
		
  
		require_once LIB_PATH."SoapOAS.class.php";
		$oas = new SoapOAS($this->setting['CWPS_Address']); //初始化OAS客户端
		$oas->setTransactionAccessKey($this->setting['CWPS_TransactionAccessKey']); //设置CWPS访问密码

		$oas->setReqCharset(CHARSET);
		$oas->setRespCharset(CHARSET);

		$oas->doLog = false; //是否对SOAP数据包进行记录
		$oas->logFile = "oas.log.".date("Y-m-d").".txt"; //log文件名


		$oas->setTransactionID(time()); //设置事务消息ID
		$Action = "ActiveSession";	
		$params = array( 
			"sId"=> $this->sId,
 			); //传递给接口的参数

		$return = $oas->call($Action, $params); //执行调用

		
		if($return === false) { //执行发生错误,错误处理...
			
			$this->session = $this->guest_session;
			return false;
		} else { //执行成功，$return包含返回的数据
			
			$this->session['CWPS_SessionActiveTime'] = time();
			//print_r($return);
			return true;
		}	
	}

	function tryLogin($sId, $ip)
	{
 
		if(empty($sId)) return false;

		require_once LIB_PATH."SoapOAS.class.php";
		$oas = new SoapOAS($this->setting['CWPS_Address']); //初始化OAS客户端
		$oas->setTransactionAccessKey($this->setting['CWPS_TransactionAccessKey']); //设置CWPS访问密码

		$oas->doLog = false; //是否对SOAP数据包进行记录
		$oas->logFile = "oas.log.".date("Y-m-d").".txt"; //log文件名

		$oas->setReqCharset(CHARSET);
		$oas->setRespCharset(CHARSET);


		$oas->setTransactionID(time()); //设置事务消息ID
		$Action = "QueryUserSession";	
		$params = array( 
			"sId"=> $sId,
 			"Ip"=> $ip,
			); //传递给接口的参数

		$return = $oas->call($Action, $params); //执行调用

		
		if($return === false) { //执行发生错误,错误处理...
		 
			$this->session = $this->guest_session;
			return false;
		} else { //执行成功，$return包含返回的数据
			$this->session = $return;
			$this->syncUser($return);
			$this->registerSession($this->session);
			$this->session['CWPS_SessionActiveTime'] = time();
			//print_r($return);
			return true;
		}


	}

	function syncUser(&$_info) 
	{
		global $table, $db, $plugin_table;
		if(empty($_info['UserID'])) return false;
		$result = $db->getRow("select UserID from {$plugin_table['oas']['user']} where UserID='{$_info['UserID']}'");
		if(!empty($result['UserID'])) return true;
		else {
			$db->query("Replace into {$plugin_table['oas']['user']} (`UserID`,`UserName`) VALUES ('{$_info['UserID']}', '{$_info['UserName']}')");
		}
	
	}

	function login($referer = "")
	{
  		$this->goCWPS($this->setting['PageInterface']['Login'], $referer) ;
 	}


	function logout($referer = "")
	{
		global $db;
		$this->clearCookies() ;	
		$sql = "DELETE FROM {$this->table_session} WHERE sId = '".$this->sId."' AND Ip ='".$this->Ip."'";
		$db->query($sql);
		
		$this->goCWPS($this->setting['PageInterface']['Logout'], $referer) ;
		 
	
	}

	function goPageInterface($_interface, $_referer) 
	{
	  	$this->goCWPS($this->setting['PageInterface']['Portal']."?".$_SERVER["QUERY_STRING"], $_referer) ;

	}

	function isLoginCWPS()
	{
		 
 		$this->goCWPS($this->setting['PageInterface']['IsLogin']) ;
	
	}

	function goCWPS($url, $referer='') 
	{
		
		if(empty($referer)) {
			$port = $_SERVER['SERVER_PORT']==80 ? "" : $_SERVER['SERVER_PORT'];
			$referer = "http://".$_SERVER['SERVER_NAME'].$port.$_SERVER['REQUEST_URI'];
		
		}

		$pos = strpos($url, '?');
		if ($pos === false) {
			$url = $url."?&referer=OAS::".urlencode($referer);
		} else 	$url = $url."&referer=OAS::".urlencode($referer);



 		header("Location: $url");
		exit;
	
	}
}
?>