<%@ page import="java.sql.*, project.connection"%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.DataSource"%>

<%
   /*  session = request.getSession(false);
    if (session == null || session.getAttribute("admin_name") == null) {
        out.println("<script> alert('Please login first.'); window.location.href = 'admin_login.jsp'; </script>");
        return;
    } */
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
							<h1>DELIVERY MANAGEMENT</h1>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Insert Button -->
		<div>
			<a href="insert_delivery_person.jsp"
				class="bg-info p-3 py-2 border-0 mx-3 text-dark mb-4 insert"
				style="display: inline-block; text-decoration: none;"> Insert
				New Delivery Person </a>
		</div>

		<!-- Delivery Persons Table -->
		<div class="container">
			<table class="table table-bordered border-warning">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Area 1</th>
						<th>Area 2</th>
						<th>Join Date</th>
						<th>Total Deliveries</th>
						<th>Salary</th>
						<th>See Order Details</th>
					</tr>
				</thead>
				<tbody>
					<%
                        Connection con = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Load MySQL JDBC Driver
                            Class.forName("com.mysql.cj.jdbc.Driver");

                            // Database connection
                            String dbURL = "jdbc:mysql://localhost:3306/shop_zone";
                            String dbUser = "root";
                            String dbPassword = "";
                            con = connection.getcon();

                            String query = "SELECT dp_id, name, email, order_area1, order_area2, join_date, total_delivery, salary FROM delivery_person ORDER BY dp_id DESC";
                            stmt = con.prepareStatement(query);
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                                int dpId = rs.getInt("dp_id");
                                String name = rs.getString("name");
                                String email = rs.getString("email");
                                String area1 = rs.getString("order_area1");
                                String area2 = rs.getString("order_area2");
                                Date joinDate = rs.getDate("join_date");
                                int totalDelivery = rs.getInt("total_delivery");
                                double salary = rs.getDouble("salary");
                    %>
					<tr>
						<td><%= dpId %></td>
						<td><%= name %></td>
						<td><%= email %></td>
						<td><%= area1 %></td>
						<td><%= area2 %></td>
						<td><%= joinDate %></td>
						<td><%= totalDelivery %></td>
						<td><%= salary %></td>
						<td><a
							href="admin_see_order_details_delivery_person.jsp?dp_id=<%= dpId %>"
							class="btn btn-secondary col-12 mb-2"> See Order Details </a></td>
					</tr>
					<%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                        } finally {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (con != null) con.close();
                        }
                    %>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Footer -->
	<div class="container-fluid bg-dark mt-3 mb-0">
		<h1 class="text-dark" style="margin-bottom: 0%; height: 200px;">#</h1>
	</div>
</body>
</html>
