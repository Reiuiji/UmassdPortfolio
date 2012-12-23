<?php
	$user="ece257";
	$password="password";
	$database="ece257";
	mysql_connect("127.0.0.1",$user,$password);
	@mysql_select_db($database) or die( "Error: cannot find the Database");
?>
