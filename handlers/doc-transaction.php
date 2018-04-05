<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("tracks");

$document_status = NULL;
$document_tracks_status = "transaction";
$track_office = $_POST['track_office'];
$track_option = NULL;
$route_office = NULL;
$route_user = NULL;
$remarks = (isset($_POST['next']['remarks']))?$_POST['next']['remarks']:"";

switch ($_POST['action']) {

	case "Flag":

		$track_option = getOption($_POST['options']);

	break;

	case "Forward":

		$document_status = "Forward";
		$document_tracks_status = "for_pick_up";
		$route_office = $_POST['next']['route_office']['id'];

	break;

	case "Release":

		$document_status = "Release";
		$document_tracks_status = "incoming";
		$route_office = $_POST['next']['route_office']['id'];
		$route_user = $_POST['next']['route_user']['id'];	

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
	"route_user"=>$route_user,
	"track_option"=>$track_option,
	"remarks"=>$remarks
);

function getOption($options) {
	
	$option = NULL;
	
	foreach ($options as $opt) {

		if (isset($opt['value'])) {

			if ($opt['value']) {
				$option = $opt['id'];
				break;
			};

		};

	};

	return $option;
	
};

$con->insertData($track);

?>