<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Total Sales Report</title>
<!-- Bootstrap link -->
<link rel="stylesheet" href="../bootstrap.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- JavaScript for Bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	margin: 0;
	padding: 0;
}

.insert {
	width: 30%;
	text-align: center;
	font-size: larger;
	border-radius: 30px;
	margin-left: 35%;
	margin-bottom: 20px;
}

.table img {
	width: 100px;
	height: 100px;
	object-fit: cover;
}

.navbar-brand {
	font-size: 1.5rem;
}

.n {
	font-size: 35px;
}

table {
	width: 80%;
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

	<h1 style="text-align: center;">Sales Report</h1>
	<center>
		<form action="generate_sales_report.jsp" method="get"
			style="text-align: center;">
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
        // Retrieve parameters
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if (startDate != null && endDate != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = project.connection.getcon();

                // SQL query
                String sql = "SELECT DATE(o.order_date) AS order_date, " +
                             "SUM(oli.quantity * p.actual_price) AS total_sales " +
                             "FROM orders o " +
                             "JOIN order_line_item oli ON o.order_id = oli.order_id " +
                             "JOIN product p ON oli.pro_id = p.pro_id " +
                             "WHERE o.order_date BETWEEN ? AND ? " +
                             "AND o.order_status = 'completed' " +
                             "GROUP BY DATE(o.order_date) " +
                             "ORDER BY DATE(o.order_date)";

                stmt = conn.prepareStatement(sql);
                stmt.setString(1, startDate);
                stmt.setString(2, endDate);

                rs = stmt.executeQuery();

                // Display results
    %>
	<table class="table table-bordered">
		<tr>
			<th>Order Date</th>
			<th>Total Sales (₹)</th>
		</tr>
		<%
                        while (rs.next()) {
                            String orderDate = rs.getString("order_date");
                            double totalSales = rs.getDouble("total_sales");
                    %>
		<tr>
			<td><%= orderDate %></td>
			<td><%= totalSales %></td>
		</tr>
		<%
                        }
                    %>
	</table>
	<%
            } catch (Exception e) {
                out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
