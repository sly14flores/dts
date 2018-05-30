<?php

require_once 'handlers/datetime.php';

$date1 = "2018-05-25 08:00:00";
$date2 = date("Y-m-d H:i:s");

$diff = date_diff_f($date1,$date2);

?>