<?php

require_once 'handlers/datetime.php';

var_dump(date("Y-m-d",strtotime("+1 Days",strtotime(date("Y-m-d")))));

?>