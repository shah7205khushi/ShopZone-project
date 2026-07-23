<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.connection"%>
<%
    // Check if the user is logged in as a delivery person
    String deliveryPerson = (String) session.getAttribute("delivery_person_of_shop_zone");
    Integer deliveryPersonId = (Integer) session.getAttribute("dp_id"); // Cast to Integer

    if (deliveryPerson == null || deliveryPersonId == null) {
        response.sendRedirect("dp_login.jsp");
        return;
    }
%>

<%  
    // Check if order details are provided in the request
    String seeOrderDetails = request.getParameter("see_order_details");
    String custId = request.getParameter("cust_id");

    if (seeOrderDetails == null || custId == null) {
        response.sendRedirect("see_order_detail_of_delivery.jsp");
        return;
    }

    // Database connection setup
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    ResultSet orderLineRs = null;
    ResultSet productRs = null;

    String orderDate = "";
    String shippingAddress = "";
    String pincode = "";
    double amount = 0;
    int orderId = 0;

    String productQuery = "SELECT * FROM product WHERE pro_id = ?"; // Declare productQuery here

    try {
        // Database connection setup
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = project.connection.getcon(); // Modify the DB URL, username, and password as per your setup

        orderId = Integer.parseInt(seeOrderDetails);

        // Fetch order details
        String orderQuery = "SELECT * FROM orders WHERE order_id = ?";
        pst = con.prepareStatement(orderQuery);
        pst.setInt(1, orderId);
        rs = pst.executeQuery();

        if (rs.next()) {
            orderDate = rs.getString("order_date");
            shippingAddress = rs.getString("shipping_address");
            pincode = rs.getString("pincode");
        }

        // Fetch order line items
        String orderLineQuery = "SELECT * FROM order_line_item WHERE order_id = ?";
        pst = con.prepareStatement(orderLineQuery);
        pst.setInt(1, orderId);
        orderLineRs = pst.executeQuery();

        // Fetch product details and calculate total amount
        while (orderLineRs.next()) {
            int productId = orderLineRs.getInt("pro_id");

            // Fetch product details using the productQuery
            pst = con.prepareStatement(productQuery);
            pst.setInt(1, productId);
            productRs = pst.executeQuery();

            while (productRs.next()) {
                double productPrice = productRs.getDouble("show_price");
                amount += productPrice; // Calculate the total amount
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (orderLineRs != null) orderLineRs.close();
            if (productRs != null) productRs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SHOP ZONE</title>
<link rel="stylesheet" href="../bootstrap.css">
<style>
body {
	margin: 0;
	padding: 0;
	overflow: none;
}

.top-navbar {
	font-size: 35px;
	font-family: "Orbitron", sans-serif;
	font-optical-sizing: auto;
	font-weight: 300;
	font-style: normal;
}

.top-navbar {
	font-family: "Noto Serif Display", serif;
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
	font-variation-settings: "wdth" 100;
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
	border: solid 1px #e6e6e6;
	padding: 20px;
	box-shadow: 0 1ox 5px rgba(0, 0, 0, 0.1);
}

#advantage {
	text-align: center;
	display: flex;
	justify-content: space-between;
}

#advantage .box .icon {
	position: absolute;
	font-size: 120px;
	width: 100%;
	text-align: center;
	top: -20px;
	height: 100%;
	float: left;
	color: #eeeeee;
	transition: all 0.2s ease-out;
	z-index: 1;
	box-sizing: border-box;
}

#advantages .box h3 {
	position: relative;
	margin: 0px 0px 20px;
	font-weight: 300;
	text-transform: uppercase;
	z-index: 2;
}

#advantages .box h3 a:hover {
	text-decoration: none;
}

#advantages .box p {
	position: relative;
	color: #555555;
	z-index: 2;
}

#hotbox {
	text-transform: uppercase;
	font-size: 36px;
	color: #4993e4;
	font-weight: 100;
	text-align: center;
	/* margin-top: 20px; */
}

.shop_by_cat {
	padding: 20px;
	border-radius: 35px;
	font-family: "Noto Serif Display", serif;
	font-optical-sizing: auto;
	font-weight: 700;
	font-style: normal;
	font-variation-settings: "wdth" 100;
	color: aqua;
}

.custom-hr {
	border: 7px solid red;
	width: 100%;
	/* Adjust the width as needed */
}

small {
	font-size: large;
}

.nav-item:hover {
	/* border: 1px solid brown; */
	border-bottom: 1px solid black;
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

.n {
	margin-left: 5px;
	margin-right: 5px;
	font-size: large;
}

img {
	width: 200px;
	height: 250px;
	object-fit: contain;
}

.dash {
	text-align: center;
}

.a, .b, .c, .d {
	margin-right: 3px;
	width: 200px;
}

.c {
	width: 450px;
	word-wrap: break-word;
}

.d {
	margin-right: 3px;
	width: 200px;
}

.f {
	margin-right: 3px;
	width: 250px;
}

.x {
	margin-right: 0%;
	margin-left: 0%;
	display: flex;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container bg-dark">
			<a class="navbar-brand text-light" href="#">SHOP ZONE</a>
		</div>
	</nav>

	<div class="bg-light">
		<h2 class="text-center p-2">
			<%
                // Check if dp_name exists in the session and is not null
                String deliveryPersonName = (String) session.getAttribute("dp_name");
                if (deliveryPersonName != null && !deliveryPersonName.isEmpty()) {
                    out.print("Welcome " + deliveryPersonName);
                } else {
                    out.print("Welcome delivery person");
                }
            %>
		</h2>
	</div>

	<div class="container">
		<div id="hotbox">
			<div class="box">
				<div class="shop_by_cat container bg-dark text-light">
					<div class="col-md-12">
						<h1>ORDER details</h1>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-2 border border-secondary rounded">
				<p class="mb-0 text-secondary">Customer Id:</p>
				<h4><%= custId %></h4>
			</div>
			<div class="col-3 border border-secondary rounded">
				<p class="mb-0 text-secondary">Order Id:</p>
				<h4><%= orderId %></h4>
			</div>
			<div class="col-3 border border-secondary rounded">
				<p class="mb-0 text-secondary">Pincode:</p>
				<h4><%= pincode %></h4>
			</div>
			<div class="col-3 border border-secondary rounded">
				<p class="mb-0 text-secondary">Shipping Address:</p>
				<h4><%= shippingAddress %></h4>
			</div>
			<div class="col-3 border border-secondary rounded">
				<p class="mb-0 text-secondary">Total Amount:</p>
				<h4>
					Rs.
					<%= amount %>
					/-
				</h4>
			</div>
		</div>

		<table class="table table-bordered border-warning mt-5">
			<thead>
				<tr>
					<th>Product Id</th>
					<th>Product Title</th>
					<th>Description</th>
					<th>Price</th>
				</tr>
			</thead>
			<tbody>
				<%
                    // Fetch product details again for each order line item
                    orderLineRs.beforeFirst(); // Rewind the result set to start from the beginning
                    while (orderLineRs.next()) {
                        int productId = orderLineRs.getInt("pro_id");

                        // Fetch product details using the productQuery
                        pst = con.prepareStatement(productQuery);
                        pst.setInt(1, productId);
                        productRs = pst.executeQuery();

                        while (productRs.next()) {
                            String productTitle = productRs.getString("title");
                            String productDescription = productRs.getString("description");
                            double productPrice = productRs.getDouble("show_price");
                %>
				<tr>
					<td><%= productId %></td>
					<td><%= productTitle %></td>
					<td><%= productDescription %></td>
					<td><%= productPrice %> /-</td>
				</tr>
				<% 
                        }
                    }
                %>
			</tbody>
		</table>
	</div>

	<!-- footer -->
	<div class="container-fluid bg-dark mt-3 mb-0">
		<h1 class="text-dark" style="margin-bottom: 0%; height: 200px;">#</h1>
	</div>

</body>
</html>

<%
    // Close database resources in the finally block to ensure cleanup
    try {
        if (rs != null) rs.close();
        if (orderLineRs != null) orderLineRs.close();
        if (productRs != null) productRs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
