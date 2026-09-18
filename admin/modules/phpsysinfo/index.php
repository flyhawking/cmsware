<?php
// phpSysInfo - A PHP System Information Script
// http://phpsysinfo.sourceforge.net/
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
// $Id: index.php,v 1.3 2005/07/15 07:40:44 Administrator Exp $
// phpsysinfo release version number
if($phpVersion == 5) 	define("PHP_VERSION_5", true);
else	define("PHP_VERSION_5", false);



$VERSION = "2.3";
define('INCLUDE_PATH','../../../include/');
define('PLUGIN_PATH', '../../../plugins/');
define('KTPL_DIR', INCLUDE_PATH.'lib/kTemplate/');
define('LANG_PATH','../../../language/');
define('IN_IWPC',true);
define('SYS_PATH', '../../../');
define('CACHE_DIR','../../../sysdata/');
define('KDB_DIR',INCLUDE_PATH.'lib/kDB/');
define('MODULES_DIR','../../modules/');
define('ADMIN_DIR','../../');
define('SETTING_DIR','../../../setting/');
define('CMSWARE_VERSION', "CMSware 2.1 Plus");
require_once INCLUDE_PATH."admin/auth.class.php";
require_once INCLUDE_PATH."functions.php";
require_once SYS_PATH."config.php";
require_once KTPL_DIR . 'kTemplate.class.php';
require_once KDB_DIR.'kDB.php';

$db = new kDB($db_config['db_driver']);
$db->connect($db_config);
//$db->setDebug(1);
//from ipb
$IN = parse_incoming();
$iWPC = new iWPC();
include_once(CACHE_DIR.'Cache_SYS_ENV.php');
include_once(CACHE_DIR.'Cache_PSN.php');
include_once(CACHE_DIR.'Cache_DSN.php');
include_once(CACHE_DIR.'Cache_CateList.php');
include_once(CACHE_DIR.'Cache_ContentModel.php');

if(!$IN[referer]) 
	$referer =  _addslashes($HTTP_SERVER_VARS[HTTP_REFERER]);
else 
	$referer = $IN[referer];
$params = array(
	'sId'=>$IN['sId'],
	'sIp'=>$IN['IP_ADDRESS'],
);
//echo $referer;
$TPL = new kTemplate();
$TPL->template_dir = SYS_PATH.'skin/admin/';
$TPL->compile_dir = SYS_PATH.'sysdata/templates_c/';
$TPL->cache_dir = SYS_PATH.'sysdata/cache/';
$TPL->lang_dir = LANG_PATH.$SYS_ENV['language'].'/lang_skin/admin/';


$TPL->compile_lang = true;
$TPL->global_lang_name = LANG_PATH.$SYS_ENV['language'].'/lang_skin_global.php';

$TPL->assign('iwpc_version', CMSWARE_VERSION);
$TPL->assign('cmsware_version', CMSWARE_VERSION);

//print_r($in);
$sys = new Auth($params);
$message = $LANG_SYS["{$IN['message']}"];
$base_url = $_SERVER["PHP_SELF"]."?sId={$IN['sId']}&";
$TPL->assign('base_url', $base_url);
$TPL->assign('referer', $referer);
$TPL->assign('sId', $IN['sId']);
$TPL->assign_by_ref('IN', $IN);
$TPL->assign('Auth', $sys->Auth);
if (!$sys->isLogin()) {
	$TPL->display("login.html");
	exit;

} elseif(!$sys->isAdmin()) {
	die("<h1>Access Denied!</h1>Only Administrator can access this module!");
}






define('APP_ROOT', dirname(__FILE__));

set_magic_quotes_runtime(0);

if (!file_exists(APP_ROOT . '/config.php')) {
  echo '<center><b>Error: config.php does not exist.</b></center>';
  exit;
}

require('./config.php'); // get the config file

if (!extension_loaded('xml')) {
  echo '<center><b>Error: phpsysinfo requires xml module.</b></center>';
  exit;

}

// reassign HTTP variables (incase register_globals is off)
if (!empty($HTTP_GET_VARS)) while (list($name, $value) = each($HTTP_GET_VARS)) $$name = $value;
if (!empty($HTTP_POST_VARS)) while (list($name, $value) = each($HTTP_POST_VARS)) $$name = $value;
// Check to see if where running inside of phpGroupWare
if (isset($sessionid) && $sessionid && $kp3 && $domain) {
  define('PHPGROUPWARE', 1);
  $phpgw_info['flags'] = array('currentapp' => 'phpsysinfo-dev'
    );
  include('../header.inc.php');
} else {
  define('PHPGROUPWARE', 0);
}

if (!isset($template)) {
  $template = $_COOKIE['template'];
}

if (!isset($template)) {
  $template = $default_template;
}

// check to see if we have a random template first
if ($template == 'random') {
  $dir = opendir('templates/');
  while (($file = readdir($dir)) != false) {
    if ($file != 'CVS' && $file != '.' && $file != '..') {
      $buf[] = $file;
    }
  }
  $template = $buf[array_rand($buf, 1)];
  $random = true;
}

if ($template != 'xml') {
  $template = basename(APP_ROOT . '/templates/' . $template); 
  // figure out if we got a template passed in the url
  if (!file_exists(APP_ROOT . "/templates/$template")) {
    // default template we should use if we don't get a argument.
    $template = $default_template;
  }
}

define('TEMPLATE_SET', $template);
// get our current language
// default to english, but this is negotiable.

if (!isset($lng)) {
  $lng = $_COOKIE['lng'];
}

if (!isset($lng)) {
  $lng = $default_lng;
}

$lng = basename(APP_ROOT . '/includes/lang/' . $lng . '.php', '.php');

if (!file_exists(APP_ROOT . '/includes/lang/' . $lng . '.php')) {
  // see if the browser knows the right languange.
  if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
    $plng = split(',', $_SERVER['HTTP_ACCEPT_LANGUAGE']);
    if (count($plng) > 0) {
      while (list($k, $v) = each($plng)) {
        $k = split(';', $v, 1);
        $k = split('-', $k[0]);
        if (file_exists(APP_ROOT . '/includes/lang/' . $k[0] . '.php')) {
          $lng = $k[0];
          break;
        }
      }
    }
  }
}

require('./includes/lang/' . $lng . '.php'); // get our language include

// Figure out which OS where running on, and detect support
if (file_exists(APP_ROOT . '/includes/os/class.' . PHP_OS . '.inc.php')) {
  require('./includes/os/class.' . PHP_OS . '.inc.php');
  $sysinfo = new sysinfo;
} else {
  echo '<center><b>Error: ' . PHP_OS . ' is not currently supported</b></center>';
  exit;
}

if (!empty($sensor_program)) {
  if (file_exists(APP_ROOT . '/includes/mb/class.' . $sensor_program . '.inc.php')) {
    require('./includes/mb/class.' . $sensor_program . '.inc.php');
    $mbinfo = new mbinfo;
  } else {
    echo '<center><b>Error: ' . $sensor_program . ' is not currently supported</b></center>';
    exit;
  }
}

require('./includes/common_functions.php'); // Set of common functions used through out the app
require('./includes/xml/vitals.php');
require('./includes/xml/network.php');
require('./includes/xml/hardware.php');
require('./includes/xml/memory.php');
require('./includes/xml/filesystems.php');
require('./includes/xml/mbinfo.php');

$xml = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";
$xml .= "<!DOCTYPE phpsysinfo SYSTEM \"phpsysinfo.dtd\">\n\n";
$xml .= created_by();
$xml .= "<phpsysinfo>\n";
$xml .= "  <Generation version=\"$VERSION\" timestamp=\"" . time() . "\"/>\n";
$xml .= xml_vitals();
$xml .= xml_network();
$xml .= xml_hardware();
$xml .= xml_memory();
$xml .= xml_filesystems();
if (!empty($sensor_program)) {
  $xml .= xml_mbtemp();
  $xml .= xml_mbfans();
  $xml .= xml_mbvoltage();
} ;
$xml .= "</phpsysinfo>";

if ($template == 'xml') {
  // just printout the XML and exit
  Header("Content-Type: text/xml\n\n");
  print $xml;
} else {
  // If they have GD complied into PHP, find out the height of the image to make this cleaner
  if (function_exists('getimagesize') && $template != 'xml') {
    $image_prop = getimagesize(APP_ROOT . '/templates/' . TEMPLATE_SET . '/images/bar_middle.gif');
    define('BAR_HEIGHT', $image_prop[1]);
    unset($image_prop);
  } else {
    // Until they complie GD into PHP, this could look ugly
    define('BAR_HEIGHT', 16);
  } 
  // Store the current template name in a cookie, set expire date to one month later
  // Store 'random' if we want a random template
  if ($random) {
    setcookie("template", 'random', (time() + 60 * 60 * 24 * 30));
  } else {
    setcookie("template", $template, (time() + 60 * 60 * 24 * 30));
  } 
  // Store the current language selection in a cookie
  setcookie("lng", $lng, (time() + 60 * 60 * 24 * 30));

  if (PHPGROUPWARE != 1) {
    require('./includes/class.Template.inc.php'); // template library
  } 
  // fire up the template engine
  $tpl = new Template(dirname(__FILE__) . '/templates/' . TEMPLATE_SET);
  $tpl->set_file(array('form' => 'form.tpl'
      )); 
  // print out a box of information
  function makebox ($title, $content, $percent) {
    $t = new Template(dirname(__FILE__) . '/templates/' . TEMPLATE_SET);

    $t->set_file(array('box' => 'box.tpl'
        ));

    $t->set_var('title', $title);
    $t->set_var('content', $content);
    if (empty($content)) {
      return '';
    } else {
      return $t->parse('out', 'box');
    } 
  } 
  // Fire off the XPath class
  require('./includes/XPath.class.php');
  $XPath = new XPath();
  $XPath->importFromString($xml); 
  // let the page begin.
  require('./includes/system_header.php');

  $tpl->set_var('title', $text['title'] . ': ' . $XPath->getData('/phpsysinfo/Vitals/Hostname') . ' (' . $XPath->getData('/phpsysinfo/Vitals/IPAddr') . ')');

  $tpl->set_var('vitals', makebox($text['vitals'], html_vitals(), '100%'));
  $tpl->set_var('network', makebox($text['netusage'], html_network(), '100%'));
  $tpl->set_var('hardware', makebox($text['hardware'], html_hardware(), '100%'));
  $tpl->set_var('memory', makebox($text['memusage'], html_memory(), '100%'));
  $tpl->set_var('filesystems', makebox($text['fs'], html_filesystems(), '100%'));
  if (!empty($sensor_program)) {
    $tpl->set_var('mbtemp', makebox($text['temperature'], html_mbtemp(), '100%'));
    $tpl->set_var('mbfans', makebox($text['fans'], html_mbfans(), '100%'));
    $tpl->set_var('mbvoltage', makebox($text['voltage'], html_mbvoltage(), '100%'));
  } else {
    $tpl->set_var('mbtemp', '');
    $tpl->set_var('mbfans', '');
    $tpl->set_var('mbvoltage', '');
  } ; 
  // parse our the template
  $tpl->pparse('out', 'form'); 
  // finally our print our footer
  if (PHPGROUPWARE == 1) {
    $phpgw->common->phpgw_footer();
  } else {
    require('./includes/system_footer.php');
  }
}

?>
