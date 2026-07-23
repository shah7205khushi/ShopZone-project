<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, project.connection"%>
<%
double grandtotal = 0;
double totalprofit=0;
%>
<!DOCTYPE html>
<html lang="en">
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

	<center>
		<h1 style="text-align: center;">product Sales Report</h1>
		<form action="generate_sales_by_product.jsp" method="get"
			style="text-align: center;">
			<label for="startDate">Start Date:</label> <input type="date"
				id="startDate" name="startDate" required> <br> <br>
			<label for="endDate">End Date:</label> <input type="date"
				id="endDate" name="endDate" required> <br> <br>
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
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = connection.getcon();

			// Query for product sales report
			String query = "SELECT p.pro_id AS product_id, " +
               "p.title AS product_name, " +
               "SUM(oli.quantity) AS units_sold, " +
               "SUM(oli.quantity * (p.show_price - ((p.show_price * p.discount) / 100))) AS total_sales, " +
               "SUM((p.actual_price * oli.quantity) - " +
               "(oli.quantity * (p.show_price - ((p.show_price * p.discount) / 100)))) AS profit " +
               "FROM order_line_item oli " +
               "JOIN product p ON oli.pro_id = p.pro_id " +
               "JOIN orders od ON oli.order_id = od.order_id " +
               "WHERE od.order_date BETWEEN ? AND ? " +
               "GROUP BY p.pro_id, p.title " +
               "ORDER BY total_sales DESC";
			ps = conn.prepareStatement(query);
			ps.setString(1, startDate);
			ps.setString(2, endDate);
			rs = ps.executeQuery();

			boolean dataFound = false;
	%>
	<center>
		<h1>Sales by Product</h1>
	</center>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>Product ID</th>
				<th>Product Name</th>
				<th>Units Sold</th>
				<th>Total Sales</th>
				<th>Profit</th>

			</tr>
		</thead>
		<tbody>
			<%
			while (rs.next()) {
				int productId = rs.getInt("product_id");
				String productName = rs.getString("product_name");
				int unitsSold = rs.getInt("units_sold");
				double totalSales = rs.getDouble("total_sales");
				double profit = rs.getDouble("profit");
				grandtotal = grandtotal + totalSales;
				totalprofit =totalprofit +profit;
				dataFound = true;
			%>
			<tr>
				<td><%=productId%></td>
				<td><%=productName%></td>
				<td><%=unitsSold%></td>
				<td>Rs. <%=totalSales%></td>
				<td>Rs. <%=profit%></td>
			</tr>
			<%
			}
%>

			<tr>
				<td colspan="3" style="text-align: right; font-weight: bold;">Grand
					Total:</td>
				<td style="font-weight: bold;">Rs. <%= grandtotal %></td>
				<td style="font-weight: bold;">Rs. <%= totalprofit %></td>
			</tr>
			<%
			if (!dataFound) {
			%>
			<tr>
				<td colspan="4" style="text-align: center;">No data available
					for the selected date range.</td>
			</tr>
			<%
			}
			} catch (Exception e) {
			out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
			} finally {
			if (rs != null)
			rs.close();
			if (ps != null)
			ps.close();
			if (conn != null)
			conn.close();
			}
			} else {
				
			/* out.println("<tr><td colspan='4' style='text-align:center;'>Please select a valid date range to generate the report.</td></tr>");
			*/ }
	
			%>
		</tbody>

	</table>

	<%--                <div class=""> <%out.println("grand total" + grandtotal); %></div>  --%>
</body>
</html>
