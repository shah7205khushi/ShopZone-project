<%@ page
	import="java.sql.*, java.util.*, java.io.*, jakarta.servlet.http.*, jakarta.servlet.annotation.MultipartConfig"%>
<%@ page import="project.connection"%>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>

<% 
if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("insert_product") != null) {
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String about = request.getParameter("about");  // Added about field
    String keywords = request.getParameter("keywords");
    String parentCategory = request.getParameter("parent_category");
    String subCategory = request.getParameter("sub_category");
    String showPrice = request.getParameter("show_price");
    String actualPrice = request.getParameter("actual_price");
    String stock = request.getParameter("stock");
    String discount = request.getParameter("discount");
    int reorderLimit = 3;

    try {
        Connection conn = connection.getcon();

        // Insert product details into product table
        String productQuery = "INSERT INTO product (title, description, about, keywords, sub_cat_id, show_price, actual_price, stock, reorder_limit, discount, create_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE())";
        PreparedStatement productStmt = conn.prepareStatement(productQuery, Statement.RETURN_GENERATED_KEYS);
        productStmt.setString(1, title);
        productStmt.setString(2, description);
        productStmt.setString(3, about);  // Set 'about' value here
        productStmt.setString(4, keywords);
        productStmt.setInt(5, Integer.parseInt(subCategory));
        productStmt.setBigDecimal(6, new java.math.BigDecimal(showPrice));
        productStmt.setBigDecimal(7, new java.math.BigDecimal(actualPrice));
        productStmt.setInt(8, Integer.parseInt(stock));
        productStmt.setInt(9, reorderLimit);
        if (discount != null && !discount.trim().isEmpty()) {
            productStmt.setBigDecimal(10, new java.math.BigDecimal(discount));
        } else {
            productStmt.setNull(10, java.sql.Types.DECIMAL);
        }
        productStmt.executeUpdate();

        conn.close();

        // Redirect to admin dashboard
        response.sendRedirect("admin_dashboard.jsp");
    } catch (Exception e) {
        e.printStackTrace(); // Check server logs for details
        String errorMessage = "Error: " + e.getClass().getName() + " - " + e.getMessage();
        out.println("<script>alert('" + errorMessage.replace("'", "\\'") + "'); window.location.href='insert_product.jsp';</script>");
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert Product</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<script>
        function updateSubcategories(parentCategoryId) {
            const subCategoryDropdown = document.getElementById("sub_category");
            const subCategoryOptions = subCategoryDropdown.querySelectorAll("option");

            subCategoryDropdown.disabled = true;
            subCategoryOptions.forEach(option => {
                if (option.dataset.parent == parentCategoryId) {
                    option.style.display = "block";
                } else {
                    option.style.display = "none";
                }
            });

            subCategoryDropdown.value = ""; // Reset selection
            if (parentCategoryId) {
                subCategoryDropdown.disabled = false;
            }
        }
    </script>
<style>
.form-container {
	margin-top: 20px;
	margin-bottom: 20px;
}
</style>
</head>
<body class="bg-light">
	<div class="container mt-3">
		<h1 class="text-center">Insert New Product</h1>
		<form action="insert_product.jsp" method="post" autocomplete="off">
			<!-- Title -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="title" class="form-label">Title:</label> <input
					type="text" name="title" id="title" class="form-control"
					placeholder="Enter Title" required>
			</div>

			<!-- Description -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="description" class="form-label">Description:</label>
				<textarea name="description" id="description" class="form-control"
					placeholder="Enter Description" required></textarea>
			</div>

			<!-- About -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="about" class="form-label">About:</label>
				<textarea name="about" id="about" class="form-control"
					placeholder="Enter About" required></textarea>
			</div>

			<!-- Keywords -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="keywords" class="form-label">Keywords:</label> <input
					type="text" name="keywords" id="keywords" class="form-control"
					placeholder="Enter Keywords" required>
			</div>

			<!-- Parent Category -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="parent_category" class="form-label">Parent
					Category:</label> <select name="parent_category" id="parent_category"
					class="form-control" onchange="updateSubcategories(this.value)"
					required>
					<option value="" disabled selected>Select Parent Category</option>
					<%
                    try (Connection conn = connection.getcon();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM parent_category")) {
                        while (rs.next()) {
                            out.println("<option value='" + rs.getInt("p_cat_id") + "'>" + rs.getString("p_cat_name") + "</option>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<script>alert('Error loading parent categories: " + e.getMessage().replace("'", "\\'") + "');</script>");
                    }
                    %>
				</select>
			</div>

			<!-- Subcategory -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="sub_category" class="form-label">Sub Category:</label> <select
					name="sub_category" id="sub_category" class="form-control" disabled
					required>
					<option value="" disabled selected>Select Sub Category</option>
					<%
                    try (Connection conn = connection.getcon();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM sub_category")) {
                        while (rs.next()) {
                            out.println("<option value='" + rs.getInt("sub_cat_id") + "' data-parent='" + rs.getInt("p_cat_id") + "'>" + rs.getString("sub_cat_name") + "</option>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<script>alert('Error loading subcategories: " + e.getMessage().replace("'", "\\'") + "');</script>");
                    }
                    %>
				</select>
			</div>

			<!-- Show Price -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="show_price" class="form-label">Show Price:</label> <input
					type="number" name="show_price" id="show_price"
					class="form-control" placeholder="Enter Show Price" required>
			</div>

			<!-- Actual Price -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="actual_price" class="form-label">Actual Price:</label> <input
					type="number" name="actual_price" id="actual_price"
					class="form-control" placeholder="Enter Actual Price" required>
			</div>

			<!-- Stock -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="stock" class="form-label">Stock:</label> <input
					type="number" name="stock" id="stock" class="form-control"
					placeholder="Enter Stock Quantity" required>
			</div>

			<!-- Discount -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="discount" class="form-label">Discount:</label> <input
					type="number" name="discount" id="discount" class="form-control"
					placeholder="Enter Discount Percentage (Optional)">
			</div>
			<!-- Image Upload -->
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="product_image" class="form-label">Product Image:</label>
				<input type="file" name="product_image" id="product_image"
					class="form-control" accept="image/*" required>
			</div>

			<!-- Submit Button -->
			<div class="form-outline mb-4 w-50 m-auto text-center">
				<button type="submit" name="insert_product"
					class="btn btn-success btn-lg">Insert Product</button>
			</div>
		</form>
	</div>
</body>
</html>
