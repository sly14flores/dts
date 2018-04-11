<?php

define('assignments', array(
	"user"=>array(
		array("id"=>1,"user"=>6,"description"=>"Provincial Administrator"),
	),
	"office"=>array(
		array("id"=>1,"office"=>2,"description"=>"Initial recepient of documents"),	
	),
	"group"=>array(
		array("id"=>1,"group"=>4,"description"=>"Receive incoming documents and notifications"),
	)
));

function getAssignmentId($assignments,$id,$col) {
	
	$value = NULL;
	
	foreach ($assignments as $assignment) {
		
		if ($id == $assignment['id']) $value = $assignment[$col];
		
	};
	
	return $value;
	
};

?>