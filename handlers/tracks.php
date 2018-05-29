<?php

require_once 'datetime.php';

function tracks($con,$tracks) {

	$status_arr = array(
		"Routed"=>"to"
	);

	foreach ($tracks as $i => $track) {

		$document_status = $track['document_status'];

		$user = $con->getData("SELECT CONCAT(users.fname, ' ', users.lname) user FROM users WHERE users.id = ".$track['document_status_user']);
		$track_office = $con->getData("SELECT offices.office FROM offices WHERE offices.id = ".$track['track_office']);
		$route_office = $con->getData("SELECT id, office FROM offices WHERE id = ".$track['route_office']);			

		$prepo = (isset($status_arr[$document_status]))?$status_arr[$document_status]:"at";

		if ($track['track_option'] != NULL) {
			$document_status = "";
			$option = $con->getData("SELECT pre_phrase, description FROM options WHERE id = ".$track['track_option']);
			$track_option = $con->getData("SELECT id, choice FROM options WHERE id = ".$track['track_option']);
			$document_status .= ($option[0]['description']==NULL)?$track_option[0]['choice']:ucfirst($option[0]['description']);
		};

		$tracks[$i]['track_date_f'] = date("(D) F j, Y",strtotime($track['track_date']));
		$tracks[$i]['track_time_f'] = date("h:i A",strtotime($track['track_date']));

		$track_office_name = (count($track_office))?$track_office[0]['office']:$route_office[0]['office'];

		$status = $document_status." $prepo $track_office_name by ".$user[0]['user']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];

		if ($track['document_tracks_status'] == "for_pick_up") {
			$status = "For pick up for ".$route_office[0]['office']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];
		};

		if ($track['document_tracks_status'] == "incoming") {
			$route_user = $con->getData("SELECT id, CONCAT(fname, ' ', lname) fullname FROM users WHERE id = ".$track['route_user']);		
			$status = "Picked up by ".$route_user[0]['fullname']." at ".$track_office[0]['office']." on ".$tracks[$i]['track_date_f']." ".$tracks[$i]['track_time_f'];
		};

		$tracks[$i]['status'] = $status;
		$tracks[$i]['interval'] = "";
		
		# Interval between tracks
		if ($i < (count($tracks)-1)) {
			
			$previous_track_date = $tracks[$i+1]['track_date'];
			$track_date = $track['track_date'];
			$interval = date_diff_f($previous_track_date,$track_date);
			$tracks[$i]['interval'] = $interval;
			
		};
		
		$date = ($i==0)?date("Y-m-d H:i:s"):$tracks[$i-1]['track_date'];
		$track_date = $track['track_date'];
		$tracks[$i]['elapsed_date_time'] = date_diff_f($track_date,$date);

	};

	return $tracks;

};

?>