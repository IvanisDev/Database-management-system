<?php
echo "<HTML>\n";

// centralized file
include "dbconfig.php";

// connection to server
$con = mysqli_connect($hostname, $username, $password, $dbname) or die("<br> Cannot connect to DB:<br>");

$query = "SELECT id, login ";
$query .= " FROM CPS3740.Customers ";
echo "<br>query: $query\n";

$result = mysqli_query($con, $query);

if ($result) {
    if (mysqli_num_rows($result) > 0) {
        echo "<br>The following customers are in the database.";
        echo "<TABLE border=1>\n";
        echo "<TR><TD>ID<TD>Name\n";

        while ($row = mysqli_fetch_array($result)) {
            $id = $row['id'];
            $name = $row['login'];
            echo "<TR><TD>$id<TD>$name\n";
        }

        echo "</TABLE>\n";
    } else {
        echo "<br>No records in the database.\n";
        mysqli_free_result($result); // free a result set
    }
} else {
    echo "<br>Something wrong with the SQL query.\n";
}

// close connection
mysqli_close($con);
?>