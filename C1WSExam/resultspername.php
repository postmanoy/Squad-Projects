<?php
session_start();
error_reporting(0);
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:../DSaaSExam/index.php');
    exit;
}
include('connect.php');

   if(isset($_SESSION['userx'])){
    $user = $_SESSION['userx'];
    $date = $_SESSION['datex'];
   }
   else{
    $user = $_POST['userName'];
    $date = $_POST['userDate'];
   }


$dates = "";

?>

<!DOCTYPE html>
<html>
<head>
  <link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
	<title>Results - DSaaS Exam</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	 <link href="https://fonts.googleapis.com/css?family=Montserrat|Open+Sans" rel="stylesheet">
<!-- 
	 font-family: 'Montserrat', sans-serif; 
	font-family: 'Open Sans', sans-serif;
	-->
<script>
$(document).ready(function()
{ 
       $(document).bind("contextmenu",function(e){
              return false;
       }); 
})

   // Load google charts
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

// Draw the chart and set the chart values
function drawChart() {
  var data = google.visualization.arrayToDataTable([
    <?php
                      $resultquery = "SELECT * FROM usersession WHERE name = '$user'";
                      $queryr = mysqli_query($con, $resultquery);
                      if ($value = mysqli_fetch_array($queryr)){
                      $dates = $value['date'];
    ?>
  ['Task', 'Score'],
  ['Networking', <?php echo $value['net_sc']; ?>],
  ['Windows', <?php echo $value['win_sc']; ?> ],
  ['Linux', <?php echo $value['lin_sc']; ?> ],
  ['Cloud', <?php echo $value['clo_sc']; ?> ]

  
                          <?php
                      }
                          ?>
]);

  // Optional; add a title and set the width and height of the chart
  var options = { chart: {'title':'Grades','titlePosition':'none'}, colors: ['green'], hAxis: { viewWindowMode:'explicit', format: '0',
            viewWindow: {
              max:10,
              min:0
            }}};

  // Display the chart inside the <div> element with id="piechart"
  var chart = new google.visualization.BarChart(document.getElementById('barchart'));
  chart.draw(data, options);
}

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart2);

function drawChart2() {
  var data2 = google.visualization.arrayToDataTable([
    <?php
                      $resultquery2 = "SELECT * FROM usersession WHERE name = '$user'";
                      $queryr2 = mysqli_query($con, $resultquery2);
                      if ($value2 = mysqli_fetch_array($queryr2)){

    ?>
  ['Task', 'Score'],
  ['Virtualization', <?php echo $value2['vir_sc']; ?>],
  ['DevOps', <?php echo $value2['dev_sc']; ?>],
  ['Database', <?php echo $value2['db_sc']; ?>],
  ['Other', <?php echo $value2['ot_sc']; ?>]

  
                          <?php
                      }
                          ?>
]);

  // Optional; add a title and set the width and height of the chart
  var options2 = { chart: {'title':'Grades','titlePosition':'none'}, colors: ['orange'], hAxis: { viewWindowMode:'explicit', format: '0',
            viewWindow: {
              max:5,
              min:0
            }}};

  // Display the chart inside the <div> element with id="piechart"
  var chart2 = new google.visualization.BarChart(document.getElementById('barchart2'));
  chart2.draw(data2, options2);
}

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart3);

function drawChart3() {
  var data3 = google.visualization.arrayToDataTable([
    <?php
                      $resultquery3 = "SELECT * FROM usersession WHERE name = '$user'";
                      $queryr3 = mysqli_query($con, $resultquery3);
                      if ($value3 = mysqli_fetch_array($queryr3)){
    ?>
  ['Task', 'Score'],
  ['Essay', <?php echo $value3['ess_sc']; ?>]

  
                          <?php
                      }
                          ?>
]);

  // Optional; add a title and set the width and height of the chart
  var options3 = { chart: {'title':'Grades','titlePosition':'none'}, colors: ['violet'], hAxis: { viewWindowMode:'explicit', format: '0',
            viewWindow: {
              max:20,
              min:0
            }}};

  // Display the chart inside the <div> element with id="piechart"
  var chart3 = new google.visualization.BarChart(document.getElementById('barchart3'));
  chart3.draw(data3, options3);
}

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart4);

function drawChart4() {
  var data4 = google.visualization.arrayToDataTable([
    <?php
                      $resultquery4 = "SELECT * FROM usersession WHERE name = '$user'";
                      $queryr4 = mysqli_query($con, $resultquery4);
                      if ($value4 = mysqli_fetch_array($queryr4)){
                        $totalscore = $value4['u_a_id'] + $value4['ess_sc'];
    ?>
  ['Task', '%'],
  ['Total: <?php echo $totalscore; ?>/80', <?php echo $totalscore  ?> / 80]

  
                          <?php
                      }
                          ?>
]);

  // Optional; add a title and set the width and height of the chart
  var options4 = { chart: {'title':'Grades','titlePosition':'none'},  hAxis: { viewWindowMode:'explicit', format: '#%',
            viewWindow: {
              max:1,
              min:0.00
            }}};

  // Display the chart inside the <div> element with id="piechart"
  var chart4 = new google.visualization.BarChart(document.getElementById('barchart4'));
  chart4.draw(data4, options4);
}

  </script>
</head>
<body>
  <h1 class="text-center text-white font-weight-bold text-uppercase bg-dark" >  Trend Micro Deep Security As A Service Exam </h1><br>
         <div class="container">
  <div class="card text-center">
    <h3>Name: <?php echo $user; ?><br>Date and Time Taken: <?php echo $dates; ?></h3>
  </div>
    <div class="card">
    <div id="barchart"></div>
  </div>
  <div class="card">
    <div id="barchart2"></div>
  </div>
   <div class="card">
    <div id="barchart3"></div>
  </div>
  <div class="card">
    <div id="barchart4"></div>
  </div>
    <hr>
<a href="clearsessionresult.php" class="btn btn-primary btn-dark d-block m-auto text-white" > Back </a> 


	 <footer>
            <h5 class="text-center"> &copy2019 PostManoy.</h5> 
         </footer>
	</div>
</div>
</body>
</html>