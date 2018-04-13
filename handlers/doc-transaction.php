<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';
require_once '../assignments.php';
require_once 'notify.php';

$assignments = assignments;

session_start();

$con = new pdo_db("tracks");

$document_status = NULL;
$document_tracks_status = "transaction";
$track_office = $_POST['track_office'];
$track_option = NULL;
$route_office = NULL;
$route_user = NULL;
$remarks = (isset($_POST['next']['remarks']))?$_POST['next']['remarks']:"";

$notifications = [];

$track_date = date("Y-m-d H:i:s");

$staff = $con->getData("SELECT CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$_SESSION['id']);

$document_origin = $con->getData("SELECT origin FROM documents WHERE id = ".$_POST['id']);
$get_track_office = $con->getData("SELECT id, office FROM offices WHERE id = $track_office");
$track_office_name = $get_track_office[0]['office'];

switch ($_POST['action']) {

	case "Flag":
	
		$track_option = getOption($_POST['options']);

		# liaisons
		$liaisons = $con->getData("SELECT id FROM users WHERE div_id = ".$document_origin[0]['origin']." AND group_id IN ".getAssignmentIds($assignments['group'],1,"group"));
		foreach ($liaisons as $liaison) {

			$notifications[] = array(
				"doc_id"=>$_POST['id'],
				"user_id"=>$liaison['id'],
				"notification_type"=>"outgoing",
				"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> was ".getOptionDescription($_POST['options'],$track_option)." at $track_office_name<br>by ".$staff[0]['fullname']."  on ".date("F j, Y h:i A",strtotime($track_date))
			);

		};
		
		# PS Staffs / AOs
		$aos = $con->getData("SELECT id FROM users WHERE div_id = ".$track_office." AND group_id IN ".getAssignmentIds($assignments['group'],2,"group"));
		foreach ($aos as $ao) {

			$notifications[] = array(
				"doc_id"=>$_POST['id'],
				"user_id"=>$ao['id'],
				"notification_type"=>"transaction",
				"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> was ".getOptionDescription($_POST['options'],$track_option)." at $track_office_name<br>by ".$staff[0]['fullname']."  on ".date("F j, Y h:i A",strtotime($track_date))
			);

		};		
		

	break;

	case "Forward":

		$document_status = "Forward";
		$document_tracks_status = "for_pick_up";
		$route_office = $_POST['next']['route_office']['id'];
		$track_option = $_POST['track_option'];

		# liaisons
		$liaisons = $con->getData("SELECT id FROM users WHERE div_id = $route_office AND group_id IN ".getAssignmentIds($assignments['group'],1,"group"));
		foreach ($liaisons as $liaison) {

			$notifications[] = array(
				"doc_id"=>$_POST['id'],
				"user_id"=>$liaison['id'],
				"notification_type"=>"incoming",
				"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> is ready for pick up at $track_office_name<br>Date: ".date("F j, Y",strtotime($track_date))."<br>Time: ".date("h:i A",strtotime($track_date))
			);

		};

	break;

	case "Release":

		$document_status = "Release";
		$document_tracks_status = "incoming";
		$route_office = $_POST['next']['route_office']['id'];
		$route_user = $_POST['next']['route_user']['id'];
		$track_option = $_POST['track_option'];		

		$pick_up_by = $con->getData("SELECT CONCAT(fname, ' ', lname) fullname FROM users WHERE id = $route_user");

		# liaisons
		$liaisons = $con->getData("SELECT id FROM users WHERE div_id = ".$document_origin[0]['origin']." AND group_id IN ".getAssignmentIds($assignments['group'],1,"group"));
		foreach ($liaisons as $liaison) {

			$notifications[] = array(
				"doc_id"=>$_POST['id'],
				"user_id"=>$liaison['id'],
				"notification_type"=>"incoming",
				"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> was picked up<br>by ".$pick_up_by[0]['fullname']." at $track_office_name on ".date("F j, Y h:i A",strtotime($track_date))
			);

		};

	break;

	case "File":

		$document_status = "Filed";
		$document_tracks_status = "filed";
		$track_option = $_POST['track_option'];

		$file_by = $con->getData("SELECT CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$_SESSION['id']);		
		
		$file_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$_SESSION['office']);
		$file_office_name = $file_office[0]['office'];		
		
		# all staffs
		$all_staffs = $con->getData("SELECT id FROM users WHERE div_id = ".$document_origin[0]['origin']." AND group_id IN ".getAssignmentIds($assignments['group'],1,"group"));
		foreach ($all_staffs as $staff) {

			$notifications[] = array(
				"doc_id"=>$_POST['id'],
				"user_id"=>$staff['id'],
				"notification_type"=>"incoming",
				"message"=>$_POST['doc_type']." with subject: <strong>".$_POST['doc_name']."</strong> was filed <br>by ".$file_by[0]['fullname']." at $file_office_name on ".date("F j, Y h:i A",strtotime($track_date))
			);

		};		
		
	break;

};

$track = array(
	"document_id"=>$_POST['id'],
	"document_status"=>$document_status, # document status
	"document_status_user"=>$_SESSION['id'],
	"document_tracks_status"=>$document_tracks_status, # tracks status
	"track_office"=>$track_office,
	"track_date"=>$track_date,
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

function getOptionDescription($options,$track_option) {

	$description = NULL;

	foreach ($options as $opt) {

		if ($opt['id'] == $track_option) {

			$description = $opt['description'];

		};

	};

	return $description;	

};

$con->insertData($track);

# notify
if (count($notifications)) {
	notify($con,$notifications);	
};

?>