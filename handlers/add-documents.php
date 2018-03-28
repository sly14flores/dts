<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';
require_once 'folder-files.php';

$con = new pdo_db("documents");

session_start();

$com = $_POST['communication']['shortname'];
$office = $_POST['origin']['shortname'];
$_POST['user_id'] = $_SESSION['id'];
$_POST['origin'] = $_POST['origin']['id'];
$_POST['doc_type'] = $_POST['doc_type']['id'];
$_POST['communication'] = $_POST['communication']['id'];
$_POST['document_transaction_type'] = $_POST['document_transaction_type']['id'];

$uploads = array("files"=>$_POST['files'],"attachments"=>$_POST['attachments']);
unset($_POST['files']);
unset($_POST['attachments']);

if ($_POST['id']) { # update

	$con->updateData($_POST,'id');
	
	echo "updated";
	
} else { # insert
	
	$incr = 1;
	
	$sql = "SELECT documents.id, documents.barcode FROM documents WHERE documents.origin = $_POST[origin] ORDER BY documents.id DESC LIMIT 1";

	$barcode = $con->getData($sql);

	if (count($barcode)) {

		$last_no = explode("-",$barcode[0]['barcode']);
		
		$incr = (isset($last_no[3]))?(int)$last_no[3]:0;
		
		$incr+=1;
		
	};
	
	$_POST['barcode'] = substr($office,0,3)."-".date("m")."-".date("Y")."-".str_pad($incr, 5, '0', STR_PAD_LEFT);

	unset($_POST['id']);
	
	$con->insertData($_POST);
	
	$id = $con->insertId;

	$barcode = $con->get(array("id"=>$id),["barcode","(SELECT document_type FROM document_types WHERE id = ".$_POST['doc_type'].") doc_type"]);

	uploadFiles($con,$uploads,$barcode[0]['barcode'],$id);

	# first track
	if ( (isset($id)) && ($id) ) {

		$initial_track_office = $con->getData("SELECT id FROM offices WHERE is_initial_track = 1");
		$track_office = (count($initial_track_office))?$initial_track_office[0]['id']:0;		

		$track = array(
			"document_id"=>$id,
			"system_document_action"=>"transaction",
			"track_office"=>$track_office,
			"document_activity"=>"Received",
			"document_activity_user"=>$_SESSION['id'],
			"document_activity_date"=>"CURRENT_TIMESTAMP"
		);

		$con->table = "tracks";
		$first_track = $con->insertData($track);

	};
	#

	echo json_encode(array("barcode"=>$barcode[0]['barcode'],"doc_type"=>$barcode[0]['doc_type']));

}

function uploadFiles($con,$uploads,$barcode,$id) {
	
	$ft = array(
		"jpeg"=>".jpg",
		"pdf"=>".pdf",
		"png"=>".png"
	);

	if (count($uploads["files"])) {

		$con->table = "files";
	
		$dir = "../files";
		
		if (!folder_exist($dir)) mkdir($dir);		

		foreach ($uploads["files"] as $key => $f) {

			if ($f['file'] == "") continue;

			$imgData = str_replace(' ','+',$f['file']);
			$imgData =  substr($imgData,strpos($imgData,",")+1);
			$imgData = base64_decode($imgData);
			$fileName = "$barcode"."_$key".$ft[$f['type']];
			$filePath = "$dir/$fileName";
			$file = fopen($filePath, 'w');
			fwrite($file, $imgData);
			fclose($file);

			$data = array("document_id"=>$id,"file_name"=>$fileName);
			$con->insertData($data);

		};

	};
	
	if (count($uploads["attachments"])) {

		$con->table = "attachments";	
	
		$dir = "../attachments";
		
		if (!folder_exist($dir)) mkdir($dir);		

		foreach ($uploads["attachments"] as $key => $f) {

			if ($f['file'] == "") continue;

			$imgData = str_replace(' ','+',$f['file']);
			$imgData =  substr($imgData,strpos($imgData,",")+1);
			$imgData = base64_decode($imgData);
			$fileName = "$barcode"."_$key".$ft[$f['type']];
			$filePath = "$dir/$fileName";
			$file = fopen($filePath, 'w');
			fwrite($file, $imgData);
			fclose($file);

			$data = array("document_id"=>$id,"file_name"=>$fileName);
			$con->insertData($data);

		};

	};

};

?>