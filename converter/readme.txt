iWPC2.6 -> CMSware 2.0 转换程序使用说明：

1.使用转换程序之前请安装一个全新的CMSware2.0（转换前不要添加任何节点、内容）。

2.将此目录(converter)复制致cmsware根目录下。正确的目录结构应该为
	/cmsware
	/cmsware/admin
	/cmsware/backup
	/cmsware/converter
	/cmsware/converter/iWPC26toCMSware2.0.php
	/cmsware/converter/iwpc_config.php
	......
	...
	..
	.


2.配置iwpc_config.php，完成iwpc数据库的连接参数配置.

3.运行iWPC26toCMSware2.0.php,按照向导完成数据转换.

4.登录后台，完成进一步的发布设置.