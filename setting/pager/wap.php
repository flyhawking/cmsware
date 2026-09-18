<?php

$contentArray =  wapAutoPage(web2wap($publishInfo[$mainContentLabel]));
$PageNum = count($contentArray);
$pagenum_pre = 0 ; 


foreach($contentArray as $key=>$var) {
						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}

 						$pagelist =  wap_page($PageNum, $key+1,  $publishFileName) ;


						if(!empty($this->NodeInfo[SubDir]) && empty($publishInfo[SelfPSNURL])) {
							if($this->NodeInfo[SubDir] == 'auto') {
								$publishFileName = $this->makeIndexSavePath($IndexID).'/'.$publishFileName;
						
							} else {
								$publishFileName = date ($this->NodeInfo[SubDir],$this->publishInfo[CreationDate]).'/'.$publishFileName;
						
							}
						
						} elseif(!empty($publishInfo[SelfPSNURL])) {
							$publishFileName =  $publishFileName;
						
						}

						//修复第一次刷新URL丢失
						$realURL = $this->getHtmlURL($publishFileName);
						$template->assign('URL', $realURL);

						//$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

						if($key == 0) { //解决URL丢失问题
							if($this->publishInfo[Type] == 1 || $this->publishInfo[Type] == 0 || $this->publishInfo[Type] == 3) {
								$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);

								$this->flushData();
								foreach($FieldsInfo as $keyIn=>$varIn) {
									if(empty($varIn['EnablePublish'])) continue;
									$this->addData($varIn[FieldName],  $publishInfo[$varIn[FieldName]]);
								}
								$this->addData('IndexID', $publishInfo[IndexID]);
								$this->addData('ContentID', $publishInfo[ContentID]);
								$this->addData('NodeID', $publishInfo[NodeID]);
								$this->addData('PublishDate', $publishInfo[PublishDate]);
								$this->addData('URL', $realURL);
								$publishInfo['URL'] = $realURL; //fix FullText Plugin `lost URL` Bug
								$this->publishUpdate($NodeInfo['TableID']);
								if(!isset($Plugin)) {
									require_once INCLUDE_PATH."admin/plugin.class.php";
									$Plugin = new Plugin();
								}  
								$Plugin->update($publishInfo);
								

							}						
						
						}
 					
						

	$template->assign("PageNum", $key+1);				
	$template->assign($_pageList, $pagelist);				
	$template->assign($mainContentLabel, $contentArray[$key]);
	$output = $template->fetch($tplname); //Get the parsed page content,ready for publishing.
	//$output = restoreXMLHeader($output);
	if($pagenum_pre == 0)
		$sign = '';
	else $sign = '_'.$pagenum_pre;

	$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

 
	if($this->_publishing($publishFileName,$output)) 
		$right=true;
	else
		$right=false;

	$pagenum_pre++;
}

if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
		$publishFileName = $publishInfo[SelfPublishFileName];
} else {
		eval ("\$publishFileName = \"$PublishFileFormat\";");
						
}
if(!empty($this->NodeInfo[SubDir]) && empty($publishInfo[SelfPSNURL]))
	$publishFileName = date ($this->NodeInfo[SubDir],$this->publishInfo[CreationDate]).'/'.$publishFileName;
elseif(!empty($publishInfo[SelfPSNURL])) {
	$publishFileName =  $publishFileName;
						
}
?>