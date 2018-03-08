<?php

session_start();

if (isset($_SESSION['id'])) unset($_SESSION['id']);
if (isset($_SESSION['group'])) unset($_SESSION['group']);

echo "Logout Successful";

header("location: ../index.html");

?>