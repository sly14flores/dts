<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db();

$tracks = $con->getData("SELECT document_activity_date, document_activity, (SELECT CONCAT(users.fname, ' ', users.lname) FROM users WHERE users.id = tracks.document_activity_user) staff, (SELECT offices.office FROM offices WHERE id = tracks.track_office) office FROM tracks WHERE document_id = ".$_POST['id']);

foreach ($tracks as $i => $track) {
	
	$tracks[$i]['date'] = date("F j, Y",strtotime($track['document_activity_date']));
	$tracks[$i]['time'] = date("h:i:s A",strtotime($track['document_activity_date']));
	
};

$files = $con->getData("SELECT id, file_name FROM files WHERE document_id = ".$_POST['id']);

foreach ($files as $i => $file) {
	
	$ft = explode(".",$file['file_name']);
	
	$files[$i]['type'] = $ft[1];
	$files[$i]['path'] = "../files/".$file['file_name'];
	
};

$attachments = $con->getData("SELECT id, file_name FROM attachments WHERE document_id = ".$_POST['id']);

foreach ($attachments as $i => $attachment) {
	
	$ft = explode(".",$attachment['file_name']);
	
	$attachments[$i]['type'] = $ft[1];
	$attachments[$i]['path'] = "../attachments/".$attachment['file_name'];
	
};

echo json_encode(array("tracks"=>$tracks,"files"=>$files,"attachments"=>$attachments));

?>