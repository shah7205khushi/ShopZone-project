<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
    // Start session
    session.setAttribute("delivery_person_of_shop_zone", session.getAttribute("delivery_person_of_shop_zone"));
    session.setAttribute("dp_id", session.getAttribute("dp_id"));
    
    if (session.getAttribute("delivery_person_of_shop_zone") == null || session.getAttribute("dp_id") == null) {
        response.sendRedirect("dp_login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ADMIN OF SHOP ZONE</title>

<link rel="stylesheet" href="../bootstrap.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
body {
	margin: 0;
	padding: 0;
	overflow: none;
}

.top-navbar {
	font-size: 35px;
	font-family: "Orbitron", sans-serif;
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
	font-family: "Noto Serif Display", serif;
	font-weight: 700;
	color: aqua;
}

.fun:hover {
	background-color: #4993e4;
	color: black;
}

.ship_w {
	max-width: 100px;
	word-wrap: break-word;
}
</style>
</head>
<body>
	<!-- FIRST NAV -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container bg-dark">
			<a class="top-navbar navbar-brand text-light" href="#">SHOP ZONE</a>

			<form class="d-flex" role="search">
				<% if (session.getAttribute("delivery_person_of_shop_zone") == null) { %>
				<button class="btn btn-outline-light text-light bg-success"
					type="button">
					<a class="text-light text-decoration-none" href="dp_login.jsp">Login</a>
				</button>
				<% } else { %>
				<button class="btn btn-outline-light text-light bg-success x"
					type="button">
					<a class="text-light text-decoration-none" href="dp_logout.jsp">Logout</a>
				</button>
				<% } %>
			</form>
		</div>
	</nav>

	<!-- SECOND -->

	<div class="bg-light">
		<h2 class="text-center p-2">
			<% 
                if (session.getAttribute("delivery_person_of_shop_zone") != null) {
                    out.print("Welcome " + session.getAttribute("delivery_person_of_shop_zone"));
                } else {
                    out.print("Welcome Delivery Person");
                }
                %>
		</h2>
	</div>

	<!-- THIRD -->
	<div class="container">
		<div id="hotbox">
			<div class="box">
				<div class="shop_by_cat container bg-dark text-light">
					<div class="col-md-12">
						<h1>${sessionScope.delivery_person_of_shop_zone}'s all
							deliveries</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ page import="java.sql.*, java.util.*"%>

	<%
    String dp_id = (String) session.getAttribute("dp_id");

    if (dp_id != null && !dp_id.isEmpty()) {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            con = project.connection.getcon();

            // Join query to fetch order and payment details for the given delivery person
            String query = "SELECT o.order_id, o.num_of_items, o.order_date, o.pincode, " +
                           "o.shipping_address, o.order_status, o.delivery_date, " +
                           "p.payment_status, p.amount " +
                           "FROM orders o " +
                           "LEFT JOIN payment p ON o.order_id = p.order_id " +
                           "WHERE o.dp_id = ? " +
                           "ORDER BY o.order_date DESC";

            stmt = con.prepareStatement(query);
            stmt.setString(1, dp_id);
            rs = stmt.executeQuery();
%>
	<!-- FOURTH -->
	<div class="container">
		<div class="row">
			<table class="table table-bordered border-warning">
				<thead>
					<tr>
						<th>Order ID</th>
						<th>Number of Items</th>
						<th>Order Date</th>
						<th>Pincode</th>
						<th>Shipping Address</th>
						<th>Order Status</th>
						<th>Payment Status</th>
						<th>Amount</th>
						<th>See Items</th>
					</tr>
				</thead>
				<tbody>
					<%
                        boolean hasOrders = false;
                        while (rs.next()) {
                            hasOrders = true;
                            int orderId = rs.getInt("order_id");
                            int numItems = rs.getInt("num_of_items");
                            String orderDate = rs.getString("order_date");
                            String pincode = rs.getString("pincode");
                            String shippingAddress = rs.getString("shipping_address");
                            String orderStatus = rs.getString("order_status");
                            String paymentStatus = rs.getString("payment_status");
                            double amount = rs.getDouble("amount");
                    %>
					<tr>
						<td><%= orderId %></td>
						<td><%= numItems %></td>
						<td><%= orderDate %></td>
						<td><%= pincode %></td>
						<td><%= shippingAddress %></td>
						<td><%= orderStatus %></td>
						<td><%= paymentStatus != null ? paymentStatus : "Pending" %></td>
						<td><%= amount %> /-</td>
						<td><a href="see_order_items.jsp?order_id=<%= orderId %>"
							class="btn btn-secondary"> See Items </a></td>
					</tr>
					<%
                        }
                        if (!hasOrders) {
                    %>
					<tr>
						<td colspan="10" class="text-center text-danger">No orders
							available for this delivery person.</td>
					</tr>
					<%
                        }
                    %>
				</tbody>
			</table>
		</div>
	</div>

	<%
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        }
    } else {
        out.println("<p style='color: red;'>Delivery person not logged in or session expired.</p>");
    }
%>
	<!-- Footer -->
	<div class="container-fluid bg-dark mt-3 mb-0">
		<h1 class="text-dark" style="margin-bottom: 0%; height: 200px;">#</h1>
	</div>
</body>
</html>
