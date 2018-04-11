<?php

$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

session_start();

$con = new pdo_db("notifications");

$outgoing = [];
$transaction = [];
$incoming = [];

$response = array(
	"count"=>0,
	"outgoing"=>[],	
	"transaction"=>[],
	"incoming"=>[],
);

$outgoing = $con->getData("SELECT id, message, system_log FROM notifications WHERE dismiss = 0 AND notification_type = 'outgoing' AND user_id = ".$_SESSION['id']);
$transaction = $con->getData("SELECT id, message, system_log FROM notifications WHERE dismiss = 0 AND notification_type = 'transaction' AND user_id = ".$_SESSION['id']);
$incoming = $con->getData("SELECT id, message, system_log FROM notifications WHERE dismiss = 0 AND notification_type = 'incoming' AND user_id = ".$_SESSION['id']);

$response['count'] = count($outgoing)+count($transaction)+count($incoming);
$response['outgoing'] = $outgoing;
$response['transaction'] = $transaction;
$response['incoming'] = $incoming;

echo json_encode($response);

?>