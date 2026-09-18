<?php
/*
 * 参考Java的Spring框架，使用BeanFactory来统一管理和生成类
 * Framework使用$_SPRING_INSTANCE_{instancename}来作为全局实例的名称
 * 好处肯定是明显的,可以大大简化类的使用复杂度
 * 
 * $BeanFactory = new Spring("spring.appcontext.php");
 * $resource = &$BeanFactory->getBean('resource');
 * $classA = &$BeanFactory->createBean('classA');
 * 
 * spring.appcontext.php的内容
 * 
 * $_SPRING_APPCONTEXT['beans'] = array(
 * 	"resource" => array(
 * 					'class_path' => INCLUDE_PATH."admin".DS."resource.class.php",
 * 					'class_name' => "Resource",
 * 					),
 * 	"classA" => array(
 * 						'class'=>"com.cw.ClassA",
 * 						'constructor-arg'=>"",
 * 					),
 * 
 * );
 * 
 */
class Spring {

	/**
	* 存储上下文信息 
	*/
	var $appcontext = array();

	/**
	* 已经使用getBean注册的Bean实例 
	*/
	var $registerBeans = array();
	
	/**
	 * 加载AppContext信息
	 *
 	 * @param string $_ClassPathResource AppContextResource的路径
	 * @access public
	 * @return void
	 */
	function Spring($_ClassPathResource)
	{
		if(!file_exists($_ClassPathResource)) {
			$_ClassPathResource = ADMIN_PATH.$_ClassPathResource;
		}
		include($_ClassPathResource);
		$this->appcontext = $_SPRING_APPCONTEXT;
		unset($_SPRING_APPCONTEXT);

	}

	function &getInstance($_ClassPathResource)
	{
		if(isset($GLOBALS['__Object_SpringBeanFactory']) && is_object($GLOBALS['__Object_SpringBeanFactory']) && get_class($GLOBALS['__Object_SpringBeanFactory']) == 'spring') {
			return $GLOBALS['__Object_SpringBeanFactory'];
		} elseif(isset($GLOBALS['BeanFactory']) && is_object($GLOBALS['BeanFactory']) && get_class($GLOBALS['BeanFactory']) == 'spring') {
			return $GLOBALS['BeanFactory'];
		} else {
			$GLOBALS['__Object_SpringBeanFactory'] = new Spring($_ClassPathResource);
			return $GLOBALS['__Object_SpringBeanFactory'];
		}
	}
	

	/**
	 * 获得实例
	 * 实例只有一个，生成一次，到处采用
 	 * @param string $_bean Bean名称
	 * @access public
	 * @return object reference
	 */
	function &getBean($_bean)
	{
		$_bean_instance_name = "_SPRING_INSTANCE_".$_bean;
		if(isset($GLOBALS[$_bean_instance_name])) {
			return $GLOBALS[$_bean_instance_name];
		} elseif(isset($this->appcontext['beans'][$_bean])) {
			if(isset( $this->appcontext['beans'][$_bean]['class'] )) {
				import($this->appcontext['beans'][$_bean]['class']);

				$class_name = substr(strrchr($this->appcontext['beans'][$_bean]['class'], "." ),1);

				if(isset($this->appcontext['beans'][$_bean]['constructor-arg'])) {
 					$GLOBALS[$_bean_instance_name] = new $class_name($this->appcontext['beans'][$_bean]['constructor-arg']);
				} else {
 					$GLOBALS[$_bean_instance_name] = new $class_name();
				}
				
			} elseif( isset( $this->appcontext['beans'][$_bean]['class_path'] )) {
				require_once($this->appcontext['beans'][$_bean]['class_path']) ;
				
				$class_name = $this->appcontext['beans'][$_bean]['class_name'];
				if(isset($this->appcontext['beans'][$_bean]['constructor-arg'])) {
					$GLOBALS[$_bean_instance_name] = new $class_name($this->appcontext['beans'][$_bean]['constructor-arg']);	
			
				} else {
					$GLOBALS[$_bean_instance_name] = new $class_name();	
				
				}
			} else die("Spring Error: Bean( ".$_bean." ) define error!");
		} else	die("Spring Error: Bean( ".$_bean." ) does not exists!");
		
		$this->registerBeans[] = $_bean;
		return $GLOBALS[$_bean_instance_name];

	}
	
	/**
	 * 生成一个新实例
	 * 
 	 * @param string $_bean Bean名称
	 * @access public
	 * @return object 
	 */
	function &createBean($_bean)
	{
		if(isset($this->appcontext['beans'][$_bean])) {
			if(isset( $this->appcontext['beans'][$_bean]['class'] )) {
				import($this->appcontext['beans'][$_bean]['class']);

				$class_name = substr(strrchr($this->appcontext['beans'][$_bean]['class'], "." ),1);
 				$returnBean = new $class_name();
			} elseif( isset( $this->appcontext['beans'][$_bean]['class_path'] )) {
				require_once($this->appcontext['beans'][$_bean]['class_path']) ;
				
				$class_name = $this->appcontext['beans'][$_bean]['class_name'];
 				$returnBean = new $class_name();
			} else die("Spring Error: Bean( ".$_bean." ) define error!");
		} else	die("Spring Error: Bean( ".$_bean." ) does not exists!");
		
		return $returnBean;
	
	}

	/**
	 * 销毁一个实例
	 * 
 	 * @param string $_bean Bean名称
	 * @access public
	 * @return void
	 */
	function destoryBean($_bean)
	{
		$_bean_instance_name = "_SPRING_INSTANCE_".$_bean;
		if(isset($GLOBALS[$_bean_instance_name])) {
			unset($GLOBALS[$_bean_instance_name]);
		}
		
	}
}
?>