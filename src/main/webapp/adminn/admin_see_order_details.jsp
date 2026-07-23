<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page session="true"%>

<%
    // Check if the admin is logged in
    String adminName = (String) session.getAttribute("admin_name");

    if (adminName == null) {
        // Redirect if not logged in
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>shop zone</title>
<link rel="stylesheet" href="../css/bootstrap.css">
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
	width: 245px;
}

.c {
	width: 560px;
	word-wrap: break-word;
}

.x {
	margin-right: 0%;
	margin-left: 0%;
	display: flex;
	/* display: c\ ; */
}
</style>
</head>

<body>

	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container bg-dark ">
			<a class="top-navbar navbar-brand text-light " href="#">shop zone</a>
		</div>
	</nav>

	<div class="bg-light">
		<h2 class="text-center p-2">
			<%
                if (session.getAttribute("admin_name") != null) {
                    out.print("Welcome Admin " + session.getAttribute("admin_name"));
                } else {
                    out.print("Admin Dashboard");
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
	</div>

	<%
        String seeOrderDetails = request.getParameter("see_order_details");
        String custId = request.getParameter("c_id");

        if (seeOrderDetails == null || custId == null) {
            out.print("<script> alert('Error in fetching order details.'); window.location.href = 'admin_see_details_of_cust_order.jsp'; </script>");
            return;
        }

        int fetchOrderId = Integer.parseInt(seeOrderDetails);
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop_zone", "root", "jinal@NEW123");

            String query = "SELECT * FROM orders WHERE order_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, fetchOrderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                String orderDate = rs.getString("order_date");
                double amt = rs.getDouble("amount");
                String ship = rs.getString("shipping_address");
                String pincode = rs.getString("pincode");

                out.print("<div class='row'>");
                out.print("<div class='col-3 border border-secondary rounded a'>");
                out.print("<p class='mb-0 text-secondary'>Customer Id :</p>");
                out.print("<h4>" + custId + "</h4>");
                out.print("</div>");

                out.print("<div class='col-3 border border-secondary b rounded'>");
                out.print("<p class='mb-0 text-secondary'>Order Id :</p>");
                out.print("<h4>" + fetchOrderId + "</h4>");
                out.print("</div>");

                out.print("<div class='col-3 border border-secondary d rounded'>");
                out.print("<p class='mb-0 text-secondary'>Pincode :</p>");
                out.print("<h4>" + pincode + "</h4>");
                out.print("</div>");

                out.print("<div class='col-3 border border-secondary c rounded'>");
                out.print("<p class='mb-0 text-secondary'>Shipping Address :</p>");
                out.print("<h4>" + ship + "</h4>");
                out.print("</div>");
                out.print("</div>");
            }

            query = "SELECT * FROM order_line_items WHERE order_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, fetchOrderId);
            rs = ps.executeQuery();

            out.print("<table class='table table-bordered border-warning mt-5'><thead>");
            out.print("<tr><th>Product Title</th><th>Product Image</th><th>Description</th><th>Price</th></tr></thead><tbody>");
            while (rs.next()) {
                int productId = rs.getInt("pro_id");
                query = "SELECT * FROM products WHERE product_id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, productId);
                ResultSet productRs = ps.executeQuery();

                while (productRs.next()) {
                    String productTitle = productRs.getString("title");
                    String productDescription = productRs.getString("product_description");
                 /*    String productImage = productRs.getString("product_image"); */
                    double productPrice = productRs.getDouble("product_price");

                    out.print("<tr>");
                    out.print("<td>" + productTitle + "</td>");
                  /*   out.print("<td><img class='cart_image' src='product_images/" + productImage + "' alt='product_image'></td>");
                   */  out.print("<td>" + productDescription + "</td>");
                    out.print("<td>" + productPrice + "/-</td>");
                    out.print("</tr>");
                }
                productRs.close();
            }
            out.print("</tbody></table>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>

	<div class="container-fluid bg-dark mt-3 mb-0">
		<h1 class="text-dark" style="margin-bottom: 0%; height: 200px;">#</h1>
	</div>

</body>

</html>