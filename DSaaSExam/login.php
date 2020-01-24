<?php
session_start();


include('connect.php');


	$username = $_POST['user'];
	$password = $_POST['pass'];

$q = " select * from admin where username = '$username' && password ='$password' ";
$result = mysqli_query($con,$q);
$row = mysqli_num_rows($result);

$p = " select * from passwordtest where password = '$password' ";
$r = mysqli_query($con,$p);
$ro = mysqli_num_rows($r);

if($row == 1){
	$_SESSION['username'] = $username;
	header('location:landing.php');	
}
else if($ro == 1){
	$querymax = "SELECT MAX(q_id) AS maximum FROM questions";
	$query = mysqli_query($con, $querymax);
	$row = mysqli_fetch_array($query);
	$maxvalue = $row['maximum'];
	for($i=1 ; $i <= $maxvalue ; $i++){
	$updatequery = "UPDATE questions SET fin = 0 WHERE q_id = $i";
	mysqli_query($con, $updatequery);
}
	$_SESSION['username'] = $username;
	$_SESSION['password'] = $password;
	$deletepw = "DELETE FROM passwordtest WHERE password = '$password'" ;
	$dpw= mysqli_query($con,$deletepw);
	header('location:exam.php');
}
else{
	$message = "Invalid Password. Try again.";
  	echo "<script type='text/javascript'>alert('$message');</script>";
	header( "refresh:0;url=index-draft.php" );
}

?>