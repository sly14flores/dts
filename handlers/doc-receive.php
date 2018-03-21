<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$track = array(
	"document_id"=>$_POST['id'],
	"system_document_status"=>"transaction",
	"track_office"=>$_POST['track_office'],
	"track_office_next"=>$_POST['track_office'],
	"document_activity"=>"Received",
	"document_activity_user"=>$_SESSION['id'],
	"document_activity_date"=>"CURRENT_TIMESTAMP"
);

$con->insertData($track);

?>