<?php
// Include the database configuration file
include "dbconfig.php";

// Check if the "keyword" parameter is set in the URL
if (isset($_GET["keyword"])) {
    // Get the search keyword from the GET request
    $keyword = $_GET["keyword"];

    // Create a database connection
    $con = mysqli_connect($hostname, $username, $password, $dbname) or die("Cannot connect to DB");

    // Create an SQL query to search for records based on the keyword
    if ($keyword == "*") {
        // Display all results if the keyword is "*"
        $sql = "SELECT * FROM your_table_name";
    } else {
        // Use pattern matching with '%'
        $keyword = mysqli_real_escape_string($con, $keyword); // Sanitize input
        $sql = "SELECT * FROM your_table_name WHERE column_name LIKE '%$keyword%'";
    }

    // Execute the SQL query
    $result = mysqli_query($con, $sql);

    // Check if there are any results
    if ($result) {
        echo "<HTML>\n";
        if (mysqli_num_rows($result) > 0) {
            echo "<h1>Search results for keyword: <strong>$keyword</strong></h1>\n";
            echo "<table border='1'>\n";
            echo "<tr><th>Column1</th><th>Column2</th></tr>\n"; // Replace with your table column names

            // Loop through the results and display them in a table
            while ($row = mysqli_fetch_array($result)) {
                $column1Value = $row['column1']; // Replace with your column names
                $column2Value = $row['column2']; // Replace with your column names

                echo "<tr><td>$column1Value</td><td>$column2Value</td></tr>\n";
            }

            echo "</table>\n";
        } else {
            echo "No results found for keyword: <strong>$keyword</strong>";
        }

        echo "</HTML>\n";
    } else {
        echo "Something went wrong with the SQL query: " . mysqli_error($con);
    }

    // Close the database connection
    mysqli_close($con);
} else {
    echo "Please provide a search keyword.";
}
?>