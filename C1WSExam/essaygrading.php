<?php
session_start();

include('connect.php');

$xname = $_POST['xname'];
$x1 = $_POST['x1'];
$x2 = $_POST['x2'];
$x3 = $_POST['x3'];
$x4 = $_POST['x4'];
$x5 = $_POST['x5'];

$xf = $x1 + $x2 + $x3 + $x4 + $x5;

$updatequery = "UPDATE usersession SET ess_sc = $xf WHERE name = '$xname'";
mysqli_query($con, $updatequery);

$_SESSION['userx'] = $xname;

header('location:resultspername.php?Messages=Essay Scores saved!' . urlencode($Messages));


?>