<%@ page
	import="java.sql.*, java.security.MessageDigest, java.util.Base64"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="project.connection"%>
<%@ page session="true"%>

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
<title>ADMIN dashboard</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.2 bg-dark/css/fontawesome.min.css"
	integrity="sha384-BY+fdrpOd3gfeRvTSMT+VUZmA728cfF9Z2G42xpaRkUGu2i3DyzpTURDo5A6CaLK"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
body {
	margin: 0;
	padding: 0;
	overflow: none;
}

.top-navbar {
	font-size: 35px;
	font-family: "Orbitron", sans-serif;
	font-weight: 300;
}

.top-navbar {
	font-family: "Noto Serif Display", serif;
	font-weight: 400;
}

.nav-item {
	margin-left: 5px;
	margin-right: 5px;
	font-size: large;
	text-decoration: none;
}

.box {
	background-color: #fff;
	margin: 0px 0px 30px;
	padding: 20px;
	box-shadow: 0 1ox 5px rgba(0, 0, 0, 0.1);
}

#hotbox {
	text-transform: uppercase;
	font-size: 36px;
	color: #4993e4;
	font-weight: 100;
	text-align: center;
}

.shop_by_cat {
	padding: 20px;
	border-radius: 35px;
	font-weight: 700;
	color: aqua;
}

.card {
	width: 100px;
	height: 300px;
}

.card-img-top {
	width: 100%;
	height: 300px;
	object-fit: contain;
}

.fun:hover {
	background-color: #4993e4;
	color: black;
}

.dash {
	text-align: center;
}

.ship_w {
	max-width: 100px;
	word-wrap: break-word;
}

.navbar-brand {
	font-size: 1.5rem;
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

	<!-- THIRD -->
	<div class="container">
		<div class="container">
			<div id="hotbox text-center">
				<div class="box">
					<div class="shop_by_cat container bg-dark text-light">
						<div class="col-md-12 text-center">
							<h1>List of Orders</h1>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- FOURTH -->
		<div class="container">
			<div class="row justify-content-center">
				<form action="" method="post">
					<table class="table table-bordered border-warning">
						<thead>
							<tr>
								<th>Order ID</th>
								<th>Amount</th>
								<th>Delivery Person ID</th>
								<th>Order Status</th>
								<th>Items</th>
								<th>Order Date</th>
								<th>Customer ID</th>
								<th>Shipping Address</th>
								<th>Details</th>
							</tr>
						</thead>
						<tbody>
							<% 
                    Connection conn = connection.getcon();
                    Statement stmt = conn.createStatement();
                    String query = "SELECT o.order_id, p.amount, o.dp_id, o.order_status, o.num_of_items, "
                                 + "o.order_date, c.c_id, o.shipping_address, c.username "
                                 + "FROM orders o "
                                 + "JOIN payment p ON o.p_id = p.p_id "
                                 + "JOIN customer c ON o.c_id = c.c_id "
                                 + "ORDER BY o.order_id DESC";
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int orderId = rs.getInt("order_id");
                        double amount = rs.getDouble("amount");
                        int dpId = rs.getInt("dp_id");
                        String orderStatus = rs.getString("order_status");
                        int numItems = rs.getInt("num_of_items");
                        String orderDate = rs.getString("order_date");
                        int customerId = rs.getInt("c_id");
                        String shippingAddress = rs.getString("shipping_address");
                        String username = rs.getString("username");

                        out.println("<tr>");
                        out.println("<td>" + orderId + "</td>");
                        out.println("<td>" + amount + "</td>");
                        out.println("<td>" + dpId + "</td>");
                        out.println("<td>"+ orderStatus+"<br>");

                        // Display the order status buttons as <a> tags
                        if ("Order Placed".equals(orderStatus)) {
                            out.println("<a href='update_order_status.jsp?order_id=" + orderId + "&status=Processing' class='btn btn-warning'>Processing</a>");
//                             out.println("<br>");out.println("<br>");
//                             out.println("<a href='update_order_status.jsp?order_id=" + orderId + "&status=Cancelled by admin' class='btn btn-danger'>Cancel</a>");
//                             out.println("<br>");
                        } else if ("Processing".equals(orderStatus)) {
                            out.println("<a href='update_order_status.jsp?order_id=" + orderId + "&status=Out for Delivery' class='btn btn-info'>Out for Delivery</a>");
                        } 

                        out.println("</td>");
                        out.println("<td>" + numItems + "</td>");
                        out.println("<td>" + orderDate + "</td>");
                        out.println("<td>" + customerId + "</td>");
                        out.println("<td>" + shippingAddress + "</td>");
                        out.println("<td><a href='admin_see_details_of_cust_order.jsp?see_order_details=" + orderId 
                                    + "&cust_id=" + customerId + "&username=" + username 
                                    + "' class='btn btn-secondary'>See Details</a></td>");
                        out.println("</tr>");
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                %>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<div class="container-fluid bg-dark mt-3 mb-0">
		<h1 class="text-dark" style="margin-bottom: 0%; height: 200px;">#</h1>
	</div>
</body>
</html>
