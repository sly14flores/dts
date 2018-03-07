<?php

define('system_privileges', array(
	array(
		"id"=>1,
		"description"=>"Dashboard",
		"privileges"=>array( # id=1 must be always page access
			array("id"=>1,"description"=>"Show Dashboard","value"=>false),
			array("id"=>2,"description"=>"Show Widgets","value"=>false),
		),
	),
	array(
		"id"=>2,
		"description"=>"Receive Document",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Receive Document","value"=>false),
			array("id"=>2,"description"=>"Add Document","value"=>false),
			array("id"=>3,"description"=>"Edit Document","value"=>false),
			array("id"=>4,"description"=>"Delete Document","value"=>false),
		),
	),
));

?>