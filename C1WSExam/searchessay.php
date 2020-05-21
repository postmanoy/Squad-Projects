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
      <title>Search Name - DSaaS Exam</title>
      <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<style type="text/css">
  .animateuse{
      animation: leelaanimate 0.5s infinite;
    }

@keyframes leelaanimate{
      0% { color: red },
      10% { color: yellow },
      20%{ color: blue }
      40% {color: green },
      50% { color: pink }
      60% { color: orange },
      80% {  color: black },
      100% {  color: brown }
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
          <h4 class="card-header text-center"> Search Name </h4>
          <br>
          <form action="essay.php" method="post">
            <div class="form-group">
              <label for="user "> Enter Full Name: </label>
              <input type="text" name="userName" id="userName" class="form-control text-center" required>
              <label for="user "> Enter Date and Time: </label>
              <input type="text" name="userDate" id="userDate" class="form-control text-center" required>
            </div>

            <button class="btn btn-success d-block m-auto" style = "width:100%;" type="submit"> Submit </button>
            <br>
            <a href="landing.php" class="btn btn-primary btn-dark d-block m-auto text-white" > Back </a>
          </form>
        
        </div>
      </div>

      
        </div>
      </div>


<br>
<hr>
<br>
<div class="container">
<div class="card">
 <table class="table table-striped table-hover table-condensed table-bordered fixed" id="Tabla">
                <thead>
                <tr class="info">
                    <td colspan = "2"><h4 align = "center"> List of Names with Date </h4></td>
                </tr>
                 </thead>
                <tbody id="TablaFamilias">
    <?php
      $resultquery = "SELECT * FROM usersession WHERE ess_sc = '0'";
      $queryr = mysqli_query($con, $resultquery);
      while ($value = mysqli_fetch_array($queryr)){
    ?>
                <tr>
                    <td width = 50% align = center><?php echo $value['name']; ?></td>
                     <td align = center><?php echo $value['date']; ?></td>
                </tr>
        <?php
}
    ?>
     <hr>
 </tbody>
</table>
   </div>
    </div>
  </div>
  

    </body>