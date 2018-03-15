<?php
$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$documents = $con->getData("SELECT *, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id WHERE tracks.track_office = ".$_SESSION['office']." ORDER BY tracks.document_transaction_date DESC LIMIT 1");

foreach ($documents as $i => $document) {

	$document_status = "";

	if ($document['system_document_status'] == "incoming") {
		$document_status = "Incoming";
		$documents[$i]['barcode'] = "TBD";
	};
	
	if ($document['system_document_status'] == "transaction") $document_status = "For Transaction";

	$documents[$i]['document_status'] = $document_status;
	
	$documents[$i]['document_transaction_date'] = date("F j, Y",strtotime($document['document_transaction_date']));
	

};

echo json_encode($documents);

?>