<?php
session_start();

include('connect.php');

error_reporting(0);
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:../DSaaSExam/index.php');
    exit;
}

if (isset($_GET['Message'])) {
     print '<script type="text/javascript">alert("' . $_GET['Message'] . '");</script>';
}

?>

<!DOCTYPE html>
<html>
<?php
?>
<head>
	<link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
	<title>Add Question (DSAdmin) - DSaaS Exam</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	 <link href="https://fonts.googleapis.com/css?family=Montserrat|Open+Sans" rel="stylesheet">
<!-- 
	 font-family: 'Montserrat', sans-serif; 
	font-family: 'Open Sans', sans-serif;
	-->
<style>
	 #txtarea {
         display:block;
         width:100%;
         height:150px;
         padding:0.5%;
         margin:0;
         border:2px solid #e6e6e6;
         overflow:auto;
         resize: none;
         }
</style>

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
		
		<div class="row">
			
			<div class="col-lg-12 text-center">
				<div class="card">
					<h4 class="card-header text-center"> Question Panel </h4>
					<br>
					<form action="addquestion.php" method="post">
					<label for="user "> Enter Question: </label>
						<textarea name="question" id="txtarea" maxlength = "600" required></textarea>
  						<br>						
						<div class="form-group">
							<label for="user "> Choice 1: </label>
							<input type="text" name="ch1" id="ch1" class="form-control text-center" required>
						</div>
						<div class="form-group">
							<label for="user "> Choice 2: </label>
							<input type="text" name="ch2" id="ch2" class="form-control text-center" required>
						</div>
						<div class="form-group">
							<label for="user "> Choice 3: </label>
							<input type="text" name="ch3" id="ch3" class="form-control text-center" required>
						</div>
						<div class="form-group">
							<label for="user "> Choice 4: </label>
							<input type="text" name="ch4" id="ch4" class="form-control text-center" required>
						</div>
						<hr>
						<div><?php
						$querymax = "SELECT MAX(a_id) AS maximum FROM answers";
						$query = mysqli_query($con, $querymax);
						$row = mysqli_fetch_array($query);?>
						  <select name="corans" id="corans">
						    <option value="0">Choose Correct Answer: </option>
						    <?php
						    $row['maximum']++;
						    for($i=1; $i<=4; $i++){?>
						    <option value="<?php echo $row['maximum']++; ?>"><?php echo $i; ?></option>
						    <?php
						}
						?>    
						     </select>					

						  <select name="cat" id="cat">
						    <option value="0">Select Category of Question:</option>
						    <option value="1">1 - Networking</option>
						    <option value="2">2 - Windows</option>
						    <option value="3">3 - Linux</option>
						    <option value="4">4 - Cloud</option>
						    <option value="5">5 - Virtualization</option>
						    <option value="6">6 - DevOps</option>
						    <option value="7">7 - Database</option>
						    <option value="8">8 - Others</option>
						    <option value="9">9 - Essay</option>
						     </select>
						</div>

<hr>
<button class="btn btn-success d-block m-auto" style = "width:100%;" type="submit"> Add! </button>
<br>
</form>											
				</div>
				<a href="landing.php" class="btn btn-primary btn-dark d-block m-auto text-white" > Back </a><br>
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