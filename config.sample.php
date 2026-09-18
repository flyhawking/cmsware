<?php
/**
 * CMSware Plus 配置模板
 *
 * 使用方法：复制本文件为 config.php 并填入实际环境参数
 *   cp config.sample.php config.php
 *
 * 注意：
 * - config.php 含敏感信息，已加入 .gitignore，请勿提交到版本库
 * - 历史版本默认使用 gbk 字符集；本仓库源码已统一转为 UTF-8，
 *   建议新环境使用 utf8（MySQL 中对应 utf8 / utf8mb4）
 */

$db_config['db_driver']   = 'db';            //db,adodb,mdb
$db_config['db_type']     = 'mysql';         //mysql,mssql,oracle
$db_config['db_host']     = 'localhost';     //数据库主机
$db_config['db_user']     = 'your_db_user';  //数据库用户名
$db_config['db_password'] = 'your_db_password'; //数据库用户密码
$db_config['db_name']     = 'cmsware_plus';  //数据库名
$db_config['table_pre']   = 'cmsware_';      //CMS表名前缀
$db_config['db_charset']  = 'utf8';          //数据库字符集 latin1,gb2312,gbk,utf8

$SYS_CONFIG['enable_validcode'] = 1;         //是否开启登陆图形验证码. 1-开启,0-关闭
$SYS_CONFIG['language'] = 'chinese_gb';      //系统语言
$SYS_CONFIG['ftp_mode'] = 0;                 //系统是否FTP模式,1-是,0-否
$SYS_CONFIG['ftp_host'] = 'localhost';       //FTP服务器地址
$SYS_CONFIG['ftp_port'] = '21';              //FTP服务器端口
$SYS_CONFIG['ftp_username'] = '';            //FTP用户名
$SYS_CONFIG['ftp_password'] = '';            //FTP密码
$SYS_CONFIG['ftp_cms_admin_path'] = '';      //CMS管理目录在FTP的目录路径

$SYS_CONFIG['dir_mode'] = 0777;              //系统创建目录的默认权限
$SYS_CONFIG['file_mode'] = 0777;             //系统创建文件的默认权限

$SYS_CONFIG['error_reporting'] = "file";     //系统报错模式 file,html,js
$SYS_CONFIG['tpl_error_display'] = true;     //是否在前台页面显示错误信息 true, false
$SYS_CONFIG['admin_dir_name'] = "admin";     //管理目录的目录名

//--------------------------------以下部分请不要修改--------------------------//

$db_config['table_content_pre']     = 'content';
$db_config['table_contribution_pre']     = 'contribution';
$db_config['table_collection_pre']     = 'collection';
$db_config['table_publish_pre']     = 'publish';
$lang_user = 'lang_user';
$lang_admin = 'lang_admin';
$SYS_DEBUG = false;
