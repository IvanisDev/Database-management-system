<?php
ini_set('pcre.jit', '0');

// Check if the user login cookie is set
if (!isset($_COOKIE['authenticated_user'])) {
    echo "Please login first!";
    exit;
}

include "dbconfig.php";

$browser_username = $_COOKIE['authenticated_user'];

// Connect to the database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

# Call the Customers table from database
$sql = "SELECT id, name, DOB, gender, street, city, zipcode, img FROM CPS3740.Customers WHERE login='$browser_username'";
$result = mysqli_query($con, $sql);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    // Fetches the customer ID.
    $user_id = $row['id'];

    // Calculate age
    $birthDate = new DateTime($row['DOB']);
    $today = new DateTime();
    $age = $birthDate->diff($today)->y;

    // Check IP Address
    $ip_address = $_SERVER['REMOTE_ADDR'];
    $is_from_kean = preg_match('/^(10\.)|(131\.125\.)/', $ip_address);

    // Display the details
    echo "<p>IP: $ip_address</p>";
    echo $is_from_kean ? "<p>You are from Kean University.</p>" : "<p>You are NOT from Kean University.</p>";
    echo "<p>Welcome {$row['name']}</p>";
    echo "<p>Gender: {$row['gender']}</p>";
    echo "<p>DOB: {$row['DOB']}, Age: $age</p>";
    echo "<p>Address: {$row['street']}, {$row['city']}, {$row['zipcode']}</p>";
    echo "<img src='data:image/jpeg;base64," . base64_encode($row['img']) . "' alt='Customer Image'><br>";
   
    echo "<br><a href='logout.php'>Logout</a>";
    echo "<br><a href='order_product.php?cid=$user_id'>Order Product</a>"; 
    echo "<br><a href='view_orders.php?cid=$user_id'>View, change, cancel my order history</a>";
   
    
} else {
    echo "User details not found.";
}

// Close the database connection
mysqli_close($con);
?>




