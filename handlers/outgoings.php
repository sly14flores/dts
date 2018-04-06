<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$filter = "WHERE documents.origin = ".$_SESSION['office'];

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, tracks.document_status, tracks.document_status_user, tracks.document_tracks_status, tracks.track_office, tracks.track_date, tracks.remarks, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter} ORDER BY tracks.track_date DESC LIMIT 1";
$outgoings = $con->getData($sql);

foreach ($outgoings as $i => $outgoing) {

	$tracks_status = "";

	$outgoings[$i]['tracks_status'] = $tracks_status;
	$outgoings[$i]['track_date'] = date("F j, Y",strtotime($outgoing['track_date']));

};

echo json_encode($outgoings);

?>