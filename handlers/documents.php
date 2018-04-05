<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$filter = "WHERE tracks.track_office = ".$_SESSION['office']." AND document_tracks_status = 'transaction'";

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, tracks.document_status, tracks.document_status_user, tracks.document_tracks_status, tracks.track_office, tracks.track_date, tracks.remarks, tracks.track_option, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter}ORDER BY tracks.track_date DESC LIMIT 1";
$documents = $con->getData($sql);

foreach ($documents as $i => $document) {

	$tracks_status = "For Transaction";
	
	if ($document['track_option'] != NULL) {
		$tracks_status = "";
		$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$document['track_option']);
		$documents[$i]['document_status'] = $track_option[0]['choice'];
	};
	
	$documents[$i]['tracks_status'] = $tracks_status;	
	$documents[$i]['track_date'] = date("F j, Y",strtotime($document['track_date']));

};

echo json_encode($documents);

?>