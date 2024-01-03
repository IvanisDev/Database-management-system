<?php
// Start the session
session_start();

// Log the user out after session is destroyed
session_destroy();
?>

<!DOCTYPE html>
<head>
    <title>Logout</title>
</head>
<body>

<p>You have logged out successfully.</p>
<a href="index.html">Return to login page</a>

</body>
</html>

