<?php
// Include configuration file 
include "dbconfig.php";

// Connect to the database
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("<br> Cannot connect to DB:<br>");

// Verify if cid is available 
if (!isset($_GET['cid'])) {
    die("Customer ID is missing!");
}

$customer_id = intval($_GET['cid']);

$sql = "SELECT P_Id, Name, Price, Quantity, V_Id FROM CPS3740.Products";
$result = mysqli_query($con, $sql);

// Styling order table
echo "<style>
        table {
            width: 40%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border: 1px solid black;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {background-color: #f5f5f5;}
        input[type='number'], input[type='submit'] {
            padding: 5px;
            margin: 5px;
        }
      </style>";

    echo "<h2>Order Your Product</h2>";

    // Display order in a table format
    echo "<table border='1'>";
    echo "<tr>
            <th>pid</th>
            <th>Name</th>
            <th>Price</th>
            <th>Available QTY</th>
            <th>vid</th>
            <th>QTY to order</th>
        </tr>";

    while ($row = mysqli_fetch_array($result)) {
        echo "<tr>";
        echo "<td>{$row['P_Id']}</td>";
        echo "<td>{$row['Name']}</td>";
        echo "<td>{$row['Price']}</td>";
        echo "<td>{$row['Quantity']}</td>";
        echo "<td>{$row['V_Id']}</td>";
        echo "<td>";
    
         // Other table forms
        echo "<form action='place_order.php?cid={$customer_id}&pid={$row['P_Id']}' method='get'>";
        echo "<input type='hidden' name='cid' value='{$customer_id}'>";
        echo "<input type='hidden' name='pid' value='{$row['P_Id']}'>";
        echo "<input type='number' name='pid_order_qty' required max='{$row['Quantity']}'>";
        echo "<input type='submit' value='Place order'>";
        echo "</form>";
        echo "</td>";
        echo "</tr>";
    
}
        echo "</table>";

// Close connection
mysqli_close($con);
?>
