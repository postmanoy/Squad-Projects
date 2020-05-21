
<?php 
include('connect.php');
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:../PHDSaaS/index.php');
    exit;
}

?>





<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
	<title>Welcome to DSaaS Exam!</title>

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
  <style>
  	 body{
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}
</style>
</head>
<body>
<h1 class="text-center text-white font-weight-bold text-uppercase bg-dark" >  Trend Micro Deep Security As A Service Exam </h1><br>
	<div class="container">
		<h1 class="text-center"> Welcome! </h1><br>

		<div class="row">
			
			<div class="col-lg-12 text-center">
				<div class="card">
					<h4 class="card-header text-center"> Login Form </h4>
					<br>
					<form action="login.php" method="post">
						<div class="form-group">
							<label for="user "> Enter your Full Name: </label>
							<input type="text" name="user" id="user" class="form-control text-center" required>
						</div>
						<div class="form-group">
							<label for="pass "> Password for Exam (ask proctor): </label>
							<input type="password" name="pass" id="pass" class="form-control text-center" required>
						</div>
						<button class="btn btn-success d-block m-auto" style = "width:100%;" type="submit"> Submit </button>
					</form>
				
				</div>
			</div>

			
				</div>
			</div>

		</div>
 <footer>
            <h5 class="text-center"> &copy2019 PostManoy.</h5> 
         </footer>
	</div>

</body>
</html>