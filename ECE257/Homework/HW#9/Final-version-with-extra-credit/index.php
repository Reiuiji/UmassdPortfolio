<!-- Dan Noyes ECE 257 Hw#9 :index.php -->
<html>
<title>ece259-HW#9</title>
<body>
<center>
<h1>ECE257-Hw#9 <br>with Extra Credit</h1>
<style>

<!-- style for background -->
body {background-image:url('paper.gif');}

<!-- Sets up a border -->
div.ex
{
	width:350px;
	padding:10px;
	border:5px solid blue;
	margin:0px;
}
</style>

<h4>please enter your informations</h4>

<!-- form to enter users name and phone number -->
<form method="post" action="Add.php">
	First Name:<input type="text" size="12" maxlength="30" name="Firstname"><br />
	Last Name:<input type="text" size="12" maxlength="30" name="Lastname"><br />
	Phone Number:<input type="text" size="12" maxlength="30" name="PhoneNum"><br />
	<br><input type="submit" value="submit" name="submit"><br />
</form><br /> 

<!-- border -->
<div class="ex">
<h3>Phone Database</h3>
<?php
	include ('List.php');
?>
</div>
<br>
<!-- Function to clear the entire database [just incase you need it :D -->
<form method="post" action="Clear.php">
	<input type="submit" value="Clear Database" name="Clear"><br />
</form><br /> 

<br>
ECE 257 HW # 9 + extra credit<br>
Created by Daniel Noyes<br>
dnoyes@umassd.edu
</center>
</body>
</html>
