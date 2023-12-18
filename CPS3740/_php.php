<?php
include "dbconfig.php";

// Setting the default timezone to Eastern Time.
date_default_timezone_set('America/New_York');

$con = null;

if (!isset($_GET['cid'])) {
    die("Customer ID is missing!");
}

$customer_id = intval($_GET['cid']);
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB.");

$query = "SELECT * FROM CPS3740_2023F.Order_iagboada WHERE cid = $customer_id";
$result = mysqli_query($con, $query);

if (!$result) {
    die("Error retrieving orders: " . mysqli_error($con));
}

if (mysqli_num_rows($result) == 0) {
    echo "No orders found for customer id $customer_id.";
} else {
    echo "<table border='1'>";
    echo "<tr>
            <th>order id</th>
            <th>product name</th>
            <th>order quantity</th>
            <th>date time</th>
            <th>actions</th>
        </tr>";

    while ($row = mysqli_fetch_assoc($result)) {
        echo "<tr>";
        echo "<td>" . $row['oid'] . "</td>";
        echo "<td>" . $row['pid'] . "</td>"; 
        echo "<td>" . $row['order_qty'] . "</td>";

        // Fetching the current date and time in the specified timezone.
        $now = new DateTime();
        $currentDateTime = $now->format('Y-m-d h:i:s');
        echo "<td>" . $currentDateTime . "</td>"; 

        echo "<td><a href='cancel_order.php?cid=$customer_id&oid=" . $row['oid'] . "'>Cancel order</a> | ";
        
        echo "<input type='number' id='qty_" . $row['oid'] . "' name='new_qty[" . $row['oid'] . "]' value='" . $row['order_qty'] . "' required style='width: 50px;'> ";
        echo "<a href='#' onclick='changeOrderQuantity(" . $row['oid'] . ", " . $customer_id . ", " . $row['pid'] . ")'>Change quantity</a></td>";


        echo "</tr>";
    }

    echo "</table>";

    echo "<script>
    function changeOrderQuantity(oid, cid, pid) {
        let qty = document.getElementById('qty_' + oid).value;
        window.location.href = 'change_order.php?new_qty=' + qty + '&oid=' + oid + '&cid=' + cid + '&pid=' + pid;
    }
    </script>";
}

if ($con) {
    mysqli_close($con);
}
?>





<?php
// Start the session
session_start();

include "dbconfig.php";

// Connect to the database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

if (isset($_POST['username']) && isset($_POST['password'])) {
    $browser_username = mysqli_real_escape_string($con, $_POST['username']);
    $browser_password = mysqli_real_escape_string($con, $_POST['password']);

    $sql = "SELECT login, password FROM CPS3740.Customers WHERE login='$browser_username'";
    $result = mysqli_query($con, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $db_password = $row['password'];

        if ($browser_password == $db_password) {
            // Successful login, set the session variable and redirect to user_home.php
            $_SESSION['authenticated_user'] = $browser_username;
            // Redirect to user home page
            header("Location: user_home.php");
            exit;
        } else {
            echo "Login $browser_username exists, but password doesn't match.";
        }
    } else {
        echo "Login $browser_username doesn't exist in the database.";
    }
} else {
    echo "Please provide both login and password.";
}

mysqli_close($con);
?>