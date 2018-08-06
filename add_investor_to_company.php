<?php
  if(isset($_POST['submitted'])) {
    include('connection-mysql.php');
    $investorID = $_POST['investorID'];
    $company_name = $_POST['company'];
    // run query to get the course_id
    $sql_compID = mysqli_query($dbcon, "SELECT compID FROM company WHERE name='$company_name'");
    $industryID = mysqli_fetch_row($sql_compID);
    $sqlinsert = "INSERT INTO company_company (investorID, compID) VALUES ('$investorID', '$industryID[0]')";
    $insert = $dbcon->query($sqlinsert);
    if(!$insert) {
      die("Error: {$dbcon->errno} : {$dbcon->error}");      
    }
  }
  header("Location:http://web.engr.oregonstate.edu/~tramd/cs340/investor.php?investorID={$investorID}");
?>  