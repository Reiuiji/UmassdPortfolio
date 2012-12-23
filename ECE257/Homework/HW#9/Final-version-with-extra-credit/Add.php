<!-- Dan Noyes ECE 257 Hw#9 :Add.php -->
<html>
<title>ece259-HW#9</title>
<body>
<style>
body {background-image:url('paper.gif');}
</style>
<!-- php script that will insert the information from index to the mysql database -->

<?php
	$user="root";
	$password="password";
	$database="ece257";
	//connects to the database with the given login information
	mysql_connect("127.0.0.1",$user,$password);
	mysql_select_db($database) or die( "Error: cannot find the Database");
	//inserts the necessary information to the database
	$insert = "INSERT INTO students (First_Name, Last_Name, Phone_Number) values ('$_POST[Firstname]', '$_POST[Lastname]', '$_POST[PhoneNum]')";
	
	if (!mysql_query($insert))
		{
			die('Error: ' . mysql_error());
		}

	mysql_close();

?>

<!-- out put the users information once it is finished with inserting them -->
Thank you <?php echo $_POST["Firstname"]; echo "   "; echo $_POST["Lastname"]; ?><br>
For your Phone information [<?php echo $_POST["PhoneNum"]; ?>]


<form method="post" action="index.php">
<input type="submit" value="Continue" name="submit"><br />
</form><br /> 


</body>
</html> 
