<?php

$_POST = json_decode(file_get_contents('php://input'), true);

$privileges = array(
	array(
		"id"=>1,
		"description"=>"Dashboard",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Dashboard","value"=>false),
		),
	),
	array(
		"id"=>2,
		"description"=>"Receive Document",
		"privileges"=>array(
			array("id"=>1,"description"=>"Show Receive Document","value"=>false),
			array("id"=>2,"description"=>"Add Document","value"=>false),
			array("id"=>3,"description"=>"Edit Document","value"=>false),
		),
	),	
);

require_once '../db.php';

$con = new pdo_db("groups");

$group_privileges = $con->get(array("id"=>$_POST['id']),["privileges"]);

if (count($group_privileges)) {
	if ($group_privileges[0]['privileges']!=NULL) {

		$group_privileges = json_decode($group_privileges[0]['privileges'],true);

		$privileges_obj = new privileges($privileges,$group_privileges);
		$privileges = $privileges_obj->get();

	};
}

class privileges {
	
	var $privileges;
	var $group_privileges;
	
	function __construct($privileges,$group_privileges) {

		$this->privileges = $privileges;
		$this->group_privileges = $group_privileges;

		foreach ($this->privileges as $key => $privilege) {
			
			if ($this->hasModule($privilege)) {
				
				$this->privileges[$key] = $this->getPrivilege($privilege);
				
			};
			
		};
		
	}
	
	function hasModule($privilege) {
		
		$hasModule = false;
		
		foreach ($this->group_privileges as $key => $value) {
			
			if ($value['id'] == $privilege['id']) $hasModule = true;
			
		};
		
		return $hasModule;

	}
	
	function getPrivilege($privilege) {
		
		
	}
	
	function get() {
		
		return $this->privileges;
		
	}	
	
};

echo json_encode($privileges);

?>