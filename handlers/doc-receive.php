<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$track = array(
	"document_id"=>$_POST['id'],
	"document_status"=>"Received", # document status
	"document_status_user"=>$_SESSION['id'],
	"document_tracks_status"=>"received", # tracks status
	"track_office"=>$_SESSION['office'],
	"track_date"=>"CURRENT_TIMESTAMP"
);

$con->insertData($track);

?>