<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
}

  $sqlcompany = "SELECT name FROM company";
  $result2 = mysqli_query($mysqli, $sqlcompany); 
 
 // get from link
  $compID = $_GET["compID"];
  $sqlname = "SELECT name FROM investor WHERE investorID='$investorID'";
  $name_query = mysqli_query($mysqli, $sqlname);
  $name = mysqli_fetch_array($name_query);

// run sql query to pull up companies in this title of investor
  $sqlportfolio = "SELECT c.compID, c.name, c.ticker, c.marketCap, industry.type 
  FROM company AS c 
  LEFT JOIN company_investor AS ci ON c.compID=ci.compID 
  LEFT JOIN investor ON ci.investorID=investor.investorID 
  LEFT JOIN industry ON c.industryID=industry.industryID
  WHERE ci.investorID='$investorID'";
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
        <ul class="NavBar">
    <li class="navItem"><a class="navlink" href="home.php">Home</a></li>
    <li class="navItem"><a class="active navlink" href="ceo.php">CEO</a></li>
    <li class="navItem"><a class="navlink"  href="company.php">Company</a></li>
    <li class="navItem"><a class="navlink"  href="industry.php">Industry</a></li>
    <li class="navItem"><a class="navlink"  href="investor.php">Investor</a></li>
  </ul>
  
      </div>
    </div>

    <div class="container">
      <h3>Portfolio For <?php echo $name[0]; ?></h3>
      <table class="table table-striped">
        <tr>
          <th>Company</th>
          <th>Ticker</th>
          <th>Market Capitalization</th>
          <th>Industry Type</th>
          <th></th>
        </tr>
        <?php while($portfolio = mysqli_fetch_array($portfolio_query)):; ?>
        <tr>
          <td><?php echo $portfolio[1]; ?></td>
          <td><?php echo $portfolio[2]; ?></td>
          <td><?php echo $portfolio[3]; ?></td>
          <td><a href="divest.php?investorID=<?php echo $investorID; ?>&amp;compID=<?php echo $portfolio[0]; ?>">Remove Company from Portfolio</td>
        </tr>
        <?php endwhile; ?>
      </table>




    </div> 

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>