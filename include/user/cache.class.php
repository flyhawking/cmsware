<?php
//
// +----------------------------------------------------------------------
// | iZz Project Name:		DMsys 2.0
// +----------------------------------------------------------------------
// | Copyright (c) 2000-2003 iZz Studio
// +----------------------------------------------------------------------
// | Note:
// | 
// | 
// | 
// +----------------------------------------------------------------------
// | Authors: iZz Studio (xshArp,Binzy,iCer,jFox,Ali,Hawking)
// +----------------------------------------------------------------------
// | Site: http://www.justdn.org
// | Bulletin Borad: http://bbs.justdn.org
// | email: webmaster@justdn.com
// +----------------------------------------------------------------------
//
// $Id: filename.php,v 1.00 2003/03/16  12:27  Beijing Time Zone 
//

/**
*
*/

class CacheData {
	
	var $DataList = array(
					'sys' => 'Cache_SYS_ENV.php',	
					'menu' => 'Cache_CATE_MENU.php',
					'admin_menu' => 'Cache_ADMIN_CATE_MENU.php',
					'catelist' =>'Cache_CateList.php',
					'psn'=>'Cache_PSN.php',
				);
	
	var $CacheFileHeader = "<?php\n//iWPC cache file, DO NOT modify me!\n//Created on " ;

	var $CacheFileFooter = "\n?>";

	var $output;
	
	function getData($key) 
	{
		include(CACHE_DIR.$this->DataList[$key]);
		
	}

	function makeCache($key)
	{	
		global $table,$db;
		switch ($key) {
			case 'sys':
				$recordSet=$db->Execute("SELECT * FROM $table->sys");
				
				if(!$recordSet) {
					print $db->ErrorMsg();
					exit;
				}else {
					while (!$recordSet->EOF) {	
						$SYS_ENV[$recordSet->fields[varName]]=$recordSet->fields[varValue];	
						$recordSet->MoveNext();
					}
				}
				$results = var_export ($SYS_ENV, true);
				$results = '$SYS_ENV = '.$results.";";
				$this->writeCache($key,$results);
				break;
			case 'psn':
				$recordSet=$db->Execute("SELECT * FROM $table->psn");
				

				if(!$recordSet) {
					print $db->ErrorMsg();
					exit;
				}else {
					while (!$recordSet->EOF) {	
						$PSN_INFO[$recordSet->fields[PSNID]]= array_merge($recordSet->fields,psn_admin::parsePSN($recordSet->fields[PSN]));
						$recordSet->MoveNext();
					}
				}
				$results = var_export ($PSN_INFO, true);
				$results = '$PSN_INFO = '.$results.";";
				$this->writeCache($key,$results);
				break;
			case 'menu':
				$results = iwpc_search_catelist();
				
				$results = '$CATE_MENU'."= \"".$results."\";";
				$this->writeCache($key,$results);
				break;
			case 'catelist':
				$results=$this->nodelist();
				$results = var_export($results, true);
				$results = '$NODE_LIST = '.$results.";";
				$this->writeCache($key,$results);
				break;
		}
	}


	function writeCache($key,$cacheData)
	{	
		$cacheData = $this->CacheFileHeader.date("F j, Y, H:i")."\n\n".$cacheData.$this->CacheFileFooter;
		$handle = fopen(CACHE_DIR.$this->DataList[$key],'w');
		@flock($handle,3);  //这里可以改为 读写均锁?。
		fwrite($handle,$cacheData);
		fclose($handle);
	}



	function nodelist($NodeID = NULL, $header = NULL)
	{
		global $db,$table;

		if(empty($NodeID)) {

			$sql = "select * from $table->site where ParentID=0  AND Disabled=0";
			$result = $db->Execute($sql);
			while (!$result->EOF) {	
				$NodeID = $result->fields[NodeID];
				$this->output[$NodeID] = array('NodeID'=>$result->fields[NodeID],'Name' =>$result->fields[Name],'ParentID' =>$result->fields[ParentID]);

				$NUM= $db->Execute("SELECT COUNT(*) as nr  FROM $table->site where ParentID='$NodeID'  AND Disabled=0");
				if(!empty($NUM->fields[nr]))
					$this->nodelist($NodeID);

				$result->MoveNext();
			}
			
			return $this->output;
			

		} else {
			$header = $header + 1;

			$sql = "select * from $table->site where ParentID=$NodeID  AND Disabled=0";
			$result = $db->Execute($sql);
			while (!$result->EOF) {	
				$NodeID = $result->fields[NodeID];
				$this->output[$NodeID] = array('NodeID'=>$result->fields[NodeID],'Name' =>$result->fields[Name],'ParentID' =>$result->fields[ParentID], 'cHeader' => $header);

				$NUM= $db->Execute("SELECT COUNT(*) as nr  FROM $table->site where ParentID='$NodeID'  AND Disabled=0");
				if(!empty($NUM->fields[nr]))
					$this->nodelist($NodeID,$header);

				$result->MoveNext();
			}
		
		}
		
	}
}

?>