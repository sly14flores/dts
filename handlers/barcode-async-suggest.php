<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$filter = (isset($_POST['filter']))?" AND documents.barcode LIKE '%".$_POST['filter']."%'":"";

$documents = $con->getData("SELECT DISTINCT documents.id, documents.barcode FROM documents LEFT JOIN tracks ON documents.id = tracks.document_id WHERE tracks.track_office = ".$_SESSION['office'].$filter);

echo json_encode($documents);

?>