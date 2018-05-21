<?php

function date_diff_f($date1,$date2) {
	
	$diff = date_diff(date_create($date1),date_create($date2));
	
	$date_diff_f = $diff->format('%i minutes');
	$i = (($diff->i)>1)?"s":"";
	$h = (($diff->h)>1)?"s":"";
	$d = (($diff->d)>1)?"s":"";
	$m = (($diff->m)>1)?"s":"";
	$y = (($diff->y)>1)?"s":"";
	if (($diff->h)>0) $date_diff_f = $diff->format("%h hour$h and %i minute$i");
	if (($diff->d)>0) $date_diff_f = $diff->format("%d day$d, %h hour$h and %i minute$i");
	if (($diff->m)>0) $date_diff_f = $diff->format("%m month$m, %d day$d, %h hour$h and %i minute$i");
	if (($diff->y)>0) $date_diff_f = $diff->format("%y year$y, %m month$m, %d day$d, %h hour$h and %i minute$i");
	
	return $date_diff_f;
	
};

?>