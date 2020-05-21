<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="shortcut icon" type="image/png" href="favicon.png"/>
  <title>PH Cloud One Support Team</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="css\aestheti.css">
  <link href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <meta http-Equiv="Cache-Control" Content="no-cache">
  <meta http-Equiv="Pragma" Content="no-cache">
  <meta http-Equiv="Expires" Content="0">
  <!--MyLiveChat-->
 <!-- <script type="text/javascript">
    function add_chatinline(){
      var hccid=54209281;var nt=document.createElement("script");
      nt.async=true;
      nt.src="https://mylivechat.com/chatinline.aspx?hccid="+hccid;
      var ct=document.getElementsByTagName("script")[0];
      ct.parentNode.insertBefore(nt,ct);
    }
      add_chatinline(); 
    </script> -->
  <!--MyLiveChat-->

  <script>
      $(document).ready(function(){
        $("#closeChat").hide();
        // Add scrollspy to <body>
        $('body').scrollspy({target: ".navbar", offset: 50});   
      
        // Add smooth scrolling on all links inside the navbar
        $("#myNavbar a").on('click', function(event) {
          // Make sure this.hash has a value before overriding default behavior
          if (this.hash !== "") {
            // Prevent default anchor click behavior
            event.preventDefault();
      
            // Store hash
            var hash = this.hash;
      
            // Using jQuery's animate() method to add smooth page scroll
            // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
            $('html, body').animate({
              scrollTop: $(hash).offset().top
            }, 800, function(){
         
              // Add hash (#) to URL when done scrolling (default click behavior)
              window.location.hash = hash;
            });
          }  // End if
        });
      });

       window.console = window.console || function(t) {};
  if (document.location.search.match(/type=embed/gi)) {
    window.parent.postMessage("resize", "*");
  }
  function adjustPopover(popover, iframe) {
    var height = iframe.contentWindow.document.body.scrollHeight + 'px',
        popoverContent = $(popover).next('.popover-content');
    iframe.style.height = height;
    popoverContent.css('height', height);
}
  $(document).ready(function()
      { 
             $(document).bind("contextmenu",function(e){
                    return false;
             });
             $('#openChatB').on('click',function(e) {
                $('#openChatB').hide();
             });

             $('.closeChat').on('click',function(e) {
              $('#openChatB').show();
              
             });

        $("#bodyPage").html("<object data='https://jarvis.trendmicro.com/' width='100%' style = 'height:80vh;' />");
      });
  </script>
  <style>
    .large-header {
     position: relative;
     width: 100%;
     background: #111;
     overflow: hidden;
     background-size: cover;
     background-position: center center;
     z-index: 1;
  }

  .demo .large-header {
     background-image: url("bg2.jpg");
  }

  .main-title {
     position: absolute;
     margin: 0;
     padding: 0;
     color: #F9F1E9;
     text-align: center;
     top: 50%;
     left: 50%;
     -webkit-transform: translate3d(-50%, -50%, 0);
     transform: translate3d(-50%, -50%, 0);
  }

  .main-title .thin {
     font-weight: 200;
  }

  @media only screen and (max-width: 768px) {
     .demo .main-title {
        font-size: 3em;
     }
  }
  body{
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

/* Overlay Button for Chat */

#mybutton {
  position: fixed;
  bottom: 10px;
  right: 20px;
  z-index: 2;
}


/* Overlay Button for Chat */
  </style>
</head>

<body>

<!-- Overlay Button for Chat -->
<div id="mybutton">
<button class="btn btn-danger btn-lg" data-toggle="modal" id = "openChatB" data-target="#openChat" style ="border-radius: 30px;"><img src="img\chaticon.png" height="30" width="30"> Chat Now </button>
</div>
<!-- Overlay Button for Chat -->

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow fixed-top">
    <div class="container">
      <img src="ds-logo.png" height="32" width="32"><a class="navbar-brand" href="#"> &nbsp;| PH Cloud One Support Team</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="#home">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#tools">Tools</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#main">Team</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
  <!-- Full Page Image Header with Vertically Centered Content -->
  <section id="home">
    <header class="masthead">
      <div class="demo">
          <div class="content">
            <div id="large-header" class="large-header">
            <canvas id="demo-canvas"></canvas>
            <h1 class="main-title"><span class="font-weight-light"><img src="ds-logo.png" height="250" width="250"><br><br>PH Cloud One Customer Support Team</span></h1>
          </div>
        </div>
      </div>
      <script src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js"></script>
      <script src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/499416/TweenLite.min.js'></script>
      <script src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/499416/EasePack.min.js'></script>
      <script src='demo.js'></script>
      <script id="rendered-js">
            // There are a few JS dependancies

            // Check the settings to take a look
            // at those as they are necessary.
            //# sourceURL=pen.js
      </script>
      <script src="https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js"></script>
    </header>
  </section>
  
<!--TOOLS-->
  <section id="tools">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-6 order-lg-2">
          <div class="p-5">
            <img class="img-fluid tool" src="tag.png" alt="" onclick="javascript:window.open('../CaseTagging/index.php', '_blank')">
          </div>
        </div>
        <div class="col-lg-6 order-lg-1">
          <div class="p-5">
            <h2 class="display-4">PH Cloud One Case Tagging Tool</h2>
            <p>Tool used to tag PH DSaaS cases and for tracking the number of cases per category. </p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section>
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-6">
          <div class="p-5">
            <img class="img-fluid tool" src="exam.png" alt="" onclick="javascript:window.open('../DSaaSExam/index.php', '_blank')">
          </div>
        </div>
        <div class="col-lg-6">
          <div class="p-5">
            <h2 class="display-4">PH C1WS Enablement Exam</h2>
            <p>Exam used for assessing the level of knowledge of the engineer in underlying Deep Security technologies</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section>
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-6 order-lg-2">
          <div class="p-5">
            <img class="img-fluid tool" src="code.png" alt="" data-toggle="modal" data-target="#pwett">
          </div>
        </div>
        <div class="col-lg-6 order-lg-1">
          <div class="p-5">
            <h2 class="display-4">P.W.E.T.T.</h2>
            <p>Pre-check Work and Early Testing Tool</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section>
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-6">
          <div class="p-5">
            <img class="img-fluid tool" src="Devops.png" alt="" data-toggle="modal" data-target="#Devops">
          </div>
        </div>
        <div class="col-lg-6 order-lg-1">
          <div class="p-5">
            <h2 class="display-4">DevOps Resources</h2>
            <p>Contains all the resources of PHDSaaS for DevOops including Jenkins, SmartCheck, DSAP, GitHub, etc.</p>
            <p></p>
          </div>
        </div>
      </div>
    </div>
  </section>
<!--end of tools-->

  <!-- TEAM -->
  <section class="py-5" id="main">
    <div class="container" id="Team">
      <h1 class="display-4">Meet the team</h1>
      <div class="container">
        <div class="row" style="padding-top: 30px; padding-bottom: 40px;">
          <!-- Team Member 1 -->
          <div class="col-4">
            <div class="card border-0 shadow mx-auto" style="width: 15rem;">
              <img src="img\dek.jpg" class="card-img-top" alt="...">
              <div class="card-body text-center">
                <h5 class="card-title mb-0">Dexter Lopez</h5>
                <div class="card-text text-black-50">Tech Lead</div>
              </div>
            </div>
          </div>
          <!-- Team Member 2 -->
          <div class="col-4">
            <div class="card border-0 shadow mx-auto" style="width: 15rem;">
              <img src="img\felix.jpg" class="card-img-top" alt="...">
              <div class="card-body text-center">
                <h5 class="card-title mb-0">Felix Yang</h5>
                <div class="card-text text-black-50">Team Manager</div>
              </div>
            </div>
          </div>
          <!-- Team Member 3 -->
          <div class="col-4">
            <div class="card border-0 shadow mx-auto" style="width: 15rem;">
              <img src="img\mark.jpg" class="card-img-top" alt="...">
              <div class="card-body text-center">
                <h5 class="card-title mb-0">Mark Mable</h5>
                <div class="card-text text-black-50">Tech Lead</div>
              </div>
            </div>
          </div>
        </div>
        <!-- /.row -->      
      </div>
      <h2 class="font-weight-light text-center">Squadrons</h2>
      <div class="row align-items-center" style="padding-top: 50px; padding-bottom: 50px;">
          <div class="sqd col-sm-4 text-center"><img src="img\md.png" class="rounded-circle squad" data-toggle="modal" data-target="#mobydock"></div>
          <div class="sqd col-sm-4 text-center"><img src="img\RS2.png" class="rounded-circle squad" data-toggle="modal" data-target="#rs2"></div>
          <div class="sqd col-sm-4 text-center"><img src="img\pm.png" class="rounded-circle squad" data-toggle="modal" data-target="#postmanoy"></div>
        </div>
    </div>
  </section>

  <!--end of team-->

<!-- Mobydock Modal -->
<div class="modal fade" id="mobydock">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
  
        <!-- Modal Header -->
        <div class="modal-header" style="background-color: grey; color: white">
           <h2 class="modal-title font-weight-bolder">Mobydock&nbsp;</h2><h2 class="modal-title font-weight-light text-center">| Docker & Kubernetes Squadron</h2>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
  
        <!-- Modal body -->
        <div class="modal-body">
            <div class="container">
                <div class="row align-items-center" style="padding-top: 50px; padding-bottom: 50px; color:white">
                    <div class="col-sm-3 text-center"><img src="img\jv.jpg" class="rounded-circle" height="200" width="200">
                      <br><br>Jayvee Velez
                      <br><b>Squad Lead</b>
                  </div>
                  <div class="col-sm-3 text-center"><img src="img\james.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Aaron James Quinto
                      
                  </div>
                  <div class="col-sm-3 text-center"><img src="img\steep.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Nino Alegre
                      
                  </div>
                  <div class="col-sm-3 text-center"><img src="img\venrod2.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Venrod Ramos
                      
                  </div>                  
                </div>
            </div>
        </div>
      </div>
    </div>
  </div>

<!--End of Mobydock Modal-->

<!-- RS2 Modal -->
<div class="modal fade" id="rs2">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
  
        <!-- Modal Header -->
        <div class="modal-header" style="background-color: grey; color: white">
          <h2 class="modal-title font-weight-bolder">RS2&nbsp;</h2><h2 class="modal-title font-weight-light text-center">| Cloud Computing Squadron</h2>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
  
        <!-- Modal body -->
        <div class="modal-body">
            <div class="container">
                <div class="row align-items-center" style="padding-top: 50px; padding-bottom: 50px; color:white">
                    <div class="col-sm-3 text-center"><img src="img\royce.jpg" class="rounded-circle" height="200" width="200">
                      <br><br>Royce Encarnacion
                      <br><b>Squad Lead</b>
                  </div>
                  <div class="col-sm-6 text-center"><img src="img\fred.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Frederick Pagala
                      
                  </div>
                  <div class="col-sm-3 text-center"><img src="img\sean.JPG" class="rounded-circle" height="200" width="200">
                    <br><br>Sean Dela Rosa
                      
                  </div>
                  <div class="col-sm-7 text-center"><img src="img\syd.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Sydney Palacio
                      
                  </div>
                  <div class="col-sm-3 text-center"><img src="img\darren.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Darren Sison
                      
                  </div>                 
                </div>
            </div>
        </div>
      </div>
    </div>
  </div>

<!--End of RS2 Modal-->


<!-- PostManoy Modal -->
<div class="modal fade" id="postmanoy">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header" style="background-color: grey; color: white">
        <h2 class="modal-title font-weight-bolder">PostManoy&nbsp;</h2><h2 class="modal-title font-weight-light text-center">| API / Coding Squadron</h2>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
          <div class="container">
              <div class="row align-items-center" style="padding-top: 50px; padding-bottom: 50px;color:white">
                  <div class="col-sm-3 text-center"><img src="img\arvin.jpg" class="rounded-circle" height="200" width="200">
                    <br><br>Arvin Movilla
                    <br><b>Squad Lead</b>
                </div>
                <div class="col-sm-6 text-center"><img src="img\clark.jpg" class="rounded-circle" height="200" width="200">
                  <br><br>Clark Panares                   
                </div>
                <div class="col-sm-3 text-center"><img src="img\fonsi.jpg" class="rounded-circle" height="200" width="200">
                  <br><br>Alfonso Munez                  
                </div>                          
              </div>
          </div>
      </div>
    </div>
  </div>
</div>
<!--End of PostManoy Modal-->

<!--PWETT Modal-->

<div class="modal fade" id="pwett">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header" style="background-color: grey; color: white">
        <h2 class="modal-title font-weight-bolder">P.W.E.T.T.&nbsp;</h2><h2 class="modal-title font-weight-light text-center">| Download the tool</h2>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
          <div class="container">
              <div class="row align-items-center" style="padding-top: 50px; padding-bottom: 50px;color:white">
                  <div class="col-sm-6 text-center"><img src="windows.png" height="200" width="200">
                    <h2 class="modal-title font-weight-light text-center">Windows</h2><br>
                    <form action = "downloadW.php" method = "post">
                    <button type="submit" class="btn btn-success"><i class="fas fa-download"></i> Download</button>
                  </form>
                  </div>
                  <div class="col-sm-6 text-center"><img src="linux.png" height="200" width="200">
                    <h2 class="modal-title font-weight-light text-center">Linux</h2><br>
                    <form action = "downloadL.php" method = "post">
                    <button type="submit" class="btn btn-success"><i class="fas fa-download"></i> Download</button>
                  </form>
                  </div>                
              </div>
          </div>
      </div>
    </div>
  </div>
</div>


<!--end of PWETT Modal-->

<!-- Chat Modal -->
<div class="modal fade modal-chat" id="openChat" data-backdrop = "false">
  <div class="modal-dialog" style = "width:100%;max-width:90%;">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header" style="background-color: grey; color: white">
        <h4 class="modal-title font-weight-bolder">Jarvis Chat</h2>
        <button type="button" class="close closeChat"data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" id = "bodyPage">
              <!--<iframe src = "https://jarvis.trendmicro.com/" height="600" width="100%"></iframe>-->
          </div>
      </div>
    </div>
  </div>
</div>

<!-- End of Chat Modal -->

<!--Devops Modal-->

<div class="modal fade" id="Devops">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header" style="background-color: grey; color: white">
        <h2 class="modal-title font-weight-bolder">DevOps Resources&nbsp;</h2><h2 class="modal-title font-weight-light text-center">| Tools</h2>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

<!-- Modal body -->
      <div class="modal-body">
          <div class="container">
              <div class="row align-items-center" style="padding-top: 50px; padding-bottom: 50px;color:white">
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="jenkins.png" height="200" width="200" onclick="javascript:window.open('http://phdsaas-rg-cicdserver01.eastus.cloudapp.azure.com:8080/', '_blank')">
                    <h2 class="modal-title font-weight-light text-center">Jenkins</h2><br>
                  </div>
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="smartcheck.png" height="200" width="200" onclick="javascript:window.open('https://phdsaas-rg-smarcheck01.eastus.cloudapp.azure.com:30019', '_blank')">
                    <h2 class="modal-title font-weight-light text-center">SmartCheck</h2><br>
                  </div>
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="appprotect.png" height="200" width="200" onclick="javascript:window.open(' https://dashboard.prod.im7.io', '_blank')">
                    <h2 class="modal-title font-weight-light text-center">DS App Protect</h2><br>
                  </div>  
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="repolock.png" height="200" width="200" onclick="alert('143631420864.dkr.ecr.us-east-2.amazonaws.com/phdsaas')">
                    <h2 class="modal-title font-weight-light text-center">Private Repository</h2><br>
                  </div>              
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="repository.png" height="200" width="200" onclick="alert('docker pull phdsaasdevops/cicd')">
                    <h2 class="modal-title font-weight-light text-center">Public Repository</h2><br>
                  </div>
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="github.png" height="200" width="200" onclick="javascript:window.open('https://github.com/phdsaasdevops/', '_blank')">
                    <h2 class="modal-title font-weight-light text-center">GitHub</h2><br>
                  </div>  
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="slack.png" height="200" width="200" onclick="javascript:window.open('https://phdsaassupport.slack.com', '_blank')">
                    <h2 class="modal-title font-weight-light text-center">Slack</h2><br>
                  </div>  
                  <div class="col-sm-3 text-center"><img class="img-fluid tool" src="trello.png" height="200" width="200" onclick="javascript:window.open('https://trello.com/b/9dFBV1Pz/ph-dsaas-squadgoals', '_blank')">
                    <h2 class="modal-title font-weight-light text-center">Trello</h2><br>
                  </div>    
              </div>
          </div>
      </div>
    </div>
  </div>
</div>

<!--end of Devops Modal-->

<footer class="py-5" style="background-color: rgb(37, 36, 36);">
    <div class="container">
      <p class="m-0 text-center text-white small">Copyright &copy; Shandi 2019</p>
    </div>
    <!-- /.container -->
</footer>

</body>

</html>