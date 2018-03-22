<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$filter = "";
if ($_SESSION['group'] > 1) $filter = "WHERE tracks.track_office = ".$_SESSION['office']." ";

$sql = "SELECT documents.id, documents.barcode, documents.doc_name, tracks.system_document_status, tracks.document_activity_date, tracks.document_activity, tracks.track_office, tracks.track_office_next, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id {$filter}ORDER BY tracks.document_activity_date DESC LIMIT 1";
$documents = $con->getData($sql);

foreach ($documents as $i => $document) {

	$document_status = "";

	if ($document['system_document_status'] == "incoming") {
		$document_status = "Incoming";
		$documents[$i]['barcode'] = "TBD";
	};
	
	if ($document['system_document_status'] == "transaction") $document_status = "For Transaction";

	$documents[$i]['document_status'] = $document_status;
	
	$documents[$i]['document_activity_date'] = date("F j, Y",strtotime($document['document_activity_date']));
	

};

echo json_encode($documents);

?>