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
	<title>View Q & A - DSaaS Exam</title>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <link rel="stylesheet" type="text/css" href="style.css">
	 <link href="https://fonts.googleapis.com/css?family=Montserrat|Open+Sans" rel="stylesheet">
<!-- 
	 font-family: 'Montserrat', sans-serif; 
	font-family: 'Open Sans', sans-serif;
	-->

<style>
  li{
padding: 10px;
background-color: black;
list-style-position:inside;
border: 2px solid grey;
color:white;

}

li a:hover{
color:#332419;

}

li:hover{
background-color:#ead6b7;
}

body {
  counter-reset: tdCounter;
}

.count::before {
  counter-increment: tdCounter;
  content: counter(tdCounter) '' ".)";
  font-weight:bold;

.count2::after {
  content: counter(tdCounter);
  font-weight:bold;

}
</style>

<script>


$(document).ready(function()
{ 
       $(document).bind("contextmenu",function(e){
              return false;
       }); 
})

function openCity(evt, cityName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOp").click();




function getPagination(table) {

  $('#maxRows').on('change', function(e) {
    $('.pagination').html(''); // reset pagination
    var trnum = 0; // reset tr counter
    var maxRows = parseInt($(this).val()); // get Max Rows from select option
    var totalRows = $(table + ' tbody tr').length; // numbers of rows
    $(table + ' tr:gt(0)').each(function() { // each TR in  table and not the header
      trnum++; // Start Counter
      if (trnum > maxRows) { // if tr number gt maxRows

        $(this).hide(); // fade it out
      }
      if (trnum <= maxRows) {
        $(this).show();
      } // else fade in Important in case if it ..
    }); //  was fade out to fade it in
    if (totalRows > maxRows) { // if tr total rows gt max rows option
      var pagenum = Math.ceil(totalRows / maxRows); // ceil total(rows/maxrows) to get ..
      //  numbers of pages
      for (var i = 1; i <= pagenum;) { // for each page append pagination li
        $('.pagination').append('<li class="wp" data-page="' + i + '">\
<span>' + i++ + '<span class="sr-only">(current)</span></span>\
</li>').show();
      } // end for i
    } // end if row count > max rows
    $('.pagination li:first-child').addClass('active'); // add active class to the first li
    $('.pagination li').on('click', function() { // on click each page
      var pageNum = $(this).attr('data-page'); // get it's number
      var trIndex = 0; // reset tr counter
      $('.pagination li').removeClass('active'); // remove active class from all li
      $(this).addClass('active'); // add active class to the clicked
      $(table + ' tr:gt(0)').each(function() { // each tr in table not the header
        trIndex++; // tr index counter
        // if tr index gt maxRows*pageNum or lt maxRows*pageNum-maxRows fade if out
        if (trIndex > (maxRows * pageNum) || trIndex <= ((maxRows * pageNum) - maxRows)) {
          $(this).hide();
        } else {
          $(this).show();
        } //else fade in
      }); // end of for each tr in table
    }); // end of on click pagination list


  });

  // end of on select change



  // END OF PAGINATION
}

  </script>
</head>
<body onload="document.getElementById('1q').click();">
  <h1 class="text-center text-white font-weight-bold text-uppercase bg-dark" >  Trend Micro Deep Security As A Service Exam </h1><br>
         <div class="container">
          <div class="card text-center bg-dark text-white text-uppercase">
    <h3>Question and Answer</h3>
  </div>
          <div class="tab">
            <?php
            $q1 = "select MIN(cat_id) As cat_id from questions GROUP BY cat_id";
              $query1 = mysqli_query($con, $q1);
      while($value1 = mysqli_fetch_array($query1)){
        if($value1['cat_id'] == 1){
            $name1 = "Networking";
        }
        else if($value1['cat_id'] == 2){
            $name1 = "Windows";
        }
        else if($value1['cat_id'] == 3){
            $name1 = "Linux";
        }
        else if($value1['cat_id'] == 4){
            $name1 = "Cloud";
        }
        else if($value1['cat_id'] == 5){
            $name1 = "Virtualization";
        }
        else if($value1['cat_id'] == 6){
            $name1 = "DevOps";
        }
        else if($value1['cat_id'] == 7){
            $name1 = "Database";
        }
        else if($value1['cat_id'] == 8){
            $name1 = "Other";
        }
        else if($value1['cat_id'] == 9){
            $name1 = "Essay";
        }
        else{
           break;
        }
            ?>
  <button class="tablinks" onclick="openCity(event, <?php echo $value1['cat_id']; ?>)" id = "<?php echo $value1['cat_id']."q"; ?>"><?php echo $name1; ?></button>
  <?php
  }
  ?>
</div>
<!-- Tab content -->
<?php
      $q2 = "select MIN(cat_id) As cid, COUNT(q_id) As lid from questions GROUP BY cat_id";
      $query2 = mysqli_query($con, $q2);
      while($value2 = mysqli_fetch_array($query2)){
?>
<div id="<?php echo $value2['cid']; ?>" class="tabcontent">
  <div class="row">
        <div class="input col-md-1 col-xs-2">
            <!--    Show Numbers Of Rows    -->
            <select class="form-control" name="state" id="maxRows" hidden>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
    </div>
     <table class="table table-striped table-hover table-condensed table-bordered fixed" id="Tabla">
       <thead>
                <tr class="info">
                  <td colspan = "2"><h4 align = "center">Total Number of Questions: <?php echo $value2['lid']; ?></h4></td>
                </tr>
                <tr class="info">
                  <?php
                    if ($value2['cid'] == 9){
                      ?>
                      <td><h4 align = "center">Question</h4></td>
                      <?php
                    }
                    else{
                    ?>
                    <td><h4 align = "center">Question</h4></td>
                    <td><h4 align = "center">Correct Answer</h4></td>
                  <?php } ?>
                </tr>
                 </thead>
                <tbody id="TablaFamilias">
  <?php
  $val = $value2['cid'];
  $q3 = "select * from questions WHERE cat_id = $val";
      $query3 = mysqli_query($con, $q3);
      while($value3 = mysqli_fetch_array($query3)){
        $qans = $value3['ans'];
        $qq = $value3['q_id'];
        ?>
        <tr>
            <?php
            if ($value2['cid'] != 9){
            ?>
              <td rowspan = "4" class = "count">
                <?php echo $value3['question'];?>
              </td>
        <?php
      }
      else{
        ?>
              <td class = "count">
                <?php echo $value3['question'];?>
              </td>
        <?php
      }
         $q4 = "select * from answers WHERE ans_id = $qq";
          $query4 = mysqli_query($con, $q4);
          while($value4 = mysqli_fetch_array($query4)){
            if ($value2['cid'] != 9){
        ?>
              <td width = '50%'>
                  <?php
                  $q5 = "select * from answers WHERE a_id = $qans";
                  $query5 = mysqli_query($con, $q5);
                  if($value5 = mysqli_fetch_array($query5)){  
                    if($value4['ans'] == $value5['ans']){
                      ?>
                        <b><?php echo $value5['ans']; ?><b><br>
                      <?php
                  }
                    else{
                      ?>
                        <?php echo $value4['ans']; ?><br>
                      <?php
                    }
                  ?>
                </td>
            </tr>
        <?php
          }
        }
      }
    }
  ?>
</tbody>
</table>
</div>
<?php
}
?>

    <hr>
<a href="landing.php" class="btn btn-primary btn-success d-block m-auto text-white" > Back </a> 


	 <footer>
            <h5 class="text-center"> &copy2019 PostManoy.</h5> 
         </footer>
	</div>
</div>
</body>
</html>