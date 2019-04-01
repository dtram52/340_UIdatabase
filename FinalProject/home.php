<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Final Project: Public Company Database</title>
    <link rel="stylesheet" href="stylesheet.css" type="text/css">
</head>

<body>

	<ul class="NavBar">
		<li class="navItem"><a class="active navlink" href="home.php">Home</a></li>
		<li class="navItem"><a class="navlink" href="company.php">Company</a></li>
		<li class="navItem"><a class="navlink"  href="ceo.php">CEO</a></li>
		<li class="navItem"><a class="navlink"  href="industry.php">Industry</a></li>
		<li class="navItem"><a class="navlink"  href="investors.php">Investor</a></li>
	</ul>


<br>


<h1>Final Project: Public Company Database</h1>
<br>
<br>
<h3>About S&P 500</h3>

<p>This website is a generic interface for a juniors' club volleybal database.
  The database consits of coache, athletes and teams. There is a page to add and update
  any of the main entities, and a page to add or update the positions of each. Please refer to the schema or ER diagram
  to see what conects to what.
</p>
<ul>Some constraints!
  <li>Team names must be unique</li>
  <li>A coach's first and last name combination must be unique</li>
</ul>
<p>It is not a constraint that a player or coach can not be on two or more teams. This happens.
  It is also not a database constraint on age groups and ages. There can be exceptions to this,
  so we chose not to enforce it at that level</p>




<h3>Volleyball ER Diagram</h3>
<img src="ERdiagram.png" alt="See VBschema.png" style="width:400;height:400;">
<br>
<h3>Volleyball Schema</h3>
<img src="VBschema.png" alt="See VBschema.png" style="width:400;height:400;">
<br>


<table class="data_display">
		<label>Example table: CEOs </label>
		<tr class="heading">
			<th>First Name</th>
			<th>Last Name</th>
			<th>Age</th>
      <th>Company</th>
		</tr>
<?php
// create the sql query
if(!($stmt = $mysqli->prepare("SELECT fname,lname,age,ceoID FROM ceo"))){
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}
// execute the sql query
if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
// bind the results to variables
if(!$stmt->bind_result($firstName, $lastName, $age)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
// operate for each returned row. Inline the html.
while($stmt->fetch()){
 echo "<tr>\n<td>" . $firstName . "</td>\n<td>" . $lastName . "</td>\n<td>" . $age . "</td>\n<tr>\n";
}
// close out the sql query.
$stmt->close();
?>
	</table>

<br>
<footer> CS340_ Database Final Project Du Tram (c)</footer>
<br>

</body>
</ht