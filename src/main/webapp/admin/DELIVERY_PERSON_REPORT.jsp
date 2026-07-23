<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*,project.connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sales by Delivery Person</title>
<!-- Bootstrap link -->
<link rel="stylesheet" href="../bootstrap.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	margin: 0;
	padding: 0;
}

.navbar-brand {
	font-size: 1.5rem;
}

table {
	width: 90%;
	margin: 20px auto;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #ddd;
}

th, td {
	padding: 8px 12px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="bg-dark navbar navbar-expand-lg navbar-custom">
		<div class="container">
			<a class="n fs-1 navbar-brand text-light" href="#">Shop Zone</a>
			<div class="mr-5">
				<a href="admin_logout.jsp" class="btn btn-danger">Logout</a> <a
					href="admin_dashboard.jsp" class="btn btn-warning">Back</a>
			</div>
		</div>
	</nav>

	<center>
		<h1>Sales by Delivery Person</h1>
		<form action="delivery_person_report.jsp" method="get">
			<label for="startDate">Start Date:</label> <input type="date"
				id="startDate" name="startDate" required> <br>
			<br> <label for="endDate">End Date:</label> <input type="date"
				id="endDate" name="endDate" required> <br>
			<br>
			<button type="submit" class="btn btn-primary">Generate
				Report</button>
		</form>
	</center>

	<%
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if (startDate != null && endDate != null) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = connection.getcon();

                // Query for Sales by Delivery Person
                String query = "SELECT dp.name AS delivery_person_name, " +
                               "dp.email AS delivery_person_email, " +
                               "dp.order_area1, dp.order_area2, " +
                               "COUNT(DISTINCT o.order_id) AS total_orders, " +
                               "SUM(oli.quantity * p.actual_price) AS total_sales " +
                               "FROM orders o " +
                               "JOIN order_line_item oli ON o.order_id = oli.order_id " +
                               "JOIN product p ON oli.pro_id = p.pro_id " +
                               "JOIN delivery_person dp ON o.dp_id = dp.dp_id " +
                               "WHERE o.order_status = 'delivered' " +
                               "AND o.order_date BETWEEN ? AND ? " +
                               "GROUP BY dp.dp_id " +
                               "ORDER BY total_sales DESC";

                ps = conn.prepareStatement(query);
                ps.setString(1, startDate);
                ps.setString(2, endDate);
                rs = ps.executeQuery();
    %>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>Delivery Person Name</th>
				<th>Email</th>
				<th>Order Area 1</th>
				<th>Order Area 2</th>
				<th>Total Orders</th>
				<th>Total Sales (₹)</th>
			</tr>
		</thead>
		<tbody>
			<%
                            boolean dataFound = false;
                            while (rs.next()) {
                                dataFound = true;
                        %>
			<tr>
				<td><%= rs.getString("delivery_person_name") %></td>
				<td><%= rs.getString("delivery_person_email") %></td>
				<td><%= rs.getString("order_area1") %></td>
				<td><%= rs.getString("order_area2") %></td>
				<td><%= rs.getInt("total_orders") %></td>
				<td>₹<%= rs.getDouble("total_sales") %></td>
			</tr>
			<%
                            }
                            if (!dataFound) {
                        %>
			<tr>
				<td colspan="6">No data found for the selected date range.</td>
			</tr>
			<%
                            }
                        %>
		</tbody>
	</table>
	<%
            } catch (Exception e) {
                out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
