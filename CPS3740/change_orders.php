<?php
include "dbconfig.php";

// Connect to the database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

// Retrieve the GET parameters
$oid = $_GET['oid'] ?? null;
$new_qty = $_GET['new_qty'] ?? null;
$pid = $_GET['pid'] ?? null;
$cid = $_GET['cid'] ?? null;

// Check if new_qty is a positive integer
if (!filter_var($new_qty, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]])) {
    echo "The new quantity must be a positive integer.";
    exit;
}

// Update the order quantity
$stmt = $con->prepare("UPDATE CPS3740_2023F.Order_iagboada SET order_qty = ? WHERE oid = ? AND pid = ? AND cid = ?");
$stmt->bind_param("iiii", $new_qty, $oid, $pid, $cid);

if ($stmt->execute()) {
    echo "Order quantity updated successfully!";
} else {
    echo "Error updating order: " . mysqli_error($con);
}

// Close the database connection
$stmt->close();
$con->close();
?>



