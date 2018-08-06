<?php
//Turn on error reporting
ini_set('display_errors', 'On');
//Connects to the database
$mysqli = new mysqli("oniddb.cws.oregonstate.edu","tramd-db","DSgejYOOUj70sUIX","tramd-db");
if($mysqli->connect_errno){
    echo "Connection error " . $mysqli->connect_errno . " " . $mysqli->connect_error;
  }
  $sqlselect = "SELECT * FROM company";
  $result1 = mysqli_query($mysqli, $sqlselect);  
?>
<!DOCTYPE html>
<html>
  <head>
    <title>CS340 Final Project - Companies</title>
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
      <h3>Companies</h3>
      <table class="table table-striped">
        <tr>
          <th>Name</th>
          <th>Ticker</th>
          <th>Market Capitalization</th>
          <th></th>
        </tr>
        <?php while($row1 = mysqli_fetch_array($result1)):; ?>
        <tr>
          <td><a href="company.php?compID=<?php echo $row1[0]; ?>&amp;compName=<?php echo $row1[1]; ?>"><?php echo $row1[1]; ?></a></td>
          <td><?php echo $row1[4]; ?></td>
          <td><?php echo $row1[3]; ?></td>
        </tr>
        <?php endwhile; ?>
      </table>


      <form method="post" action="insert_company.php">
        <input type="hidden" name="submitted" value="true" />
        <legend>Add Company</legend>
        <div class="form-group">
          <label for="compinputname">Name</label>
          <input type="text" name="name" class="form-control" id="compinputname" placeholder="">
        </div>
        <div class="form-group">
          <label for="compinputticker">Ticker</label>
          <input type="text" name="ticker" class="form-control" id="compinputticker" placeholder="">
        </div>
        <div class="form-group">
          <label for="compinputMC">Market Capitalization</label>
          <input type="text" name="marketCap" class="form-control" id="compinputMC" placeholder="">
        </div>
        <button type="submit" class="btn btn-default">Add</button>
      </form>
    </div> 

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>