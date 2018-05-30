<?php

function date_diff_f($date1,$date2) {
	
	# less weekends / 16 hours
	$weekdays = 0;
	$weekends = 0;
	$start = $date1;
	while (strtotime($start) <= strtotime($date2)) {

		if ( (date("D",strtotime($start)) == "Sat") || (date("D",strtotime($start)) == "Sun") ) $weekends++;
		else $weekdays++;
		
		$start = date("Y-m-d H:i:s",strtotime("+1 day",strtotime($start)));
		
	};
	
	#

	$diff = date_diff(date_create($date1),date_create($date2));
	
	$i = (($diff->i)>1)?"s":"";
	$h = (($diff->h)>1)?"s":"";
	$d = (($diff->d)>1)?"s":"";
	$m = (($diff->m)>1)?"s":"";
	$y = (($diff->y)>1)?"s":"";
	$date_diff_f = $diff->format("%i minute$i");
	if (($diff->h)>0) {
		$date_diff_f = $diff->format("%h hour$h and %i minute$i");
	};
	if (($diff->d)>0) {
		$date_diff_f = $diff->format("%d day$d, %h hour$h and %i minute$i");
	};
	if (($diff->m)>0) {
		$date_diff_f = $diff->format("%m month$m, %d day$d, %h hour$h and %i minute$i");
	};
	if (($diff->y)>0) {
		$date_diff_f = $diff->format("%y year$y, %m month$m, %d day$d, %h hour$h and %i minute$i");
	};
	
	return $date_diff_f;
	
};

?>