<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';
require_once 'tracks.php';

$con = new pdo_db("documents");

$sql = "SELECT tracks.id, tracks.document_status, IFNULL(tracks.track_office,0) track_office, tracks.document_status_user, tracks.track_option, tracks.document_tracks_status, tracks.track_date, IFNULL(tracks.route_office,0) route_office, tracks.route_user, tracks.track_option FROM tracks LEFT JOIN documents ON tracks.document_id = documents.id WHERE documents.id = ".$_POST['id']." ORDER BY id DESC";

$tracks = $con->getData($sql);

$tracks = tracks($con,$tracks);

echo json_encode($tracks);

?>