<?php

include("login.php");
	
	$query="SELECT * FROM students";
	$result = mysql_query($query);
	$num = mysql_numrows($result);
	$i=0;
	echo "<ul>";
	while ($i<$num){
		$First_name = mysql_result($result,$i,"First_Name");
		$Last_name = mysql_result($result,$i,"Last_Name");
		$Phone_Num = mysql_result($result,$i,"Phone_Number");
		$List = "$First_name  $Last_name   $Phone_Num";
	echo " <li> $List </li>";
	$i++;
	}
	echo "</ul>";
mysql_close();
?>
