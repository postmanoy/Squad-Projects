<?php
$file_url = 'D:\\xampp\\htdocs\\Storage\\precheck.sh';
header('Content-Type: application/octet-stream');
header("Content-Transfer-Encoding: Binary"); 
header("Content-disposition: attachment; filename=\"" . basename($file_url) . "\"");
$fn=fopen($file_url,"r");
fpassthru($fn);
?>