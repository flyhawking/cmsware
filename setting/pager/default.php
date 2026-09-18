<?php
			if (preg_match_all($patt, $publishInfo[$mainContentLabel], $match)) {
					$contentArray = preg_split($patt, $publishInfo[$mainContentLabel]);

					if($contentArray[0] == "") {
						$contentArray = array_slice ($contentArray, 1); 
						
						$pagenum=count($contentArray);
						$pagenum_pre = $pagenum;
						$this->mDoc[PageNum]=$pagenum;
						$totalnum=$pagenum;
						$pagenum--;
						$pagenum_pre--;
						$hawking = 1;
					} else {
						$pagenum=count($contentArray);
						$pagenum_pre = $pagenum;
						$this->mDoc[PageNum]=$pagenum;
						$totalnum=$pagenum;
						$pagenum--;
						$pagenum_pre--;
						$hawking = 0;
					}

					do { 
						if($pagenum_pre==0) 
							$sign='';
						else	$sign='_'.$pagenum_pre;
						
						
						
						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}
						//$publishFileName = str_replace('.', $sign.".", $publishFileName);
						$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

						if ($hawking==1) {
							
							$pageNav[] = array(
								'Title' => $match[1][$pagenum_pre],
								'URL' => $publishFileName,
								'Link' => $publishFileName,
							);
						} else {
							if($match[1][$pagenum_pre-1] == '')
								$match[1][$pagenum_pre-1]= $IndexPageTitle;
							$pageNav[] = array(
								'Title' => $match[1][$pagenum_pre-1],
								'URL' => $publishFileName,
								'Link' => $publishFileName,
							);
						}
					} while($pagenum_pre--);
					
					$pageNav = array_reverse ($pageNav);

					do {
						$pagenumlist=$totalnum;
						$pagenumlist--;
						$pagelist='';

						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}
					//	$publishFileName = str_replace(".", "{symbol}{page}.", $publishFileName);
						$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU", "{symbol}{page}.\\1", $publishFileName);
						//echo $publishFileName ;
						$pagelist =  Content_Page($totalnum,$pagenum+1,$publishFileName) ;
						
						$template->assign($mainContentLabel,$contentArray[$pagenum]);
						if($hawking == 1)
							$template->assign($_pageTitle,$match[1][$pagenum]);
						else
							$template->assign($_pageTitle,$match[1][$pagenum-1]);
						$template->assign($_pageList,$pagelist);
						$template->assign($_pageNav, $pageNav);

						$GLOBALS['_CMS']['ContentPageNav'] = $pageNav;
						$GLOBALS['_CMS']['CurrentPage'] = $pagenum;
						$GLOBALS['_CMS']['PublishDate'] = $publishInfo['PublishDate'];
						$GLOBALS['_CMS']['NodeID'] = $publishInfo['NodeID'];

						
						if($pagenum == 0)
							$sign = '';
						else
							$sign = '_'.$pagenum;


						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}

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

						//$publishFileName = str_replace('.', $sign.".", $publishFileName);
						$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

						if($pagenum == 0) { //解决URL丢失问题
							if($this->publishInfo[Type] == 1 || $this->publishInfo[Type] == 0 || $this->publishInfo[Type] == 3) {
								$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);

								$this->flushData();
								foreach($FieldsInfo as $key=>$var) {
									if(empty($var['EnablePublish'])) continue;
									$this->addData($var[FieldName],  $publishInfo[$var[FieldName]]);
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
						$output = $template->fetch($tplname, 0); //Get the parsed page content,ready for publishing.
						$output = restoreXMLHeader($output) ;


						if($this->_publishing($publishFileName,$output)) 
							$right=true;
						else
							$right=false;
					}while($pagenum--);

					
					
				} elseif(preg_match_all($patt1, $publishInfo[$mainContentLabel], $match)) {
					$contentArray = preg_split($patt1, $publishInfo[$mainContentLabel]);

					if($contentArray[0] == "") {
						$contentArray = array_slice ($contentArray, 1); 
						
						$pagenum=count($contentArray);
						$pagenum_pre = $pagenum;
						$this->mDoc[PageNum]=$pagenum;
						$totalnum=$pagenum;
						$pagenum--;
						$pagenum_pre--;
						$hawking = 1;
					} else {
						$pagenum=count($contentArray);
						$pagenum_pre = $pagenum;
						$this->mDoc[PageNum]=$pagenum;
						$totalnum=$pagenum;
						$pagenum--;
						$pagenum_pre--;
						$hawking = 0;
					}

					do { 
						if($pagenum_pre==0) 
							$sign='';
						else	$sign='_'.$pagenum_pre;
						
						
						
						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}
						//$publishFileName = str_replace('.', $sign.".", $publishFileName);
						$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

						if ($hawking==1) {
							
							$pageNav[] = array(
								'Title' => $match[1][$pagenum_pre],
								'URL' => $publishFileName,
								'Link' => $publishFileName,
							);
						} else {
							if($match[1][$pagenum_pre-1] == '')
								$match[1][$pagenum_pre-1]= $IndexPageTitle;
							$pageNav[] = array(
								'Title' => $match[1][$pagenum_pre-1],
								'URL' => $publishFileName,
								'Link' => $publishFileName,
							);
						}
					} while($pagenum_pre--);
					
					$pageNav = array_reverse ($pageNav);

					do {
						$pagenumlist=$totalnum;
						$pagenumlist--;
						$pagelist='';

						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}
						//$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

						$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU", "{symbol}{page}.\\1", $publishFileName);
						//echo $publishFileName ;
						$pagelist =  Content_Page($totalnum,$pagenum+1,$publishFileName) ;
						
						$template->assign($mainContentLabel,$contentArray[$pagenum]);
						if($hawking == 1)
							$template->assign($_pageTitle,$match[1][$pagenum]);
						else
							$template->assign($_pageTitle,$match[1][$pagenum-1]);
						$template->assign($_pageList,$pagelist);
						$template->assign($_pageNav, $pageNav);

						
						if($pagenum == 0)
							$sign = '';
						else
							$sign = '_'.$pagenum;


						if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
							$publishFileName = $publishInfo[SelfPublishFileName];
						} else {
							eval ("\$publishFileName = \"$PublishFileFormat\";");
						
						}

					if(!empty($this->NodeInfo[SubDir]) && empty($publishInfo[SelfPSNURL])) {
							if($this->NodeInfo[SubDir] == 'auto') {
								$publishFileName = $this->makeIndexSavePath($IndexID).'/'.$publishFileName;
						
							} else {
								$publishFileName = date ($this->NodeInfo[SubDir],$this->publishInfo[CreationDate]).'/'.$publishFileName;
						
							}					
					} elseif(!empty($publishInfo[SelfPSNURL])) {
						$publishFileName =  $publishFileName;
						
					}

						//$publishFileName = str_replace('.', $sign.".", $publishFileName);
						$publishFileName = preg_replace("/\.([A-Za-z0-9]+)$/isU",$sign.".\\1", $publishFileName);

						//修复第一次刷新URL丢失
						$realURL = $this->getHtmlURL($publishFileName);
						$template->assign('URL', $realURL);
						if($pagenum == 0) {//解决URL丢失问题
							if($this->publishInfo[Type] == 1 || $this->publishInfo[Type] == 0 || $this->publishInfo[Type] == 3) {
								$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);

								$this->flushData();
								foreach($FieldsInfo as $key=>$var) {
									if(empty($var['EnablePublish'])) continue;
									$this->addData($var[FieldName],  $publishInfo[$var[FieldName]]);
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


					 
						$output = $template->fetch($tplname, 0); //Get the parsed page content,ready for publishing.
						$output = restoreXMLHeader($output) ;

						if($this->_publishing($publishFileName,$output)) 
							$right=true;
						else
							$right=false;
					}while($pagenum--);

					
					
				
				
				}else {
					$template->assign($mainContentLabel,$publishInfo[$mainContentLabel]);
					//$template->registerPreFilter('CMS_Parser');

					//debug($NodeInfo);
					if($publishInfo[SelfPublishFileName] != '') { //格式化发布文件名
						$publishFileName = $publishInfo[SelfPublishFileName];
					} else {
						eval ("\$publishFileName = \"$PublishFileFormat\";");
						
					}
					
					
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
						 //解决URL丢失问题
							if($this->publishInfo[Type] == 1 || $this->publishInfo[Type] == 0 || $this->publishInfo[Type] == 3) {
								$FieldsInfo = content_table_admin::getTableFieldsInfo($NodeInfo[TableID]);

								$this->flushData();
								foreach($FieldsInfo as $key=>$var) {
									if(empty($var['EnablePublish'])) continue;
									$this->addData($var[FieldName],  $publishInfo[$var[FieldName]]);
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
					 
 					$output=$template->fetch($tplname, 0); //Get the parsed content,ready for publishing.
					//echo $template->_tpl_vars[Content];exit;
					$output = restoreXMLHeader($output) ;

					if($this->_publishing($publishFileName,$output)) 
							$right=true;
					else
							$right=false;
				}
			//	print_r($template->_tpl_vars); 

?>