
<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
}
  $student_id = $_GET["studentID"];
  $course_id = $_GET["courseID"];
  // remove student from course
  $sqlremove = "DELETE FROM company_investor WHERE investorID='$investorID' AND compID='$compID'";
  $remove = $mysqli->query($sqlremove);
  if(!$remove) {
    die("Error: {$mysqli->errno} : {$mysqli->error}");
  }
  header("Location:http://web.engr.oregonstate.edu/~tramd/cs340/comp.php?compID={$compID}");
?>  