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
<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

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
  
</style>

<script>
  $(document).ready(function()
{ 
       $(document).bind("contextmenu",function(e){
              return false;
       }); 
})
  </script>

  <script type = "text/javascript">
    $(document).ready(function () {
  getPagination('#Tabla');
  $('#maxRows option:last').prop('selected', true).trigger('change');
});

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
   <body>
    <h1 class="text-center text-white font-weight-bold text-uppercase bg-dark" >  Trend Micro Deep Security As A Service Exam </h1><br>
     <div class="container">

    <div class="row">
      
      <div class="col-lg-12 text-center">
        <div class="card">
          <h4 class="card-header text-center"> Search Name </h4>
          <br>
          <form action="resultspername.php" method="post">
            <div class="form-group">
              <label for="user "> Enter Full Name: </label>
              <input type="text" name="userName" id="userName" class="form-control text-center" required>
              <label for="user "> Enter Date and Time: </label>
              <input type="text" name="userDate" id="userDate" class="form-control text-center" required>
            </div>

            <button class="btn btn-success d-block m-auto" style = "width:100%;" type="submit"> Submit </button>
            <br>
            <a href="result.php" class="btn btn-primary btn-info d-block m-auto text-white" > Show All Results </a>
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
  <br>
  <div class="text-center">
    <div class="container-fluid">
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
                    <td colspan = "2"><h4> List of Names with Date </h4></td>
                </tr>
                 </thead>
                <tbody id="TablaFamilias">
    <?php
      $resultquery = "SELECT * FROM usersession";
      $queryr = mysqli_query($con, $resultquery);
      while ($value = mysqli_fetch_array($queryr)){
    ?>
                <tr>
                    <td width = 50%><?php echo $value['name']; ?></td>
                     <td><?php echo $value['date']; ?></td>
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
  <div style="margin:0 auto;">
  <ul class="pagination"></ul>
</div>
  

    </body>
    </html>