<?php
import("KF.Util.Observable");
//所有SQL会封装在Domain和DAO里面，利于多数据库切换
//Domain已经封装了CRUD和基础DAO方法，其它被封装在DAO里面
//Domain中封装了所有Fields，同样DAO中应该也封装，而mapping的数据DAO应该去Domain里面取得
//数据表的Fields对于逻辑层应该不可见

//Active Record Pattern, Rich Domain Model
class KF_DB_DomainModel extends KF_Util_Observable{
	var $_vars;//用于缓存get_object_vars返回的变量数组
	var $_vars_loaded = false;

	function create() {

	}

	function update($IndexID) {
	}

	function del($IndexID) {
	}

	function get($IndexID) {
	}

	/*
	$params['campID'] = "1";
	$params['campName'] = "test_name";
	*/
	function updateBy($params) {
	}

	function delBy($params) {
	}

	function getBy($params) {
	}


	function findAll($params, $start = 0, $end = 0) {

	}
	
	// campID=? AND campName=? OR campID=?
	function findOne($params, $kql = "") {
	
	}


	function _init() {
		if($this->_vars_loaded === true) return true;

		$this->_vars = get_object_vars($this);
		$this->_vars_loaded = true;

		return true;
	}

	function setVar($varName, $varValue) {
		
	}

	function getVar($varName) {

	}

	function toArray() {
		$return = array();
		foreach($this->_vars as $var) {
			if(substr($var, 1) == '_' ) continue;
			$return[$var] = $this->$var;
		}

		return $return;
	}

}
?>