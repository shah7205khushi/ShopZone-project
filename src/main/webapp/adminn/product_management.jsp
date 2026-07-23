<%@ page import="java.sql.*, project.connection"%>

<%@ page import="java.sql.*, project.connection"%>
<%@ page session="true"%>
<%
    // Check session for admin login
    if (session.getAttribute("admin_name") == null) {
        response.sendRedirect("index.jsp");
        return;
    } 

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Use project.connection class for database connection
    	Class.forName("com.mysql.cj.jdbc.Driver");
        con = connection.getcon();

    } catch (Exception e) {
        out.println("<script> alert('Database connection error: " + e.getMessage().replace("'", "\\'") + "'); </script>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	margin: 0;
	padding: 0;
}

.insert {
	width: 30%;
	text-align: center;
	font-size: larger;
	border-radius: 30px;
	margin-left: 35%;
	margin-bottom: 20px;
}

.table img {
	width: 100px;
	height: 100px;
	object-fit: cover;
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
			<a class="n fs-1 navbar-brand text-light" href="#">Shop Zone</a>
			<div class="mr-5">
				<a href="admin_logout.jsp" class="btn btn-danger">Logout</a> <a
					href="admin_dashboard.jsp" class="btn btn-warning">Back</a>
			</div>
		</div>
	</nav>

	<!-- Product List -->
	<h1 class="text-center">List of Products</h1>
	<a href="insert_product.jsp" class="bg-info p-3 text-dark insert"
		style="display: inline-block; text-decoration: none;">Insert New
		Product</a>

	<table class="table table-bordered border-warning">
		<thead>
			<tr>
				<th>ID</th>
				<th>Title</th>
				<th>Image</th>
				<th>Description</th>
				<th>Keywords</th>
				<th>Parent Category</th>
				<th>Sub Category</th>
				<th>M.R.P.</th>
				<th>Actual Price</th>
				<th>Stock</th>
				<th>Reorder Limit</th>
				<th>Discount</th>
				<th>Status</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
			<%
                String query = "SELECT " +
                               "    p.pro_id, " +
                               "    p.title, " +
                               "    p.description, " +
                               "    p.sub_cat_id, " +
                               "    p.keywords, " +
                               "    p.show_price, " +
                               "    p.actual_price, " +
                               "    p.stock, " +
                               "    p.pro_status, " +
                               "    p.reorder_limit, " +
                               "    p.discount, " +
                               "    p.create_date, " +
                               "    p.update_date, " +
                               "    i.path, " +
                               "    sc.sub_cat_name, " +
                               "    pc.p_cat_name " +
                               "FROM " +
                               "    product p " +
                               "LEFT JOIN " +
                               "    image i ON i.img_id = ( " +
                               "        SELECT img_id " +
                               "        FROM image " +
                               "        WHERE pro_id = p.pro_id " +
                               "        ORDER BY created_at DESC " +
                               "        LIMIT 1 " +
                               "    ) " +
                               "LEFT JOIN " +
                               "    sub_category sc ON p.sub_cat_id = sc.sub_cat_id " +
                               "LEFT JOIN " +
                               "    parent_category pc ON sc.p_cat_id = pc.p_cat_id " +
                               "ORDER BY " +
                               "    p.pro_id DESC;";
                try {
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    while (rs.next()) {
            %>
			<tr>
				<td><%= rs.getInt("pro_id") %></td>
				<td><%= rs.getString("title") %></td>
				<td>
					<%
                        String imagePath = rs.getString("path");
                        if (imagePath != null && !imagePath.isEmpty()) { 
                    %> <!-- Display the image --> <img
					src="<%= request.getContextPath() + "/" + imagePath %>"
					alt="Product Image"> <% } else { %> <span>No Image</span> <% } %>
				</td>
				<td><%= rs.getString("description") %></td>
				<td><%= rs.getString("keywords") %></td>
				<td><%= rs.getString("p_cat_name") %></td>
				<td><%= rs.getString("sub_cat_name") %></td>
				<td><%= rs.getBigDecimal("show_price") %></td>
				<td><%= rs.getBigDecimal("actual_price") %></td>
				<%--                 <td><%= rs.getInt("stock") %></td> --%>
				<td
					class="<%= rs.getInt("stock") == 0 ? "table-danger" : (rs.getInt("stock") <= rs.getInt("reorder_limit") ? "table-warning" : "") %>">
					<%= rs.getInt("stock") == 0 ? "Out of Stock" : (rs.getInt("stock") <= rs.getInt("reorder_limit") ? "Low Stock: " + rs.getInt("stock") + " piece" : rs.getInt("stock") + " piece") %>
				</td>
				<%@ page import="java.math.BigDecimal"%>


				<td><%= rs.getInt("reorder_limit") %></td>
				<td><%= rs.getBigDecimal("discount").setScale(0, BigDecimal.ROUND_DOWN).toString() + " %" %></td>



				<td><%= rs.getInt("pro_status") == 1 ? "Active" : "Inactive" %></td>
				<td><a
					href="<%= rs.getInt("pro_status") == 0 ? "javascript:void(0);" : "admin_edit_product.jsp?pro_id=" + rs.getInt("pro_id") %>"
					class="btn <%= rs.getInt("pro_status") == 0 ? "btn-secondary disabled" : "btn-primary" %>"
					<%= rs.getInt("pro_status") == 0 ? "aria-disabled='true'" : "" %>>
						Edit </a></td>

				<td>
					<%
    int proStatus = rs.getInt("pro_status");
    int proId = rs.getInt("pro_id");
%> <%-- <%= proStatus == 1 ? "Active" : "Inactive" %>  --%> <a
					href="javascript:void(0);"
					class="btn btn-danger <%= proStatus == 0 ? "disabled" : "" %>"
					onclick="<%= proStatus == 1 ? "confirmDelete(" + proId + ")" : "" %>">
						Delete </a>
				</td>
			</tr>
			<%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='16' class='text-danger text-center'>Error: " + e.getMessage().replace("'", "\\'") + "</td></tr>");
                }
            %>
		</tbody>
	</table>
	<script type="text/javascript">
        function confirmDelete(pro_id) {
            if (confirm("Are you sure you want to delete this product?")) {
                // User clicked "Yes", proceed to delete the product
                window.location.href = "admin_delete_product.jsp?pro_id=" + pro_id;
            } else {
                // User clicked "No", redirect to product management page
                window.location.href = "product_management.jsp";
            }
        }
    </script>
</body>
</html>

<%
    // Close resources
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (Exception e) {
        out.println("<script> alert('Error closing resources: " + e.getMessage().replace("'", "\\'") + "'); </script>");
    }
%>