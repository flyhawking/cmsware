<?php
class psn_admin extends iData{

	function add()
	{
		global $table;
		if($this->dataInsert($table->psn))
			return true;
		else return false;	
	}

	function del($PSNID)
	{
		global $table;
		$which="PSNID";
		
		if($this->dataDel($table->psn,$which,$PSNID,$method="="))
			return true;
		else return false;
	
	}


	function update($PSNID)
	{
		global $table;

		$where="where PSNID=".$PSNID;
		if($this->dataUpdate($table->psn,$where))
			return true;
		else return false;
	
	}

	function getPSNInfo($PSNID)
	{
		global $table,$db;

		$sql  ="SELECT * FROM $table->psn  WHERE PSNID='$PSNID'";
		
		$result = $db->getRow($sql);
		return $result;
	}

	function getAllPSN()
	{
		global $table,$db;
		$sql  ="SELECT * FROM $table->psn";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}

	function parsePSN($psn)
	{	


		$patt = "/file::(.*)/si";
		if (preg_match($patt, $psn, $matches)) 
		{	
			$output[publish_path] = $matches[1];
			
			$output[publish_type] = 'local';

			return $output;

		} 

		$patt = "/relate::(.*)/si";
		if (preg_match($patt, $psn, $matches)) 
		{	
			$output[publish_path] = $matches[1];
			
			$output[publish_type] = 'local';
			

			return $output;

		} 


		$patt = "/ftp::([^:]+):(.*)@([a-zA-Z0-9-_\.]+):([0-9]+)(.*)/si";
		if (preg_match($patt, $psn, $matches)) 
		{	
			$output[publish_path] = $matches[5];
			
			$output[publish_type] = 'ftp';
			$output[publish_ftp_host] = $matches[3];
			$output[publish_ftp_port] = $matches[4];
			$output[publish_ftp_user] = $matches[1];
			$output[publish_ftp_pass] = $matches[2];
			
			return $output;


		} 
		//debug($output);exit;

	}
	
	function haveSon($NodeID)
	{
		global $table,$db;

		$sql  ="SELECT count(*) as nr FROM $table->site  WHERE cFId='$NodeID'  AND disabled=0";

		$result = $db->getRow($sql);

		if($result[nr]>0) return true;
		else return false;
	
	}

	function getAll4Tree($cFId = 0)
	{
		global $table,$db;
		$sql  ="SELECT NodeID,cName,cFId FROM $table->site where cFId=$cFId  AND disabled=0";

		$result = $db->Execute($sql);
		while(!$result->EOF) {

			if($this->haveSon($result->fields[NodeID])) 
				$haveSon = 1;
			else
				$haveSon = 0;
			$data[] = array(
				'NodeID'=> $result->fields[NodeID],
				'cName'=> $result->fields[cName],
				'cFId'=> $result->fields[cFId],
				'haveSon'=> $haveSon,
			
			);
			$result->MoveNext();

		}
		
		return $data;
	
	}
/*
			$output[publish_path] = 'ftp';
			$output[publish_type] = 'ftp';
			$output[publish_ftp_host] = $matches[3];
			$output[publish_ftp_port] = $matches[4];
			$output[publish_ftp_user] = $matches[1];
			$output[publish_ftp_pass] = $matches[2];

*/
	function connect($PSN)
	{
		$psnInfo = $this->parsePSN($PSN);
		$this->PSN = $PSN;
		$this->psnInfo = $psnInfo;
		switch($psnInfo[publish_type]) {
			case 'local':
				break;
			case 'ftp':
				$this->_ftp_connect();
				break;
		}

	}
	
	function close()
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return true;
				break;
			case 'ftp':
				return $this->_ftp_close();
				break;
		}
	
	}

	function _ftp_close()
	{
		return ftp_close($this->conn_id);
	}
	function _ftp_connect()
	{
			if (function_exists('ftp_connect')) {
				$mode = decoct($mode);
				if (strlen($mode) == 4)
					$mode = substr($mode,1);

				$this->conn_id = @ftp_connect($this->psnInfo['publish_ftp_host'], $this->psnInfo['publish_ftp_port']); 
				
				// login with username and password		
				$login_result = @ftp_login($this->conn_id, $this->psnInfo['publish_ftp_user'], $this->psnInfo['publish_ftp_pass']); 
				
				if ((!$this->conn_id) || (!$login_result)) { 
					echo "<font color=red>FTP connection has failed!</font><br>Attempted to connect to {$this->psnInfo['publish_ftp_host']}:{$this->psnInfo['publish_ftp_port']} for user {$this->psnInfo['publish_ftp_user']}.<br>";
					echo "Please reset you FTP accounts correctly in your iWPC system setting."; 
					exit; 
				} else {
					// connected!
				}
			} else {
				echo 'The FTP module can not found,Please contact to you web administrator to install it' ;
				return false;
			}
	}

	function listFile($path = NULL)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_list($path);
				break;
			case 'ftp':
				return $this->_ftp_list($path);
				break;
		}

	}

	function mkDir($dirname, $mode = 777)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_mkdir($dirname, $mode);
				break;
			case 'ftp':
				return $this->_ftp_mkdir($dirname, $mode);
				break;
		}

	}

	function _mkdir($dirname, $mode)
	{
		if(@mkdir($this->psnInfo[publish_path] .'/'. $dirname, $mode))
			return true;
		else 
			return false;
	}

	function _ftp_mkdir($dirname, $mode)
	{
		if(ftp_mkdir($this->conn_id, $this->psnInfo[publish_path] .'/'. $dirname)) {
			ftp_site($this->conn_id,"CHMOD $mode ". $this->psnInfo[publish_path] .'/'. $dirname);
					//echo ftp_pwd($conn_id); 
			return true;
		} else {
			return false;
		}
	
	}

	function delFile($filename)
	{
		//debug($this->psnInfo);
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_delFile($filename);
				break;
			case 'ftp':
				return $this->_ftp_delFile($filename);
				break;
		}		
	}
	
	function _delFile($filename)
	{
		if(@unlink($this->psnInfo[publish_path] .$filename))
			return true;
		else
			return false;
	}

	function _ftp_delFile($filename)
	{
		if(ftp_delete ($this->conn_id, $this->psnInfo[publish_path] .$filename))
			return true;
		else
			return false;

	}

	function upload($filename, $destination)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_upload($filename, $destination);
				break;
			case 'ftp':
				return $this->_ftp_upload($filename, $destination);
				break;
		}	
	
	}

	function _upload($filename, $destination)
	{
		$path = $this->psnInfo[publish_path] .$destination;
		$pathInfo = pathinfo($path);

		CMSware_mkDir($pathInfo['dirname']);
		if(copy($filename, $path)) {
			$this->logIt($destination, 'binary');
			return true;
		
		}
		else
			return false;
	}

	function _ftp_upload($filename, $destination)
	{
		$path = $this->psnInfo[publish_path] .$destination;
		$pathInfo = pathinfo($path);
		//echo $path;exit;
		$this->ftpMakeDir($pathInfo['dirname']);
		if(ftp_put($this->conn_id, $path, $filename, FTP_BINARY)) {
			$this->logIt($destination, 'binary');
			return true;
		} else {
			return false;
		}
	}
	function put($filename, &$content)
	{
		//debug($this->psnInfo);
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_put($filename, $content);
				break;
			case 'ftp':
				return $this->_ftp_put($filename, $content);
				break;
		}	
	}

	function _put($filename, &$content)
	{
		$path = $this->psnInfo[publish_path] .$filename;
		$pathInfo = pathinfo($path);

		CMSware_mkDir($pathInfo['dirname']);
		if(writeFile($path, $content)) {
			$this->logIt($filename, 'text');
			return true;
		
		}
		else
			return false;
	}

	function _ftp_put($filename, &$content)
	{
		$path = $this->psnInfo[publish_path] .$filename;
		$pathInfo = pathinfo($path);
		//echo $path;exit;
		$this->ftpMakeDir($pathInfo['dirname']);
		$tmpFile = $this->makeTmpFile($content);
		if(ftp_put($this->conn_id, $path, $tmpFile, FTP_ASCII)) {
			$this->logIt($filename, 'text');
			@unlink($tmpFile);
			return true;
		} else {
			@unlink($tmpFile);
			return false;
		}
	}

	function logIt($FileName, $Type)
	{
		global $table;
		//logID  IndexID  PSN  FileName  TYPE  URL  
		$this->flushData();
		$this->addData('IndexID', $this->sendVar[IndexID]);
		$this->addData('ContentID', $this->sendVar[ContentID]);
		$this->addData('NodeID', $this->sendVar[NodeID]);
		$this->addData('PSN', $this->PSN);
		$this->addData('FileName', $FileName);
		$this->addData('Type', $Type);
		if($this->logExits()) {
			return true;		
		} else {
			if($this->dataInsert($table->publish_log))
				return true;
			else return false;	
		
		}
	}

	function logExits()
	{	
		global $db,$table;
		$sql = "SELECT logID  FROM $table->publish_log  WHERE IndexID={$this->insData[IndexID]} AND PSN='{$this->insData[PSN]}' AND FileName='{$this->insData[FileName]}'"	;
		$result = $db->getRow($sql);
		if(!empty($result[logID]))
			return true;
		else 
			return false;

	}

	/**
     * Method: makeTmpFile(&$content)
     * 生成临时文件,用于FTP文件上传操作(远程发布).
     * @param string $content
	 * @return boolean or string
     */
	function makeTmpFile(&$content)
	{
		$tmpfilename = CACHE_DIR.Auth::makeSessionKey();
		if(writeFile($tmpfilename, $content))
			return $tmpfilename;
		else
			return false;
	}
	/**
     * Method: ftpMakeDir($directory, &$conn_id)
     * 生成FTP文件目录结构.
     * @param string $directory, resource $conn_id
	 * @return boolean
     */
	function ftpMakeDir($directory)
	{			$pwd = ftp_pwd($this->conn_id);
				if(@ftp_chdir($this->conn_id,$directory)) {
					@ftp_chdir($this->conn_id,$pwd);
					return true;
				}
				$dirinfo =pathinfo($directory);
				//debug($dirinfo);
				if(!@ftp_chdir($this->conn_id,$dirinfo["dirname"])) {
					$pathInfo = explode("/",$dirinfo["dirname"]);
					$basedir="";
					foreach($pathInfo as $var) {
						if($var == '') {
							continue;
						}else {

							//debug($basedir.$var);

							if ($this->ftpMakeDir( $dirinfo["dirname"]) ) {
								echo "Repair ${basedir}${var} OK<br>";
							} else {
								echo "Repair ${basedir}${var} Fail<br>";
							}
						}
					}
					
				}
				//debug($dirinfo);
				if(ftp_mkdir($this->conn_id,$dirinfo["basename"])) {
					ftp_site($this->conn_id,"CHMOD 777 ".$dirinfo["basename"]);
					//echo ftp_pwd($conn_id); 
					return true;
				} else {
					return false;
				}
	
	}

	function _list($path)
	{
		$dir=dir($this->psnInfo[publish_path] .'/'. $path);
		$dir->rewind();
		while($file=$dir->read()) {
			if( $file=="." || $file=="..") {
				continue;
			} elseif(is_dir($this->psnInfo[publish_path] .'/'. $path. '/' . $file)) {
				$dirlist[] = array(
					'type'=>'dir',
					'name'=>$file,
				);
			} else {
				$arr = explode('.', $file);
				$filelist[] = array(
					'type'=>array_pop($arr),
					'name'=>$file,
				);
		
			}
			
		}
		$filelist = array_merge($dirlist, $filelist);
		$dir->close();
		return $filelist;
	}

	function _ftp_list($path)
	{
		$list = ftp_rawlist($this->conn_id , $this->psnInfo[publish_path] . $path);
		foreach($list as $key=>$var) {
			$patt = "/^([d-])([rw-]+)[\s]+([0-9]+)[\s]+([\S]+)[\s]+([\S]+)[\s]+([0-9]+)[\s]+([A-Za-z]+[\s]+[0-9]+[\s]+[0-9]+:[0-9]+)[\s]+([\S]+)/is";

			preg_match ($patt, $var ,$matches);

			if( $matches[8]=="." || $matches[8]=="..") {
				continue;
			} elseif($matches[1] == 'd') {
				$dirlist[] = array(
					'type'=>'dir',
					'name'=> $matches[8],
					'user'=> $matches[4],
					'group'=> $matches[5],
					'size'=> $matches[6],
					'modifiedDate'=> $matches[7],
					'mode' =>$matches[1].$matches[2],
				);
			
			} else {
				$arr = explode('.', $matches[8]);
				$filelist[] = array(
					'type'=>array_pop($arr),
					'name'=> $matches[8],
					'size'=> $matches[6],
					'user'=> $matches[4],
					'group'=> $matches[5],
					'modifiedDate'=> $matches[7],
					'mode' =>$matches[1].$matches[2],
				);
			
			}
			
		}
		$filelist = array_merge($dirlist, $filelist);
		return $filelist;
	}

}

?>