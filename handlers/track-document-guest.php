<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';
require_once 'tracks.php';

$con = new pdo_db("documents");

$sql = "SELECT documents.id, documents.barcode, documents.barcode, documents.doc_name, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.document_transaction_type) document_transaction_type, DATE_FORMAT(documents.document_date, '%M %d, %Y') document_date FROM documents WHERE documents.barcode = '".$_POST['barcode']."'";
$document = $con->getData($sql);

$sql = "SELECT tracks.id, tracks.document_status, IFNULL(tracks.track_office,0) track_office, tracks.document_status_user, tracks.track_option, tracks.document_tracks_status, tracks.track_date, IFNULL(tracks.route_office,0) route_office, tracks.route_user, tracks.track_option FROM tracks LEFT JOIN documents ON tracks.document_id = documents.id WHERE documents.barcode = '".$_POST['barcode']."' ORDER BY id DESC";
$tracks = $con->getData($sql);

$tracks = tracks($con,$tracks);

$response = array("document"=>$document[0],"tracks"=>$tracks);

echo json_encode($response);

?>