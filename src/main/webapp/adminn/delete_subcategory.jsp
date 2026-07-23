<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,project.*"%>

<%
    // Check if admin is logged in
    if (session == null || session.getAttribute("admin_name") == null) {
        out.println("<script> alert('Please login first.'); window.location.href = 'admin_login.jsp'; </script>");
        return;
    }

    // Check if sub_cat_id is provided
    String subCatIdParam = request.getParameter("sub_cat_id");
    if (subCatIdParam == null || subCatIdParam.isEmpty()) {
        out.println("<script> alert('Error in fetching subcategory.'); window.location.href = 'admin_manage_category.jsp'; </script>");
        return;
    }

    int subCatId = Integer.parseInt(subCatIdParam);

    Connection conn = null;
    PreparedStatement softDeleteProductsStmt = null;
    PreparedStatement softDeleteSubCategoryStmt = null;
    PreparedStatement checkParentCategoryStmt = null;
    PreparedStatement checkSiblingSubcategoriesStmt = null;
    PreparedStatement subCategoryStatusStmt = null;
    boolean isDisabled = false;  // Initialize the variable

    try {
        // Establish connection
        conn = connection.getcon();

        // Step 1: Soft delete all products associated with the subcategory (set status = 0 or DELETE products)
        String softDeleteProductsQuery = "UPDATE product SET pro_status = 0 WHERE sub_cat_id = ?";
        softDeleteProductsStmt = conn.prepareStatement(softDeleteProductsQuery);
        softDeleteProductsStmt.setInt(1, subCatId);
        int productsUpdated = softDeleteProductsStmt.executeUpdate(); // Rows affected by soft deleting products

        // Step 2: Fetch the parent category and check if it exists
        String checkParentCategoryQuery = "SELECT p_cat_id FROM sub_category WHERE sub_cat_id = ?";
        checkParentCategoryStmt = conn.prepareStatement(checkParentCategoryQuery);
        checkParentCategoryStmt.setInt(1, subCatId);
        ResultSet parentCategoryRs = checkParentCategoryStmt.executeQuery();

        int pCatId = -1;  // Default value if no result found
        if (parentCategoryRs.next()) {
            pCatId = parentCategoryRs.getInt("p_cat_id");
        }

        // Check if the subcategory exists in the database
        if (pCatId == -1) {
            out.println("<script>alert('Parent category not found for this subcategory.'); window.location='admin_manage_category.jsp';</script>");
            return;
        }

        // Step 3: Check if there are other subcategories under the same parent category
        String checkSiblingSubcategoriesQuery = "SELECT COUNT(*) FROM sub_category WHERE p_cat_id = ? AND sub_cat_id != ?";
        checkSiblingSubcategoriesStmt = conn.prepareStatement(checkSiblingSubcategoriesQuery);
        checkSiblingSubcategoriesStmt.setInt(1, pCatId);
        checkSiblingSubcategoriesStmt.setInt(2, subCatId);
        ResultSet siblingRs = checkSiblingSubcategoriesStmt.executeQuery();

        int siblingSubcategoriesCount = 0;
        if (siblingRs.next()) {
            siblingSubcategoriesCount = siblingRs.getInt(1);
        }

        // Fetch the status of the subcategory
        String subCategoryStatusQuery = "SELECT status FROM sub_category WHERE sub_cat_id = ?";
        subCategoryStatusStmt = conn.prepareStatement(subCategoryStatusQuery);
        subCategoryStatusStmt.setInt(1, subCatId);
        ResultSet statusRs = subCategoryStatusStmt.executeQuery();

        int status = -1; // Default value if no result found
        if (statusRs.next()) {
            status = statusRs.getInt("status");
        }

        // Check if status is 0 (inactive), then disable the delete button
        isDisabled = (status == 0);

        // Step 4: Soft delete the subcategory if there are other subcategories
        if (siblingSubcategoriesCount > 0) {
            // Other subcategories exist under the same parent, soft delete the subcategory
            String softDeleteSubCategoryQuery = "UPDATE sub_category SET status = 0 WHERE sub_cat_id = ?";
            softDeleteSubCategoryStmt = conn.prepareStatement(softDeleteSubCategoryQuery);
            softDeleteSubCategoryStmt.setInt(1, subCatId);
            int subCategoryUpdated = softDeleteSubCategoryStmt.executeUpdate();

            if (subCategoryUpdated > 0) {
                out.println("<script>alert('Subcategory and associated products soft deleted successfully!'); window.location='admin_manage_category.jsp';</script>");
            } else {
                out.println("<script>alert('Error in soft deleting subcategory.'); window.location='admin_manage_category.jsp';</script>");
            }
        } else {
            // This is the last subcategory under this parent category
            out.println("<script>alert('Cannot soft delete this subcategory. It is the last subcategory under its parent category.'); window.location='admin_manage_category.jsp';</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script> alert('Error in soft deleting subcategory and products: " + e.getMessage() + "'); window.location.href = 'admin_manage_category.jsp'; </script>");
    } finally {
        // Close resources
        if (softDeleteProductsStmt != null) try { softDeleteProductsStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (softDeleteSubCategoryStmt != null) try { softDeleteSubCategoryStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (checkParentCategoryStmt != null) try { checkParentCategoryStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (checkSiblingSubcategoriesStmt != null) try { checkSiblingSubcategoriesStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (subCategoryStatusStmt != null) try { subCategoryStatusStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
