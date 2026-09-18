<?php
	
class FTP {
	var $relateDir;
	var $file_list = array();
	var $file_view_ext = array();
	var $viewMode ;
	var $viewMode_cate_type;
	var $NodeID = 0;
	var $limit = array();
	var $savePath;

	function FTP($params) 
	{
		
		if (isset($params['relateDir']))	$this->relateDir = $params['relateDir'];
		if (isset($params['NodeID'])) $this->NodeID = intval($params['NodeID']);
		if (isset($params['mode'])) $this->viewMode = $params['mode'];
		if (isset($params['savePath'])) $this->savePath = $params['savePath'];

		if (isset($params['mode_cate_type'])) $this->viewMode_cate_type = $params['mode_cate_type'];
		if (isset($params['file_view_ext'])) $this->file_view_ext = explode('|',$params['file_view_ext']);
		//if (isset($params['limit'])) $this->limit = explode(',',$params['limit']);
	}
	function setLimit($start,$limit)
	{
		$this->limit = array($start,$limit);
	}
	function fileNameFilter()
	{
	
	}
	
	function recordNum()
	{
		global $db,$table;
		$sql = "SELECT COUNT(*) as nr FROM $table->resource WHERE  Category='".$this->viewMode_cate_type."' and NodeID=".$this->NodeID;
		$row = $db->query($sql);

		$this->recordNum = $row[nr];
		return $this->recordNum;
	}

	function listFile() 
	{
		global $db,$table;
		
		if ($this->viewMode == 'cate') {
			if ($this->viewMode_cate_type == 'img') {
				
				$sql = "SELECT * FROM $table->resource   WHERE Category='img' and NodeID=".$this->NodeID."  ORDER BY `ResourceID` DESC  LIMIT ".$this->limit[0].",".$this->limit[1];
				
				$result = $db->Execute($sql);
			
				while(!$result->EOF) {
					//upId   upCId  upType  upSize  upTime  upMini  upSaveMode  upFileName  upSavePath  


					$url = $this->savePath .'/'.$result->fields['Path'];
						
					
					
						
					$type = explode('.', $result->fields['Path']);
					$this->file_list[] = array(
						'id' => $result->fields['ResourceID'],
						'filename' => $result->fields['Name'],
						'uptime' => $result->fields['CreationDate'],
						'url' => $url,
						'type' => array_pop($type),
						'dimension' => explode("*", $result->fields['Info']),
						'size' => ceil($result->fields['Size']/1024),
					
					);
					
					
					$result->MoveNext();
				}
				
				return $this->file_list;
					
			} else {
			
			}
		} elseif ($this->viewMode == 'dir') {
		
		}
	}
	
	
	function delFile()
	{
	
	}

	function makeDir()
	{
	
	}

	function delDir()
	{
	
	}

	function renameDir()
	{
	
	}

}


class Upload extends iData {
	/**
	$params = array(
	'POST_File' =>$_FILES['userfile'],
	'uploadType' => 'img',
	'cId' => 1,
	);
	$upload = new Upload($params);

	$upload->report();
	*/
	var $sysInfo;	//array to store system running information
	var $runError=false;	//a variable judge whether system catch an error
	
	var $uploadFileArray;
	var $POST_File;
	var $upload_num;
	var $saveFile;
	var $saveMiniFile;
	var $NodeID;
	var $uploadType;
	var $makeMini;
	var $miniHeight;
	var $miniWidth;
	var $changeName;
	var $rootPath;
	
	var $imgAllowSuffix = "gif|jpg|jpeg|png";
	var $imgAllowSize = 640000;
	function POST_Data_handler()
	{
		global $SYS_ENV;
		if($this->uploadType == 'img') {
			$allowSuffix = $this->imgAllowSuffix;
			$allowSize   = $this->imgAllowSize;
		} elseif ($this->uploadType == 'attach') {
			$allowSuffix = $SYS_ENV['upAttachType'];
			$allowSize   = $SYS_ENV['upAttachSize'];
		} elseif ($this->uploadType == 'flash') {
			$allowSuffix = 'swf';
			$allowSize   = $SYS_ENV[upFlashSize];
		}

		foreach($this->POST_File['name'] as $key=>$var) {
				if($this->test_filetype($var,$allowSuffix) && $this->test_filesize($this->POST_File['size'][$key], $allowSize)) {
					$this->uploadFileArray[] = array(
						'name' => $var,	
						'tmp_name' => $this->POST_File['tmp_name'][$key],
						'size' => $this->POST_File['size'][$key],
					);
					
				} else {
					@unlink($this->POST_File['tmp_name'][$key]);
				}
		}
			
		unset($this->POST_File);
	
	}


	function Upload($params)
	{
		global $db,$table,$SYS_ENV;
		if (isset($params['POST_File']))	$this->POST_File = $params['POST_File'];
		if (isset($params['uploadType'])) $this->uploadType = $params['uploadType'];
		if (isset($params['NodeID'])) $this->NodeID = $params['NodeID'];
		if (isset($params['rootPath'])) $this->rootPath = $params['rootPath'].'/';
		if (isset($params['makeMini'])) $this->makeMini = $params['makeMini'];
		if (isset($params['miniWidth'])) $this->miniWidth = $params['miniWidth'];
		if (isset($params['miniHeight'])) $this->miniHeight = $params['miniHeight'];
		if (isset($params['changeName'])) $this->changeName = $params['changeName'];
		

		switch($this->uploadType) {
			case 'img':
				$sql = "SELECT varValue as num FROM $table->sys WHERE  varName ='ResourceNum'";
				break;
			case 'flash':
				$sql = "SELECT varValue as num FROM $table->sys WHERE  varName ='upload_flash_num'";
 				break;
			case 'attach':
				$sql = "SELECT varValue as num FROM $table->sys WHERE  varName ='upload_attach_num'";
 				break;
		}

		$row = $db->getRow($sql);


		$this->upload_num = $row[num];
		$this->imgAllowSuffix = $SYS_ENV[upImgType];
		$this->imgAllowSize = $SYS_ENV[upImgSize];
		$this->POST_Data_handler();
		$this->_Upload();
	}

	function _Upload()
	{
		global $db, $_LANG_ADMIN,$SYS_ENV;
		if(!is_array($this->uploadFileArray)) return false;
		
			//save file in category dir
			foreach($this->uploadFileArray as $key=>$var) {
				$dataPath = $this->makeAutoPath();

				$targetPath = $this->uploadType.'/'.$dataPath."/";
				if(CMSware_mkDir($this->rootPath.$targetPath,0777)){

					if ($this->changeName == '1') {
						$arr = explode('.', $var['name']);

						$rename = $this->uploadType.date("YmdHis", time()).$key.'.'.array_pop($arr);

					} else
						$rename = $var['name'];

					$destination = $this->rootPath . $targetPath . $rename;
					if(move_uploaded_file($var['tmp_name'],$destination)) {
						$this->sysInfo[] = $var['name'].$_LANG_ADMIN['upload_ok_rename'].$rename;
						
						if($this->uploadType == 'img') {
							$img_size = Image::getImgSize($destination);
							$info = $img_size['width'].'*'.$img_size['height'];
						} 
						
						$this->flushData();
						$this->addData("Category", $this->uploadType);
						$this->addData("Type", 1);
						$this->addData("NodeID", $this->NodeID);
						$this->addData("Title", $var['name']);
						$this->addData("Name", $rename);
						$this->addData("Path", $targetPath.$rename);
						$this->addData("Size", $var['size']);
						$this->addData("Info", $info);
						$this->insertDBLog();

						$this->saveFile[] = $destination;
						 


						//$this->saveFile[] = $this->rootPath . $targetPath . $rename;
						if ($this->makeMini == 1) {
							$miniName = str_replace('.','_s.',$rename);
							if(Image::makeMiniature($this->rootPath . $targetPath.$rename,$this->rootPath . $targetPath.$miniName,$this->miniWidth,$this->miniHeight)) {
								$this->flushData();
								$this->addData("Category", $this->uploadType);
								$this->addData("ParentID", $this->db_insert_id);
								$this->addData("Type", 1);
								$this->addData("NodeID", $this->NodeID);
								$this->addData("Name", $miniName);
								$this->addData("Path", $targetPath.$miniName);
								$this->addData("Size", $var['size']);
								$this->addData("Info", $this->miniWidth.'*'.$this->miniHeight);
								$this->insertDBLog();
								$this->sysInfo[] = $_LANG_ADMIN['upload_makemini_ok'].$miniName."\\n";
						
							}
							$this->saveMiniFile[] = $this->rootPath . $targetPath .  $miniName;
						}

						if($SYS_ENV['EnableWaterMark'] == 1 && $this->uploadType== 'img') {
							imageWaterMark($destination, $SYS_ENV['WaterMarkPosition'], $SYS_ENV['WaterMarkImgPath']); 
							 
						}
						//unlink($var['tmp_name']);
					} else
						$this->sysInfo[] = $var['name'].$_LANG_ADMIN['upload_fail'];

				} else
					$this->sysInfo[] =$_LANG_ADMIN['upload_fail_mkdir_fail'];
			}
	
			$this->Counter(1, $this->uploadType);
	}
	
	function Counter($num = 1, $type = 'img')
	{
		global $db,$table;
		switch($type) {
			case 'img':
				$sql = "UPDATE $table->sys SET `varValue`=varValue +1  where varName='ResourceNum'";
				break;
			case 'flash':
				$sql = "UPDATE $table->sys SET `varValue`=varValue +1  where varName='upload_flash_num'";
				break;
			case 'attach':
				$sql = "UPDATE $table->sys SET `varValue`=varValue +1  where varName='upload_attach_num'";
				break;
		}
		
		$db->query($sql);
	
	}
	function insertDBLog()
	{	
		global $db,$table,$sys;
		$time = time();
		$this->addData("CreationUserID", $sys->session['sUId']);
		$this->addData("CreationDate", $time);
		$this->addData("ModifiedDate", $time);
		//$this->debugData();
		if($this->dataInsert($table->resource)) {
			return true;
		}else {
			new Error("Failure: insertDBLog");
			return false;			
		}	

	}


	function makeAutoPath() {

			$num = $this->upload_num;

			$num = strval($num);
			$add_zero = 8- strlen($num);
			$num = str_repeat('0', $add_zero).$num;

			$DirSecond = "h".substr($num, 0, 3);
			$DirFirst = "h".substr($num, -5,2);

			return $DirSecond ."/".$DirFirst;
	}

	function test_filetype($upfilename_name,$allow_upimgtype) {
		global $SYS_ENV,$_LANG_ADMIN;
		//$allow_upimgtype=$SYS_ENV[upImgType];

		$file_ext = $this->get_file_ext($upfilename_name);
		
		
		if(isDeniedExtensions($file_ext)) {
			$this->sysInfo[] = sprintf($_LANG_ADMIN['upload_error_filetype_not_match'],$upfilename_name,$file_ext,$allow_upimgtype); 
				$this->runError=true;
				return false;
		}

		if (($upfilename_name!="none")&&($upfilename_name!="")) {

			$typelist = explode("|",$allow_upimgtype);

			//$typelist = array_merge($typelist, $DeniedExtensions);
			$typecount=count($typelist);
			$typeok=false;
			for ($i=0;$i<=($typecount-1);$i++) {
				if (strlen(strpos($file_ext,$typelist[$i]))!=0) {
				
				return true;
				
				}
			}
			if ($typeok==false) {
				$this->sysInfo[] = sprintf($_LANG_ADMIN['upload_error_filetype_not_match'],$upfilename_name,$file_ext,$allow_upimgtype); 
				$this->runError=true;
				return false;
			}
		}else {
			$this->runError=true;
			return false;
		}
	
	}

	function test_filesize($upfilename_size,$allow_upimgsize) {
		
		global $SYS_ENV,$_LANG_ADMIN;
		//$allow_upimgsize=$SYS_ENV[upImgSize];
		if($upfilename_size>($allow_upimgsize*1024)){
			$this->sysInfo[] = sprintf($_LANG_ADMIN['upload_error_size_overflow'],round($allow_upimgsize));
				
			
			$this->runError=true;
			return false;
	
		}else {
			//$this->sysInfo[]="文件大小:".round($upfilename_size/1024)."KB";
			return true;
		}
	
	}

	function get_file_ext($filename,$mode=0) {
		$tmpimgname=explode(".",$filename);
		if($mode==1){
			$tmpimgnamecount = count($tmpimgname)-2;
			$file_ext = $tmpimgname[$tmpimgnamecount];
		
		}else{
			$tmpimgnamecount = count($tmpimgname)-1;
			$file_ext = $tmpimgname[$tmpimgnamecount];
		}
		
		return strtolower($file_ext); 
	}

	function report() {
		
		if(is_array($this->sysInfo)) {
			foreach($this->sysInfo as $key=>$val){
				$output.= $val."<br>";
			
			}
		}
		echo $output;
	}

}
?>