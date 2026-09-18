<?php
/**
CREATE TABLE `cmsware_plugin_bbsi_access` (
  `AccessID` int(10) NOT NULL auto_increment,
  `AccessType` int(1) NOT NULL default '0', #0为用户权限，1为用户组权限
  `Info` text NOT NULL,
  `OwnerID` int(10) NOT NULL default '0',
  `ReadIndex` text NOT NULL,
  `ReadContent` text NOT NULL,
  `PostComment` text NOT NULL,
  `ReadComment` text NOT NULL,
  PRIMARY KEY  (`AccessID`,`AccessType`),
  KEY `PermissionType` (`AccessType`,`OwnerID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;


 * Permission 
 * 1.ReadIndex   浏览首页
 * 1.ReadContent 浏览内容页
 * 2.PostComment 发表评论
 * 3.ReadComment 查看评论
 * ------------非必须-----------
 * 4.Grade 评分
 * 5.Contribution 用户投稿 -----非必须
 * 6.Recommend 用户推荐(邮件发送) -----非必须
 *
 *
 */
class AccessUser extends SqlMap {
	
	function AccessUser()
	{
		$this->_basefile = __FILE__;
	}
	
	function getRecordNum()
	{
 		$this->startTransaction();
		$result = $this->queryForObject("getRecordNum");
		return $result['nr'];
	}		

	function getRecordLimit($start=0, $offset=10, &$oas)
	{

 		$this->startTransaction();
		$this->addData("start", $start);
		$this->addData("offset", $offset);
		$userList = $this->queryForList("getRecordLimit");

		$userIds = "";
		foreach($userList as $key=>$var) {
			if(empty($key)) $userIds = $var['OwnerID'];
			else $userIds .=",".$var['OwnerID'];
		}


		$oas->setTransactionID(time()); 
		$oas->setDataEncode(false);
		$return = $oas->call("GetUserListByUserIDs", array("UserIDs"=> $userIds)); //执行调用

		if($return === false) {
			$oas->error();
		} else {
			$returnUserList = $oas->unserialize($return['List']);
		}

		foreach($userList as $key=>$var) {
 			$userList[$key] = array_merge($var, $returnUserList[$var['OwnerID']]);
		}

		//print_r($userList);
		
 		return $userList;

	}
	
	

	function getInfo($aId, &$oas)
	{
		if(empty($aId)) return false;

 		$this->startTransaction();
		$this->addData("AccessID", $aId);
		$userInfo = $this->queryForObject("getAccessInfoByAccessID");
		
		$oas->setTransactionID(time()); 
		
		$oas->setDataEncode(false);
		$params['UserID'] = $userInfo['OwnerID'];
		$return = $oas->call("GetUserInfo", $params); //执行调用
 		if($return === false) {
			$oas->error();
			
		} else {
 			$userInfo = array_merge($userInfo, $oas->unserialize($return['Info']));
		}

	 	$this->startTransaction();
		$this->addData("AccessID", $aId);
		$accessMap = $this->queryForList("getAccessMapByAccessID");

		foreach($accessMap as $var) {
			$userInfo[$var['PermissionKey']] = $var['AccessNodeIDs'];
		}
		//print_r($userInfo);
 		return $userInfo;

	}


	function userExists($UserName, &$oas)
	{
		$oas->setTransactionID(time()); 

		$return = $oas->call("IsUserExists", array("UserName"=>$UserName)); //执行调用

		if($return === false) {
			$oas->error();	
		} else {
			 
 			if(empty($return['ok'])) return false;
			else return $return['ok'];
		}

	
	}

	function accessDefined($UserName, &$oas)
	{
		$oas->setTransactionID(time()); 

		$return = $oas->call("IsUserExists", array("UserName"=>$UserName)); //执行调用
		
		if($return === false) {
			$oas->error();	
		} else {		 
 			$UserID = $return['ok'];
		}
   
	 	$this->startTransaction();
		$this->addData("UserID", $UserID);
		$accessInfo = $this->queryForObject("getAccessInfoByUserID");
		if(empty($accessInfo['AccessID'])) return false;
		else return true;
	}




}

?>