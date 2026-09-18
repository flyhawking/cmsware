<?php
// +----------------------------------------------------------------------+
// | iZz :: File 
// +----------------------------------------------------------------------+
// | Copyright (c) 2000-2002 iZz Studio
// +----------------------------------------------------------------------+
// | This source file is created by iZz Studio. And this file is not 
// | public and not a open source file. If you get this file, and not
// | , please contact us by emailing to justdn@justdn.com. 
// |       
// |                                                                      
// |                                                                      
// |                                                                      
// |                                                                      
// +----------------------------------------------------------------------+
// | Author(s):                                                            
// |                                                                      
// |                                                                      
// +----------------------------------------------------------------------+
//
// $Id: file.class.php,v 1.3 2006/06/20 14:58:07 Administrator Exp $

class iFile {
	//只处理一次File Open.
	var $Fp;
	var $Pipe; //(fopen,popen)(0,1)
	var $File;
	var $OpenMode; //(r,r+,w,w+,a,a+,b)
	//var $LockMode; //(1,2,3,4)

	//function iFile(){
	//}

	function OpenFile($File, $Pipe = '0', $Mode = 'r'){
		$this -> OpenMode = $Mode;
		$this -> File     = $File;

		if($Pipe == '0'){
			$this -> Pipe = 'f';
		}else{
			$this -> Pipe = 'p';
		} //这里是兼容上版本，建议将Pipe放到最后。

		if ($this -> OpenMode == 'r'||$this -> OpenMode == 'r+'){

			if($this->CheckFile()){
				if ($this -> Pipe == 'f') {
					$this->Fp = fopen($this -> File, $this -> OpenMode);
				} elseif ($Pipe == 'p') {
					$this->Fp = popen($this -> File, $this -> OpenMode);
				}else{
					echo "Check The OpenFile Mode,It refer to fwrite() function.";
				}
			} else {
				echo "Access Error: Check $File is exist ";
			}

		} else {
			if ($this -> Pipe == 'f') {
				$this->Fp = fopen($this -> File, $this -> OpenMode);
			} elseif ($Pipe == 'p') {
				$this->Fp = popen($this -> File, $this -> OpenMode);
			} else {
				echo "Check The OpenFile Pipe,It can be 'f' or 'p'." ;
			}

		}

		Return $this->Fp; //放在这里是兼容上版本，如果重新写iTemplate可去除.

	}


	function CloseFile(){
		if ($this->Pipe == 'f'){
			@fclose($this->Fp);
		} else {
			@pclose($this->Fp);
		}
	}

	function getFileData(){
		@flock($this->Fp, 1);
		$size = filesize($this->File);
		if(!empty($size)) $Content = fread($this->Fp, $size);
		return $Content;
	}


	function CheckFile(){
		if (file_exists($this -> File)) { return true; } else { return false; }
	}

	function WriteFile($Data,$Mode = 3){
		@flock($this->Fp,$Mode);  //这里可以改为 读写均锁?。
		fwrite($this->Fp,$Data);
		$this->CloseFile();
		return true;
	}

}

?>