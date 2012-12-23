<!-- Dan Noyes ECE 257 Hw#9 :List.php -->
<?php
//loging information
$user="root";
$password="password";
$database="ece257";

	mysql_connect("127.0.0.1",$user,$password);
	@mysql_select_db($database) or die( "Error: cannot find the Database");
	//outputs all the information in the students table
	$query="SELECT * FROM students";
	$result = mysql_query($query);
	//grabs the number of rows
	$num = mysql_numrows($result);
	$i=0;
	
	//configure the data to be displayed as a table
	echo "<table border='2'>";
	echo "<tr><th>First Name</th> <th>Last Name</th> <th>Phone Number</th> </tr>";

	//while loop that will go through the entire table based on the row [id]
	while ($i<$num){
		$First_name = mysql_result($result,$i,"First_Name");
		$Last_name = mysql_result($result,$i,"Last_Name");
		$Phone_Num = mysql_result($result,$i,"Phone_Number");
		$List = "<td>$First_name</td>   <td>$Last_name</td>   <td>$Phone_Num</td>";//set the the table column
	
	//print out each row
	echo " <tr> $List </tr>";
	$i++;
	}
mysql_close();

//closes the table
echo "</table>"
?>
