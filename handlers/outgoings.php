<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$outgoings = [];

# Origination from an office

$filter = "WHERE tracks.id = (SELECT MAX(tracks.id) FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id WHERE tracks.document_id = documents.id)";
$filter .= " AND documents.origin = ".$_SESSION['office'];

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, documents.document_date, tracks.document_status, tracks.document_status_user, tracks.document_tracks_status, tracks.track_office, tracks.track_date, tracks.track_option, tracks.route_office, tracks.route_user, tracks.remarks, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter} ORDER BY tracks.track_date DESC LIMIT 1";
$originating = $con->getData($sql);

foreach ($originating as $i => $o) {

	$status = $o['document_status'];

	if ($o['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$o['track_option']);
		$status = $track_option[0]['choice'];
	};		
	
	if ( ($o['document_status'] == "Received") && ($o['document_tracks_status'] == "transaction") ) {
		$document_status_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$o['document_status_user']);
		$status .= " by ".$document_status_user[0]['fullname'];
	};		
	
	if ($o['document_tracks_status'] == "for_pick_up") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$o['track_office']);		
		$status .= " and for pick up from ".$track_office[0]['office'];
	};	

	if ($o['document_tracks_status'] == "incoming") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$o['track_office']);		
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$o['route_user']);		
		$status = "Picked up from ".$track_office[0]['office']." by ".$route_user[0]['fullname'];
	};
	
	$originating[$i]['document_status'] = $status;	
	$originating[$i]['track_date'] = date("F j, Y h:i A",strtotime($o['track_date']));
	$originating[$i]['document_date'] = date("F j, Y",strtotime($o['document_date']));
	
	$outgoings[] = $originating[$i];
	
};

# Has transactions in an office

$filter = "WHERE tracks.id = (SELECT MAX(tracks.id) FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id WHERE tracks.document_id = documents.id)";
$filter .= " AND tracks.track_office = ".$_SESSION['office']." AND document_tracks_status = 'for_pick_up'";

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, documents.document_date, tracks.document_status, tracks.document_status_user, tracks.document_tracks_status, tracks.track_office, tracks.track_date, tracks.track_option, tracks.route_office, tracks.route_user, tracks.remarks, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter} ORDER BY tracks.track_date DESC LIMIT 1";
$transactions = $con->getData($sql);

foreach ($transactions as $i => $t) {

	$status = $t['document_status'];

	if ($t['track_option'] != NULL) {
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$t['track_option']);
		$status = $track_option[0]['choice'];
	};		
	
	if ( ($t['document_status'] == "Received") && ($t['document_tracks_status'] == "transaction") ) {
		$document_status_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$t['document_status_user']);
		$status .= " by ".$document_status_user[0]['fullname'];
	};		
	
	if ($t['document_tracks_status'] == "for_pick_up") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$t['track_office']);		
		$status .= " and for pick up from ".$track_office[0]['office'];
	};	

	if ($t['document_tracks_status'] == "incoming") {
		$track_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$t['track_office']);		
		$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$t['route_user']);		
		$status = "Picked up from ".$track_office[0]['office']." by ".$route_user[0]['fullname'];
	};
	
	$transactions[$i]['document_status'] = $status;	
	$transactions[$i]['track_date'] = date("F j, Y h:i A",strtotime($t['track_date']));
	$transactions[$i]['document_date'] = date("F j, Y",strtotime($t['document_date']));
	
	$outgoings[] = $transactions[$i];
	
};

echo json_encode($outgoings);

?>