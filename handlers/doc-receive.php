<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';
require_once '../assignments.php';
require_once 'notify.php';

$assignments = assignments;

session_start();

$con = new pdo_db("tracks");

$track_date = date("Y-m-d H:i:s");

# notification
$notifications = [];

$liaisons = $con->getData("SELECT id FROM users WHERE div_id = ".$_SESSION['office']." AND group_id IN ".getAssignmentIds($assignments['group'],1,"group"));
$office = $con->getData("SELECT id, office FROM offices WHERE id = ".$_SESSION['office']);
$receive_by = $con->getData("SELECT CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$_SESSION['id']);
#

# preceding_track
$preceding_track = 0;
if (count($_POST['tracks'])) $preceding_track = $_POST['tracks'][0]['id'];

switch ($_POST['next']['opt']) {

	case "transaction":

		$document_status = "Received";
		$document_tracks_status = "transaction";

		$track = array(
			"document_id"=>$_POST['id'],
			"document_status"=>$document_status, # document status
			"document_status_user"=>$_SESSION['id'],
			"document_tracks_status"=>$document_tracks_status, # tracks status
			"track_office"=>$_SESSION['office'],
			"track_date"=>$track_date,
			"preceding_track"=>$preceding_track
		);

		$con->insertData($track);
		$track_id = $con->insertId;

	break;

	case "filed":

		$document_status = "Received";
		$document_tracks_status = "transaction";

		$track = array(
			"document_id"=>$_POST['id'],
			"document_status"=>$document_status, # document status
			"document_status_user"=>$_SESSION['id'],
			"document_tracks_status"=>$document_tracks_status, # tracks status
			"track_office"=>$_SESSION['office'],
			"track_date"=>$track_date,
			"preceding_track"=>$preceding_track
		);	

		$con->insertData($track);
		$track_id = $con->insertId;		

		$document_status = "Filed";
		$document_tracks_status = "filed";

		$track = array(
			"document_id"=>$_POST['id'],
			"document_status"=>$document_status, # document status
			"document_status_user"=>$_SESSION['id'],
			"document_tracks_status"=>$document_tracks_status, # tracks status
			"track_office"=>$_SESSION['office'],
			"track_date"=>$track_date,
			"preceding_track"=>$preceding_track
		);

		$con->insertData($track);
		$track_id = $con->insertId;		

	break;

};



/* # notify
foreach ($liaisons as $liaison) {
	$notifications[] = array(
		"doc_id"=>$_POST['id'],
		"user_id"=>$liaison['id'],
		"track_id"=>intval($track_id),
		"notification_type"=>"incoming",
		"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> was received at ".$office[0]['office']."<br>by ".$receive_by[0]['fullname']."  on ".date("F j, Y h:i A",strtotime($track_date))
	);
};

if (count($notifications)) {
	notify($con,$notifications);	
}; */

?>