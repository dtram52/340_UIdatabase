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
<h3>CEO candidates for the Listed Companies</h3>
<p> These are the CEO candidates for the Companies in our Database. As each CEO only has one special expertise. This table gives us the candidates that are qualified candidates to become CEO of the Company in your portfolio company.</p>
<div>
	<table>
		<tr class="heading">
			<th> Candidate's First Name </th>
			<th> Candidate's Last Name </th>
			<th> Age </th>
			<th> Industry </th>
			<th>Company</th>
		</tr>
<?php

if(!($stmt = $mysqli->prepare("SELECT ceo.fname, ceo.lname, ceo.age, i.type, c.name FROM ceo 
	INNER JOIN industry i ON ceo.industryID = i.industryID 
	INNER JOIN company c ON i.industryID = c.industryID 
	ORDER BY c.name")))
{
	echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
}
if(!$stmt->execute()){
	echo "Execute failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
if(!$stmt->bind_result($fname, $lname, $age, $industry, $company)){
	echo "Bind failed: "  . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
//table input of query
while($stmt->fetch()){
 echo "<tr>\n<td>\n" . $fname . "\n</td>\n<td>\n" . $lname . "\n</td>\n<td>\n" . $age . "\n</td>\n<td>" . $industry . "\n</td>\n<td>" . $company . "\n</td>\n</tr>";
}
$stmt->close();
?>
	</table>
</div>

</body>
</html>