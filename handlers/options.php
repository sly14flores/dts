<?php

require_once '../db.php';

$con = new pdo_db("options");

$options = $con->all(['id','choice','description']);

echo json_encode($options);

?>