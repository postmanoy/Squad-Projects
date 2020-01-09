<?php
session_start();
error_reporting(0);

include('connect.php');

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
});

$(document).ready(function () {
    $("#opt").change(function () {
      var optvalue = $(this).val();
      if(optvalue == "dsc"){
        <?php
            $i = 0;
            $qopt1 = "select * from dsc";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['dsc_value']; ?>' /><?php echo $roopt1['dsc_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }

      else if(optvalue == "prbm"){
        <?php
            $i = 0;
            $qopt1 = "select * from prbm";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['prbm_value']; ?>' /><?php echo $roopt1['prbm_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }

      else if(optvalue == "os"){
        <?php
            $i = 0;
            $qopt1 = "select * from os order by os_value asc";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['os_value']; ?>' /><?php echo $roopt1['os_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }

      else if(optvalue == "dsm"){
        <?php
            $i = 0;
            $qopt1 = "select * from dsm order by (dsm_value * 1.00) asc";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['dsm_value']; ?>' /><?php echo $roopt1['dsm_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }

      else if(optvalue == "dsa"){
        <?php
            $i = 0;
            $qopt1 = "select * from dsa order by (dsa_value * 1.00) asc";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['dsa_value']; ?>' /><?php echo $roopt1['dsa_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }

      else if(optvalue == "ic"){
        <?php
            $i = 0;
            $qopt1 = "select * from ic";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['ic_value']; ?>' /><?php echo $roopt1['ic_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }

      else if(optvalue == "sc"){
        $("#tableopt").html("");
        $("#issCat").change(function () {
        var icvalue = $(this).val();
        <?php
            $i = 0;
            $qic= "select * from ic";
            $queryic = mysqli_query($con, $qic);
            while($roic = mysqli_fetch_array($queryic)){
              $valic = $roic['ic_value'];
            ?>
            if (icvalue == "<?php echo $valic; ?>") {
              <?php
                    $qsc = "select * from sc WHERE sc_ic_value = '$valic'";
                    $querysc = mysqli_query($con, $qsc);
              ?>
                $("#tableopt").html(" \
                    <?php
                    while($rosc = mysqli_fetch_array($querysc)){
                    ?>
                    <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $rosc['sc_value']; ?>' /><?php echo $rosc['sc_value']; ?><br> \
                    <?php
                    $i++;
                  }
                  ?>
                  "); 
            } 
        <?php 
          } 
        ?>
        });
      }

      else if(optvalue == "seg"){
        <?php
            $i = 0;
            $qopt1 = "select * from seg";
            $queryopt1 = mysqli_query($con, $qopt1);
            ?>
            $("#tableopt").html(" \
                          <?php
                            while($roopt1 = mysqli_fetch_array($queryopt1)){
                           ?>
                            <input type='checkbox' name='delete[<?php echo $i; ?>]' value='<?php echo $roopt1['seg_value']; ?>' /><?php echo $roopt1['seg_value']; ?><br> \
                          <?php
                            $i++;
                            } 
                          ?>
                    ");
            <?php   
        ?>
      }


      else if (optvalue == "N/A"){
        $("#tableopt").html("");
      }                
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
                <h3 class="margin">Remove Choices</h3>
        </div>

        <div class="container" id="div1">
            <div class="row">
                <div class="col">
                    <form action="removeprocessentry.php" method = "post" id = "reply">
                      <label for="exampleFormControlSelect1" class = "text-center"><b>Options available:</b></label>
                      <select class="form-control" id="opt" name = "opt">
                        <option value="N/A">Please select an option...</option>
                        <option value="dsc">Deep Security Component</option>
                        <option value="prbm">Problematic Module</option>
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
                                              <option value="N/A">Select Issue Category...</option>
                                      <?php
                                                $qic = "select * from ic";
                                                      $queryic = mysqli_query($con, $qic);
                                                      while($roic = mysqli_fetch_array($queryic)){
                                            ?>
                                              <option value="<?php echo $roic['ic_value']; ?>"><?php echo $roic['ic_value']; ?></option>
                                      <?php
                                      }
                                      ?>
                                    </select>
                            </div>
                  <div class="form-group card">
                    <div class="container" id = "tableopt" style="height: 200px;overflow-y: scroll;">
                          </div>
                        </div>
                    </div>
                   </div>
            </div>

            <div class="container" id="div2">
              <input type = "submit" class="btn btn-danger btn-lg btn-block" id = "submit" value = "Remove">
            </div>
      

</body>
</html>

<?php
unset($_SESSION['output']);
session_destroy();
?>