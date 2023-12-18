<?php
include "dbconfig.php";

$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

if (!isset($_GET['cid'])) {
    die("Customer ID is missing!");
}

$customer_id = intval($_GET['cid']);

$query = "
    SELECT O.oid AS order_id, P.Name AS product_name, P.Price AS price, P.Quantity AS available_quantity, 
            P.V_Id AS vendor_id, O.order_qty AS order_qty, O.order_datetime AS order_date
    FROM CPS3740_2023F.Order_iagboada O
    JOIN CPS3740.Products P ON O.pid = P.P_Id  
    WHERE O.cid = ?";

$stmt = $con->prepare($query);
if (false === $stmt) {
    die("Error preparing query: " . mysqli_error($con));
}

$stmt->bind_param('i', $customer_id);
$stmt->execute();
$result = $stmt->get_result();

if (!$result) {
    die("Error retrieving orders: " . mysqli_error($con));
}

if ($result->num_rows == 0) {
    echo "No orders found for customer id $customer_id.";
} else {
    echo "<table border='1'>";
    echo "<tr>
            <th>order id</th>
            <th>product name</th>
            <th>Price</th>
            <th>Available qty</th>
            <th>Order qty</th>
            <th>Vendor ID</th>
            <th>Date Time</th>
            <th>Actions</th>
        </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . $row['order_id'] . "</td>";
        echo "<td>" . $row['product_name'] . "</td>";
        echo "<td>" . $row['price'] . "</td>";
        echo "<td>" . $row['available_quantity'] . "</td>";
        echo "<td>" . $row['order_qty'] . "</td>";
        echo "<td>" . $row['vendor_id'] . "</td>";
        echo "<td>" . $row['order_date'] . "</td>"; 
        echo "<td><a href='cancel_order.php?cid=" . urlencode($customer_id) . "&oid=" . urlencode($row['order_id']) . "'>Cancel order</a> ";
        echo "<form method='get' action='change_order.php'>";
        echo "<input type='number' name='new_qty' value='" . $row['order_qty'] . "' required style='width: 50px;'>"; 
        echo "<input type='hidden' name='oid' value='" . $row['order_id'] . "'>";
        echo "<input type='hidden' name='cid' value='" . $customer_id . "'>";
        echo "<input type='hidden' name='pid' value='" . $row['P_Id '] . "'>";
        echo "<input type='submit' value='Change quantity'>";
        echo "</form></td>";
        echo "</tr>";
    }
    echo "</table>";
}

// Close
$stmt->close();
$con->close();
?>

