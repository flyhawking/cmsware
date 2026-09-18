<?php
//if(!defined("CLASS_PATH")) define("CLASS_PATH", dirname(__FILE__)."/classes/");
$GLOBALS['CLASS_PATH'] = array();
if(defined("LIB_PATH"))  $GLOBALS['CLASS_PATH'][] = LIB_PATH;

function get_file_path($class_path) {
	
	if(strpos($class_path, ".") !== false) { //namespace path
		$filename = str_replace('.', DIRECTORY_SEPARATOR, $class_path);
		$filename = CLASS_PATH.DIRECTORY_SEPARATOR.$filename;

	} else $filename = $class_path;

    $ext = pathinfo($filename, PATHINFO_EXTENSION);
    if ($ext == '') { $filename .= '.php'; }

    // 首先搜索当前目录
    if (is_readable($filename)) { return realpath($filename); }
	
	if (is_array($GLOBALS['CLASS_PATH'])) {
		$filename = str_replace('.', DIRECTORY_SEPARATOR, $class_path);
		$ext = pathinfo($filename, PATHINFO_EXTENSION);
		if ($ext == '') { $filename .= '.php'; }
		
		foreach ($GLOBALS['CLASS_PATH'] as $classdir) {
            $path = $classdir . DIRECTORY_SEPARATOR . $filename;
            if (is_readable($path)) {
                return realpath($path);
            }
        }
    }
    return false;
}


/**
 * 载入指定类的定义文件
 *
 * 关于类的命名规则请参考 @see get_file_path 。
 *
 * 用法：
 * <code>
 * load_class('FLEA_Helper_Pager');
 * $pager =& new FLEA_Helper_Pager(...);
 * </code>
 *
 * @param string $className
 *
 * @return boolean
 */
function load_class($class_path) {
	$className = str_replace(".", "_", $class_path);
	
	if (class_exists($className)) { return true; }

    $filename = get_file_path($class_path);
    if ($filename) {
        require_once($filename);
        if (class_exists($className)) { return true; }
    }

    // 文件中没有指定类的定义
	trigger_error("$filename not exists, $className not found", E_USER_ERROR);
	return false;
}

/**
 * 返回指定对象的唯一实例
 *
 * 该函数是一个通用的单子设计模式实现。当使用同样的类名称作为参数时，
 * get_singleton() 会返回该类的同一个实例。
 *
 * 在 PHP 中，大多数情况下，提供服务的对象（例如数据库访问、业务逻辑）都只需要
 * 唯一的一个实例。使用该函数，可以不用自己为指定的类实现单子设计模式，提高了
 * 开发效率。
 *
 * 注意：如果类的构造函数要求提供参数，那么不能用 get_singleton() 来获取该类的实例。
 *
 * 用法：
 * <code>
 * $obj =& get_singleton('MY_OBJ');
 * $obj2 =& get_singleton('MY_OBJ');
 * // 此时 $obj 和 $obj2 实际上指向同一个对象的实例
 * </code>
 *
 * @param string $className
 *
 * @return object
 */
function & get_singleton($class_path) {
    static $objs = array();
	
	$className = str_replace(".", "_", $class_path);

    if (isset($objs[$className])) { return $objs[$className]; }
    if (!class_exists($className)) { load_class($class_path); }
	
	$objs[$className] = new $className();
    

    return $objs[$className];
}

function import($class_path) {
	return load_class($class_path);
}


function logger($_msg, $_level = 'INFO') 
{
	$debuginfo = debug_backtrace();
	$file = pathinfo($debuginfo[0]['file']);
	
	if(is_array($_msg)) {
		$_msg = "Array ".var_export($_msg, TRUE);
	} elseif(is_bool($_msg)) {
		$_msg = $_msg ? "Boolean TRUE" : "Boolean FALSE";
	} elseif(is_int($_msg)) {
		$_msg = "INT ".$_msg ;
	}
	
	switch($_level) {
		case "error":
			echo "ERROR [{$file['basename']}:{$debuginfo[0]['line']}] ".$_msg."\n";
			break;
		case "INFO":
		case "info":
		default:
			echo "INFO [{$file['basename']}:{$debuginfo[0]['line']}] ".$_msg."\n";
			break;
	}
}
?>