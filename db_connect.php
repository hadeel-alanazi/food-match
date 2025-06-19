<?php
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "food_suggestions"; 

$conn = mysqli_connect($host, $user, $pass, $dbname);

if (!$conn) {
    die("فشل الاتصال: " . mysqli_connect_error());
}
?>
