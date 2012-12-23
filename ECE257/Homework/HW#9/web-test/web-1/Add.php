<html>
<title>ece259-HW#9</title>
<body>

<?php
$user="root";
$password="password";
$database="ece257";
mysql_connect("127.0.0.1",$user,$password);
mysql_select_db($database) or die( "Error: cannot find the Database");
$insert = "INSERT INTO students (First_Name, Last_Name, Phone_Number) values ('$_POST[Firstname]', '$_POST[Lastname]', '$_POST[PhoneNum]')";
if (!mysql_query($insert))
  {
  die('Error: ' . mysql_error());
  }

mysql_close();

?>

Thank you <?php echo $_POST["Firstname"]; echo "   "; echo $_POST["Lastname"]; ?><br>
For your Phone information [<?php echo $_POST["PhoneNum"]; ?>]


<form method="post" action="index-1.php">
<input type="submit" value="Continue" name="submit"><br />
</form><br /> 


</body>
</html> 
