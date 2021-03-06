<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;}
    



    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $age = $_POST['age'];
    $industry= $_POST['industryID'];


if(isset($_POST['Add']))
 
  //Add new athlete
{
  if(!$mysqli || $mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
  }
//Inserts new ceo based on user input first name, last name, age, and industry.
  if(!($stmt = $mysqli->prepare("INSERT INTO `ceo` (`fname`,`lname`,`age`,`industryID`) VALUES (?,?,?,?)"))){
    echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
  }
  if(!($stmt->bind_param("ssii",$fname , $lname, $age, $industryID))){
    echo "Bind failed: "  . $stmt->errno . " " . $stmt->error;
  }
  if(!$stmt->execute()){
    echo "Execute failed: "  . $stmt->errno . " " . $stmt->error;
  } else {
    echo "CEO has been added to database.";}
} else
{
  //Updates existing athlete based upon user entry first name and last name
  //Updates the team and age fields
  if(!($updateQ = $mysqli->prepare("UPDATE ceo SET industryID=?, age=? WHERE first_name=?  AND last_name=? "))){
    echo "Prepare failed: "  . $updateQ->errno . " " . $updateQ->error;
  }
  if(!($updateQ->bind_param("iiss",$industry, $age, $fname, $lname))){
    echo "Bind failed: "  . $updateQ->errno . " " . $updateQ->error;
  }
  if(!$updateQ->execute()){
    echo "Execute failed: "  . $updateQ->errno . " " . $updateQ->error;
  }
  else if($updateQ->affected_rows > 0)
  {
    echo "Athlete age and team have been updated!";
  }
  else
  {
    echo "No rows affected, please enter the first name and last of current athlete to update.";
  }
}
?>
<p>Navigate back to <a href="ceo.php"> CEO</a> page.