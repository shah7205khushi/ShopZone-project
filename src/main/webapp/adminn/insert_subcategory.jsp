<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.io.*, java.util.* "%>
<%@ page import="java.sql.*, project.connection"%>

<%
    // Initialize variables
    String subCategoryName = "";
    int parentCategoryId = 0;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("insert_subcategory") != null) {
            // Retrieve form values
            subCategoryName = request.getParameter("sub_category_name");
            parentCategoryId = Integer.parseInt(request.getParameter("parent_category"));

            if (subCategoryName.isEmpty() || parentCategoryId == 0) {
                out.println("<script> alert('Please fill all the fields.'); </script>");
            } else {
                // Connect to database
                Connection con = null;
                PreparedStatement pst = null;
                try {
                    // Establish connection to database
                    String url = "jdbc:mysql://localhost:3306/shop_zone";
                    String user = "root";
                    String pass = "";  // Replace with actual password
                    con = project.connection.getcon();

                    // SQL query to insert subcategory
                    String insertQuery = "INSERT INTO sub_category (sub_cat_name, p_cat_id, total_products) VALUES (?, ?, 0)";
                    pst = con.prepareStatement(insertQuery);
                    pst.setString(1, subCategoryName);
                    pst.setInt(2, parentCategoryId);
                    int result = pst.executeUpdate();

                    if (result > 0) {
                        out.println("<script> alert('Subcategory successfully inserted.'); window.location.href='admin_manage_subcategory.jsp'; </script>");
                    } else {
                        out.println("<script> alert('Subcategory insertion unsuccessful.'); window.location.href='admin_manage_subcategory.jsp'; </script>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<script> alert('Database error occurred.'); window.location.href='admin_manage_subcategory.jsp'; </script>");
                } finally {
                    if (pst != null) try { pst.close(); } catch (SQLException e) {}
                    if (con != null) try { con.close(); } catch (SQLException e) {}
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert Subcategory - Admin Dashboard</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="../bootstrap.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="bg-light">
	<div class="container mt-3">
		<h1 class="text-center">Insert Subcategory</h1>

		<!-- Form -->
		<form action="" method="POST" autocomplete="on">

			<!-- Subcategory Name -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="sub_category_name" class="form-label">Subcategory
					Name</label> <input type="text" name="sub_category_name"
					id="sub_category_name" class="form-control"
					placeholder="Enter subcategory name" required="required">
			</div>

			<!-- Parent Category Dropdown -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="parent_category" class="form-label">Select
					Parent Category</label> <select name="parent_category" id="parent_category"
					class="form-control" required="required">
					<option value="">-- Select Parent Category --</option>
					<%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
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

			<!-- Submit -->
			<div class="form-outline mb-4 w-50 m-auto">
				<input type="submit" value="Insert Subcategory"
					name="insert_subcategory" class="btn btn-info mb-3 px-3">
			</div>

		</form>
	</div>
</body>

</html>
