<?php
$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$documents = $con->getData("SELECT *, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type, (SELECT offices.office FROM offices WHERE offices.id = documents.origin) origin FROM tracks LEFT JOIN documents ON tracks.document_id = documents.id WHERE tracks.track_office = ".$_SESSION['office']." AND tracks.track_user = ".$_SESSION['id']);

echo json_encode($documents);

?>