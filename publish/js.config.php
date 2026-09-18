<?php
/*
js输出调用方法:

js.php?id=new :相当于输出/js/js_new.html这个模板的内容
js.php?id=hot :相当于输出/js/js_hot.html这个模板的内容
<script src="[$PUBLISH_URL]js.php?o=new"></script> 
*/

$cacheTime = 3600 ; //js缓存有效时间,秒(seconds)

$templateKeys = array(
	'new' =>"/js/js_new.html", //最新文章模板
	'hot' =>"/js/js_hot.html", //最热文章模板
	'download_today_top10'=>"/js/download_today_top10.html", //本日下载排行10
	'download_week_top10'=>"/js/download_week_top10.html",//本周下载排行10
	'comment'=>"/js/comment_display.html",
	'oas_comment'=>"/oas/comment/js_comment_display.html",
	'download_pale_blue_down10'=>"/js/download_pale_blue_down10.html",
	'download_pale_blue_new10'=>"/js/download_pale_blue_new10.html",
	'photo_pale_blue_hits10'=>"/js/photo_pale_blue_hits10.html",
	'photo_pale_blue_new10'=>"/js/photo_pale_blue_new10.html",
	'flash_pale_blue_hits10'=>"/js/flash_pale_blue_hits10.html",
	'flash_pale_blue_new10'=>"/js/flash_pale_blue_new10.html",

  

);
?>