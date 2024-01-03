<?php
//  Include configuration file 
include "dbconfig.php";

// Connect to database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

// Check customer login and  valid login cookie
if (isset($_POST['username']) && isset($_POST['password'])) {
    $browser_username = mysqli_real_escape_string($con, $_POST['username']);
    $browser_password = mysqli_real_escape_string($con, $_POST['password']);
    $sql = "SELECT id, login, password, name, DOB, gender, street, city, zipcode, img FROM CPS3740.Customers WHERE login='$browser_username'";
} elseif (isset($_COOKIE['authenticated_user'])) {
    $browser_username = $_COOKIE['authenticated_user'];
    $sql = "SELECT id, name, DOB, gender, street, city, zipcode, img FROM CPS3740.Customers WHERE login='$browser_username'";
} else {
    echo "Please login first!";
    mysqli_close($con);
    exit;
}

if (!empty($sql)) {
    $result = mysqli_query($con, $sql);
    if (!$result) {
        echo "Error executing query: " . mysqli_error($con);
        exit;
    }

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $user_id = $row['id'];

        // Handle incorrect password during login
        if (isset($browser_password) && $browser_password != $row['password']) {
            echo "Login $browser_username exists, but password doesn't match.";
            mysqli_close($con);
            exit;
        }

        // Calculate Customer's age
        $birthDate = new DateTime($row['DOB']);
        $today = new DateTime();
        $age = $birthDate->diff($today)->y;

        // Check IP address
        $ip_address = $_SERVER['REMOTE_ADDR'];
        $is_from_kean = preg_match('/^(10\.)|(131\.125\.)/', $ip_address);

        // Display Customer information
        echo "IP: $ip_address<br>";
        echo $is_from_kean ? "You are from Kean University.<br>" : "You are NOT from Kean University.<br>";
        echo "Welcome {$row['name']}<br>";
        echo "Gender: {$row['gender']}<br>";
        echo "DOB: {$row['DOB']}, Age: $age<br>";
        echo "Address: {$row['street']}, {$row['city']}, {$row['zipcode']}<br>";
        echo "<img src='data:image/jpeg;base64," . base64_encode($row['img']) . "' alt='Customer Image'><br>";
        echo "<a href='logout.php'>Logout</a><br>";
        echo "<a href='order_product.php?cid=$user_id'>Order Product</a><br>"; 
        echo "<a href='view_order.php?cid=$user_id'>View, change, cancel my order history</a><br>";

    } else {
        echo "User details not found or login incorrect.";
    }
} else {
    echo "No valid operation requested.";
}

// Close connection
mysqli_close($con);
?>








