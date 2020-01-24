<?php
session_start();
error_reporting(0);

include('connect.php');

   if(isset($_SESSION['output'])){
    $output = $_SESSION['output'];
   }

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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  <script type = "text/javascript" src="aesteti.js"></script>
  <link rel="stylesheet" href="aesteti.css" />

<script>
$(document).ready(function () {
    $("#ic").change(function () {
        var val = $(this).val();
        $('#sc').val('');
        <?php
            $qic= "select * from ic";
            $queryic = mysqli_query($con, $qic);
            while($roic = mysqli_fetch_array($queryic)){
              $valic = $roic['ic_value'];
            ?>
            if (val == "<?php echo $valic; ?>") {
                $("#scl").html(" \
                  <?php
                    $qsc = "select * from sc WHERE sc_ic_value = '$valic' order by sc_value asc";
                    $querysc = mysqli_query($con, $qsc);
                    while($rosc = mysqli_fetch_array($querysc)){
                  
                    ?>
                    <option value='<?php echo $rosc['sc_value']; ?>'><?php echo $rosc['sc_value']; ?></option> \
                    <?php
                  }
                  ?>
                  "); 
            } 
        <?php 
      } 
        ?>
        if (val == "N/A") {
            $("#scl").html("<option value='N/A'>N/A</option>");
            $('#sc').val('N/A');
        }
    });

});


</script>

</head>
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
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#AddChoice">Add Choices</button>
                    &nbsp;
                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#RemoveChoice">Remove Choices</button>
                  </div>
                </div>
        </nav>

    </n>
        <div class="container" id="div1">
            <div class="row">
                <div class="col">
                    <form>
                            <div class="form-group">
                                    <h2>Environment Details</h2>
                                    <label for="exampleFormControlSelect1"><b>Deep Security Component:</b></label>
                                    <input class="form-control" id ="dsc" list="dscl" value = "Choose an option..." autocomplete="off">
                                    <datalist id="dscl">
                                      <?php
                                            $qdsc = "select * from dsc order by dsc_value asc";
                                                  $querydsc = mysqli_query($con, $qdsc);
                                                  while($rodsc = mysqli_fetch_array($querydsc)){
                                        ?>
                                          <option value="<?php echo $rodsc['dsc_value']; ?>"><?php echo $rodsc['dsc_value']; ?></option>
                                  <?php
                                  }
                                  ?>
                                    </datalist>
                            </div>
                            <div class="form-group">
                                    <label for="exampleFormControlSelect1"><b>Concerned Feature:</b></label>
                                   <input class="form-control" id ="prbm" list="prbml" value = "Choose an option..." autocomplete="off">
                                    <datalist id="prbml">
                                      <?php
                                            $qprbm = "select * from prbm order by prbm_value asc";
                                                  $queryprbm = mysqli_query($con, $qprbm);
                                                  while($roprbm = mysqli_fetch_array($queryprbm)){
                                        ?>
                                          <option value="<?php echo $roprbm['prbm_value']; ?>"><?php echo $roprbm['prbm_value']; ?></option>
                                  <?php
                                  }
                                  ?>              
                                    </datalist>
                            </div>
                            <div class="form-group">
                                    <label for="exampleFormControlSelect1"><b>Affected Operating System:</b></label>
                                    <input class="form-control" id ="os" list="osl" value = "N/A" autocomplete="off">
                                    <datalist id="osl">
                                      <option value="N/A">N/A</option>
                                      <?php
                                            $qos = "select * from os order by os_value asc";
                                                  $queryos = mysqli_query($con, $qos);
                                                  while($roos = mysqli_fetch_array($queryos)){
                                        ?>
                                          <option value="<?php echo $roos['os_value']; ?>"><?php echo $roos['os_value']; ?></option>
                                  <?php
                                  }
                                  ?>                  
                                    </datalist>
                            </div>
                            <div class="form-group">
                                    <label for="exampleFormControlSelect1"><b>DSM Build:</b></label>
                                    <input class="form-control" id ="dsm" list="dsml" value = "N/A" autocomplete="off">
                                    <datalist id="dsml">
                                      <option value="N/A">N/A</option>
                                      <?php
                                            $qdsm = "select * from dsm order by (dsm_value * 1.00) asc";
                                                  $querydsm = mysqli_query($con, $qdsm);
                                                  while($rodsm = mysqli_fetch_array($querydsm)){
                                        ?>
                                          <option value="<?php echo $rodsm['dsm_value']; ?>"><?php echo $rodsm['dsm_value']; ?></option>
                                  <?php
                                  }
                                  ?>            
                                    </datalist>
                            </div>
                            <div class="form-group">
                                    <label for="exampleFormControlSelect1"><b>DSA Build:</b></label>
                                    <input class="form-control" id ="dsa" list="dsal" value = "N/A" autocomplete="off">
                                    <datalist id="dsal">
                                      <option value="N/A">N/A</option>
                                      <?php
                                            $qdsa = "select * from dsa order by (dsa_value * 1.00) asc";
                                                  $querydsa = mysqli_query($con, $qdsa);
                                                  while($rodsa = mysqli_fetch_array($querydsa)){
                                        ?>
                                          <option value="<?php echo $rodsa['dsa_value']; ?>"><?php echo $rodsa['dsa_value']; ?></option>
                                  <?php
                                  }
                                  ?>            
                                    </datalist>
                            </div>
                    </form>
                </div>

                <div class="col">
                        <form>
                                <div class="form-group">
                                        <h2>Issue Details</h2>
                                        <label for="exampleFormControlSelect1"><b>Issue Category:</b></label>
                                        <input class="form-control" id ="ic" list="icl" value = "Choose an option..." autocomplete="off">
                                        <datalist id="icl">
                                          <?php
                                              $qic = "select * from ic order by ic_value asc";
                                                    $queryic = mysqli_query($con, $qic);
                                                    while($roic = mysqli_fetch_array($queryic)){
                                          ?>
                                            <option value="<?php echo $roic['ic_value']; ?>"><?php echo $roic['ic_value']; ?></option>
                                    <?php
                                    }
                                    ?>
                                        </datalist>
                                </div>
                                <div class="form-group">
                                        <label for="exampleFormControlSelect1"><b>Sub Category:</b></label>
                                        <input class="form-control" id ="sc" list="scl" value = "Choose an option..." autocomplete="off">
                                        <datalist id="scl">
                                        </datalist>
                                </div>
                                <div class="custom-control custom-switch">
                                  <input type="checkbox" class="custom-control-input" id="customSwitch1">
                                  <label class="custom-control-label" for="customSwitch1">SEG Escalated</label>
                                </div>
                                <div class="form-group">
                                  <label for="exampleFormControlSelect1"></label>
                                  <input class="form-control" id ="seg" list="segl" value = "N/A" autocomplete="off">
                                    <datalist id="segl">
                                      <option value="N/A">N/A</option>
                                    <?php
                                              $qseg = "select * from seg";
                                                    $queryseg = mysqli_query($con, $qseg);
                                                    while($roseg = mysqli_fetch_array($queryseg)){
                                          ?>
                                            <option value="<?php echo $roseg['seg_value']; ?>"><?php echo $roseg['seg_value']; ?></option>
                                    <?php
                                    }
                                    ?>
                                  </datalist>
                                </div>
                                <div class="form-group">
                                        <h2>Other Details</h2>
                                        <textarea class="form-control" rows="4" placeholder="Comments" id = "txtarea"></textarea>
                                </div>
                        </form>
                </div>

            </div>
                <div class="container" id="div2">
                    <button type="button" class="btn btn-success btn-lg btn-block" id = "submit">Create Output</button>
                    <br>
                    <div class="form-group">
                            <textarea class="form-control text-center" rows="5" placeholder="Output" id = "outputs" readonly></textarea>
                    </div>
                </div>
        </div>

        <!-- Modal -->
<div id="AddChoice" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Administrator Password to Add Choices:</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="processpw.php" method = "post" id = "reply">
      <div class="modal-body">
        <input type = "password" class="form-control" name = "PasswordProtectAC" placeholder = "Password"/>
      </div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-success" value = "Submit" />
      </form>
      </div>
    </div>

  </div>
</div>

<!-- Modal -->
<div id="RemoveChoice" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Administrator Password to Remove Choices:</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <form action="processpw.php" method = "post" id = "reply">
      <div class="modal-body">
        <input type = "password" class="form-control" name = "PasswordProtectRC" placeholder = "Password"/>
      </div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-success" value = "Submit" />
      </form>
      </div>
    </div>

  </div>
</div>
        

</body>
</html>

<?php
unset($_SESSION['output']);
session_destroy();
?>