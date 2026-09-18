<?php
define('ActionErrors_GLOBAL_ERROR', 1);
define('ActionMapping_Referer', 8);

if(!defined("DS")) {
	if(DIRECTORY_SEPARATOR == "\\") define("DS", "\\\\");
	else define("DS", "/");
}

if(!defined("BASE_PATH")) {
	define("BASE_PATH", ROOT_PATH);
}

/**
 * 
 * MUST define : KDB_DIR, KTPL_DIR, ROOT_PATH, CLS_PATH, TMP_DIR
 *  
 */
class Struts {
	var $TPL;

	var $config;
	var $request;
	var $action_cfg;

	function Struts(&$STRUTS_CONFIG, &$IN)
	{
		global $db_config, $db, $SYS_ENV;

		$this->config = &$STRUTS_CONFIG;
		$this->request = &$IN;

		$action = $IN['do'];
		if(empty($action) || !isset($STRUTS_CONFIG['action-mappings'][$action])) $action = "default";
			//$this->stop("Action [$action] does not exists!");

		$action_cfg = &$STRUTS_CONFIG['action-mappings'][$action];
		$this->action_cfg = &$STRUTS_CONFIG['action-mappings'][$action];

		if(!isset($action_cfg['db']) || $action_cfg['db']) {
			if(!isset($db) || !is_resource($db)) {
				require_once KDB_DIR . 'kDB.php';
				$db = new kDB($db_config['db_driver']);
				$db->connect($db_config);
				$db->setDebug($SYS_ENV['enable_debug_pro']);
				$db->setFetchMode('assoc');
				$db->setCacheDir(TMP_DIR.'cache'.DS);		
			}
		}



		if(!isset($action_cfg['tpl']) || $action_cfg['tpl']) {
			require_once KTPL_DIR . 'kTemplate.class.php';
 			$this->TPL = new kTemplate();
			$this->TPL->template_dir = BASE_PATH.$STRUTS_CONFIG['template-resources'].DS;
			$this->TPL->compile_dir = TMP_DIR.'templates_c'.DS;
			$this->TPL->cache_dir = TMP_DIR.'cache'.DS;
			$this->TPL->compile_lang = true;
			$this->TPL->global_lang_name = BASE_PATH.$STRUTS_CONFIG['message-resources']['language-dir'].DS.$SYS_ENV['language'].DS.$STRUTS_CONFIG['message-resources']["templates-global-messages-resource"];
			$this->TPL->lang_dir = BASE_PATH.$STRUTS_CONFIG['message-resources']['language-dir'].DS.$SYS_ENV['language'].DS.$STRUTS_CONFIG['message-resources']["template-messages-package"].DS;
 			$this->TPL->assign_by_ref('SYS_ENV', $SYS_ENV);

			$session_id_name = $STRUTS_CONFIG['session-id-name'];
 			$this->TPL->assign($session_id_name, $IN[$session_id_name]);
			$this->TPL->assign('base_url', $STRUTS_CONFIG['entrance']."?{$session_id_name}=".$IN[$session_id_name]."&amp;");

			
			$this->TPL->assign('SYS_NAME', $SYS_ENV['sys_name']);
			$this->TPL->assign('html_url', $SYS_ENV['html_url']);
			
 			$this->TPL->assign('Action', $action);
			$this->TPL->assign('charset', CHARSET);
			$this->TPL->assign_by_ref("Request", $IN);
			$this->TPL->registerPreFilter("StrutsCompiler");
		}


		

	}

	function doing()
	{
		if(!$this->request[referer]) 	$referer =  _addslashes($_SERVER["HTTP_REFERER"]);
		else 	$referer = $this->request[referer];

		$this->TPL->assign('referer', $referer);

		$ActionMapping = new ActionMapping($this->config, $this->TPL);
		$ActionMapping->sId = $this->request[$this->config['session-id-name']];
		$ActionMapping->referer = $referer;


 		if(!isset($this->action_cfg['forward'])) {
			$ActionForm = &$this->loadActionForm($ActionMapping, $this->action_cfg);
			$this->loadAction($ActionMapping, $this->action_cfg, $ActionForm);
		
		} else {
			if(isset($this->action_cfg['type'])) {
				$this->loadAction($ActionMapping, $this->action_cfg, $ActionForm);
			} else {
				$ActionMapping->doForward($this->action_cfg['forward']);
		
			}
		
		}
	
	}

	function tpl_assign($_key, $_value) 
	{
		if(isset($this->TPL)) {
			$this->TPL->assign($_key, $_value);
		}
	}
	
	function &loadActionForm(&$ActionMapping, $action_cfg)
	{
		$formBeanName = $action_cfg['attribute'];
		if(empty($formBeanName)) return;//no ActionForm defined , goto Action
		$form_bean_type = &$this->config['form-beans'][$formBeanName]['type'];
		
		if(empty($form_bean_type)) $this->stop("FormBean [$formBeanName] does not exists!");

		if($form_bean_type == 'super') {
			$FormBean = new ActionForm();
		
		} else {
			$form_class_path = str_replace('.', DS, $form_bean_type);
			$form_class_path =  CLS_PATH.$form_class_path.".php";
			
			if(file_exists($form_class_path)) require_once $form_class_path;
			else $this->stop("ActionForm File $form_class_path does not exists!");

			$FormBean = new $formBeanName();
			
		}
		$errors = new ActionErrors();

		foreach($this->config['form-beans'][$formBeanName]['form-property'] as $key=>$var ) {
			if(is_array($var)) {
				if(isset($var['validator'])) {
					if(!$FormBean->checkData($this->request[$key], $var['validator'])) {
						$errors->add(ActionErrors_GLOBAL_ERROR, "struts.validator.".$formBeanName.'.'.$key);
					}
				}
				switch($var['type']) {
					case 'int':
						$FormBean->set($key, (int)$this->request[$key]);
						break;
					case 'string':
						$FormBean->set($key, $this->request[$key]);
						break;
				}		
			} else {
				switch($var) {
					case 'int':
						$FormBean->set($key, (int)$this->request[$key]);
						break;
					case 'string':
						$FormBean->set($key, $this->request[$key]);
						break;
				}		
			}
 			
		}

		// trigger some invalid input data errors, back to the input
		if(!empty($errors->errors)) { 
			$this->TPL->assign("Struts_Errors", $errors->errors);
			$this->TPL->assign("Struts_BackInput", 1);
			
			$ActionMapping->doForward($action_cfg['input']);
		}
 
		$errors = &$FormBean->validate($this->TPL, $this->request); //ActionForm run

		if(!empty($errors->errors)) { // trigger some errors, back to the input
 			$this->TPL->assign("Struts_Errors", $errors->errors);
			$this->TPL->assign("Struts_BackInput", 1);
			$ActionMapping->doForward($action_cfg['input']);
		}
		return $FormBean;
	}

	function loadAction(&$ActionMapping, $action_cfg, &$ActionForm)
	{
		$actionName = $action_cfg['type'];
		$action_class_path = CLS_PATH.str_replace('.', DS, $actionName).".php";
		if(file_exists($action_class_path)) require_once $action_class_path;
		else $this->stop("Action File $action_class_path does not exists!");

		$ActionClassName = $this->getActionClassName($actionName);

		$Action = new $ActionClassName();

		$errors = &$Action->execute($ActionMapping, $ActionForm, $this->request, $this->TPL);
		
		if(!empty($errors->errors)) { // trigger some errors, back to the input
 			$this->TPL->assign("Struts_Errors", $errors->errors);
			$this->TPL->assign("Struts_BackInput", 1);
			$ActionMapping->doForward($action_cfg['input']);
		} elseif(isset($action_cfg['forward'])) {
			$ActionMapping->doForward($action_cfg['forward']);
		}
	
	}
	
	function getActionClassName($actionNS)
	{
		return  array_pop(explode('.', $actionNS));
	}
	


	function stop($msg)
	{
		die("<B>Struts Error:</B> ". $msg . "<BR>");
	}

}

/**
 * Struts Action Class
 * @access  public
 */
class Action {
	
	/**
	 * Method execute
	 * @param ActionMapping $mapping
	 * @param ActionForm $form
	 * @param HttpRequestArray $IN
	 * @param kTemplate $TPL
	 * @access  public
	 */
	function execute(&$ActionMapping, &$ActionForm, &$IN, &$TPL)
	{
	}

}

/**
 * Struts ActionForm Class
 * @access  public
 */
class ActionForm {
	
	var $bean = array();
	
    /**
	 * @param ActionMapping $ActionMapping
	 * @param HttpRequestArray $IN  
	 */
	function  &validate(&$ActionMapping, &$IN) 
	{
	}

	function  checkData($data, $validator)
	{
 		if(preg_match("/^(.*)\.([a-zA-Z0-9_]+)$/is", $validator, $match)) {

			$validator_class_path = CLS_PATH.str_replace('.', DS, $match[1]).".php";

			if(file_exists($validator_class_path)) require_once $validator_class_path;
			else die("Struts Error : Validator File [ $validator_class_path ] does not exists!");
			
			$validationFunctionName = array_pop(explode('.', $match[1])).'__'.$match[2];
			if($validationFunctionName($data)) {
				return true;
			} else return false;
		} else {
			return false;
		}

	}

	function get($key)
	{
		return $this->bean[$key];
	}

	function set($key, $value)
	{
		$this->bean[$key] = $value;
	}

}

/**
 * Struts ActionMapping Class
 * @access  public
 */
 class ActionMapping {
	
	var $mapping = array();
	var $TPL;
	var $strutsConfig;
	var $actionErrors;
	var $sId;
	var $_parameter = array();
	
	/**
	* @param array $STRUTS_CONFIG   
	* @param kTemplate Object $TPL
	*/
	function ActionMapping(&$STRUTS_CONFIG, &$TPL) 
	{
		$this->mapping = &$STRUTS_CONFIG['global-forwards'];
		$this->strutsConfig = &$STRUTS_CONFIG;
		$this->TPL = &$TPL;
	}

	function findForward($forward)
	{
		if(isset($this->mapping[$forward])) {
			$this->doForward($this->mapping[$forward]);
		} else {
			$this->doForward($this->mapping['default']);
		}
	}

	function doHeaderAction($url_forward)
	{
		global $STRUTS_CONFIG;
		if($STRUTS_CONFIG['session-id-store'] == 'page') {
			
			$session_id_name = $STRUTS_CONFIG['session-id-name'];

			if($url_forward == ActionMapping_Referer){
				$url_forward =  $this->referer;					
			} elseif(isset($this->strutsConfig['action-mappings'][$url_forward])) {
	
				$url_forward = "{$STRUTS_CONFIG['entrance']}?{$session_id_name}={$this->sId}&do=".$url_forward;		
			} elseif(empty($url_forward)) {
				$url_forward = $STRUTS_CONFIG['entrance'];		
			} 
		
		} else {
			if($url_forward == ActionMapping_Referer){
				$url_forward =  $this->referer;					
			} elseif(isset($this->strutsConfig['action-mappings'][$url_forward])) {
				$url_forward = "{$STRUTS_CONFIG['entrance']}?do=".$url_forward;		
			} elseif(empty($url_forward)) {
				$url_forward = $STRUTS_CONFIG['entrance'];		
			} 
		
		}

		header("Location: ".$url_forward.$this->getParams("&"));
		exit;
	}

	function addParameter($_key, $_value)
	{
		$this->_parameter[$_key] = $_value;
	}

	function getParams($_sep = "&amp;")
	{
		$params = "";
		if(!empty($this->_parameter)) {
			foreach($this->_parameter as $key=>$var) {
				$params .= $_sep.$key."=".urlencode($var);
			}
		}

		return $params;
	}

	function doForwardAction($url_forward, $jumpMsg = '', $jumpTime = 1)
	{
		global $_LANG_MESSAGES,$STRUTS_CONFIG;

		if(preg_match("/^[0-9A-Za-z]+\.[0-9A-Za-z]+/isU", $jumpMsg)) {
			if(isset($_LANG_MESSAGES[$jumpMsg])) $jumpMsg = $_LANG_MESSAGES[$jumpMsg];
			else $jumpMsg = "Application Resources [ $jumpMsg ] does not exists!";
		} 

		$this->TPL->assign('show_message', $jumpMsg);	
		$this->TPL->assign('delay', $jumpTime);		
		
		if($STRUTS_CONFIG['session-id-store'] == 'page') {
			
			$session_id_name = $STRUTS_CONFIG['session-id-name'];

			if($url_forward == ActionMapping_Referer){
				$this->TPL->assign('url_forward', $this->referer);					
			} elseif(isset($this->strutsConfig['action-mappings'][$url_forward])) {
	
				$this->TPL->assign('url_forward', "{$STRUTS_CONFIG['entrance']}?{$session_id_name}={$this->sId}&amp;do=".$url_forward.$this->getParams());		
			} elseif(empty($url_forward)) {
				$this->TPL->assign('url_forward', $STRUTS_CONFIG['entrance']);		
			} else {
				$this->TPL->assign('url_forward', $url_forward);		
			}
		
		} else {
			if($url_forward == ActionMapping_Referer){
				$this->TPL->assign('url_forward', $this->referer);					
			} elseif(isset($this->strutsConfig['action-mappings'][$url_forward])) {
				$this->TPL->assign('url_forward', "{$STRUTS_CONFIG['entrance']}?do=".$url_forward.$this->getParams());		
			} elseif(empty($url_forward)) {
				$this->TPL->assign('url_forward', $STRUTS_CONFIG['entrance']);		
			} else {
				$this->TPL->assign('url_forward', $url_forward);		
			}
		
		}
		//print_r($this->TPL->_tpl_vars);exit;
		//echo $this->referer;exit;

		
		$this->doForward($this->strutsConfig['template-forward-action']);
	}

	function doForward($tplname)
	{	
		$mime_types = array(
			"html"=> "text/html",
			"htm"=> "text/html",
			"txt"=> "text/plain",	
			"wml"=> "text/vnd.wap.wml",	
			"wmls"=> "text/vnd.wap.wmlscript",	
			"js"=> "application/x-javascript",	
			"xhtml"=> "application/xhtml+xml",	
			"xslt"=> "application/xslt+xml",	
			"xml"=> "application/xml",	
			"xsl"=> "application/xml",	
		);

		$suffix = strtolower(array_pop(explode('.', $tplname)));
		$contentType = isset($mime_types[$suffix]) ? $mime_types[$suffix] : "text/plain";
		//echo $contentType ;exit;
		header("Content-Type: $contentType; charset=".CHARSET);
		if($suffix=='xml') {
			$now = gmdate('D, d M Y H:i:s') . ' GMT';
		    header('Expires: ' . $now);		
		}


		$this->TPL->display($tplname);
		exit;
	}
}

class ActionErrors {

	var $errors = array();

	function add($error_scope, $error_msg, $params = array())
	{
		global $_LANG_MESSAGES;
		if(preg_match("/^[0-9A-Za-z]+\.[0-9A-Za-z]+/isU", $error_msg)) {
			
			if(!isset($_LANG_MESSAGES[$error_msg])) {
				$this->errors[] = "Application Resources [ $error_msg ] does not exists!";
				return;
			}


			if(!empty($params)) {
				foreach($params as $key=>$var) {
					$var = addslashes($var);
					if(empty($key)) $evalStr = "sprintf(\$_LANG_MESSAGES[\$error_msg], \"$var\"";
					else $evalStr .= ", \"$var\"";

					
				}

				$evalStr .= " );"; 
 				eval ("\$data= $evalStr;");
				$this->errors[] = $data;	
			} else {
				$this->errors[] = $_LANG_MESSAGES[$error_msg];	
			}
		} else {
			$this->errors[] = $error_msg;
		}
		
	}

}

/**
 * Struts HTML Compiler
 * action="*.do", href="*.do", src="*.do"
 *
 * @param string $tplContent
 * @access private  
 * @return string  
 */
function StrutsCompiler(&$tplContent)
{	
	global $STRUTS_CONFIG,$SYS_ENV;
	$url = $SYS_ENV['sys_url'];
	
	$search = array (
		"'action=\"([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\"'siU", 
		"'href=\"([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\"'siU", 
		"'src=\"([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\"'siU", 
		"'location=\"([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\"'siU", 

		"'action=\'([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\''siU", 
		"'href=\'([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\''siU", 
		"'src=\'([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\''siU", 
		"'location=\'([a-zA-Z0-9]+)\.do[\?]?([^\?]*)\''siU", 
					 );                     
	
	if($STRUTS_CONFIG['session-id-store'] == 'page') {
		$replace = array (
			"action=\"{$url}/[\$base_url]do=\\1&amp;\\2\"",
			"href=\"{$url}/[\$base_url]do=\\1&amp;\\2\"",
			"src=\"{$url}/[\$base_url]do=\\1&amp;\\2\"",
			"location=\"{$url}/[\$base_url]do=\\1&amp;\\2\"",
			"action='{$url}/[\$base_url]do=\\1&amp;\\2'",
			"href='{$url}/[\$base_url]do=\\1&amp;\\2'",
			"src='{$url}/[\$base_url]do=\\1\&amp;\2'",
			"location='{$url}/[\$base_url]do=\\1&amp;\\2'",

						);	
	} else {
		$replace = array (
			"action=\"{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2\"",
			"href=\"{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2\"",
			"src=\"{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2\"",
			"location=\"{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2\"",
			"action='{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2'",
			"href='{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2'",
			"src='{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1\&amp;\2'",
			"location='{$url}/{$STRUTS_CONFIG['entrance']}?do=\\1&amp;\\2'",

						);
	
	}



	$tplContent = preg_replace ($search, $replace, $tplContent);
	//end action parse


 	$patt = "/<html:errors[\s]+(.*)[\s]*\/>/siU";
	if (preg_match_all($patt, $tplContent, $matches)) {	
		foreach($matches[1] as $key=>$var) {
			//$attributes = StrutsCompiler_parseAttribute($matches[1][$key]);
			$replace = "\n<if test=\"!empty(\$Struts_Errors)\">\n\n<loop name=\"Struts_Errors\" key=\"key\" var=\"var\" >\n";
			$replace .= "· [\$var]<br/>\n";
			$replace .= "</loop>\n\n</if>";
			$tplContent = str_replace($matches[0][$key], $replace,  $tplContent);
		}
	} 

 	$patt = "/<form([^>]+)>(.*)<\/form>/siU";
	if (preg_match_all($patt, $tplContent, $matches)) {
		//print_r($matches);exit;
		foreach($matches[1] as $key=>$var) {
			$attributes = StrutsCompiler_parseAttribute($matches[1][$key]);
			$ActionFormName = $attributes['name'];
			if(isset($STRUTS_CONFIG['form-beans'][$ActionFormName])) {
				$tplContent = StrutsCompiler_parseForm($STRUTS_CONFIG['form-beans'][$ActionFormName]['form-property'], $matches[2][$key], $tplContent);
			} else continue;
		}
		
		
	}


	return $tplContent;

}


function StrutsCompiler_parseForm(&$form_property, $formContent, &$tplContent)
{
	$srcformContent = $formContent;

 	$patt = "/<input[\s]+type=\"radio\"([^>]+)>(.*)<\/input>/siU";
	if (preg_match_all($patt, $formContent, $matches)) {		 
		foreach($matches[1] as $key=>$var) {
			$attributes = StrutsCompiler_parseAttribute($matches[1][$key]);
			$propertyName = $attributes['name'];
			if(isset($form_property[$propertyName])) {
				$replace =  "\n<if test=\"isset(\$Struts_BackInput)\">\n";
				$replace .= "<input type=\"radio\" ".StrutsCompiler_makeAttribute($attributes).">".$matches[2][$key]."</input>";
				$replace .= "\n<else>\n";
				$replace .= $matches[0][$key];
				$replace .= "\n</if>\n";
				$formContent = str_replace($matches[0][$key], $replace, $formContent);
			} else continue;	
		}
	}
 
	$patt = "/<input([^>]+)>/siU";
	if (preg_match_all($patt, $formContent, $matches)) {	
		//print_r($matches);exit;
		foreach($matches[0] as $key=>$var) {
			$attributes = StrutsCompiler_parseAttribute($matches[1][$key]);
			$propertyName = $attributes['name'];
			//print_r($attributes);exit;
			$type = strtolower($attributes['type']);

			if( $type == 'radio' || $type == 'submit' || $type == 'button' || $type == 'reset' ) continue;

			if($type == 'checkbox') {
				if(isset($form_property[$propertyName])) {
					$replace =  "\n<if test=\"isset(\$Struts_BackInput)\">\n";
					$replace .=  "\n	<if test=\"isset(\$Request.".$attributes['name'].")\">\n";
					$replace .= "<input ".StrutsCompiler_makeAttribute_checkbox($attributes)." checked>".$matches[2][$key]."</input>";
					$replace .= "\n		<else>\n";
					$replace .= "<input ".StrutsCompiler_makeAttribute_checkbox($attributes).">".$matches[2][$key]."</input>";
					$replace .= "\n		</if>\n";
					$replace .= "\n<else>\n";
					$replace .= $matches[0][$key];
					$replace .= "\n</if>\n";
					$formContent = str_replace($matches[0][$key], $replace, $formContent);
					continue;
				} else continue;	
			
			}

			if(isset($form_property[$propertyName])) {
				$replace =  "\n<if test=\"isset(\$Struts_BackInput)\">\n";
				$replace .= "<input ".StrutsCompiler_makeAttribute2($attributes)." >";
				$replace .= "\n<else>\n";
				$replace .= $matches[0][$key];
				$replace .= "\n</if>\n";
				$formContent = str_replace($matches[0][$key], $replace, $formContent);
			} else continue;	
		}
	}


 	$patt = "/<select([^>]+)>(.*)<\/select>/siU";
	if (preg_match_all($patt, $formContent, $matches)) {		 
		foreach($matches[1] as $key=>$var) {
			$attributes = StrutsCompiler_parseAttribute($matches[1][$key]);
			$propertyName = $attributes['name'];
			if(isset($form_property[$propertyName])) {
				$replace =  "\n<if test=\"isset(\$Struts_BackInput)\">\n";
				$replace .= "<select ".StrutsCompiler_makeAttribute($attributes).">".$matches[2][$key]."</select>";
				$replace .= "\n<else>\n";
				$replace .= $matches[0][$key];
				$replace .= "\n</if>\n";
				$formContent = str_replace($matches[0][$key], $replace, $formContent);
			} else continue;	
		}
	}



 	$patt = "/<textarea([^>]+)>(.*)<\/textarea>/siU";
	if (preg_match_all($patt, $formContent, $matches)) {		 
		foreach($matches[1] as $key=>$var) {
			$attributes = StrutsCompiler_parseAttribute($matches[1][$key]);
			$propertyName = $attributes['name'];
			if(isset($form_property[$propertyName])) {
				$replace =  "\n<if test=\"isset(\$Struts_BackInput)\">\n";
				$replace .= "<textarea ".StrutsCompiler_makeAttribute($attributes).">[\$Request.".$attributes['name']."]</textarea>";
				$replace .= "\n<else>\n";
				$replace .= $matches[0][$key];
				$replace .= "\n</if>\n";
				$formContent = str_replace($matches[0][$key], $replace, $formContent);
			} else continue;	
		}
	}

	$tplContent =   str_replace($srcformContent, $formContent, $tplContent);
	return $tplContent;

}

function StrutsCompiler_makeAttribute($attributes)
{
	$setValue = false;
	foreach($attributes as $key=>$var) {
		if($key=="value") {
			$setValue = true;
			$return .= " value=\"{\$Request.".$attributes['name']."}\" ";
		} else $return .= " $key=\"$var\" ";
	}

	if(!$setValue ) $return .= " value=\"{\$Request.".$attributes['name']."}\" ";
	
	return $return;
}

function StrutsCompiler_makeAttribute2($attributes)
{
	$setValue = false;
	foreach($attributes as $key=>$var) {
		if($key=="value") {
			$setValue = true;
			$return .= " value=\"[\$Request.".$attributes['name']."]\" ";
		} else $return .= " $key=\"$var\" ";
	}

	if(!$setValue ) $return .= " value=\"[\$Request.".$attributes['name']."]\" ";
	
	return $return;
}

function StrutsCompiler_makeAttribute_checkbox($attributes)
{
	$setValue = false;
	foreach($attributes as $key=>$var) {
		if($key=="value") {
			$setValue = true;
			$return .= " value=\"[\$Request.".$attributes['name']."]\" ";
		} else $return .= " $key=\"$var\" ";
	}

	if(!$setValue ) $return .= " value=\"[\$Request.".$attributes['name']."]\" ";
	
	return $return;
}

function StrutsCompiler_parseAttribute($Parameter) 
{
 	$pattern = "/([a-zA-Z0-9_]+)=[\"]([^\"]+)[\"]/isU";
	if(preg_match_all($pattern, $Parameter, $matches)) {
 		foreach($matches[0] as $key=>$var) {
			$output[strtolower($matches[1][$key])] = $matches[2][$key];
		
		}
	}
 	return $output;
}


?>