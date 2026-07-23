<%@ page
	import="java.sql.*, java.io.*, java.text.SimpleDateFormat, project.connection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Generate Customer Orders Report</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 8px;
}

th {
	text-align: left;
}
</style>
</head>
<body>
	<h1>Customer Orders Report</h1>

	<%
        // Get the start and end dates from the request parameters
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        if (startDate != null && endDate != null) {
            // JDBC connection details
            String url = "jdbc:mysql://localhost:3306/shop_zone";  // Ensure this is the correct database name
            String user = "root";  // Your MySQL username
            String password = "";  // Your MySQL password

            try {
                // Set up JDBC connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn =connection.getcon();

                // SQL query to fetch customer order details, including UPI ID, shipping address, total order value, and feedback
                String query = "SELECT c.username, c.email, c.phone_number, o.shipping_address, COUNT(o.order_id) AS order_count, " +
                               "SUM(oi.quantity * p.show_price) AS total_order_value, GROUP_CONCAT(f.content) AS customer_feedback " +
                               "FROM customer c " +
                               "JOIN orders o ON c.c_id = o.c_id " +
                               "JOIN order_line_item oi ON o.order_id = oi.order_id " +
                               "JOIN product p ON oi.pro_id = p.pro_id " +
                               "LEFT JOIN feedback f ON c.c_id = f.c_id " +
                               "WHERE o.order_date BETWEEN ? AND ? " +
                               "GROUP BY c.c_id";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, startDate);
                stmt.setString(2, endDate);

                // Execute the query
                ResultSet rs = stmt.executeQuery();

                // Display the results in a table
                out.println("<table>");
                out.println("<tr><th>Customer Name</th><th>Email</th><th>Phone Number</th><th>Shipping Address</th>" +
                            "<th>Number of Orders</th><th>Total Order Value</th><th>Customer Feedback</th></tr>");

                // Process the result set and display the data in the table
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getString("phone_number") + "</td>");
                    out.println("<td>" + rs.getString("shipping_address") + "</td>");
                    out.println("<td>" + rs.getInt("order_count") + "</td>");
                    out.println("<td>" + rs.getDouble("total_order_value") + "</td>");
                    out.println("<td>" + rs.getString("customer_feedback") + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");

                // Close resources
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Please select both start and end dates.</p>");
        }
    %>
</body>
</html>
