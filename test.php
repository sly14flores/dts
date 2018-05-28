<?php

require_once 'db.php';

$con = new pdo_db("documents");

$q = $con->getObj(array("id"=>1),["id","doc_name",array("origin"=>array("divisions"=>["id","division","shortname"]))]);

var_dump($q);

?>