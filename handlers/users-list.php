<?php
$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

$con = new pdo_db("users");

$users = $con->getData("SELECT *, (SELECT offices.shortname FROM offices WHERE offices.id = users.div_id) div_id FROM `users` ORDER BY `users`.`employee_id` ASC");

echo json_encode($users);

?>