<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$track_office = $_POST['track_office'];
$document_status = "";
$document_tracks_status = "transaction";
$route_office = NULL;
$remarks = (isset($_POST['next']['remarks']))?$_POST['next']['remarks']:"";

switch ($_POST['action']) {

	case "Flag":

		$document_status = $_POST['next']['document_status'];

	break;

	case "Route":

		$document_status = "Routed";
		$document_tracks_status = "incoming";
		$route_office = $_POST['next']['route_office']['id'];

	break;

	case "File":

		$document_status = "Filed";

	break;

};

$track = array(
	"document_id"=>$_POST['id'],
	"document_status"=>$document_status, # document status
	"document_status_user"=>$_SESSION['id'],
	"document_tracks_status"=>$document_tracks_status, # tracks status
	"track_office"=>$track_office,
	"track_date"=>"CURRENT_TIMESTAMP",
	"route_office"=>$route_office,
	"remarks"=>$remarks
);

$con->insertData($track);

?>