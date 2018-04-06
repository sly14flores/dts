<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

$con = new pdo_db("documents");

$tracks = $con->getData("SELECT tracks.id, tracks.document_status, tracks.track_office, tracks.document_status_user, tracks.track_option, tracks.track_date FROM tracks LEFT JOIN documents ON tracks.document_id = documents.id WHERE documents.id = ".$_POST['id']." ORDER BY track_date DESC");

$status_arr = array(
	"Routed"=>"to"
);

foreach ($tracks as $i => $track) {

	$user = $con->getData("SELECT CONCAT(users.fname, ' ', users.lname) user FROM users WHERE users.id = ".$track['document_status_user']);
	$office = $con->getData("SELECT offices.office FROM offices WHERE offices.id = ".$track['track_office']);
	
	$prepo = (isset($status_arr[$track['document_status']]))?$status_arr[$track['document_status']]:"at";
	
	if ($track['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$track['track_option']);
		$track['document_status'] = $track_option[0]['choice'];
	};		
	
	$tracks[$i]['track_date_f'] = date("(D) F j, Y",strtotime($track['track_date']));
	$tracks[$i]['track_time_f'] = date("h:i A",strtotime($track['track_date']));
	$tracks[$i]['status'] = $track['document_status']." $prepo ".$office[0]['office']." by ".$user[0]['user']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];

};

echo json_encode($tracks);

?>