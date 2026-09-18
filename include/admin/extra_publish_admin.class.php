<?php
class extra_publish_admin  extends iData {

	function add()
	{
		global $table,$sys;
		$time = time();
		$this->addData('CreationUserID', $sys->session['sUId']);
		$this->addData('LastModifiedUserID', $sys->session['sUId']);
		$this->addData('CreationDate', $time);
		$this->addData('ModifiedDate', $time);
		if($this->dataInsert($table->extra_publish))
			return true;
		else return false;
	
	}

	function update($PublishID)
	{
		global $table,$sys;
		$this->addData('LastModifiedUserID', $sys->session['sUId']);
 		$this->addData('ModifiedDate', time());
		$where="where PublishID=".$PublishID;
		if($this->dataUpdate($table->extra_publish,$where))
			return true;
		else return false;
	
	}

	function del($PublishID)
	{
		global $table;
		$which="PublishID";
		if($this->dataDel($table->extra_publish,$which,$PublishID,$method="="))
			return true;
		else return false;

	}
	
	function getAll($NodeID = 0)
	{
		global $table,$db;
		$sql  ="SELECT t.*, u.uName as LastModifiedUser FROM $table->extra_publish t left join $table->user u ON   u.uId=t.LastModifiedUserID where t.NodeID='$NodeID' ";
		$result = $db->Execute($sql);
		while(!$result->EOF) {
			$data[] = $result->fields;
			$result->MoveNext();
		}
		
		return $data;
	}


	function getInfo($PublishID)
	{
		global $db, $table;
		
		$sql  ="SELECT * FROM $table->extra_publish where PublishID='$PublishID'";
		
		return $db->getRow($sql);
	}
	
	function getView($PublishID)
	{
		global $iWPC;
		$PublishInfo = $this->getInfo($PublishID);
		$NodeInfo = $iWPC->loadNodeInfo($PublishInfo[NodeID]);

		return $this->getHtmlURL($PublishInfo, $NodeInfo);
	}
  
	function refresh(&$PublishInfo,&$NodeInfo, $filename) 
	{
		global $iWPC,$SYS_ENV;
		/*
		switch($NodeInfo[PublishMode]) {
			case '0';
				return true;
				break;
			case '2':
				$template = new kTemplate();
				$template->template_dir = SYS_PATH.'templates';
				$cacheId = $NodeID.'0'.$PublishInfo['Tpl'];
				for($i=0;$i<=10;$i++) {
					$template->clear_cache($PublishInfo['Tpl'], $PublishID.$i.$PublishInfo['Tpl']);
				}
				return true;
				break;
		
		}*/

		$template = new kTemplate();
		$template->template_dir = $SYS_ENV[templatePath];
		$template->compile_dir = SYS_PATH.'sysdata/templates_c/';
		$template->assign('NodeInfo', $NodeInfo);


		if(!class_exists('TplVarsAdmin')) {
			require_once INCLUDE_PATH.'admin/TplVarsAdmin.class.php';
		}


		$tpl_vars = TplVarsAdmin::getAll();
		foreach($tpl_vars as $key=>$var) {//模板变量赋值

			if($var['IsGlobal']) {//全局模板变量
				$template->assign($var['VarName'], $var['VarValue']);	
			} else {
				if(preg_match("/,".$this->NodeInfo['NodeID']."/isU", $var['NodeScope'])) {//单个结点匹配
					$template->assign($var['VarName'], $var['VarValue']);	
				} else {
					foreach(explode('%', $this->NodeInfo['ParentNodeID']) as $varIn) {
						if(preg_match("/all-".$varIn."/isU", $var['NodeScope'])) { //包含子结点模式匹配
							$template->assign($var['VarName'], $var['VarValue']);	
						}
					}
				}
			}

 		}

		//获取模板路径
		if(preg_match("/\{TID:([0-9]+)\}/isU", $PublishInfo['Tpl'], $matches)) { 
			require_once INCLUDE_PATH."admin/cate_tpl_admin.class.php";
			if(!isset($cate_tpl)) {
				$cate_tpl = new cate_tpl_admin();
				$TID = $matches[1];
				$TInfo = $cate_tpl->getInfo($TID);
				$tplname="/ROOT/".$TInfo[TCID]."/".$TInfo[TID].".tpl";
					
			}
				
		} else {
			$tplname = $PublishInfo['Tpl'];
		}


		if(!empty($tplname)) {			
			if(!file_exists($template->template_dir. $tplname)) {
				new Error("Error: The  template  \'{$template->template_dir}{ $tplname}\' does not exits, Please Set it First to run.");
				return false;
			}

		} else {
			new Error("Error: You have not set the template, Please Set it First.");
			return false;
		
		} 

		$template->registerPreFilter('CMS_Parser');
		$template->assign_by_ref('PublishInfo', $PublishInfo);

		$output=$template->fetch($tplname, 1); //Get the parsed content,ready for publishing.

		if($this->_publishing($NodeInfo,$PublishInfo,$filename, $output)) {
			return true;
		}else 
			return false;

	
	}


	function _publishing(&$NodeInfo,&$PublishInfo, $filename,$content)
	{	
		if(!class_exists('psn_admin')) {
			require_once INCLUDE_PATH."admin/psn_admin.class.php";
			
		}

		$psn = new psn_admin();

		$patt = "/{PSN:([0-9]+)}([\S]*)/is";

		if(!empty($PublishInfo[SelfPSN])) {
			preg_match ($patt, $PublishInfo[SelfPSN] ,$matches);
		
		} else {
			preg_match ($patt, $NodeInfo[ContentPSN] ,$matches);
		
		}
		$PSNID = $matches[1];
		$publish_path = $matches[2];

		$psnInfo = $psn->getPSNInfo($PSNID);
		$psn->connect($psnInfo[PSN]);
		$filename = $publish_path.'/'.$filename;
		
		$psn->isLog = false;
		if($psn->put($filename, $content)) {
			$psn->close();
			return true;
		} else {
			$psn->close();
			return false;
		
		}
	}


	function getHtmlURL($PublishInfo, $NodeInfo) 
	{	
		$patt = "/{PSN-URL:([0-9]+)}([\S]*)/is";
		$publishFileName = $PublishInfo[PublishFileName];

		if(!empty($PublishInfo[SelfPSNURL])) {
			if(preg_match ($patt, $PublishInfo[SelfPSNURL] ,$matches)) {
				$PSNID = $matches[1];
				$publish_path = $matches[2];
				$psnInfo = psn_admin::getPSNInfo($PSNID);

				$url = $psnInfo[URL].$publish_path.'/'.$publishFileName;
		
			
			}  	
		} else {
 			$ContentURL = str_replace('{NodeID}', $NodeInfo['NodeID'], $NodeInfo[ContentURL]);
			if(preg_match ($patt, $ContentURL ,$matches)) {
				$PSNID = $matches[1];
				$publish_path = $matches[2];
				$psnInfo = psn_admin::getPSNInfo($PSNID);

				$url = $psnInfo[URL].$publish_path.'/'.$publishFileName;
		
			
			} else {
				$url = $ContentURL.'/'.$publishFileName;
			}		
		}
		if(preg_match("/\{Page\}/isU", $url)) {
				$url = str_replace("{Page}",'', $url);
		} 
 		return $url;
	}

}
?>