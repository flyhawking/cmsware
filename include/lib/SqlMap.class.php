<?php

class SqlMap {

	/**
	* 内部POJO数组
	* 对PHP我们使用数组来保存POJO的属性,相比一个个getter/setter会方便很多,同时达到同样的目的,何必拘泥呢:)
	*/
	var $_db = NULL; //datasource
	var $_basefile = NULL;
	var $_pojo = array();
	var $_sqlmap_select = array();
	var $_sqlmap_update = array();
	var $_sqlmap_delete = array();
	var $_sqlmap_insert = array();
	var $_contextIsLoaded = false;
	var $_debug = false;
	

	/**
	* 初始化SQLMAP
	*/
	function SqlMap($_context_bundle, $_auto_start = false)
	{
		global $table;
		if(file_exists($_context_bundle)) {
			include($_context_bundle);
			$this->_sqlmap_select = $_sqlMap_select;
			$this->_sqlmap_update = $_sqlMap_update;
			$this->_sqlmap_delete = $_sqlMap_delete;
			$this->_sqlmap_insert = $_sqlMap_insert;
			unset($_sqlMap_select);
			unset($_sqlMap_update);
			unset($_sqlMap_delete);
			unset($_sqlMap_insert);

			$this->_contextIsLoaded = true;
			if($_auto_start) $this->startTransaction();
		}
	}

	/**
	* 读取sqlmap配置文件并加载context 
	*/
	function startTransaction()
	{
		global $table;

		if(!$this->_contextIsLoaded) {
			include(str_replace(".php", "-sqlmap.php", $this->_basefile));
			$this->_sqlmap_select = $_sqlMap_select;
			$this->_sqlmap_update = $_sqlMap_update;
			$this->_sqlmap_delete = $_sqlMap_delete;
			$this->_sqlmap_insert = $_sqlMap_insert;

			unset($_sqlMap_select);
			unset($_sqlMap_update);
			unset($_sqlMap_delete);
			unset($_sqlMap_insert);

			$this->_contextIsLoaded = true;
		}

		if(is_null($this->_db)) {
			if(!empty($GLOBALS['db'])) $this->_db = &$GLOBALS['db'];
			else $this->error("global datasource is null ");
		}  

		$this->_pojo = array();
	}

	function commitTransaction()
	{
	
	}


	/**
	* 为POJO数组添加数据
	*
	* @param $_data 键名 为数组时会自动合并数组
	* @param $_val 键值
	* @access public
	* @return void
	*/
	function addData($_data, $_val = NULL)
	{
		if(is_array($_data)) {
			foreach($_data as $key=>$var) {
				$this->_pojo[$key] = $this->_db->escape_string($var);
			}
		} else {
			$this->_pojo[$_data] = $this->_db->escape_string($_val);
		
		}
	}

	/**
	* 删除数据
	*
	* @param $_key 键名
	* @access public
	* @return void
	*/
	function delData($_key)
	{
		unset($this->_pojo[$_key]);
	}


	/**
	* 自动使用$IN中数据进行绑定填充.
	* 约定:$IN的键名必须以data_开头
	*
	* @param $IN HttpRequest Array
	* @access public
	* @return void
	*/
	function filterData(&$IN, $_prefix = "data_")
	{
		if(!is_array($IN)) return false;

		foreach($IN as $key=>$var) {
			if(substr($key, 0, 5) == $_prefix) {
				$field = substr($key, 5);
				$this->addData($field, $var);
			} else
				continue;
		}
	}

	function getData()
	{
		return $this->_pojo;
	}

	
	/**
	* 编译处理SQL
	* 如果包含sql_processor还要执行sql_processor
	*
	* @param $_sqlmap
	* @param $_escape_str
	* @access private
	* @return 
	*/
	function _processQueryStr($_sqlmap, $_escape_str = false)
	{

		if(is_array($_sqlmap)) {
			$sql = $_sqlmap['sql'];
			if(isset($_sqlmap['sql_processor'])) {
				$sql_p = $_sqlmap['sql_processor'];
				if(preg_match_all("/#([a-zA-Z0-9_]+)#/isU", $sql_p, $matches)) {
					foreach($matches[0] as $key=>$var) {
						$sql_p = str_replace($var, '$this->_pojo[\''.$matches[1][$key].'\']', $sql_p);
					}
				}
				eval($sql_p);
			}
		} else {
			$sql = $_sqlmap;
		}


		

		if(preg_match_all("/#([a-zA-Z0-9_]+)#/isU", $sql, $matches)) {
			foreach($matches[0] as $key=>$var) {
				if($_escape_str) {
					$sql = str_replace($var, $this->_db->escape_string($this->_pojo[$matches[1][$key]]), $sql);
				} else {
					$sql = str_replace($var, $this->_pojo[$matches[1][$key]], $sql);
				}
			}
		}


		if($this->_debug) exit($sql);

		return $sql;
	}


	/**
	* 执行数据插入
	* 用于自定义insert语句的执行
	* 
	* 	$User = new User();
	* 	$User->startTransaction();
	* 	$User->addData("UserName", "''Hawking");
	* 	$User->insert("user");
	* 	
	* 	$_sqlMap_insert = array(
	* 		'user'=> array(
	* 			'table'=> $table->user,
	* 			'sql'=>"insert into {$table->user} values(#UserName#)"),
	* 	
	* 	);
	* 	
	* 使用$_sqlMap_insert['user']['sql']
	* 
	* @param $_queryid sqlmap语句的id
	* @param $_pojo POJO数组
	* @access public
	* @return bool
	*/
	function insert($_queryid, $_pojo = NULL)
	{
		$escape_string = false;

		if(!empty($_pojo)) {
			$this->_pojo = $_pojo;
			$escape_string = true;
		}

		if(!isset($this->_sqlmap_insert[$_queryid])) $this->error("Insert queryid $_queryid does not exists");
		
		$sql = $this->_processQueryStr($this->_sqlmap_insert[$_queryid], $escape_string);

		return $this->_db->query($sql);
	}

	/**
	* 执行数据插入
	* 自动构建insert语句并执行,大部分情况下insert、update、delete使用自动构建更加方便
	* 自定义sql的执行主要用于select或者复杂的数据维护
	* 
	* 	$User = new User();
	* 	$User->startTransaction();
	* 	$User->addData("UserName", "''Hawking");
	* 	$User->dataInsert("user");
	* 
	* 	$_sqlMap_insert = array(
	* 		'user'=> array(
	* 			'table'=> $table->user,
	* 			'sql'=>"insert into {$table->user} values(#UserName#)"),
	* 	
	* 	);
	* 	
	* 使用 $_sqlMap_insert['user']['table']
	* 	
	* @param $_queryid sqlmap语句的id
	* @access public
	* @return bool
	*/
	function dataInsert($_queryid)
	{
		if(!isset($this->_sqlmap_insert[$_queryid])) $this->error("Insert queryid $_queryid does not exists");
		
		if(is_array($this->_sqlmap_insert[$_queryid])) {
			$table_name = $this->_sqlmap_insert[$_queryid]['table'];
		} else {
			$this->error("Insert queryid $_queryid do not have  the table name defined");
		}		

		$insData_Num = count($this->_pojo); 
		$Foreach_I = 0;
		$query = "Insert into ".$table_name." \n(\n";
		$query_key = "";
		$query_val = "";
		foreach($this->_pojo as $key=>$val){
			if(strlen($val)>0){
				if($Foreach_I == 0){
					$query_key .= '`'.$key.'`';
					$query_val .= "'".$val."'";
				}else{
					$query_key .= ",\n".'`'.$key.'`';
					$query_val .= ",\n'".$val."'";
				}
				$Foreach_I = $Foreach_I + 1;
			}
		}
		$query .=$query_key."\n) \nValues \n(\n".$query_val."\n)";
		
		if(empty($query)) $this->error("query is empty");
		
		if($result = $this->_db->query($query)){
 			$this->db_insert_id=$this->_db->Insert_ID();
			return true;
		}else return false;
	
	}

	function dataReplace($_queryid)
	{
		if(!isset($this->_sqlmap_insert[$_queryid])) $this->error("Insert queryid $_queryid does not exists");
		
		if(is_array($this->_sqlmap_insert[$_queryid])) {
			$table_name = $this->_sqlmap_insert[$_queryid]['table'];
		} else {
			$this->error("Insert queryid $_queryid do not have  the table name defined");
		}		

		$insData_Num = count($this->_pojo); 
		$Foreach_I = 0;
		$query = "Replace into ".$table_name." \n(\n";
		$query_key = "";
		$query_val = "";
		foreach($this->_pojo as $key=>$val){
			if(strlen($val)>0){
				if($Foreach_I == 0){
					$query_key .= '`'.$key.'`';
					$query_val .= "'".$val."'";
				}else{
					$query_key .= ",\n".'`'.$key.'`';
					$query_val .= ",\n'".$val."'";
				}
				$Foreach_I = $Foreach_I + 1;
			}
		}
		$query .=$query_key."\n) \nValues \n(\n".$query_val."\n)";
		
		if(empty($query)) $this->error("query is empty");
		
		if($result = $this->_db->query($query)){
 			$this->db_insert_id=$this->_db->Insert_ID();
			return true;
		}else return false;
	
	}


	function update($_queryid, $_pojo = NULL)
	{
		$escape_string = false;

		if(!empty($_pojo)) {
			$this->_pojo = $_pojo;
			$escape_string = true;
		}

		if(!isset($this->_sqlmap_update[$_queryid])) $this->error("Update queryid $_queryid does not exists");
		
		$sql = $this->_processQueryStr($this->_sqlmap_update[$_queryid], $escape_string);

		return $this->_db->query($sql);
	}


	/**
	* 针对setting表的key=>value键值对应关系进行数据更新
	* 将同时更新 sizeof($this->_pojo) 条记录
	*
	* @param 
	* @access public
	* @return bool
	*/
	function settingUpdate($_queryid)
	{
		if(!isset($this->_sqlmap_update[$_queryid])) $this->error("Update queryid $_queryid does not exists");
		if(is_array($this->_sqlmap_update[$_queryid])) {
			$table_name = $this->_sqlmap_update[$_queryid]['table'];
		} else {
			$this->error("Update queryid $_queryid do not have  the table name defined");
		}

		foreach($this->_pojo as $key=>$val) {
			$sql = "Replace Into $table_name Values('".$key."', '".$val."')";
			if($this->_db->query($sql)){
				$return = true;
			} else $return = false;
		}

		return $return;
	}

	function dataUpdate($_queryid)
	{
		if(!isset($this->_sqlmap_update[$_queryid])) $this->error("Update queryid $_queryid does not exists");
		
		if(is_array($this->_sqlmap_update[$_queryid])) {
			$table_name = $this->_sqlmap_update[$_queryid]['table'];
			if(!empty($this->_sqlmap_update[$_queryid]['where'])) {
				$where = " Where ".$this->_sqlmap_update[$_queryid]['where'];
			}
			
		} else {
			$this->error("Update queryid $_queryid do not have  the table name defined");
		}

		//foreach($this->_pojo as $key=>$var) {
		//	$where = str_replace("#".$key."#", "'".$var."'", $where);
		//}

		$where = $this->_processQueryStr($where);
		
		$Foreach_I = 0;  
     	$query = "update ".$table_name." set ";
     	$query_key = "";
     	$query_val = "";
		foreach($this->_pojo as $key=>$val) {
			if(strlen($val)>=0) { //为空则不插入,否则出错
				if($Foreach_I == 0) {
					$query_key = '`'.$key.'`';
					$query_val = "='".$val."'";
					$query .= $query_key.$query_val;
				} else {
					$query_key = ",".'`'.$key.'`';
					$query_val = "='".$val."'";
					$query .= $query_key.$query_val;
				}

				$Foreach_I = $Foreach_I + 1;
			}
		}

		$query .= $where;
		if(empty($query)) $this->error("query is empty");
		//exit($query);
		if($this->_db->query($query)){
			return true;
		} else return false;

	}

	function del($_queryid, $_pojo = NULL)
	{
		$escape_string = false;

		if(!empty($_pojo)) {
			$this->_pojo = $_pojo;
			$escape_string = true;
		}

		if(!isset($this->_sqlmap_delete[$_queryid])) $this->error("Delete queryid $_queryid does not exists");
		
		$sql = $this->_processQueryStr($this->_sqlmap_delete[$_queryid], $escape_string);

		return $this->_db->query($sql);	
	}


	function dataDel($_queryid)
	{
		if(!isset($this->_sqlmap_delete[$_queryid])) $this->error("Delete queryid $_queryid does not exists");
		
		if(is_array($this->_sqlmap_delete[$_queryid])) {
			$table_name = $this->_sqlmap_delete[$_queryid]['table'];
			$where = " Where ".$this->_sqlmap_delete[$_queryid]['where'];
		} else {
			$this->error("Delete queryid $_queryid do not have  the table name defined");
		}

		//foreach($this->_pojo as $key=>$var) {
		//	$where = str_replace("#".$key."#", "'".$var."'", $where);
		//}		
		
		$where = $this->_processQueryStr($where);

		$query = "Delete From ".$table_name;
		$query .= $where;
	
		if(empty($query)) $this->error("query is empty");

		if($this->_db->query($query)){
			return true;
		} else return false;

	}


	function queryForObject($_queryid, $_pojo = NULL)
	{
		$escape_string = false;

		if(!empty($_pojo)) {
			$this->_pojo = $_pojo;
			$escape_string = true;
		}

		if(!isset($this->_sqlmap_select[$_queryid])) $this->error("Select queryid $_queryid does not exists");
		
		$sql = $this->_processQueryStr($this->_sqlmap_select[$_queryid], $escape_string);

		if(empty($sql)) $this->error("query is empty");

		$result = $this->_db->getRow($sql);
		if(empty($result)) return false;
		else return $result;
	}

	function queryForList($_queryid, $_pojo = NULL)
	{
		$escape_string = false;
		$data = array();

		if(!empty($_pojo)) {
			$this->_pojo = $_pojo;
			$escape_string = true;
		}

		if(!isset($this->_sqlmap_select[$_queryid])) $this->error("Select queryid $_queryid does not exists");
				
		$sql = $this->_processQueryStr($this->_sqlmap_select[$_queryid], $escape_string);

		
		if(empty($sql)) $this->error("query is empty");


		$result = $this->_db->Execute($sql);

		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}

		return $data;
	}

	function queryForSettingMap($_queryid, $_pojo = NULL)
	{
		$escape_string = false;
		$data = array();

		if(!empty($_pojo)) {
			$this->_pojo = $_pojo;
			$escape_string = true;
		}

		if(!isset($this->_sqlmap_select[$_queryid])) $this->error("Select queryid $_queryid does not exists");
				
		$sql = $this->_processQueryStr($this->_sqlmap_select[$_queryid], $escape_string);

		if(empty($sql)) $this->error("query is empty");

		if(is_array($this->_sqlmap_select[$_queryid]['map'])) {

			foreach($this->_sqlmap_select[$_queryid]['map'] as $key=>$var) {
				$map_key = $key;
				$map_value = $var;
			}
		} else {
			$map_key = "key";
			$map_value = "value";
		}
		

		$result = $this->_db->Execute($sql);

		while(!$result->EOF) {
			$data[$result->fields[$map_key]] = $result->fields[$map_value];
			$result->MoveNext();
		}

		return $data;
	}


	/**
	* 触发错误 
	*/
	function error($_msg)
	{
		trigger_error("SqlMap Error : ".$_msg, E_USER_ERROR);
	}

	function setDebug($_debug)
	{
		$this->_debug = $_debug;
	}
}
?>