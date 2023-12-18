<?php
//  Include configuration file 
include "dbconfig.php";

// Connect to database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

// Retrieve 'cid' and 'oid' 
if (!isset($_GET['cid'], $_GET['oid'])) {
    die("Required parameters are missing!");
}

$customer_id = intval($_GET['cid']);
$order_id = intval($_GET['oid']);


// Check if the order belongs to the logged-in customer
$stmt_check = $con->prepare("SELECT * FROM CPS3740_2023F.Order_iagboada WHERE oid = ? AND cid = ?");
$stmt_check->bind_param("ii", $order_id, $customer_id);
$stmt_check->execute();
$result_check = $stmt_check->get_result();

if ($result_check->num_rows == 0) {
    echo "The order id $order_id for customer id $customer_id does not exist, the order cannot be canceled.";
} else {

    // Delete the order from Order_iagboada table
    $stmt_delete = $con->prepare("DELETE FROM CPS3740_2023F.Order_iagboada WHERE oid = ?");
    $stmt_delete->bind_param("i", $order_id);
    if ($stmt_delete->execute()) {
        echo "Successfully deleted the order $order_id!";
    } else {
        echo "There was an error deleting the order. Please try again.";
    }
    $stmt_delete->close();
}

// Close all connections
$stmt_check->close();
mysqli_close($con);
?>
