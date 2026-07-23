<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.sql.*, java.security.MessageDigest, java.util.Base64"%>
<%@ page import="java.sql.*, project.connection"%>
<%@ page import="java.sql.*, project.connection"%>

<%
     // Check if the admin is logged in
    String adminName = (String) session.getAttribute("admin_name");

    if (adminName == null) {
        // Redirect if not logged in
        response.sendRedirect("index.jsp");
        return;
    } 
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.2 bg-dark/css/fontawesome.min.css"
	integrity="sha384-BY+fdrpOd3gfeRvTSMT+VUZmA728cfF9Z2G42xpaRkUGu2i3DyzpTURDo5A6CaLK"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400..900&display=swap"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	margin: 0;
	padding: 0;
	overflow: none;
}

.navbar-brand {
	font-size: 1.5rem;
}

.n {
	font-size: 35px;
}

.top-navbar {
	font-size: 35px;
	font-family: "Orbitron", sans-serif;
	font-weight: 300;
}

.nav-item {
	margin-left: 5px;
	margin-right: 5px;
	font-size: large;
}

.box {
	background-color: #fff;
	margin: 0px 0px 30px;
	padding: 20px;
	box-shadow: 0 10px 5px rgba(0, 0, 0, 0.1);
}

#advantage {
	text-align: center;
	display: flex;
	justify-content: space-between;
}

.shop_by_cat {
	padding: 20px;
	border-radius: 35px;
	color: aqua;
}

.custom-hr {
	border: 7px solid red;
	width: 100%;
}

small {
	font-size: large;
}

.nav-item:hover {
	border-bottom: 1px solid black;
}

.n {
	font-size: 35px;
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="bg-dark navbar navbar-expand-lg navbar-custom">
		<div class="container">
			<a class="n fs-1 navbar-brand text-light" href="#">Shop zone</a>
			<div class="mr-5">
				<a href="admin_logout.jsp" class="btn btn-danger">Logout</a> <a
					href="admin_dashboard.jsp" class="btn btn-warning">Back</a>
			</div>
		</div>
	</nav>

	<!-- Third Section -->
	<div class="container">
		<div class="container">
			<div id="hotbox text-center">
				<div class="box">
					<div class="shop_by_cat container bg-dark text-light">
						<div class="col-md-12 text-center">
							<h1>MANAGE CUSTOMERS</h1>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Fourth Section: Customer Data Table -->
		<div class="container">
			<div class="row justify-content-center">
				<form action="" method="post">
					<table class="table table-bordered border-warning">
						<thead>
							<tr>
								<th>Customer ID</th>
								<th>Username</th>
								<th>Email</th>
								<th>Total Orders</th>
								<th>See Order History</th>
							</tr>
						</thead>
						<tbody>
							<%
    // Database connection
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        // Load JDBC driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = project.connection.getcon(); // Replace with actual password
        
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM customer");

        while (rs.next()) {
            int cust_id = rs.getInt("c_id");
            String username = rs.getString("username");
            String email = rs.getString("email");

            // Fetch the total number of orders for this customer
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS order_count FROM orders WHERE c_id = ?");
            ps.setInt(1, cust_id);
            ResultSet rsOrder = ps.executeQuery();
            rsOrder.next();
            int orderCount = rsOrder.getInt("order_count");

            // Fetch the most recent order_id for this customer
            PreparedStatement psOrder = con.prepareStatement(
                "SELECT order_id FROM orders WHERE c_id = ? ORDER BY order_date DESC LIMIT 1");
            psOrder.setInt(1, cust_id);
            ResultSet rsOrderId = psOrder.executeQuery();

            int orderId = 0;
            if (rsOrderId.next()) {
                orderId = rsOrderId.getInt("order_id");
            } else {
                orderId = -1; // If no order exists, set orderId to a default value
            }
    %>
							<tr>
								<td><%= cust_id %></td>
								<td><%= username %></td>
								<td><%= email %></td>
								<td><%= orderCount %></td>
								<td>
									<!-- Check if orderId is valid before linking --> <%
                        if (orderId > 0) {
                    %> <a
									href="list_of_orders_of_customer.jsp?see_order_details=<%= orderId %>&cust_id=<%= cust_id %>&username=<%= username %>"
									class="btn btn-secondary col-12 mb-2">list of orders</a> <%
                        } else {
                    %> <span class="text-muted">No Orders</span> <%
                        }
                    %>
								</td>
							</tr>
							<%
        }
        rs.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

						</tbody>

					</table>
				</form>
			</div>
		</div>

		<!-- Footer -->
		<div class="container-fluid bg-dark mt-3 mb-0">
			<h1 class="text-dark" style="margin-bottom: 0%; height: 200px;">#</h1>
		</div>
	</div>
</body>
</html>
