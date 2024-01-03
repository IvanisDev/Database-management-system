<?php
// Include configuration file 
include "dbconfig.php";

// Connect to the database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("<br> Cannot connect to DB:<br>");

// Fetch GET parameters
$cid = $_GET['cid'] ?? null;
$pid = $_GET['pid'] ?? null;
$pid_order_qty = $_GET['pid_order_qty'] ?? null;

// Verify if the quantity is accurate
if (!is_numeric($pid_order_qty)) {
    echo "The order quantity must be a number. The order has not been successfully placed.";
    exit;
} elseif ($pid_order_qty != (int)$pid_order_qty) {
    echo "The order quantity must be an integer. The order has not been successfully placed.";
    exit;
} elseif ((int)$pid_order_qty <= 0) {
    echo "The order quantity must be > 0. The order has not been successfully placed.";
    exit;
}

$pid_order_qty = (int)$pid_order_qty;

// Verify the available stock of the chosen product
$stmt = $con->prepare("SELECT Quantity FROM CPS3740.Products WHERE P_Id = ?");
$stmt->bind_param("i", $pid);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo "Product not found.";
    exit;
}

$row = $result->fetch_assoc();
$available_qty = $row['Quantity'];

if ($pid_order_qty > $available_qty) {
    echo "The order quantity 4000 is more than the available quantity 11. Order failed!.";
    exit;
}

// Place order and insert it into Order_iagboada table 
$stmt = $con->prepare("INSERT INTO CPS3740_2023F.Order_iagboada (cid, pid, order_qty, order_datetime) VALUES (?, ?, ?, NOW())");
$stmt->bind_param("iii", $cid, $pid, $pid_order_qty);

if ($stmt->execute()) {
    echo "Successfully placed the order!";
} else {
    echo "Error placing order: " . mysqli_error($con);
}

// Close all connections
$stmt->close();
mysqli_close($con);
?>



