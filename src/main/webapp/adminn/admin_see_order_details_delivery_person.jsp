<%@ page
	import="java.sql.*, java.security.MessageDigest, java.util.Base64"%>
<%@ page import="project.connection"%>
<%@ page session="true"%>

<%
    // Check if the admin is logged in
    String adminName = (String) session.getAttribute("admin_name");

    if (adminName == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Get parameters from the request
//     String username = request.getParameter("username");
    String dp_id = request.getParameter("dp_id");
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


	<!-- Section for List of Orders -->
	<div class="container my-4">
		<div class="shop_by_cat container bg-dark text-light py-3">
			<div class="col-md-12 text-center">
				<h1>List of Orders for delivery person</h1>
			</div>
		</div>

		<% if (dp_id == null || dp_id.isEmpty()) { %>
		<h2 class="text-center text-danger mt-4">Please select delivery
			person.</h2>

		<% } else { %>
		<div class="row justify-content-center mt-4">
			<table class="table table-bordered border-warning">
				<thead>
					<tr>
						<th>Order ID</th>
						<th>Amount</th>
						<!--                             <th>Delivery Person ID</th> -->
						<th>Order Status</th>
						<th>Number of Items</th>
						<!--                             <th>Order Date</th> -->
						<th>pin code</th>
						<th>Shipping Address</th>
						<th>Payment status</th>
					</tr>
				</thead>
				<tbody>
					<%
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;

                            try {
                                // Database connection
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = connection.getcon();

                                // SQL query to fetch orders for the specific customer
String query = "SELECT o.order_id, p.amount, o.order_status, o.num_of_items, p.payment_status, "
             + "o.shipping_address, o.pincode "
             + "FROM orders o "
             + "JOIN payment p ON o.p_id = p.p_id "
             + "WHERE o.dp_id = ? AND o.order_status != 'order placed' "
             + "ORDER BY o.order_id DESC";
	
                                ps = conn.prepareStatement(query);
                                ps.setInt(1, Integer.parseInt(dp_id));
                                rs = ps.executeQuery();

                                if (rs.next()) {
                                    do {
                                        out.println("<tr>");
                                        out.println("<td>" + rs.getInt("order_id") + "</td>");
//                                         out.println("<td>" + rs.getInt("p_id") + "</td>");
                                        out.println("<td> Rs. " + rs.getDouble("amount") + "</td>");
//                                         out.println("<td>" + rs.getInt("dp_id") + "</td>");
                                        out.println("<td>" + rs.getString("order_status") + "</td>");
                                        out.println("<td>" + rs.getInt("num_of_items") + "</td>");
//                                         out.println("<td>" + rs.getString("order_date") + "</td>");
                                        out.println("<td>" + rs.getString("pincode") + "</td>"); 
                                        out.println("<td>" + rs.getString("shipping_address") + "</td>"); 
                                        out.println("<td>" + rs.getString("payment_status") + "</td>"); 
                                        %>
					<%--                                         <td> <a href='payment_collected.jsp?p=<%= rs.getInt("p_id") %>'></a><td> --%>
					<%
//                                         out.println("<td><a href='admin_see_details_of_cust_order.jsp?see_order_details=" + rs.getInt("order_id") + "&cust_id=" + custIdParam + "&username=" + username + "' class='btn btn-secondary'>See Order Details</a></td>");
                                        out.println("</tr>");
                                    } while (rs.next());
                                } else {
                                    out.println("<tr><td colspan='8' class='text-center text-danger'>No orders found for this customer.</td></tr>");
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='8' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                            } finally {
                                try { if (rs != null) rs.close(); } catch (Exception e) {}
                                try { if (ps != null) ps.close(); } catch (Exception e) {}
                                try { if (conn != null) conn.close(); } catch (Exception e) {}
                            }
                        %>
				</tbody>
			</table>
		</div>
		<% } %>
	</div>
</body>
</html>
