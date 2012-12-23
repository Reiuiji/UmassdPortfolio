<!-- Dan Noyes ECE 257 Hw#9 :Clear.php -->
<html>
<title>ece259-HW#9</title>
<body>

<!-- style for background -->
<style>
body {background-image:url('paper.gif');}
</style>

<!-- connects to the mysql database and clears the table by truncate -->
<?php
$user="root";
$password="password";
$database="ece257";
mysql_connect("127.0.0.1",$user,$password);
mysql_select_db($database) or die( "Error: cannot find the Database");
//clear the information in the student table
mysql_query('TRUNCATE TABLE students;');
mysql_close();

echo "Tables have been Cleared!";

?>


<!-- button to go to the main page [index.php] -->
<form method="post" action="index.php">
<input type="submit" value="Continue" name="submit"><br />
</form><br /> 

</body>
</html> 
