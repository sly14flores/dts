<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$filter = "WHERE tracks.route_office = ".$_SESSION['office']." AND document_tracks_status = 'for_pick_up' OR document_tracks_status = 'incoming'";

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, tracks.document_status, tracks.document_status_user, tracks.document_tracks_status, tracks.track_office, tracks.route_user, tracks.track_date, tracks.remarks, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter}ORDER BY tracks.track_date DESC LIMIT 1";
$incomings = $con->getData($sql);

foreach ($incomings as $i => $incoming) {

	if ($incoming['document_tracks_status'] == "for_pick_up") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$incoming['track_office']);		
		$incomings[$i]['document_status'] = "For pick up from ".$track_office[0]['office'];
	};	

	if ($incoming['document_tracks_status'] == "incoming") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$incoming['track_office']);		
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$incoming['route_user']);		
		$incomings[$i]['document_status'] = "Picked up from ".$track_office[0]['office']." by ".$route_user[0]['fullname'];
	};	

	$incomings[$i]['track_date'] = date("F j, Y",strtotime($incoming['track_date']));

};

echo json_encode($incomings);

?>