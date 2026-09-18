<?php
require_once dirname(__FILE__)."/pclzip.lib.php";

class FileSystem_Zip extends PclZip {
	
	function FileSystem_Zip()
	{
		parent::PclZip("");
	}

	function setZipName($_name) 
	{
		if (!function_exists('gzopen'))
		{
			die('Abort '.basename(__FILE__).' : Missing zlib extensions');
		}

		// ----- Set the attributes
		$this->zipname = $_name;
		$this->zip_fd = 0;
		$this->magic_quotes_status = -1;

		return;

	}

	function setTmpDir($_dir)
	{	
		$_dir = empty($_dir) ? "C:/temp/" : $_dir;
		define( 'PCLZIP_TEMPORARY_DIR', $_dir );
	}
}
?>