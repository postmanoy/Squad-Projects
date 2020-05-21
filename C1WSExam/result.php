<?php
session_start();
error_reporting(0);
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:../DSaaSExam/index.php');
    exit;
}
include('connect.php');

?>

<!DOCTYPE html>
<html>
<head>
  <link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
	<title>Results - C1WS Exam</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
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
  </script>
</head>
<body>
  <h1 class="text-center text-white font-weight-bold text-uppercase bg-dark" >  Trend Micro Cloud One - Workload Security Exam </h1><br>
<style>
    .fixed {
  }
  table-layout: fixed;
}
  </style>
	<div class="container">
<table class="table text-center table-bordered table-hover fixed">
  <tr>
    <th colspan="17" class="bg-dark"> <h1 class="text-white"> Results </h1></th>
  </tr>
  <tr>
    <th width = "20%">Date of Submission</th>
    <th width = "50%">Name</th>
    <th>Networking</th>
    <th>Windows</th>
    <th>Linux</th>
    <th>Cloud</th>
    <th>Virtualization</th>
    <th>DevOps</th>
    <th>Database</th>
    <th>Other</th>
    <th>Essay</th>
    <th width = "50%">Total</th>
  </tr>
    <?php
      $resultquery = "SELECT * FROM usersession";
      $queryr = mysqli_query($con, $resultquery);
      while ($value = mysqli_fetch_array($queryr)){
    ?>
     <tr>
      <td><b><?php echo $value['date']; ?></b></td>
      <td><b><?php echo $value['name']; ?></b></td>
      <td><b><?php echo $value['net_sc']; ?></b>/10</td>
      <td><b><?php echo $value['win_sc']; ?></b>/10</td>
      <td><b><?php echo $value['lin_sc']; ?></b>/10</td>
      <td><b><?php echo $value['clo_sc']; ?></b>/10</td>
      <td><b><?php echo $value['vir_sc']; ?></b>/5</td>
      <td><b><?php echo $value['dev_sc']; ?></b>/5</td>
      <td><b><?php echo $value['db_sc']; ?></b>/5</td>
      <td><b><?php echo $value['ot_sc']; ?></b>/5</td>
      <td><b><?php echo $value['ess_sc']; ?></b>/20</td>
      <td><b><?php $total = $value['u_a_id'] + $value['ess_sc'];  echo $total; ?> out of 80 items </b></td>
    </tr>
      <?php
}
    ?>
    <tr>
      <td colspan = "17">
<a href="resultsearch.php" class="btn btn-primary btn-success d-block m-auto text-white" > Back </a> 
</td>
</tr>
</table>


	 <footer>
            <h5 class="text-center"> &copy2019 PostManoy.</h5> 
         </footer>
	</div>
</body>
</html>