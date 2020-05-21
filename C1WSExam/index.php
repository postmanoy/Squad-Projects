<?php 
include('connect.php');
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:../PHDSaaS/index.php');
    exit;
}

?>

<html>
<head>
<link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
<title>Welcome to PH C1WS Enablement Exam!</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<script src="three.r95.min.js"></script>
<script src="vanta.net.min.js"></script>
<script>
   $(document).ready(function()
      { 
             $(document).bind("contextmenu",function(e){
                    return false;
             });
      });
</script>
<style>

body {
    font-family: "Lato", sans-serif;
    background-color: #000;
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

input{
  text-align:center;
}

::-webkit-input-placeholder {
   text-align: center;
}

:-moz-placeholder { /* Firefox 18- */
   text-align: center;  
}

::-moz-placeholder {  /* Firefox 19+ */
   text-align: center;  
}

:-ms-input-placeholder {  
   text-align: center; 
}

label {
   color:white;
}

.main {
    overflow-x: hidden;
    overflow-y: hidden;
}

.login-main-text{
    color: #fff;
}

.login-main-text h2{
    font-weight: 300;
}

.btn-black{
    background-color: #000 !important;
    color: #fff;
}

.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  overflow: auto;
  overflow-x: hidden;
  overflow-y: hidden; /* Just to visualize the extent */
  background-color: black;
  
}

p {
  color:#fff;
}

div.boxx{
   box-shadow: 10px 10px 5px black;
   background-color: #454545;
   border-radius: 15px;
   padding: 20px;
}

</style>
</head>
<body>

<div class = "fullscreen w3-animate-bottom" id = "background-main">
        <center>
          <div class="login-main-text">
          <br><br>
            <img src="ds-logo.png" height="250" width="250"><br>
            <h2>PH C1WS Enablement Exam</h2>
         </div></center>
         <center><div class="col-md-4 col-sm-12">
            <div class="login-form w3-container boxx">
                        <center><h2 class = "text-white" style = "font-weight: 300;">Please Login</h2></center>
               <form action="login.php" method="post">
                  <div class="form-group">
                     <label style = "text-align:left;float: left;">Full Name</label>
                     <input type="text" name = "user" id = "user" class="form-control" placeholder="Full Name" required>
                  </div>
                  <div class="form-group">
                     <label style = "text-align:left;float: left;">Password</label>
                     <input type="password" name = "pass" id = "pass" class="form-control" placeholder="Password" required>
                  </div>
                  <center><button type="submit" class="btn btn-danger" style="width:25%;">Start Exam</button></center>
               </form>
            </div>
            <br>
            <p>To login, please ask the proctor for the password.<br>&copy 2019 PostManoy</p>
         </div></center>
      </div>

      <script>
            VANTA.NET({
              el: "#background-main",
              mouseControls: true,
              touchControls: true,
              minHeight: 500.00,
              minWidth: 500.00,
              scale: 1.00,
              scaleMobile: 1.00,
              color: 0x810707,
              backgroundColor: 0x2e0201,
              points: 9.00,
              maxDistance: 24.00
            })
</script>

</body>
</html>