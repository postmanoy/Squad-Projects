<?php
session_start();
error_reporting(0);
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:index.php');
    exit;
}

include('connect.php');

?>

<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
	<title>Admin Page - DSaaS Exam</title>

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
<h1 class="text-center text-white font-weight-bold text-uppercase bg-dark" >  Trend Micro Deep Security As A Service Exam </h1><br>
	<div class="container">
		<div class = "col-lg-12 text-center">
		<h1 class="text-center"> Welcome, DS-Admin! </h1><br>

		<h2 class="text-center"> Choose what you want to do: </h2><br>
		<hr>
		<a href="resultsearch.php" class="btn btn-primary d-block m-auto text-white" > Go to Results </a> 
		<hr>
		<a href="searchessay.php" class="btn btn-primary d-block  m-auto text-white"> Check Essays </a>
		<hr>
		<a href="showquestions.php" class="btn btn-primary d-block m-auto text-white"> View Q & A </a>
		<hr>
		<a href="admin.php" class="btn btn-primary d-block m-auto text-white"> Add Questions to DB </a>
		<hr> 
		<a href="logout.php" class="btn btn-primary btn-danger d-block m-auto text-white"> Logout </a>
	</div>
	<hr>
			<?php
			$q = "select * from passwordtest ORDER BY p_id DESC LIMIT 1";
            $query = mysqli_query($con, $q);
            while($rows = mysqli_fetch_array($query)){
            	$pwd = $rows['password'];
            }
            ?>
		<input type="text" name="ch1" id="ch1" class="form-control text-center" value ="<?php echo $pwd ; ?>" disabled>
		<form action="passwordgen.php" method="post">
		<button class="btn btn-success d-block m-auto" style = "width:100%;" type="submit"> Generate Password for Exam </button>
	</form>
	 <footer>
            <h5 class="text-center"> &copy2019 PostManoy.</h5> 
         </footer>
</div>
</body>
</html>
