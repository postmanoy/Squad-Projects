<?php
$con = mysqli_connect('192.168.1.5','phdsaas', 'N0virus1!');

// Check connection
if (mysqli_connect_errno()) {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  exit();
}

mysqli_select_db($con,'casetag');
?>