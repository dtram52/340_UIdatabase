<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CEO</title>
    <link rel="stylesheet" href="stylesheet.css" type="text/css">
</head>
<html>
<body>


  <ul class="NavBar">
    <li class="navItem"><a class="navlink" href="home.php">Home</a></li>
    <li class="navItem"><a class="active navlink" href="ceo.php">CEO</a></li>
    <li class="navItem"><a class="navlink"  href="company.php">Company</a></li>
    <li class="navItem"><a class="navlink"  href="industry.php">Industry</a></li>
    <li class="navItem"><a class="navlink"  href="investor.php">Investor</a></li>
  </ul>


<br>

<h1>CEO</h1>
<p> There are two special rules you should be aware of for our CEOs:</p>
<ul>
	<li>In order to focus on their work, they should only have expertise in one industry.</li>
	<li>Our industry may have many companies so CEO may serve on more than one Company. However, this is rare so please avoid these situations when using our Database.</li>
</ul>
<h3>Part 1: CEO On Display.</h3>
<p> These are the CEOs currently in our Database</p>
<div>
	<table>
		<tr class="heading">
			<th> First Name </th>
			<th> Last Name </th>
			<th> Age </th>
			<th> Industry </th>
		</tr>
<?php

if(!($stmt = $mysqli->prepare("SELECT ceo.fname, ceo.lname, ceo.age, i.type FROM ceo ceo 
	INNER JOIN industry i ON ceo.industryID = i.industryID ORDER BY i.type")))
{
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}
if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
if(!$stmt->bind_result($fname, $lname, $age, $industry)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
//table input of query
while($stmt->fetch()){
 echo "<tr>\n<td>\n" . $fname . "\n</td>\n<td>\n" . $lname . "\n</td>\n<td>\n" . $age . "\n</td>\n<td>"  . $industry . "\n</td>\n</tr>";
}
$stmt->close();
?>
	</table>
</div>

<h3>Part 2: Add and Update CEOs</h3>

<div class="formHeader">
<h3>Part 2 bis</h3>
<p> If you know which companies are in your portfolio and want to look for a CEO candidate to elect, You should take a look at the <a href="ceocomp.php">CEO candidate</a> page.</p>

	<form method="post" action="addupdate_ceo.php">
		<fieldset>
			<legend>CEO Name</legend>
			<p>First Name: <input type="text" name="fname" /></p>
			<p>Last Name: <input type="text" name="lname" /></p>
		</fieldset>

		<fieldset>
			<legend>Age</legend>
			<p>Age: <input type="text" name="age" /></p>
		</fieldset>

		<fieldset>
			<legend>CEO's industry</legend>
			<select name="industryID">
<?php


if(!($stmt = $mysqli->prepare("SELECT industryID, type FROM industry"))){
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}
if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
if(!$stmt->bind_result($industryID, $type)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
while($stmt->fetch()){
	echo '<option value=" '. $industryID . ' "> ' . $type . '</option>\n';
}
$stmt->close();
?>

		</select>
		</fieldset>
		<input type="submit" name="Add" value="Add CEO" />
		<input type="submit" name="Update" value="Update CEO" />
	</form>
</div>

<br>
<br>
<br>


<footer> Final Project by Du Tram ©</footer>
<br>

</body>
</html>