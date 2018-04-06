<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$filter = "WHERE documents.origin = ".$_SESSION['office'];

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, tracks.document_status, tracks.document_status_user, tracks.document_tracks_status, tracks.track_office, tracks.track_date, tracks.track_option, tracks.route_office, tracks.route_user, tracks.remarks, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter} ORDER BY tracks.track_date DESC LIMIT 1";
$outgoings = $con->getData($sql);

foreach ($outgoings as $i => $outgoing) {

	if ($outgoing['document_tracks_status'] == "for_pick_up") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$outgoing['track_office']);		
		$outgoings[$i]['document_status'] = "For pick up from ".$track_office[0]['office'];
	};	

	if ($outgoing['document_tracks_status'] == "incoming") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$outgoing['track_office']);		
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$outgoing['route_user']);		
		$outgoings[$i]['document_status'] = "Picked up from ".$track_office[0]['office']." by ".$route_user[0]['fullname'];
	};

	if ($outgoing['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$outgoing['track_option']);
		$outgoings[$i]['document_status'] = $track_option[0]['choice'];
	};	
	
	$outgoings[$i]['track_date'] = date("F j, Y",strtotime($outgoing['track_date']));

};

echo json_encode($outgoings);

?>