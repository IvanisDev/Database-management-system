<?php
# Keep the sensitive information in a separated PHP file.
include "dbconfig.php";

$con = mysqli_connect($imc.kean.edu, $iagboada, $854236, $CPS3740) or die("<br>Cannot connect to DB\n");

$query = "SELECT id, login";
$query = $query. "FROM CPS3740.Customers";
echo "<query: $query\n";

$result = mysqli_query($con, $query);

if ($result) {
    if (mysqli_num_rows($result) > 0) {
        
        echo "<br>The following customers are in the database:";
        echo "<table border='1'>\n";
        echo "<tr><td>ID<td>Name\n"; 

        while ($row = mysqli_fetch_array($result)) {
            $id = $row['id'];
            $name = $row['login'];
            echo"<tr><td>$id<td>Name\n";  
        }

        echo "</table>\n";
       }

        else {
            echo "<br>No records in the database.\n";
            mysqli_free_result($result);
        }
 }
 else {
    echo "<br>Something wrong with the SQL query.\n";
 }
 mysqli_close($con);
 ?>



 