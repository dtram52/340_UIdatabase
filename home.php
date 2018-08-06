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
		<li class="navItem"><a class="navlink"  href="investor.php">Investor</a></li>
	</ul>


<br>

<div class="container">
      <!-- Main hero unit for a primary marketing message or call to action -->
      <div class="hero-unit">
        <h1> Company Database for your Investment References</h1>
        <h3>Welcome Investors!</h3>
      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span6">
          <h2>Market Interaction Overview</h2>
          <p>If you want to find the right Company, your trusted CEO or your favorite industry. Take a look here!</p>
          <p><a class="btn" href="overview.html">View details &raquo;</a></p>
        </div>
        <div class="span6">
          <h2>Investor Portal</h2>
          <p>If you are an investor, look up what companies are in your portfolio.</p>
          <p><a class="btn" href="investor_portal.php">View details &raquo;</a></p>
       </div>
      </div>
<h1>Final Project: Public Company Database</h1>
<br>
<br>





<h3>ER Diagram</h3>
<img src="ERDiagram.png" alt="See VBschema.png" style="width:400;height:400;">
<br>
<h3>Schema</h3>
<img src="Schema.png" alt="See VBschema.png" style="width:400;height:400;">
<br>


<table class="data_display">
		<label>Example table: CEOs </label>
		<tr class="heading">
			<th>First Name</th>
			<th>Last Name</th>
			<th>Age</th>
      		<th>Industry</th>
		</tr>
<?php
// create the sql query
if(!($stmt = $mysqli->prepare("SELECT fname,lname,age,industryID FROM ceo"))){
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}
// execute the sql query
if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
// bind the results to variables
if(!$stmt->bind_result($firstName, $lastName, $age, $industryID)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
// operate for each returned row. Inline the html.
while($stmt->fetch()){
 echo "<tr>\n<td>" . $firstName . "</td>\n<td>" . $lastName . "</td>\n<td>" . $age . "</td>\n<td>" .$industryID . "</td>\n<tr>\n";
}
// close out the sql query.
$stmt->close();
?>
	</table>


<table class="data_display">
		<label>Industry </label>
		<tr class="heading">
			<th>Type</th>
			<th>Size</th>
			<th>Industry</th>
		</tr>
<?php
// create the sql query
if(!($stmt = $mysqli->prepare("SELECT type, size, industryID FROM industry"))){
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}
// execute the sql query
if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
// bind the results to variables
if(!$stmt->bind_result($type, $size, $industryID)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
// operate for each returned row. Inline the html.
while($stmt->fetch()){
 echo "<tr>\n<td>" . $type . "</td>\n<td>" . $size . "</td>\n<td>" .$industryID . "</td>\n<tr>\n";
}
// close out the sql query.
$stmt->close();
?>
	</table>


<br>
<footer> CS340_ Database Final Project Du Tram ©</footer>
<br>

</body>
</html>