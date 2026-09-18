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

	function Access($bbs_name)
	{
		include PLUGINS_PATH.'bbs/'.BBS_NAME.'/bbs.php';

		$this->bbs = new BBS($bbs_name);
		$this->sId = &$this->bbs->sId;
		$this->user = &$this->bbs->user;
		$this->pass = &$this->bbs->pass;
		$this->bbs->ActionMap = &$this->ActionMap;
	}

	function canAccess($NodeID, $Action)
	{
		global $plugin_table, $bbs_table, $db, $_FieldMapping, $iWPC;
		if(!in_array($Action, $this->ActionMap)) {
			$Access->deny_code = 'action_not_exists';
			return false;
		} else {
		
			//debug($this->session);
			$NodeInfo = $iWPC->loadNodeInfo($NodeID);
			$ParentNodeID = explode('%', $NodeInfo[ParentNodeID]);
						

			$sql  ="SELECT {$Action},AuthInherit FROM {$plugin_table['bbsi']['access']}  WHERE OwnerID={$this->bbs->session[GroupID]}  AND  AccessType=1 ";
			$result = $db->getRow($sql);
			if(strpos($result[$Action], ','.$NodeID.','))
				return true;
			else {
				foreach ($ParentNodeID as $var) {
					if(strpos($result[$Action], ','.$var.',') && strpos($result['AuthInherit'], ','.$var.','))
						return true;
					else
						continue;
				}
		
//print_r($this->bbs->session);
				if($this->bbs->session['GroupName'] == 'Guest') return false;

				$sql  ="SELECT {$Action},AuthInherit FROM {$plugin_table['bbsi']['access']}  WHERE OwnerID={$this->bbs->session[UserID]}  AND  AccessType=0 ";
				$result = $db->getRow($sql);
				if(strpos($result[$Action], ','.$NodeID.','))
					return true;
				else {
				
					foreach ($ParentNodeID as $var) {
						if(strpos($result[$Action], ','.$var.',') && strpos($result['AuthInherit'], ','.$var.','))
							return true;
						else
							continue;
					}
				
				}
				
				
				return false;
		
			
			}
		
		
		
		}
			
	}

	function isLogin()
	{
		return $this->bbs->isLogin(); 
	}
}

?>