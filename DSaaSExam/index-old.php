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
<title>Welcome to PH DSaaS Enablement Exam!</title>

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

label {
   color:white;
}

.sidenav {
    height: 100%;
    overflow-x: hidden;
    padding-top: 20px;
    overflow-y: hidden;
}


.main {
    padding: 0px 10px;
    overflow-x: hidden;
    overflow-y: hidden;
}


@media screen and (max-height: 450px) {
    .sidenav {padding-top: 15px;}
}

@media screen and (max-width: 450px) {
    .login-form{
        margin-top: 10%;
    }

}

@media screen and (min-width: 768px){
    .main{
        margin-left: 10%;
    }

    .sidenav{
        width: 40%;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
    }

    .login-form{
        margin-top: 50%;
    }

}


.login-main-text{
    margin-top: 20%;
    padding: 60px;
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
  left: 30%;
  bottom: 0;
  right: 0;
  overflow: auto;
  background-color: black;
  overflow-x: hidden;
  overflow-y: hidden; /* Just to visualize the extent */
  
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

<div class = "fullscreen w3-animate-opacity" id = "background-main">
<div class="sidenav w3-animate-opacity">
         <div class="login-main-text">
            <img src="ds-logo.png" height="250" width="250"><br>
            <br>
            <h2>PH DSaaS<br> Enablement Exam</h2>
            <p>To login, please ask the proctor for the password.</p>
            <br>
            <p>&copy 2019 PostManoy</p>
         </div>
      </div>
      <div class="main w3-animate-bottom">
         <div class="col-md-6 col-sm-12">
            <div class="login-form w3-container boxx">
               <form action="login.php" method="post">
                  <div class="form-group">
                     <label>Full Name</label>
                     <input type="text" name = "user" id = "user" class="form-control" placeholder="Full Name" required>
                  </div>
                  <div class="form-group">
                     <label>Password</label>
                     <input type="password" name = "pass" id = "pass" class="form-control" placeholder="Password" required>
                  </div>
                  <center><button type="submit" class="btn btn-danger" style="width:30%;">Start Exam</button></center>
               </form>
            </div>
         </div>
      </div>
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