<?php

class AccessGroup extends SqlMap {
	
	function AccessGroup()
	{
		$this->_basefile = __FILE__;
	
	}

	function getAll(&$oas)
	{

		$oas->setTransactionID(time()); 
		$oas->setDataEncode(false);
		$return = $oas->call("GetAllGroup"); //执行调用

		if($return === false) {
			$oas->error();
		} else {
			$groupList = $oas->unserialize($return['List']);
		}

		foreach($groupList as $key=>$var) {
			$this->startTransaction();
			$this->addData("GroupID", $var['GroupID']);
			$groupList[$key] = array_merge($var, $this->queryForObject("getAccessInfoByGroupID")) ;
		}
		
		return $groupList;
	}
	

	function getInfo($aId, &$oas)
	{
		if(empty($aId)) return false;

 		$this->startTransaction();
		$this->addData("AccessID", $aId);
		$groupInfo = $this->queryForObject("getAccessInfoByAccessID");
		
		$oas->setTransactionID(time()); 
		$oas->setDataEncode(false);
		$params['GroupID'] = $groupInfo['OwnerID'];
		$return = $oas->call("GetGroupInfo", $params); //执行调用

		if($return === false) {
			$oas->error();
		} else {
 			$groupInfo = array_merge($groupInfo, $oas->unserialize($return['Info']));
		}

		$this->startTransaction();
		$this->addData("AccessID", $aId);
		$accessMap = $this->queryForList("getAccessMapByAccessID");

		foreach($accessMap as $var) {
			$groupInfo[$var['PermissionKey']] = $var['AccessNodeIDs'];
		}


 		return $groupInfo;

	}

}

?>