<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';
require_once '../assignments.php';
require_once 'notify.php';

$assignments = assignments;

session_start();

$con = new pdo_db("tracks");

$track_date = date("Y-m-d H:i:s");

$track = array(
	"document_id"=>$_POST['id'],
	"document_status"=>"Received", # document status
	"document_status_user"=>$_SESSION['id'],
	"document_tracks_status"=>"transaction", # tracks status
	"track_office"=>$_SESSION['office'],
	"track_date"=>$track_date
);

$con->insertData($track);

# notify

$notifications = [];

$liaisons = $con->getData("SELECT id FROM users WHERE div_id = ".$_SESSION['office']." AND group_id IN ".getAssignmentIds($assignments['group'],1,"group"));

$office = $con->getData("SELECT id, office FROM offices WHERE id = ".$_SESSION['office']);

$receive_by = $con->getData("SELECT CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$_SESSION['id']);

foreach ($liaisons as $liaison) {
	$notifications[] = array(
		"doc_id"=>$_POST['id'],
		"user_id"=>$liaison['id'],
		"notification_type"=>"incoming",
		"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> was received at ".$office[0]['office']."<br>by ".$receive_by[0]['fullname']."  on ".date("F j, Y h:i A",strtotime($track_date))
	);
};

if (count($notifications)) {
	notify($con,$notifications);	
};

?>