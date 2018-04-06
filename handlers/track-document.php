<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

$con = new pdo_db("documents");

$tracks = $con->getData("SELECT tracks.id, tracks.document_status, tracks.track_office, tracks.document_status_user, tracks.track_option, tracks.document_tracks_status, tracks.track_date, tracks.route_office, tracks.route_user, tracks.track_option FROM tracks LEFT JOIN documents ON tracks.document_id = documents.id WHERE documents.id = ".$_POST['id']." ORDER BY track_date DESC");

$status_arr = array(
	"Routed"=>"to"
);

foreach ($tracks as $i => $track) {

	$document_status = $track['document_status'];

	$user = $con->getData("SELECT CONCAT(users.fname, ' ', users.lname) user FROM users WHERE users.id = ".$track['document_status_user']);
	$track_office = $con->getData("SELECT offices.office FROM offices WHERE offices.id = ".$track['track_office']);
	
	$prepo = (isset($status_arr[$document_status]))?$status_arr[$document_status]:"at";
	
	if ($track['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$track['track_option']);
		$document_status = $track_option[0]['choice'];
	};		

	$tracks[$i]['track_date_f'] = date("(D) F j, Y",strtotime($track['track_date']));
	$tracks[$i]['track_time_f'] = date("h:i A",strtotime($track['track_date']));

	$status = $document_status." $prepo ".$track_office[0]['office']." by ".$user[0]['user']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];

	if ($track['document_tracks_status'] == "for_pick_up") {
		$route_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$track['route_office']);		
		$status = $document_status." and for pick up for ".$route_office[0]['office']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];
	};

	if ($track['document_tracks_status'] == "incoming") {
		$route_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$track['route_office']);		
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$track['route_user']);		
		$status = "Picked up by ".$route_user[0]['fullname']." at ".$track_office[0]['office']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];
	};

	$tracks[$i]['status'] = $status;

};

echo json_encode($tracks);

?>