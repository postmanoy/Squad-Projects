<?php
session_start();
error_reporting(0);

include('connect.php')

   if(isset($_SESSION['output'])){
    $output = $_SESSION['output'];
   }

      //if (isset($_SESSION['message'])) {
      //$msg = $_SESSION['message'];
      //print '<script type="text/javascript">alert("' . $msg . '");</script>';
//}

?>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>PH DSaaS Case Tagging Tool</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" type="image/png" href="favicon.png"/>
  <link href="https://fonts.googleapis.com/css?family=Roboto:300|Roboto+Slab:400,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

  <script>


function createArr(){
    var arr=new Array();
    var txt=$('#outputs').val();
    $.each(txt.split(', '),function(i,value){
    if(value!=""){
          arr.push(value);
        }
    });
  console.log(arr);
  $('#example').val(JSON.stringify(arr));
}

$(document).ready(function()
      { 
             $(document).bind("contextmenu",function(e){
                    return false;
             });
             $("#issCat").hide();
             $("#issCatL").hide();
      });
      
      $(document).ready(function () 
      {
              $("#opt").change(function () {
              var val = $(this).val();
              if (val != "sc") {
                  $("#issCat").hide();
                  $("#issCatL").hide();
              }
              else{
                  $("#issCat").show();
                  $("#issCatL").show();
              }   
            });

      $("#outputs").keyup(function(){
        $("#count").text("Characters left: " + (2000 - $(this).val().length));
      });

      $("#submit").click(function(){
          createArr();
      });
});




  </script>

</head>
<style>

a {
    font-family: 'Roboto', sans-serif;
}

h2 {
    font-family: 'Roboto Slab', serif;
    font-weight: 700;
}

#div1 {
    padding-top: 60px;
  }
  @media (max-width: 980px) {
    body {
      padding-top: 0;
    }
  }

#div2 {
    padding-top: 40px;
  }
  @media (max-width: 980px) {
    body {
      padding-top: 0;
    }
  }

#bg {
    background-image: url("bg.jpg");
    background-repeat: no-repeat;
    background-size: cover;
    color: #ffffff;
}

.navbar-brand
{
    font-size: 20px;
}

.container-fluid {
    padding-top: 30px;
    padding-bottom: 30px;
}

</style>
<body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <a class="navbar-brand" href="index.php" >
                        <img src="ds-logo.png" height="32" width="32" class="d-inline-block align-top" alt="">
                        | PH DSaaS Case Tagging Tool
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                        <div class="navbar-nav ml-auto">
                          <a href="index.php"><button type="button" class="btn btn-outline-light">Home</button></a>
                        </div>
                </div>
        </nav>

        <div class="container-fluid text-center" id="bg">
                <h3 class="margin">Add Choices</h3>
        </div>

        <div class="container" id="div1">
            <div class="row">
                <div class="col">
                    <form action="processentry.php" method = "post" id = "reply">
                      <label for="exampleFormControlSelect1" class = "text-center"><b>Options available:</b></label>
                      <select class="form-control" id="opt" name = "opt">
                        <option value="dsc">Deep Security Component</option>
                        <option value="prbm">Concerned Feature</option>
                        <option value="os">Affected Operating System</option>
                        <option value="dsm">DSM Version</option>
                        <option value="dsa">DSA Version</option>
                        <option value="ic">Issue Category</option>
                        <option value="sc">Sub Category</option>
                        <option value="seg">Reason for SEG Escalation</option>
                        </select>
                      <div class="form-group">
                                    <label for="exampleFormControlSelect1" id = "issCatL"><b>Issue Sub Category:</b></label>
                                    <select class="form-control" id="issCat" name="icl">
                                      <?php
                                                $qic = "select * from ic order by ic_value asc";
                                                      $queryic = mysqli_query($con, $qic);
                                                      while($roic = mysqli_fetch_array($queryic)){
                                            ?>
                                              <option value="<?php echo $roic['ic_value']; ?>"><?php echo $roic['ic_value']; ?></option>
                                      <?php
                                      }
                                      ?>
                                    </select>
                            </div>
                  <div class="form-group">
                            <textarea class="form-control" rows="10" placeholder="Enter values here" id = "outputs" style = "resize:none;" maxlength="2000" name = "outputs"></textarea>
                            <h6 class = "text-center" id = "count">Characters Left: 2000</h6>
                            <p class = "text-center"><i>Example Formats:<br>*For multiple entries, put a <b>", "</b> every after entry.<br>For DSM Version: 12.0.300, 12.0.347, 10.0.2500<br> For Deep Security Component: DSM AMI, DSaaS, DSA, DSR<i></p>
                            <input type = "text" id = "example" name = "outputsfinal" maxlength="2000" hidden />
                    </div>
                   </div>
            </div>

            <div class="container" id="div2">
              <input type = "submit" class="btn btn-success btn-lg btn-block" id = "submit" value = "Add">
            </div>
      

</body>
</html>

<?php
unset($_SESSION['output']);
session_destroy();
?>