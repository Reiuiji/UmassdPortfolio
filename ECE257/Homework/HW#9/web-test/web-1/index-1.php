<html>
<title>ece259-HW#9</title>
<body>
<h1>ECE257-test page</h1>

<form method="post" action="Add.php">
	First Name:<input type="text" size="12" maxlength="30" name="Firstname"><br />
	Last Name:<input type="text" size="12" maxlength="30" name="Lastname"><br />
	Phone Number:<input type="text" size="12" maxlength="30" name="PhoneNum"><br />
	<input type="submit" value="submit" name="submit"><br />
</form><br /> 

<?php
	include ('List.php');
?>


<form method="post" action="Clear.php">
	<input type="submit" value="Clear" name="Clear"><br />
</form><br /> 

</body>
</html>
