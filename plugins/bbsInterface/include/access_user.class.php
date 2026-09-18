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
class AccessUser extends iData {
	
	function add()
	{
		global $plugin_table;
		if($this->dataInsert($plugin_table['bbsi']['access']))
			return true;
		else return false;	
	}

	function del($AccessID)
	{
		global $plugin_table;
		$which="AccessID";
		
		if($this->dataDel($plugin_table['bbsi']['access'],$which,$AccessID,$method="="))
			return true;
		else return false;
	
	}


	function update($AccessID)
	{
		global $plugin_table;

		$where="where AccessID=".$AccessID;
		if($this->dataUpdate($plugin_table['bbsi']['access'],$where))
			return true;
		else return false;
	
	}

	function getRecordNum()
	{
		global $plugin_table,$db;
		$sql = "SELECT count(*) nr FROM {$plugin_table['bbsi']['access']} ";
		$result = $db->getRow($sql);
		return $result['nr'];
	}		

	function getRecordLimit($start=0, $offset=10)
	{
		global $plugin_table, $bbs_table, $db, $_FieldMapping;

		$sql =  "SELECT a.*,u.{$_FieldMapping['UserTable_UserName']} as UserName FROM {$plugin_table['bbsi']['access']} a, $bbs_table->user u WHERE a.OwnerID=u.{$_FieldMapping['UserTable_UserID']}  AND  a.AccessType=0 Limit $start, $offset ";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}
	

	function getInfo($aId)
	{
		global $plugin_table, $bbs_table, $db, $_FieldMapping;

		$sql  ="SELECT a.*,u.{$_FieldMapping['UserTable_UserName']} as UserName FROM {$plugin_table['bbsi']['access']} a, $bbs_table->user u WHERE a.OwnerID=u.{$_FieldMapping['UserTable_UserID']} AND  AccessID='$aId'   AND  a.AccessType=0 ";
		$result = $db->getRow($sql);
		return $result;
	}


	function userExists($UserName)
	{
		global $plugin_table, $bbs_table, $db, $_FieldMapping;
		$sql  ="SELECT {$_FieldMapping['UserTable_UserID']} as UserID,{$_FieldMapping['UserTable_UserName']} FROM  $bbs_table->user  WHERE {$_FieldMapping['UserTable_UserName']}='$UserName' ";
		$result = $db->getRow($sql);
		if(empty($result[$_FieldMapping['UserTable_UserName']]))
			return false;
		else
			return $result['UserID'];
	
	}

	function accessDefined($UserName)
	{
		global $plugin_table, $bbs_table, $db, $_FieldMapping;
		$sql = "SELECT a.AccessID FROM {$plugin_table['bbsi']['access']} a, $bbs_table->user u WHERE a.OwnerID=u.{$_FieldMapping['UserTable_UserID']}  AND  a.AccessType=0  AND  u.{$_FieldMapping['UserTable_UserName']}='$UserName'  ";
		$result = $db->getRow($sql);
		if(empty($result['AccessID']))
			return false;
		else
			return $result['AccessID'];
	
	
	}




}

?>