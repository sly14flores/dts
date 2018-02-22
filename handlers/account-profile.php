<?php

require_once '../db.php';

session_start();

$con = new pdo_db("users");

$user = $con->get(["id"=>$_SESSION['id']],["employee_id","CONCAT(fname, ' ', lname) user"]);

$dir = "pictures/";
$avatar = $dir."avatar.png";

$picture = $dir.$user[0]['employee_id'].".jpg";
if (!file_exists("../".$picture)) $picture = $avatar;

$profile = array(
	"user"=>$user[0]['user'],
	"picture"=>$picture
);

echo json_encode($profile);

?>