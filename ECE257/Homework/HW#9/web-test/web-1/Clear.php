<?php
$user="root";
$password="password";
$database="ece257";
mysql_connect("127.0.0.1",$user,$password);
mysql_select_db($database) or die( "Error: cannot find the Database");
mysql_query('TRUNCATE TABLE table;');
mysql_close();
?>
