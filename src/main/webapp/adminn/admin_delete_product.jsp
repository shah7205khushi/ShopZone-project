<%@ page import="jakarta.servlet.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="java.sql.*,project.connection"%>

<%
    // Including the database connection file
    String dbURL = "jdbc:mysql://localhost:3306/shop_zone";
    String dbUsername = "root";
    String dbPassword = "";

    // Check if the user is logged in as an admin
    if (session.getAttribute("admin_name") == null) {
        out.println("<script> alert('Please login first.'); window.location.href = 'index.jsp'; </script>");
    } else { 
        // Check if the product ID is provided in the URL
        String productIdStr = request.getParameter("pro_id");
        if (productIdStr == null || productIdStr.isEmpty()) {
            out.println("<script> alert('Error in fetching product.'); window.location.href = 'product_management.jsp'; </script>");
        } else {
            try {
                // Convert the product ID to an integer
                int productId = Integer.parseInt(productIdStr);

                // Database connection
                Connection conn = connection.getcon();
                String query = "UPDATE product SET pro_status = 0 WHERE pro_id = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, productId);

                // Execute the update query
                int rowsAffected = ps.executeUpdate();
                ps.close(); // Close the PreparedStatement
                conn.close(); // Close the connection

                if (rowsAffected > 0) {
                    out.println("<script> alert('Product marked as inactive successfully.'); window.location.href = 'product_management.jsp'; </script>");
                } else {
                    out.println("<script> alert('Error in updating product status. Please try again.'); window.location.href = 'product_management.jsp'; </script>");
                }
            } catch (NumberFormatException e) {
                out.println("<script> alert('Invalid product ID.'); window.location.href = 'product_management.jsp'; </script>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script> alert('Database error: " + e.getMessage() + "'); window.location.href = 'product_management.jsp'; </script>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script> alert('Unexpected error occurred. Please try again later.'); window.location.href = 'product_management.jsp'; </script>");
            }
        }
    } 
%>
