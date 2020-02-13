<?php

session_start();
error_reporting(0);

include('connect.php');

$opt = mysqli_real_escape_string($con, nl2br($_POST['opt'])); 
$icl = mysqli_real_escape_string($con, nl2br($_POST['icl']));
$strvalue = $_POST['delete'];

if ($opt == "dsc"){
	foreach ($strvalue as $str){
	$postdsc = "DELETE FROM dsc WHERE dsc_value='$str'";
	mysqli_query($con, $postdsc);
	}

	//Rearrange counting for dsc table
	$dscq = "SELECT * FROM dsc";
	$dscq2 = mysqli_query($con, $dscq);
	$dscq4 = 1;
	while ($dscq3 = mysqli_fetch_array($dscq2)){
	$dscq5 = $dscq3['dsc_id'];
	$alterdsc ="UPDATE dsc SET dsc_id = $dscq4 WHERE dsc_id = $dscq5";
	mysqli_query($con, $alterdsc);
	$dscq4++;
	}
}

if ($opt == "prbm"){

	foreach ($strvalue as $str){
	$postprbm = "DELETE FROM prbm WHERE prbm_value='$str'";
	mysqli_query($con, $postprbm);
	}

	//Rearrange counting for prbm table
	$prbmq = "SELECT * FROM prbm";
	$prbmq2 = mysqli_query($con, $prbmq);
	$prbmq4 = 1;
	while ($prbmq3 = mysqli_fetch_array($prbmq2)){
	$prbmq5 = $prbmq3['prbm_id'];
	$alterprbm ="UPDATE prbm SET prbm_id = $prbmq4 WHERE prbm_id = $prbmq5";
	mysqli_query($con, $alterprbm);
	$prbmq4++;
	}
}


if ($opt == "os"){

	//Reset autoincrement for os table
	$osq = "SELECT MAX(os_id) AS min FROM os";
	$osq2 = mysqli_query($con, $osq);
	$osq3 = mysqli_fetch_array($osq2);
	$osq4 = $osq3['min'];
	$osq4++;
	$alteros ="ALTER TABLE os AUTO_INCREMENT = $osq4";
	mysqli_query($con, $alteros);

	foreach ($strvalue as $str){
	$postos = "DELETE FROM os WHERE os_value='$str'";
	mysqli_query($con, $postos);
	}
}

if ($opt == "dsm"){

	//Reset autoincrement for dsm table
	$dsmq = "SELECT MAX(dsm_id) AS min FROM dsm";
	$dsmq2 = mysqli_query($con, $dsmq);
	$dsmq3 = mysqli_fetch_array($dsmq2);
	$dsmq4 = $dsmq3['min'];
	$dsmq4++;
	$alterdsm ="ALTER TABLE dsm AUTO_INCREMENT = $dsmq4";
	mysqli_query($con, $alterdsm);

	foreach ($strvalue as $str){
	$postdsm = "DELETE FROM dsm WHERE dsm_value='$str'";
	mysqli_query($con, $postdsm);
	}
}

if ($opt == "dsa"){

	//Reset autoincrement for dsa table
	$dsaq = "SELECT MAX(dsa_id) AS min FROM dsa";
	$dsaq2 = mysqli_query($con, $dsaq);
	$dsaq3 = mysqli_fetch_array($dsaq2);
	$dsaq4 = $dsaq3['min'];
	$dsaq4++;
	$alterdsa ="ALTER TABLE dsa AUTO_INCREMENT = $dsaq4";
	mysqli_query($con, $alterdsa);

	foreach ($strvalue as $str){
	$postdsa = "DELETE FROM dsa WHERE dsa_value='$str'";
	mysqli_query($con, $postdsa);
	}
}

if ($opt == "ic"){

	//Reset autoincrement for ic table
	$icq = "SELECT MAX(ic_id) AS min FROM ic";
	$icq2 = mysqli_query($con, $icq);
	$icq3 = mysqli_fetch_array($icq2);
	$icq4 = $icq3['min'];
	$icq4++;
	$alteric ="ALTER TABLE ic AUTO_INCREMENT = $icq4";
	mysqli_query($con, $alteric);

	foreach ($strvalue as $str){
	$postic = "DELETE FROM ic WHERE ic_value='$str'";
	mysqli_query($con, $postic);
	}
}

if ($opt == "sc"){

	//Reset autoincrement for sc table
	$scq = "SELECT MAX(sc_id) AS min FROM sc";
	$scq2 = mysqli_query($con, $scq);
	$scq3 = mysqli_fetch_array($scq2);
	$scq4 = $scq3['min'];
	$scq4++;
	$altersc ="ALTER TABLE sc AUTO_INCREMENT = $scq4";
	mysqli_query($con, $altersc);

	foreach ($strvalue as $str){
	$postscc = "DELETE FROM sc WHERE sc_value='$str' AND sc_ic_value='$icl'";
	mysqli_query($con, $postscc);
	}
}

if ($opt == "seg"){

	//Reset autoincrement for seg table
	$segq = "SELECT MAX(seg_id) AS min FROM seg";
	$segq2 = mysqli_query($con, $segq);
	$segq3 = mysqli_fetch_array($segq2);
	$segq4 = $segq3['min'];
	$segq4++;
	$alterseg ="ALTER TABLE seg AUTO_INCREMENT = $segq4";
	mysqli_query($con, $alterseg);

	foreach ($strvalue as $str){
	$postseg = "DELETE FROM seg WHERE seg_value='$str'";
	mysqli_query($con, $postseg);
	}
}

if ($opt == "issk"){

	//Reset autoincrement for seg table
	$isskq = "SELECT MAX(issK_id) AS min FROM issk";
	$isskq2 = mysqli_query($con, $isskq);
	$isskq3 = mysqli_fetch_array($isskq2);
	$isskq4 = $isskq3['min'];
	$isskq4++;
	$alterissk ="ALTER TABLE issk AUTO_INCREMENT = $isskq4";
	mysqli_query($con, $alterissk);

	foreach ($strvalue as $str){
	$postissk = "DELETE FROM issk WHERE issK_value='$str'";
	mysqli_query($con, $postissk);
	}
}

header('location:removeentry.php');



?>