<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jakarta.servlet.http.*, project.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delivery Person's Dashboard</title>

<link rel="stylesheet" href="../bootstrap.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	user-select: none;
}

.top-navbar {
	font-size: 35px;
	font-family: "Orbitron", sans-serif;
}

.nav-link {
	width: 165px;
	height: 30px;
	margin: 1.5px;
}

.nav-link:hover {
	text-decoration: underline;
}

.activities {
	padding-top: 10px;
	padding-bottom: 10px;
	margin-bottom: 20px;
	align-items: center;
	font-size: larger;
}

.x {
	margin-left: 5px;
}

.n-i:nth-child(1) {
	margin-left: 570px;
}
</style>
</head>

<body>
	<div class="container-fluid p-0">
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

		<div class="container bg-dark activities">
			<div class="row bg-secondary">
				<div class="col-md-12 p-1 d-flex align-items-center">
					<div class="button text-center">
						<button class="n-i bg-success">
							<a href="see_order_details_of_delivery.jsp"
								class="nav-link text-light bg-success my-1">Manage Orders</a>
						</button>
					</div>
				</div>
			</div>
		</div>

		<div class="container my-5">
			<% 
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = connection.getcon();

                String query = "SELECT * FROM delivery_person WHERE dp_id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, (Integer) session.getAttribute("dp_id"));

                rs = ps.executeQuery();

                if (rs.next()) {
            %>
			<table class="table table-bordered">
				<tr>
					<th>Name</th>
					<td><%= rs.getString("name") %></td>
				</tr>
				<tr>
					<th>Email</th>
					<td><%= rs.getString("email") %></td>
				</tr>
				<tr>
					<th>Order Area 1</th>
					<td><%= rs.getString("order_area1") %></td>
				</tr>
				<tr>
					<th>Order Area 2</th>
					<td><%= rs.getString("order_area2") %></td>
				</tr>
				<tr>
					<th>Join Date</th>
					<td><%= rs.getDate("join_date") %></td>
				</tr>
				<tr>
					<th>Total Deliveries</th>
					<td><%= rs.getInt("total_delivery") %></td>
				</tr>
				<tr>
					<th>Salary</th>
					<td><%= rs.getDouble("salary") %></td>
				</tr>
			</table>
			<% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); if (ps != null) ps.close(); if (con != null) con.close(); } catch (SQLException ex) { }
            }
            %>
		</div>
	</div>
</body>

</html>