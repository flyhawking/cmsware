<?php
function kAddslashes($string, $force = 0) {
	if(!$GLOBALS['magic_quotes_gpc'] || $force) {
		if(is_array($string)) {
			foreach($string as $key => $val) {
				$string[$key] = kaddslashes($val, $force);
			}
		} else {
			$string = addslashes($string);
		}
	}
	return $string;
}

function random($length) {
	$hash = '';
	$chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
	$max = strlen($chars) - 1;
	mt_srand((double)microtime() * 1000000);
	for($i = 0; $i < $length; $i++) {
		$hash .= $chars[mt_rand(0, $max)];
	}
	return $hash;
}


class Access {
	var $GuestGroupID = 1; //默认Guest的GroupID使用CWPS的设置GroupID=1
	var $sId = '';
	var $user = '';
	var $pass = '';
	var $bbs = '';
	var $ActionMap = array(
		'ReadIndex',
		'ReadContent',
		'PostComment',
		'ReadComment',
		);

	function Access(&$oas)
	{	
 		//自动CWPS登陆获取UserSession,否则得到GuestSession
		$this->oas = &$oas;

		$this->sId = &$this->oas->sId;
		$this->user = &$this->oas->user;
		$this->pass = &$this->oas->pass;
		$this->oas->ActionMap = &$this->ActionMap;
	}

	function canAccess($NodeID, $Action)
	{
		
		//如果是GuestSession,判断Guest是否有权限
		if($this->_canAccess($NodeID, $Action)) return true;
		else {
			if(!$this->oas->isLogin() && !$this->oas->fromCWPS) {
 				//$this->oas->login();
			}
			return false;
		}
	}

	function _canAccess($NodeID, $Action)
	{
		global $plugin_table, $bbs_table, $db, $_FieldMapping, $iWPC;
		//if(!in_array($Action, $this->ActionMap)) {
		//	echo "A";
		//	$Access->deny_code = 'action_not_exists';
		//	return false;
		//} else {
		
			//debug($this->session);
			$NodeInfo = $iWPC->loadNodeInfo($NodeID);
			$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
						

			$sql  ="SELECT m.AccessNodeIDs,a.AccessInherit FROM {$plugin_table['oas']['access']} a, {$plugin_table['oas']['access_map']} m  WHERE a.OwnerID={$this->oas->session[GroupID]}  AND  a.AccessType=1 AND a.AccessID=m.AccessID AND m.PermissionKey='{$Action}'";
			$result = $db->getRow($sql);
			 
			if(strpos($result['AccessNodeIDs'], ','.$NodeID.',')) {
				return true;
			} else {
				//Group AuthInherit
				foreach ($ParentNodeID as $var) {
					if(strpos($result['AccessNodeIDs'], ','.$var.',') && strpos($result['AccessInherit'], ','.$var.','))
						return true;
					else
						continue;
				}

				//用户组无权限，检测是否用户权限有定义
				if(!empty($this->oas->session[UserID])) {
					$sql  ="SELECT m.AccessNodeIDs,a.AccessInherit FROM {$plugin_table['oas']['access']} a, {$plugin_table['oas']['access_map']} m  WHERE a.OwnerID={$this->oas->session[UserID]}  AND  a.AccessType=0 AND a.AccessID=m.AccessID AND m.PermissionKey='{$Action}'";
					$result = $db->getRow($sql);
					if(strpos($result['AccessNodeIDs'], ','.$NodeID.','))
						return true;
					else {
						//User AuthInherit
						foreach ($ParentNodeID as $var) {
							if(strpos($result['AccessNodeIDs'], ','.$var.',') && strpos($result['AccessInherit'], ','.$var.','))
								return true;
							else
								continue;
						}
					
					}	
				}
 
				
				//Noting Access Defined, then return false
				return false;
		
			
			}  
		
		
		
		//}
			
	}

	function isLogin()
	{
		return $this->oas->isLogin(); 
	}
}

?>