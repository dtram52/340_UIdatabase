<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
}

  
  // run sql query to get student_id from name
  $title = $_POST["title"];
  $sqlinvestorid = "SELECT investorID FROM investor WHERE title='$title'";
  $id_query = mysqli_query($mysqli, $sqlinvestorid);
  $investorID = mysqli_fetch_array($id_query);
  // run sql query to pull up students class schedule
  $sqlportfolio = "SELECT c.compID, c.name, c.ticker, c.marketCap, industry.type 
  FROM company AS c 
  LEFT JOIN company_investor AS ci ON c.compID=ci.compID 
  LEFT JOIN investor ON ci.investorID=investor.investorID 
  LEFT JOIN industry ON c.industryID=industry.industryID
  WHERE ci.investorID='$investorID[0]'";
  $portfolio_query = mysqli_query($mysqli, $sqlportfolio);
  
?>

<!DOCTYPE html>
<html>
  <head>
    <title>CS340 Final Project - Investors</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
  </head>
  <body>
    <div class="navbar navbar-inverse">
      <div class="navbar-inner">
        <a class="brand" href="index.html">CS340 Final Project</a>
      </div>
    </div>

    <div class="container">
      <h3>Portfolio For <?php echo $title; ?></h3>
      <table class="table table-striped">
        <tr>
          <th>Company</th>
          <th>Ticker</th>
          <th>Market Cap (in dollars)</th>
          <th>Industry</th>
        </tr>
        <?php while($portfolio = mysqli_fetch_array($portfolio_query)):; ?>
        <tr>
          <td><?php echo $portfolio[1]; ?></td>
          <td><?php echo $portfolio[2]; ?></td>
          <td><?php echo $portfolio[3]; ?></td>
          <td><?php echo $portfolio[4]; ?></td>
        </tr>
        <?php endwhile; ?>
      </table>

    </div> 

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>

  