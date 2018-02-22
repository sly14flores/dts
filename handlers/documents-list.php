<?php
$_POST = json_decode(file_get_contents('php://input'), true);

require_once '../db.php';

$con = new pdo_db("documents");

$documents = $con->getData("SELECT *, (SELECT offices.shortname FROM offices WHERE offices.id = documents.origin) origin, (SELECT transactions.transaction FROM transactions WHERE transactions.id = documents.transaction) transaction, (SELECT document_types.document_type FROM document_types WHERE document_types.id = documents.doc_type) doc_type,(SELECT communications.shortname FROM communications WHERE communications.id = documents.communication) communication FROM `documents` ORDER BY `documents`.`origin` ASC");

echo json_encode($documents);

?>