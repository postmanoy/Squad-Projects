<?php
session_start();
error_reporting(0);
if(!isset($_SERVER['HTTP_REFERER'])){
    // redirect them to your desired location
    header('location:../DSaaSExam/index.php');
    exit;
}

include('connect.php');

$querymax = "SELECT MAX(q_id) AS maximum FROM questions";
$query = mysqli_query($con, $querymax);
$row = mysqli_fetch_array($query);
$maxvalue = $row['maximum'];
for($i=1 ; $i <= $maxvalue ; $i++){
$updatequery = "UPDATE questions SET fin = 0 WHERE q_id = $i";
mysqli_query($con, $updatequery);
}


   ?>
<!DOCTYPE html>
<html>
   <head>
    <link rel="shortcut icon" type="image/png" href="PHDSAAS.png"/>
      <title>Thank You</title>
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
    body{
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
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
     <div class="container text-center" >
     	<br><br>
    	<h1 class="text-center text-success text-uppercase animateuse" > Trend Micro DSaaS Exam</h1>
    	<br><br><br><br>
      <table class="table text-center table-bordered table-hover">
      	<tr>
      		<th colspan="2" class="bg-dark"> <h1 class="text-white"> Results </h1></th>
      		
      	</tr>
      	<tr>
		      	<td>
		      		Questions Attempted
		      	</td>

	       <?php
         $counter = 0;
         $Resultans = 0;
            if(isset($_POST['submit'])){
              if(!empty($_POST['quizcheck'])) {

                $count = count($_POST['quizcheck']);
                ?>
              <td>
                <?php
                echo "Out of 65, you have provided ".$count. " answers";
                ?>
              </td>
                <?php
                $essayid=array();
                $essayqq=array();
                $essayans=array();
                $result = 0;
                $netscore = 0;
                $winscore = 0;
                $linscore = 0;
                $cloudscore = 0;
                $virscore = 0;
                $devscore = 0;
                $dbscore = 0;
                $otscore = 0;

                $qmax = "SELECT MAX(q_id) AS mq FROM questions";
                $q = mysqli_query($con, $qmax);
                $re = mysqli_fetch_array($q);
                $mxq = $re['mq'];

                $selected = $_POST['quizcheck'];
                $selectedcat = $_POST['quizcheckcat'];
                $selectedqid = $_POST['quizcheckid'];
                for($i=1; $i <= $mxq ; $i++){
                $q = "select * from questions";
                $query = mysqli_query($con, $q);

                while ($rows = mysqli_fetch_array($query)){

                  $checked = $rows['ans'] == $selected[$i];
                  if($checked){
                    $result++;

                  if($selectedcat[$i] == "1"){

                    $netscore++;
                  }
                  else if ($selectedcat[$i] == "2"){
                    
                    $winscore++;
                  }
                  else if ($selectedcat[$i] == "3"){
                    
                    $linscore++;
                  }
                  else if ($selectedcat[$i] == "4"){
                    
                    $cloudscore++;
                  }
                  else if ($selectedcat[$i] == "5"){
                    
                    $virscore++;
                  
                  }
                  else if ($selectedcat[$i] == "6"){
                    
                    $devscore++;
                  }
                  else if ($selectedcat[$i] == "7"){
                    
                    $dbscore++;
                  }
                  else if ($selectedcat[$i] == "8"){
                    
                    $otscore++;
                  }
                }
              }

              if ($selectedcat[$i] == "9"){
                    $finalans = mysqli_real_escape_string($con, nl2br($selected[$i]));
                    $finalqid = $selectedqid[$i];
                    array_push($essayans, $finalans);
                    array_push($essayid, $finalqid);
                  }
               //printf($selected[$i]);
            }
                ?>
                <?php
            }
          }
          ?>
            <?php




date_default_timezone_set('Singapore');
$date = date('m/d/Y h:i:s a', time());


$querymax = "SELECT MAX(u_id) AS maximum FROM usersession";
$query = mysqli_query($con, $querymax);
$row = mysqli_fetch_array($query);
$maxvalue = $row['maximum'];
$maxvalue++;
$alterquery ="ALTER TABLE usersession AUTO_INCREMENT = $maxvalue";
mysqli_query($con, $alterquery);
            
$name = $_SESSION['username'];
$passw = $_SESSION['password'];
$finalresult = "INSERT INTO usersession(u_id,name,u_q_id, u_a_id, net_sc, win_sc, lin_sc, clo_sc, vir_sc, dev_sc, db_sc, ot_sc, ess_sc , date, essay_sc1, essay_sc2, essay_sc3, essay_sc4, essay_sc5, q_essay_id1, q_essay_id2, q_essay_id3, q_essay_id4, q_essay_id5) values ('$maxvalue','$name','60','$result','$netscore','$winscore','$linscore','$cloudscore','$virscore','$devscore','$dbscore','$otscore', 0, '$date', '$essayans[0]', '$essayans[1]', '$essayans[2]', '$essayans[3]', '$essayans[4]', '$essayid[0]', '$essayid[1]', '$essayid[2]', '$essayid[3]', '$essayid[4]')";
//$deletepw = "DELETE FROM passwordtest WHERE password = '$passw'" ;
$queryresult= mysqli_query($con,$finalresult);
//$dpw= mysqli_query($con,$deletepw);

if(!$queryresult){
  echo("Error description: " . mysqli_error($con));
}
?>


      </table>

      	<a href="logout.php" class="btn btn-success"> FINISH </a>
         <footer>
            <h5 class="text-center"> &copy2019 PostManoy.</h5> 
         </footer>
      </div>
   </body>
</html>