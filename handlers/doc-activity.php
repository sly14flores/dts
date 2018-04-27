<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db();

$tracks = $con->getData("SELECT id, track_date, document_status, document_tracks_status, document_status_user, track_option, IFNULL(track_office,0) track_office, IFNULL(route_office,0) route_office, route_user, (SELECT CONCAT(users.fname, ' ', users.lname) FROM users WHERE users.id = tracks.document_status_user) staff FROM tracks WHERE document_id = ".$_POST['id']." ORDER BY tracks.track_date DESC");

foreach ($tracks as $i => $track) {

	$status = $track['document_status'];

	$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$track['track_office']);
	$route_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$track['route_office']);	

	$track_office_name = (count($track_office))?$track_office[0]['office']:"";
	$route_office_name = (count($route_office))?$route_office[0]['office']:"";

	$office = $track_office_name;

	if ($track['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$track['track_option']);
		$document_status_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$track['document_status_user']);
		$status = $track_option[0]['choice'];
		$status .= " by ".$document_status_user[0]['fullname'];		
	};

	if ( ($track['document_status'] == "Received") && ($track['document_tracks_status'] == "transaction") ) {
		$document_status_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$track['document_status_user']);
		$status .= " by ".$document_status_user[0]['fullname'];
		$office = $track_office_name;
	};		

	if ($track['document_tracks_status'] == "for_pick_up") {
		$status .= " and for pick up for ".$route_office[0]['office'];
		$office = $route_office_name;		
	};

	if ($track['document_tracks_status'] == "incoming") {
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$track['route_user']);		
		$status = "Picked up by ".$route_user[0]['fullname'];
	};

	if ($track['document_tracks_status'] == "filed") {
		$document_status_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$track['document_status_user']);
		$status = "Filed by ".$document_status_user[0]['fullname'];
	};	

	$tracks[$i]['date'] = date("F j, Y",strtotime($track['track_date']));
	$tracks[$i]['time'] = date("h:i:s A",strtotime($track['track_date']));

	$tracks[$i]['document_status'] = $status;
	$tracks[$i]['office'] = $office;

};

$files = $con->getData("SELECT id, file_name FROM files WHERE document_id = ".$_POST['id']);

foreach ($files as $i => $file) {
	
	$ft = explode(".",$file['file_name']);
	
	$files[$i]['type'] = $ft[1];
	$files[$i]['path'] = "../files/".$file['file_name'];
	
};

$attachments = $con->getData("SELECT id, file_name FROM attachments WHERE document_id = ".$_POST['id']);

foreach ($attachments as $i => $attachment) {
	
	$ft = explode(".",$attachment['file_name']);
	
	$attachments[$i]['type'] = $ft[1];
	$attachments[$i]['path'] = "../attachments/".$attachment['file_name'];
	
};

echo json_encode(array("tracks"=>$tracks,"files"=>$files,"attachments"=>$attachments));

?>