<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$documents = [];

# Track office
$filter = "WHERE tracks.id = (SELECT MAX(tracks.id) FROM tracks WHERE tracks.document_id = documents.id)";
$filter .= " AND tracks.track_office = ".$_SESSION['office']." AND document_tracks_status = 'transaction'";

$documents1 = $con->getData($sql);

foreach ($documents1 as $document) {
	
	$documents[] = $document;
	
};

foreach ($documents as $i => $document) {

	$status = $document['document_status'];

	if ($document['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$document['track_option']);
		$status = $track_option[0]['choice'];
	};

	if ( ($document['document_status'] == "Received") && ($document['document_tracks_status'] == "transaction") ) {
		$document_status_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$document['document_status_user']);
		$status .= " by ".$document_status_user[0]['fullname'];
	};	

	if ($document['document_tracks_status'] == "for_pick_up") {
		$route_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$document['route_office']);		
		$status .= " and for pick up for ".$route_office[0]['office'];
	};

	if ($document['document_tracks_status'] == "incoming") {
		$route_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$document['route_office']);		
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$document['route_user']);		
		$status = "Picked up by ".$route_user[0]['fullname'];
	};	

	$documents[$i]['document_status'] = $status;	
	$documents[$i]['track_date'] = date("F j, Y h:i A",strtotime($document['track_date']));
	$documents[$i]['document_date'] = date("F j, Y",strtotime($document['document_date']));

};

echo json_encode($documents);

?>