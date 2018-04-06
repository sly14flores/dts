<?php

define('system_privileges', array(
	array( # 0
		"id"=>1,
		"description"=>"Dashboard",
		"privileges"=>array( # id=1 must be always page access
			array("id"=>1,"description"=>"Show Dashboard","value"=>false),
		),
	),
	array( # 1
		"id"=>2,
		"description"=>"Receive Document",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Receive Document","value"=>false),
			array("id"=>2,"description"=>"Add Document","value"=>false),		
		),
	),
	array( # 2
		"id"=>3,
		"description"=>"Incoming",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Incoming Document","value"=>false),
		),
	),	
	array( # 3
		"id"=>4,
		"description"=>"Transact",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Transact","value"=>false),
		),
	),
	array( # 4
		"id"=>5,
		"description"=>"List of Documents",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show List of Documents","value"=>false),
		),
	),
	array( # 5
		"id"=>6,
		"description"=>"Tracks",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Tracks","value"=>false),
		),
	),
	array( # 6
		"id"=>7,
		"description"=>"Accounts",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show User Accounts","value"=>false),
			array("id"=>2,"description"=>"Add User Account","value"=>false),
			array("id"=>3,"description"=>"Edit User Account","value"=>false),
			array("id"=>4,"description"=>"Delete User Account","value"=>false),
		),
	),
	array( # 7
		"id"=>8,
		"description"=>"Groups",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show User Groups","value"=>false),
			array("id"=>2,"description"=>"Add User Groups","value"=>false),
			array("id"=>3,"description"=>"Edit User Groups","value"=>false),
			array("id"=>4,"description"=>"Delete User Groups","value"=>false),
		),
	),
	array( # 8
		"id"=>9,
		"description"=>"Maintenance",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Maintenance","value"=>false),
			array("id"=>2,"description"=>"Add/Edit Item","value"=>false),
			array("id"=>3,"description"=>"Delete Item","value"=>false),
		),
	),
));

?>