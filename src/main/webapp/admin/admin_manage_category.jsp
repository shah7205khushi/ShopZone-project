<%@ page import="java.sql.*, project.connection"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
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

	<div class="container" style="padding: 20px;">
		<div class="container">
			<div id="hotbox text-center">
				<div class="box">
					<div class="shop_by_cat container bg-dark text-light">
						<div class="col-md-12 text-center">
							<h1>CATEGORY MANAGEMENT</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-section">
			<form method="GET" action="admin_manage_category.jsp"
				style="display: flex; justify-content: space-between; align-items: center;">
				<div>
					<label for="parentCategory"><strong>Select Parent
							Category:</strong></label> <select id="parentCategory" name="parentCategory"
						onchange="this.form.submit()">
						<option value="">-- Select Parent Category --</option>
						<% 
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = connection.getcon();
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM parent_category");

                        while (rs.next()) {
                            int pCatId = rs.getInt("p_cat_id");
                            String pCatName = rs.getString("p_cat_name");
                %>
						<option value="<%=pCatId%>"><%=pCatName%></option>
						<%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
					</select>
				</div>

				<div>
					<a href="insert_subcategory.jsp">
						<button type="button"
							style="background-color: #007BFF; color: white; border: none; border-radius: 10px; padding: 8px 15px; margin-left: 10px; cursor: pointer;">Insert
							Subcategory</button>
					</a>
				</div>
			</form>
		</div>

		<h1 style="text-align: center; color: #555; border-radius: 10px;">Subcategories</h1>

		<table
			style="width: 100%; border-collapse: collapse; font-size: 1em; margin-top: 10px;">
			<thead>
				<tr>
					<th>Subcategory ID</th>
					<th>Subcategory Name</th>
					<th>Total Products</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
                String parentCategory = request.getParameter("parentCategory");
                if (parentCategory != null && !parentCategory.isEmpty()) {
                    try {
                        conn = connection.getcon(); // Update total_products column first
                        String updateQuery = "UPDATE sub_category sc " +
                                             "JOIN (SELECT sub_cat_id, COUNT(*) AS product_count " +
                                             "FROM product GROUP BY sub_cat_id) p " +
                                             "ON sc.sub_cat_id = p.sub_cat_id " +
                                             "SET sc.total_products = p.product_count";
                        Statement updateStmt = conn.createStatement();
                        updateStmt.executeUpdate(updateQuery); // Update total products

                        String query = "SELECT * FROM sub_category WHERE p_cat_id = ?";
                        PreparedStatement ps = conn.prepareStatement(query);
                        ps.setInt(1, Integer.parseInt(parentCategory));
                        rs = ps.executeQuery();

                        boolean hasSubcategories = false;
                        while (rs.next()) {
                            hasSubcategories = true;
                            int status = rs.getInt("status"); // Assuming 'status' column indicates if it's disabled
                            boolean isDisabled = (status == 0); // Disable if status is 0
            %>
				<tr style="background-color: #f9f9f9;">
					<td><%= rs.getInt("sub_cat_id") %></td>
					<td><%= rs.getString("sub_cat_name") %></td>
					<td><%= rs.getInt("total_products") %></td>
					<td
						style="display: flex; justify-content: space-between; align-items: center;">
						<a
						href="edit_subcategory.jsp?sub_cat_id=<%= rs.getInt("sub_cat_id") %>"
						style="text-decoration: none;">
							<button
								style="background-color: blue; color: white; border: none; padding: 5px 10px; cursor: pointer;">Edit</button>
					</a> <a
						href="delete_subcategory.jsp?sub_cat_id=<%= rs.getInt("sub_cat_id") %>"
						style="text-decoration: none;">
							<button
								style="background-color: red; color: white; border: none; padding: 5px 10px; cursor: pointer;"
								<%= isDisabled ? " disabled" : "" %>>Delete</button>
					</a>
					</td>
				</tr>
				<%
                        }
                        if (!hasSubcategories) {
            %>
				<tr style="background-color: #f9f9f9;">
					<td colspan="5" class="empty">No subcategories available for
						this parent category.</td>
				</tr>
				<%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (conn != null) conn.close();
                    }
                } else {
            %>
				<tr>
					<td colspan="5" class="empty">Please select a parent category
						to view subcategories.</td>
				</tr>
				<%
                }
            %>
			</tbody>
		</table>
	</div>
</body>
</html>
