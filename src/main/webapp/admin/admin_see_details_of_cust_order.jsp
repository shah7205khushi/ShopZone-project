<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.sql.*, javax.sql.*,project.*, javax.naming.*, jakarta.servlet.*, jakarta.servlet.http.*, java.io.*"%>

<%
    // Get order details and customer ID
    String seeOrderDetails = request.getParameter("see_order_details");
    String custId = request.getParameter("cust_id"); 
    String custname = request.getParameter("username");

    if (seeOrderDetails == null || custname == null) {
        out.println("<p>Error: Missing order or customer details.</p>");
        return;
    }

    int orderId = Integer.parseInt(seeOrderDetails);

    // Database connection setup
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String orderDate = null;
    double amount = 0;
    String shippingAddress = null;
    String pincode = null;

    try {
        con = connection.getcon();
        // Fetch order details
        String query = "SELECT * FROM orders WHERE order_id = ?";
        stmt = con.prepareStatement(query);
        stmt.setInt(1, orderId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            orderDate = rs.getString("order_date");
            shippingAddress = rs.getString("shipping_address");
            pincode = rs.getString("pincode");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
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

	<!-- Order Details -->
	<div class="container mt-4">
		<div class="container my-4">
			<div>
				<div class="shop_by_cat container bg-dark text-light py-3">
					<div class="col-md-12 text-center">
						<h1>Order details</h1>
					</div>
				</div>
			</div>


			<div class="row justify-content-center mt-4">
				<div class="col-3 border border-secondary rounded a">
					<p class="mb-0 text-secondary">Customer Id:</p>
					<h4><%= custId %></h4>
				</div>
				<div class="col-3 border border-secondary b rounded">
					<p class="mb-0 text-secondary">Order Id:</p>
					<h4><%= seeOrderDetails %></h4>
				</div>
				<div class="col-3 border border-secondary d rounded">
					<p class="mb-0 text-secondary">Pincode:</p>
					<h4><%= pincode %></h4>
				</div>
				<div class="col-3 border border-secondary c rounded">
					<p class="mb-0 text-secondary">Shipping Address:</p>
					<h4><%= shippingAddress %></h4>
				</div>
			</div>

			<!-- Products Table -->
			<table class="table table-bordered border-warning mt-5">
				<thead>
					<tr>

						<th>Product Title</th>
						<th>Product Image</th>
						<th>Description</th>
						<th>Price</th>
					</tr>
				</thead>
				<tbody>
					<%
    con = connection.getcon();
    try {
        String productQuery = "SELECT * FROM order_line_item WHERE order_id = ?";
        stmt = con.prepareStatement(productQuery);
        stmt.setInt(1, orderId);
        rs = stmt.executeQuery();

        while (rs.next()) {
            int productId = rs.getInt("pro_id");

            // Corrected SQL Query to fetch the latest image for each product
            String productSelectQuery = "SELECT p.title, p.description, p.show_price, i.path "
                    + "FROM product p "
                    + "LEFT JOIN ("
                    + "    SELECT path, pro_id "
                    + "    FROM image "
                    + "    WHERE img_id IN ("
                    + "        SELECT MAX(img_id) "
                    + "        FROM image "
                    + "        GROUP BY pro_id"
                    + "    )"
                    + ") i ON p.pro_id = i.pro_id "
                    + "WHERE p.pro_id = ?";
            
            PreparedStatement productStmt = con.prepareStatement(productSelectQuery);
            productStmt.setInt(1, productId);
            ResultSet productRs = productStmt.executeQuery();

            if (productRs.next()) {
                String productTitle = productRs.getString("title");
                String productDescription = productRs.getString("description");
                double productPrice = productRs.getDouble("show_price");
                String imagePath = productRs.getString("path");

                // If the image path is null or empty, use a default image
                if (imagePath == null || imagePath.isEmpty()) {
                    imagePath = "default-image.jpg"; // Replace with your default image path
                }

                // Display the product details
        %>
					<tr>
						<td><%= productTitle %></td>
						<td>
							<%
            // Check if imagePath is available and not empty
            if (imagePath != null && !imagePath.isEmpty()) { 
        %> <!-- Display the product image with proper width and height -->
							<img src="<%= request.getContextPath() + "/" + imagePath %>"
							alt="Product Image" width="100" height="100"> <% } else { %>
							<!-- If no image, display a placeholder text or a default image -->
							<span>No Image</span> <% } %>
						</td>
						<td><%= productDescription %></td>
						<td><%= productPrice %>/-</td>
					</tr>

					<%
            }
            productRs.close();
            productStmt.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
    }
%>


				</tbody>
			</table>

		</div>
</body>
</html>
