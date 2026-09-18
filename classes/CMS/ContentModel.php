<?php
require_once INCLUDE_PATH."admin/content_table_admin.class.php";

class CMS_ContentModel extends content_table_admin{
	
	var $ContentModelReservedFieldName = array('IndexID','ContentID','NodeID','ParentIndexID','Type','PublishDate','Template',
'State','URL','Top','Pink','Sort','CreationDate','ModifiedDate','CreationUserID','LastModifiedUserID',
'ContributionUserID','ContributionID','ApprovedDate','TableID','ParentID','Name');


	function CMS_ContentModel()
	{
 	}


	function import($_content)
	{
 		$TableData = $this->parseContentTableXML($_content);
		return $this->_import($TableData);
	}

	function importFromFile($_file)
	{
 		$TableData = $this->parseContentTableXMLFile($_file);
		return $this->_import($TableData);
	}

	function _import(&$TableData)
	{
		if(!empty($TableData)) {
		 
			$this->flushData();
			$this->addData("Name", $TableData['Name']);

			$TableInfo = $this->getTableInfo($TableData['TableID']);
			if(empty($TableInfo['TableID'])) {
				$this->addData("TableID", $TableData['TableID']);
			}
	
			if($this->addTable()) {
				$TableID = $this->db_insert_id;

				foreach($TableData['Fields'] as $var) {
 					if(in_array($var[FieldName], $this->ContentModelReservedFieldName)) {
						continue;
					}
					$FieldsMulti[] = $var;
				}
				
				$this->addField($TableID, $FieldsMulti, true);
				
				if(file_exists(CACHE_DIR.'Cache_ContentModel.php'))	unlink(CACHE_DIR.'Cache_ContentModel.php');
				
				$factory = & get_singleton("CMS.CacheData");
				$cache = $factory->getInstance();
				$cache->makeCache('content_model');	
				clearDir(SYS_PATH.'sysdata/cache/','index.html;.htaccess') ;
				return true;
			}
		} else return false;
	}

	function parseContentTableXMLFile($_file)
	{
		$this->File = & get_singleton("FileSystem.File");
		$xml_content = $this->File->read($_file);
		
		return $this->parseContentTableXML($xml_content);
	}

	function parseContentTableXML($content)
	{	
		$rulePattern['Name'] = "/<Name>(.*)<\/Name>/isU";
		$rulePattern['TableID'] = "/<TableID>(.*)<\/TableID>/isU";
		 
		$rulePattern_ContentModel = "/<Field>(.*)<\/Field>/isU";

		if(strpos($content, "<version>1.1</version>") !== false) $version = 11;
		else $version = 10;

		foreach($rulePattern as $key=>$var) { //解析分类采集规则
			if(preg_match($var, $content, $match)) {
				if($version == 10 )$Rules[$key] = html_entity_decode($match[1]);
				elseif($version == 11 )$Rules[$key] = $match[1];
			}
		}

		if(preg_match_all($rulePattern_ContentModel, $content, $match)) { //解析内容模型采集规则
			$pattern = "/<(.*)>(.*)<\/\\1>/isU";
			foreach($match[1] as $key=>$var) {
				$tmp = array();
				if(preg_match_all($pattern, $var, $matches)) {
					foreach($matches[1] as $keyIn=>$varIn) {
						if($version == 10 )$tmp[$varIn] = html_entity_decode($matches[2][$keyIn]);
						elseif($version == 11 )$tmp[$varIn] = $matches[2][$keyIn];
						
					}
					$ContentModelRules[] = $tmp;
				}		
			}
		}

		$Rules['Fields'] = $ContentModelRules;
		return $Rules;

	}


}
?>