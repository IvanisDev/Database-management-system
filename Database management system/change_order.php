<?php
//  Include configuration file 
include "dbconfig.php";

// Connect to database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

// Retrieve GET parameters
$oid = $_GET['oid'] ?? null;
$new_qty = $_GET['new_qty'] ?? null;
$pid = $_GET['pid'] ?? null;
$cid = $_GET['cid'] ?? null;

// Verify if new quantity is a positive integer
if (!filter_var($new_qty, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]])) {
    echo "Please enter a positive integer.";
    exit;
}

// Verify if the order exists and belongs to signed-in Customer
$stmt_check = $con->prepare("SELECT * FROM CPS3740_2023F.Order_iagboada WHERE oid = ? AND cid = ?");
$stmt_check->bind_param("ii", $oid, $cid);
$stmt_check->execute();
$result_check = $stmt_check->get_result();

if ($result_check->num_rows == 0) {
    echo "The order id $oid for customer id $cid does not exist, the order cannot be changed.";
    exit;
}

// Verify new quantity limit
$stmt_product = $con->prepare("SELECT Quantity FROM CPS3740.Products WHERE P_Id = ?");
$stmt_product->bind_param("i", $pid);
$stmt_product->execute();
$result_product = $stmt_product->get_result();

if ($row = $result_product->fetch_assoc()) {
    $available_qty = $row['Quantity'];
    if ($new_qty > $available_qty) {
        echo "There is only $available_qty quantity available. The change is not successfully.";
        exit;
    }
} 

// Update the order quantity and datetime in Order_iagboada table
$stmt_update = $con->prepare("UPDATE CPS3740_2023F.Order_iagboada SET order_qty = ?, order_datetime = NOW() WHERE oid = ?");
$stmt_update->bind_param("ii", $new_qty, $oid);

if ($stmt_update->execute()) {
    echo "Successfully changed the order $oid!";
} else {
    echo "Error updating order: " . mysqli_error($con);
}

// Close all connections
$stmt_check->close();
$stmt_product->close();
$stmt_update->close();
mysqli_close($con);
?>






