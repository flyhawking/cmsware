<?php
class psn_admin extends iData {
	
	var $isLog = true;
	var $conn_id_stack = array();
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

	public static function isValid()
	{
		global $table,$db,$PSN_INFO;
		$i=0;
		require(SYS_PATH.'/license.php');
		$license_array = $License;
		unset($License);		
		if(!empty($PSN_INFO)) {
			$allPsn = $PSN_INFO;

		} else {
			$allPsn = psn_admin::getAllPSN();
		
		}
		foreach($allPsn as $key=>$var) {
			$psnInfo = psn_admin::parsePSN($var['PSN']);
			if($psnInfo[publish_type] == 'ftp')
				$i++;
			else
				continue;
		}

		if($i > $license_array['RemotePSN-num']) {
			goback('license_RemotePSN_num_overflow');
		}
	
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
		global $table,$db,$PSN_INFO;
 
			$sql  ="SELECT * FROM $table->psn  WHERE PSNID='$PSNID'";
			$result = $db->getRow($sql);		
 			return $result;
		 

	}

	public static function getAllPSN()
	{
		global $table,$db,$PSN_INFO;
 
			$sql  ="SELECT * FROM $table->psn";
			$result = $db->Execute($sql);
			while(!$result->EOF) {
				$data[] = $result->fields;
				$result->MoveNext();
			}
			return $data;
	
	 
		
	}

	function getAllPSNByPermission()
	{
		global $table,$db,$PSN_INFO,$sys;
		 
			$sql  ="SELECT * FROM $table->psn";
			$result = $db->Execute($sql);
			while(!$result->EOF) {
				if($this->canPermissionReadG($result->fields, $sys->session['sGId'])) {
					$data[] = $result->fields;
				} 
				$result->MoveNext();
			}
			return $data;
	
		 
		
	}

	function canPermissionReadG($PSNInfo, $gId)
	{
		global $db,$table,$sys;

		if($sys->isAdmin()) return true;

		if(!empty($PSNInfo['PermissionReadG'])) {
			$posMG = strpos(','.$PSNInfo['PermissionReadG'].',', ','.$gId.',');
			if( $posMG === false ) {
				$result = $db->getRow("select ParentGID from $table->group where gId='$gId'");
				if(empty($result['ParentGID'])) return false;
				else {
					return $this->canPermissionReadG($PSNInfo, $result['ParentGID']);
				
				}
			} else	return true;
		} else return false;
	
	}


	public static function parsePSN($psn)
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
				if(is_dir($psnInfo[publish_path])) return true;
				else return false;
				break;
			case 'ftp':
				$this->conn_id_key = md5($PSN);
				if(is_resource($this->conn_id[$this->conn_id_key])) return true;
				else {
					//echo get_resource_type($this->conn_id[$this->conn_id_key]);
					//echo "is not resource<HR>";
					return $this->_ftp_connect();
				}
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
		//return ftp_close($this->conn_id[$this->conn_id_key]);
		return true;
	}
	function _ftp_connect()
	{
			if (function_exists('ftp_connect')) {
				$mode = decoct($mode);
				if (strlen($mode) == 4)
					$mode = substr($mode,1);

				$this->conn_id[$this->conn_id_key] = ftp_connect($this->psnInfo['publish_ftp_host'], $this->psnInfo['publish_ftp_port'],100); 
				
				// login with username and password		
				$login_result = @ftp_login($this->conn_id[$this->conn_id_key], $this->psnInfo['publish_ftp_user'], $this->psnInfo['publish_ftp_pass']); 

				//echo get_resource_type($this->conn_id[$this->conn_id_key]);
				
				if ((!$this->conn_id[$this->conn_id_key]) || (!$login_result)) { 
					echo "<font color=red>FTP connection has failed!</font><br>Attempted to connect to {$this->psnInfo['publish_ftp_host']}:{$this->psnInfo['publish_ftp_port']} for user {$this->psnInfo['publish_ftp_user']}.<br>";
					echo "Please reset you FTP accounts correctly in your iWPC system setting."; 
					exit; 
				} else {
					return true;
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

	function mkDir($dirname, $mode = 0777)
	{	
		global $SYS_CONFIG;

		if(!empty($SYS_CONFIG['dir_mode'])) $mode = $SYS_CONFIG['dir_mode'];

 
		switch($this->psnInfo[publish_type]) {
			case 'local':
				//$mode = octdec($mode);
				return $this->_mkdir($dirname, $mode);
				break;
			case 'ftp':
				return $this->_ftp_mkdir($dirname, $mode);
				break;
		}

	}

	function _mkdir($dirname, $mode)
	{
		if(File::automkdir($this->psnInfo[publish_path] .'/'. $dirname, $mode)) {
			//chmod ($this->psnInfo[publish_path] .'/'. $dirname, 0777);
			return true;

		} else 
			return false;
	}

	function _ftp_mkdir($dirname, $mode)
	{
		if(ftp_mkdir($this->conn_id[$this->conn_id_key], $this->psnInfo[publish_path] .'/'. $dirname)) {
			ftp_site($this->conn_id[$this->conn_id_key],"CHMOD $mode ". $this->psnInfo[publish_path] .'/'. $dirname);
					//echo ftp_pwd($conn_id); 
			return true;
		} else {
			return false;
		}
	
	}

	function rmDir($dirname)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_rmdir($dirname);
				break;
			case 'ftp':
				return $this->_ftp_rmdir($dirname);
				break;
		}

	}

	function _rmdir($dirname)
	{
		return rmdir( $this->psnInfo[publish_path] .'/'. $dirname);
	}

	function _ftp_rmdir($dirname)
	{
		return ftp_rmdir($this->conn_id[$this->conn_id_key], $this->psnInfo[publish_path] .'/'. $dirname);
	}

	function delFile($path,$filename)
	{
		//debug($this->psnInfo);
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_delFile($path,$filename);
				break;
			case 'ftp':
				return $this->_ftp_delFile($path,$filename);
				break;
		}		
	}
	
	function _delFile($path,$filename)
	{
		$deler = $this->psnInfo[publish_path] .$path.'/'.$filename;
		if(file_exists($deler)) {
			if(unlink($deler))
				return true;
			else
				return false;
		
		} else return true;
	}

	function _ftp_delFile($path,$filename)
	{
		if(ftp_delete ($this->conn_id[$this->conn_id_key], $this->psnInfo[publish_path] .$path.'/'.$filename))
			return true;
		else
			return false;

	}

//移动
	function move($filename, $destination)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_move($filename, $destination);
				break;
			case 'ftp':
				return $this->_ftp_move($filename, $destination);
				break;
		}	
	
	}

	function _move($filename, $destination)
	{
		if(File::autocopy($this->psnInfo[publish_path].$filename,  $this->psnInfo[publish_path].$destination)) {
			unlink($this->psnInfo[publish_path].$filename);
			return true;
		} else
			return false;

	}

	function _ftp_move($filename, $destination)
	{
		if(ftp_exec($this->conn_id[$this->conn_id_key], "RNFR ".$this->psnInfo[publish_path].$filename) && ftp_exec($this->conn_id[$this->conn_id_key], "RNTO ".$this->psnInfo[publish_path].$destination))
			return true;
		else
			return false;
		

	
	}
//复制
	function cp($filename, $destination)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_cp($filename, $destination);
				break;
			case 'ftp':
				return $this->_ftp_cp($filename, $destination);
				break;
		}	
	
	}

	function _cp($filename, $destination)
	{
		if(File::autocopy($this->psnInfo[publish_path].$filename,  $this->psnInfo[publish_path].$destination)) {
			return true;
		} else
			return false;

	}

	function _ftp_cp($filename, $destination)
	{
		return false;

	
	}


//重命名文件
	function renameFile($filename, $destination)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_renameFile($filename, $destination);
				break;
			case 'ftp':
				return $this->_ftp_renameFile($filename, $destination);
				break;
		}	
	
	}

	function _renameFile($filename, $destination)
	{
		return rename($this->psnInfo[publish_path].$filename,  $this->psnInfo[publish_path].$destination);
	}
	
	function _ftp_renameFile($filename, $destination)
	{
		return ftp_rename($this->conn_id[$this->conn_id_key], $this->psnInfo[publish_path].$filename,  $this->psnInfo[publish_path].$destination);
	}


	function upload($filename, $destination, $URL = '')
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_upload($filename, $destination, $URL);
				break;
			case 'ftp':
				return $this->_ftp_upload($filename, $destination, $URL);
				break;
		}	
	
	}

	function _upload($filename, $destination, $URL = '')
	{
		global $SYS_CONFIG;

		$mode = empty($SYS_CONFIG['file_mode']) ? 0777 : $SYS_CONFIG['file_mode'] ;

		$path = $this->psnInfo[publish_path] .$destination;
		$pathInfo = pathinfo($path);
		//echo $pathInfo['dirname'];
		CMSware_mkDir($pathInfo['dirname']);
		//echo $filename."--------------------".$path;
		if(File::autocopy($filename, $path)) {
			//chmod($path, $mode);
			if($this->isLog) $this->logIt($destination, 'binary', $URL);
			return true;
		
		}
		else
			return false;
	}

	function _ftp_upload($filename, $destination, $URL = '')
	{
		$path = $this->psnInfo[publish_path] .$destination;
		$pathInfo = pathinfo($path);
		//echo $path;exit;
		$this->ftpMakeDir($pathInfo['dirname']);
		if(ftp_put($this->conn_id[$this->conn_id_key], $path, $filename, FTP_BINARY)) {
			if($this->isLog) $this->logIt($destination, 'binary',  $URL);
			return true;
		} else {
			return false;
		}
	}
	
	function fileExists($filename)
	{
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_file_exists($filename);
				break;
			case 'ftp':
				return $this->_ftp_file_exists($filename);
				break;
		}	
	
	}

	function _file_exists($filename)
	{	
		return file_exists($this->psnInfo[publish_path] .'/'. $filename);
	}


	function _ftp_file_exists($filename)
	{
		return ftp_rename($this->conn_id[$this->conn_id_key], $this->psnInfo[publish_path] . '/'. $filename, $this->psnInfo[publish_path] . '/'. $filename);
	}


	function read($path, $filename)
	{
		//debug($this->psnInfo);
		switch($this->psnInfo[publish_type]) {
			case 'local':
				return $this->_read($path, $filename);
				break;
			case 'ftp':
				return $this->_ftp_read($path, $filename);
				break;
		}	
	
	}

	function _read($path, $filename)
	{	
		$Path2Get = $this->psnInfo[publish_path] . $path .'/'. $filename;
		return getFile($Path2Get);
	}

	function _ftp_read($path, $filename)
	{
		$tmpfilename = CACHE_DIR.Auth::makeSessionKey();
		$remote_file = $this->psnInfo[publish_path]  . $path .'/'. $filename;
		if(ftp_get ($this->conn_id[$this->conn_id_key], $tmpfilename, $remote_file, FTP_ASCII)) {
			if($content = getFile($tmpfilename)) {
				unlink($tmpfilename);
				return $content;
			} else
				return false;
				
		} else
			return false;


	}


	function put($filename, &$content)
	{
		//debug($this->psnInfo);
		$wap_mark = "<wap>";
		if(preg_match("/<wap>(.*)<\/wap>/isU", $content, $match)) {
			$function = $match[1];
			$content = $function($content);
			$content = str_replace($match[0], '', $content);
			$content = str_replace('<%xml', '<?xml', $content);
			$content = str_replace('%>', '?>', $content);
		
		}
 
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
		global $SYS_CONFIG;

		$mode = empty($SYS_CONFIG['file_mode']) ? 0777 : $SYS_CONFIG['file_mode'] ;

		$path = $this->psnInfo[publish_path] .$filename;
		$pathInfo = pathinfo($path);

		CMSware_mkDir($pathInfo['dirname']);
		if(File::autowrite($path, $content)) {
			//chmod($path, $mode);
			if($this->isLog)
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
		if(ftp_put($this->conn_id[$this->conn_id_key], $path, $tmpFile, FTP_ASCII)) {
			if($this->isLog) $this->logIt($filename, 'text');
			@unlink($tmpFile);
			return true;
		} else {
			@unlink($tmpFile);
			return false;
		}
	}

	function logIt($FileName, $Type, $URL = '')
	{
		global $table;
		//logID  IndexID  PSN  FileName  TYPE  URL  
		$this->flushData();
	//	$this->addData('IndexID', $this->sendVar[IndexID]);
		$this->addData('ContentID', $this->sendVar[ContentID]);
		$this->addData('NodeID', $this->sendVar[NodeID]);
		$this->addData('PSN', $this->PSN);
		$this->addData('FileName', $FileName);
		$this->addData('Type', $Type);
		$this->addData('URL', $URL);
		if($this->logExits($this->sendVar[ContentID], $this->PSN, $FileName)) {
			return true;		
		} else {
			if($this->dataInsert($table->publish_log))
				return true;
			else return false;	
		
		}
	}

	function logExits($ContentID, $PSN, $FileName)
	{	
		global $db,$table,$CMS_CACHE_logExits;
		$CacheKey = md5($ContentID.$PSN.$FileName);
		if(isset($CMS_CACHE_logExits[$CacheKey])) {
			return $CMS_CACHE_logExits[$CacheKey];
		} else {
			$sql = "SELECT logID  FROM $table->publish_log  WHERE ContentID={$ContentID} AND PSN='{$PSN}' AND FileName='{$FileName}'"	;
			$result = $db->getRow($sql);
			if(!empty($result[logID])) {
				$CMS_CACHE_logExits[$CacheKey] = true;
				return true;
			} else {
				$CMS_CACHE_logExits[$CacheKey] = false;
				return false;
			}
		
		}

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
	{			$pwd = ftp_pwd($this->conn_id[$this->conn_id_key]);
				if(@ftp_chdir($this->conn_id[$this->conn_id_key],$directory)) {
					@ftp_chdir($this->conn_id[$this->conn_id_key],$pwd);
					return true;
				}
				$dirinfo =pathinfo($directory);
				//debug($dirinfo);
				if(!@ftp_chdir($this->conn_id[$this->conn_id_key],$dirinfo["dirname"])) {
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
				if(ftp_mkdir($this->conn_id[$this->conn_id_key],$dirinfo["basename"])) {
					ftp_site($this->conn_id[$this->conn_id_key],"CHMOD 777 ".$dirinfo["basename"]);
					//echo ftp_pwd($conn_id); 
					return true;
				} else {
					return false;
				}
	
	}

	function _list($path)
	{
		$dirlist = array();
		$filelist = array();
		$dir=dir($this->psnInfo[publish_path] .'/'. $path);
		$dir->rewind();
		while($file=$dir->read()) {
			if( $file=="." || $file=="..") {
				continue;
			} elseif(is_dir($this->psnInfo[publish_path] .'/'. $path. '/' . $file)) {
				$dirlist[] = array(
					'type'=>'dir',
					'name'=>$file,
					'user'=> $matches[4],
					'group'=> $matches[5],
					'size'=> ceil(filesize($this->psnInfo[publish_path] .'/'. $path. '/' . $file)/1080),
					'modifiedDate'=> date('Y-m-d H:i:s',filemtime($this->psnInfo[publish_path] .'/'. $path. '/' . $file)),
					'mode' =>fileperms($this->psnInfo[publish_path] .'/'. $path. '/' . $file),
				);
			} else {
				$arr = explode('.', $file);
				$filelist[] = array(
					'type'=>array_pop($arr),
					'name'=>$file,
					'user'=> $matches[4],
					'group'=> $matches[5],
					'size'=> ceil(filesize($this->psnInfo[publish_path] .'/'. $path. '/' . $file)/1080),
					'modifiedDate'=> date('Y-m-d H:i:s',filemtime($this->psnInfo[publish_path] .'/'. $path. '/' . $file)),
					'mode' =>fileperms($this->psnInfo[publish_path] .'/'. $path. '/' . $file),
				);
		
			}
			
		}
		$filelist = array_merge($dirlist, $filelist);
		$dir->close();
		return $filelist;
	}
/*
Array
(
    [0] => drwxrwxrwx		8 501      20           4096 May 20 20:01 apache_1.3.31
		([d-])([rw]+)[\s]+([0-9]+)[\s]+([0-9]+)[\s]+([0-9]+)[\s]+([0-9]+)[\s]+([A-Za-z]+[\s]+[0-9]+[\s]+[0-9]+:[0-9]+)[\s]+([\S]+)
    [1] => -rwxrwxrwx    1 504      504       2467371 May 20 19:58 apache_1.3.31.tar.gz
    [2] => drwxrwxrwx   12 500      500          4096 May 20 21:28 httpd-2.0.49
    [3] => -rwxrwxrwx    1 504      504       5919279 May 20 21:20 httpd-2.0.49.tar[1].gz
    [4] => -rwxrwxrwx    1 504      504           315 May 19 22:23 license.dat
    [5] => drwxrwxrwx   18 1003     1003         4096 May 20 22:01 php-4.3.6
    [6] => -rwxrwxrwx    1 504      504       4828134 May 20 21:50 php-4.3.6.tar.gz
    [7] => -rwxrwxrwx    1 504      504         23040 May 20 21:14 软件销售合同.doc
)

*/
	function _ftp_list($path)
	{
		$type = ftp_systype($this->conn_id[$this->conn_id_key]);

		$list = ftp_rawlist($this->conn_id[$this->conn_id_key] , $this->psnInfo[publish_path] . $path);
		if($type == 'UNIX') {
			foreach($list as $key=>$var) {
				$patt = "/^([d-])([rwx-]+)[\s]+([\S]+)[\s]+([\S]+)[\s]+([\S]+)[\s]+([0-9]+)[\s]+([A-Za-z]+[\s]+[0-9]+[\s]+[0-9]+:[0-9]+)[\s]+([\S]+)/is";

				preg_match ($patt, $var ,$matches);
				//debug($matches);
				if( $matches[8]=="." || $matches[8]=="..") {
					continue;
				} elseif($matches[1] == 'd') {
					$dirlist[] = array(
						'type'=>'dir',
						'name'=> $matches[8],
						'user'=> $matches[4],
						'group'=> $matches[5],
						'size'=> ceil($matches[6]/1080),
						'modifiedDate'=> $matches[7],
						'mode' =>$matches[1].$matches[2],
					);
				
				} else {
					$arr = explode('.', $matches[8]);
					$filelist[] = array(
						'type'=>array_pop($arr),
						'name'=> $matches[8],
						'size'=> ceil($matches[6]/1080),
						'user'=> $matches[4],
						'group'=> $matches[5],
						'modifiedDate'=> $matches[7],
						'mode' =>$matches[1].$matches[2],
					);
				
				}
				
			}		
			//foreachend
		} else {
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
						'size'=> ceil($matches[6]/1024),
						'modifiedDate'=> $matches[7],
						'mode' =>$matches[1].$matches[2],
					);
				
				} else {
					$arr = explode('.', $matches[8]);
					$filelist[] = array(
						'type'=>array_pop($arr),
						'name'=> $matches[8],
						'size'=> ceil($matches[6]/1024),
						'user'=> $matches[4],
						'group'=> $matches[5],
						'modifiedDate'=> $matches[7],
						'mode' =>$matches[1].$matches[2],
					);
				
				}
				
			}		
		}

		$filelist = array_merge($dirlist, $filelist);
		return $filelist;
	}

}

?>