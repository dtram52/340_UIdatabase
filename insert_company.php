<?php
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");

if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
  }

    $name = $_POST['name'];
    $ticker = $_POST['ticker'];
    $marketCap = $_POST['marketCap'];
  if(isset($_POST['submitted'])) if(isset($_POST['Add']))
 
  //Add new Company ignoring industryID

//Highly not recommended.
{
  if(!$mysqli || $mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
  }

  if(!($stmt = $mysqli->prepare("INSERT INTO company (name, ticker, marketCap) VALUES (?, ?, ?)"))){
    echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
  }
  if(!($stmt->bind_param("ssi",$name, $ticker, $marketCap))){
    echo "Bind failed: "  . $stmt->errno . " " . $stmt->error;
  }
  if(!$stmt->execute()){
    echo "Execute failed: "  . $stmt->errno . " " . $stmt->error;
  } else {
    echo "CEO has been added to database.";}
}

?>  
<p> Added! However, please note that we have disregarded the Foreign Key and ignore it.  
  Navigate back to <a href="companies.php">Companies</a> page.