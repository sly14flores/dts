<?php

require_once '../db.php';

$con = new pdo_db("offices");

$offices = $con->all(['id','office','shortname']);

echo json_encode($offices);

?>