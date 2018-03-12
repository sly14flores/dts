<?php

define('system_privileges', array(
	array(
		"id"=>1,
		"description"=>"Dashboard",
		"privileges"=>array( # id=1 must be always page access
			array("id"=>1,"description"=>"Show Dashboard","value"=>false),
		),
	),
	array(
		"id"=>2,
		"description"=>"Receive Document",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Receive Document","value"=>false),
			array("id"=>2,"description"=>"Add Document","value"=>false),			
		),
	),
	array(
		"id"=>3,
		"description"=>"My Documents",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Incoming Document","value"=>false),
		),
	),
	array(
		"id"=>6,
		"description"=>"List of Documents",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show List of Documents","value"=>false),
		),
	),
	array(
		"id"=>7,
		"description"=>"Tracks",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Tracks of Documents","value"=>false),
		),
	),
	array(
		"id"=>8,
		"description"=>"Accounts",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show User Accounts","value"=>false),
			array("id"=>2,"description"=>"Add User Account","value"=>false),
			array("id"=>3,"description"=>"Edit User Account","value"=>false),
			array("id"=>4,"description"=>"Delete User Account","value"=>false),
		),
	),
	array(
		"id"=>9,
		"description"=>"Groups",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show User Groups","value"=>false),
			array("id"=>2,"description"=>"Add User Groups","value"=>false),
			array("id"=>3,"description"=>"Edit User Groups","value"=>false),
			array("id"=>4,"description"=>"Delete User Groups","value"=>false),
		),
	),
	array(
		"id"=>10,
		"description"=>"Maintenance",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Maintenance","value"=>false),
			array("id"=>2,"description"=>"Add/Edit Item","value"=>false),
			array("id"=>3,"description"=>"Delete Item","value"=>false),
		),
	),
));

?>