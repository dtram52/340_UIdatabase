<?php
  error_reporting(E_ALL);
  DEFINE ('DB_USER', 'tramd-db');
  DEFINE ('DB_PSWD', 'DSgejYOOUj70sUIX');
  DEFINE ('DB_HOST', 'oniddb.cws.oregonstate.edu');
  DEFINE ('DB_NAME', 'tramd-db');
  $dbcon = mysqli_connect(DB_HOST, DB_USER, DB_PSWD, DB_NAME);
  if($dbcon->connect_errno) {
    echo "Connection error " . $dbcon->connect_errno . " " . $dbcon->connect_error;
  }
?>