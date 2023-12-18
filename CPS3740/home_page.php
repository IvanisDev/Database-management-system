<?php
ini_set('pcre.jit', '0');

include "dbconfig.php";

$con = mysqli_connect($hostname, $username, $password, $dbname) or die("<br> Cannot connect to DB:<br>");

if (isset($_COOKIE["Login"])) {
    $browser_username = $_COOKIE["Login"];

    $sql = "SELECT name, DOB, gender, login, password, street, city, zipcode, img FROM CPS3740.Customers WHERE login='$browser_username'";
    $result = mysqli_query($con, $sql);

    if ($result) {
        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_array($result);
            $customer_name = $row['name'];
            $birthdate = $row['DOB'];
            $gender = $row['gender'];
            $street = $row['street'];
            $city = $row['city'];
            $zipcode = $row['zipcode'];
            $img = $row['img'];

            // Calculate age
            $birthDate = new DateTime($birthdate);
            $today = new DateTime();
            $age = $birthDate->diff($today)->y;
            $address = "$street, $city, $zipcode";

            // Check IP Address
            $ip_address = $_SERVER['REMOTE_ADDR'];
            $is_from_kean = preg_match('/^(10\.)|(131\.125\.)/', $ip_address);
            ?>


            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Welcome
                    <?= $customer_name ?>
                </title>
            </head>

            <body>
                <!-- IP and Domain Info -->
                <p>IP:
                    <?= $ip_address ?>
                </p>
                <p>You are
                    <?= $is_from_kean ? '' : 'not' ?> from Kean University.
                </p>

                <!-- Customer Info -->
                <p>Welcome customer:
                    <?= $customer_name ?>
                </p>

                <p>DOB:
                    <?= $birthdate ?>, age:
                    <?= $age ?>
                </p>
                <p>Address:
                    <?= $address ?>
                </p>
                <img src='data:image/jpeg;base64,<?= base64_encode($img) ?>' alt="Customer Image">

                <!-- Links -->
                <ul>
                    <li><a href="logout.php">Logout</a></li>
                    <li><a href="order_product.php">Order Product</a></li>
                    <li><a href="view_orders.php">View, change, cancel my order history</a></li>
                </ul>

            </body>

            </html>

            <?php
        } else {
            echo "User not found!";
        }
    } else {
        echo "Something is wrong with SQL: " . mysqli_error($con);
    }
} else {
    echo "Please login first!";
}
mysqli_close($con);
?>