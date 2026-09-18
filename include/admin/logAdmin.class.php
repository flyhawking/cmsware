<?php
class LogAdmin extends iData{

	/*
	 * 新增登陆日志
	 */
	function addLoginLog($uName, $IP, $state = false)
	{
		global $table;

		if($state == true) $logdata = "$IP - - [".date("Y-m-d H:i:s")."] - - $uName - - OK";
		else $logdata = "$IP - - [".date("Y-m-d H:i:s")."] - - $uName - - Fail";

		$this->addFileLog("login", $logdata);
		
		if($state == true) {
			$this->addData('uName', $uName);
			$this->addData('IP', $IP);
			$this->addData('Time', time());
			if($this->dataInsert($table->log_login))
				return true;
			else return false;		
		}


 	}

	/*
	 * 新增管理日志
	 */
	function addAdminLog($uName, $IP, &$IN)
	{
		global $table;
		include(INCLUDE_PATH .'admin/log.ini.php');
		$requestPathInfo = pathinfo($_SERVER['PHP_SELF']);

		if (array_key_exists($requestPathInfo['basename'], $LOG_MAP)) {
			if(in_array($IN['o'], $LOG_MAP[$requestPathInfo['basename']])) {
				$logdata = "$IP - - [".date("Y-m-d H:i:s")."] - - $uName - -  ".$requestPathInfo['basename']."::".$IN['o']." - - ".preg_replace("/(sId=[0-9a-z]*&)/is", '', $_SERVER["REQUEST_URI"]);
				$this->addFileLog("admin", $logdata);

				$this->addData('uName', $uName);
				$this->addData('IP', $IP);
				$this->addData('Action', $requestPathInfo['basename']."::".$IN['o']);
				$this->addData('ActionURL', preg_replace("/(sId=[0-9a-z]*&)/is", '', $_SERVER["REQUEST_URI"]));
				$this->addData('Time', time());
				if($this->dataInsert($table->log_admin))
					return true;
				else return false;
		
			} else return true;

		} else return true;



 	}

	function addFileLog($type, $data)
	{
		switch($type) {
			case 'login':
				$filename = "login.".date("Ymd").".log.php";
				break;
			case 'admin':
				$filename = "admin.".date("Ymd").".log.php";
				break;
		}



		if(is_writable(SYS_PATH."sysdata/logs")) {
			$filename = SYS_PATH."sysdata/logs/".$filename;
		} else {
			$filename = SYS_PATH."sysdata/".$filename;
		}

		if(!file_exists($filename)) {
			if ($handle = fopen($filename, 'a')) {
				fwrite($handle, "<?php exit('Access Denied!'); ?>\n");
				fclose($handle);
			}		
		}

		if ($handle = fopen($filename, 'a')) {
			fwrite($handle, $data."\n");
			fclose($handle);
		}

	}

	/*
	 * 删除登陆日志
	 */
	function delLoginLog($LogID)
	{
		global $table;
		$which="LogID";
		
		if($this->dataDel($table->log_login,$which,$LogID,$method="="))
			return true;
		else return false;
	
	}


	/*
	 * 删除管理日志
	 */
	function delAdminLog($LogID)
	{
		global $table;
		$which="LogID";
		
		if($this->dataDel($table->log_admin,$which,$LogID,$method="="))
			return true;
		else return false;
	
	}


	/*
	 * 根据时间段删除登陆日志
	 */
	function delLoginLogByTime($start_time, $end_time)
	{
		global $table,$db;
		$result = $db->query("DELETE FROM $table->log_login where Time > $start_time AND Time < $end_time ");
		if($result)
			return true;
		else return false;
	}

	/*
	 * 根据时间段删除管理日志
	 */
	function delAdminLogByTime($start_time, $end_time)
	{
		global $table,$db;
		$result = $db->query("DELETE FROM $table->log_admin where Time > $start_time AND Time < $end_time ");
		if($result)
			return true;
		else return false;
	}


	/*
	 * 读取一段登陆日志数量
	 */
	function getLoginLogRecordNum()
	{
		global $table,$db;
 		$result = $db->getRow("SELECT COUNT(*) as TotalNum FROM $table->log_login ");
 		return $result['TotalNum'];
	}

	/*
	 * 读取一段管理日志数量
	 */
	function getAdminLogRecordNum()
	{
		global $table,$db;
 		$result = $db->getRow("SELECT COUNT(*) as TotalNum FROM $table->log_admin ");
 		return $result['TotalNum'];
	}

	/*
	 * 读取一段登陆日志记录
	 */
	function getLoginLogLimit($start, $offset)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->log_login ORDER BY LogID DESC LIMIT $start, $offset ";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}

	/*
	 * 读取一段管理日志记录
	 */
	function getAdminLogLimit($start, $offset)
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->log_admin ORDER BY LogID DESC LIMIT $start, $offset ";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}

	/*
	 * 搜索一段登陆日志的数量
	 * $params['field']
	 * $params['value']
	 * 
	 * $params['start_time']
	 * $params['end_time']
	 */
	function searchLoginLogRecordNum($params)
	{
		global $table,$db;
		switch($params['field']) {
			case 'uName':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_login where uName='".$params['value']."' ";
 				break;
			case 'IP':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_login where IP='".$params['value']."' ";
 				break;
			case 'Time':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_login where Time > ".$params['start_time']." AND Time < ".$params['end_time'];
 				break;
		}
		$numResult = $db->getRow($sql_count);		
		return $numResult[TotalNum];
	}

	/*
	 * 搜索一段登陆日志记录
	 * $params['field']
	 * $params['value']
	 * $params['start']
	 * $params['offset']
	 * 
	 * $params['start_time']
	 * $params['end_time']
	 */
	function searchLoginLogLimit($params)
	{
		global $table,$db;
		switch($params['field']) {
			case 'uName':
 				$sql  ="SELECT * FROM $table->log_login where uName='".$params['value']."' ORDER BY LogID DESC LIMIT ".$params['start']." , ".$params['offset'] ;
				break;
			case 'IP':
 				$sql  ="SELECT * FROM $table->log_login where IP='".$params['value']."' ORDER BY LogID DESC LIMIT     ".$params['start']." , ".$params['offset'] ;
				break;
			case 'Time':
 				$sql  ="SELECT * FROM $table->log_login where Time > ".$params['start_time']." AND Time < ".$params['end_time']." ORDER BY LogID DESC LIMIT  ".$params['start']." , ".$params['offset'] ;
				break;
		}
 
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}


	/*
	 * 搜索一段管理日志的数量
	 * $params['field']
	 * $params['value']
	 * 
	 * $params['start_time']
	 * $params['end_time']
	 */
	function searchAdminLogRecordNum($params)
	{
		global $table,$db;
		switch($params['field']) {
			case 'uName':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_admin where uName='".$params['value']."' ";
 				break;
			case 'IP':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_admin where IP='".$params['value']."' ";
 				break;
			case 'Action':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_admin where Action='".$params['value']."' ";
 				break;
			case 'Time':
				$sql_count  ="SELECT COUNT(*) as TotalNum FROM $table->log_admin where Time > ".$params['start_time']." AND Time < ".$params['end_time'];
 				break;
		}
		$numResult = $db->getRow($sql_count);		
		return $numResult[TotalNum];
	}

	/*
	 * 搜索一段管理日志记录
	 * $params['field']
	 * $params['value']
	 * $params['start']
	 * $params['offset']
	 * 
	 * $params['start_time']
	 * $params['end_time']
	 */
	function searchAdminLogLimit($params)
	{
		global $table,$db;
		switch($params['field']) {
			case 'uName':
 				$sql  ="SELECT * FROM $table->log_admin where uName='".$params['value']."' ORDER BY LogID DESC LIMIT    ".$params['start']." , ".$params['offset'] ;
				break;
			case 'IP':
 				$sql  ="SELECT * FROM $table->log_admin where IP='".$params['value']."' ORDER BY LogID DESC LIMIT  ".$params['start']." , ".$params['offset'] ;
				break;
			case 'Action':
 				$sql  ="SELECT * FROM $table->log_admin where Action='".$params['value']."' ORDER BY LogID DESC LIMIT  ".$params['start']." , ".$params['offset'] ;
				break;
			case 'Time':
 				$sql  ="SELECT * FROM $table->log_admin where Time > ".$params['start_time']." AND Time < ".$params['end_time']." ORDER BY LogID DESC LIMIT  ".$params['start']." , ".$params['offset'] ;
				break;
		}
 
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}

}

?>