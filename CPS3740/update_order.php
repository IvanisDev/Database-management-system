<!DOCTYPE html>
<html>
<head>
    <title>Update Order</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="orderInfo">
        <!-- Order information will be displayed here -->
    </div>
    <script>
        $(document).ready(function () {
            // Function to update order information
            function updateOrderInfo() {
                $.ajax({
                    url: 'update_order.php?oid=<?php echo $oid; ?>',
                    type: 'GET',
                    success: function (data) {
                        $('#orderInfo').html(data);
                    },
                    error: function () {
                        alert('Error updating order information.');
                    }
                });
            }

            // Call the function to update order information initially
            updateOrderInfo();
        });
    </script>
</body>
</html>
