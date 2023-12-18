<?php
include "dbconfig.php";

if (isset($_GET["keyword"])) {
    $keyword = $_GET["keyword"];
    $con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

    if ($keyword == "*") {
        $sql = "SELECT * FROM CPS3740.Products";
    } else {
        $keyword = mysqli_real_escape_string($con, $keyword);
        $sql = "SELECT * FROM CPS3740.Products WHERE Name LIKE '%$keyword%'";
    }

    $result = mysqli_query($con, $sql);

    if ($result) {
        echo "<HTML>\n";
        if (mysqli_num_rows($result) > 0) {
            echo "<p>The results of your search keyword '$keyword':</p>\n";
            echo "<table border='1'>\n";
            echo "<tr>
                    <th>pid</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>QTY</th>
                    <th>vid</th>
                </tr>\n";

            while ($row = mysqli_fetch_array($result)) {
                echo "<tr>";
                echo "<td>{$row['P_Id']}</td>";
                echo "<td>{$row['Name']}</td>";
                echo "<td>{$row['Price']}</td>";
                echo "<td>{$row['Quantity']}</td>";
                echo "<td>{$row['V_Id']}</td>";
                echo "</tr>\n";
            }

            echo "</table>\n";
        } else {
            echo "No results found for keyword: <strong>$keyword</strong>";
        }

        echo "</HTML>\n";
    } else {
        echo "Something went wrong with the SQL query: " . mysqli_error($con);
    }

    mysqli_close($con);
} else {
    echo "Please provide a search keyword.";
}
?>
