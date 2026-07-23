

<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>
<%
    Connection con = null;
    PreparedStatement ps = null;

    // Get the product ID from the query string
    String proId = request.getParameter("pro_id");

    if (proId != null) {
        try {
            // Assuming you have a connection provider class
            con = project.connection.getcon();
            int productId = Integer.parseInt(proId);

            // Query to delete the product from the cart
            String deleteQuery = "DELETE FROM cart WHERE pro_id = ? AND c_id = ?";
            ps = con.prepareStatement(deleteQuery);
            ps.setInt(1, productId);
            ps.setInt(2, Integer.parseInt((String) session.getAttribute("user_id")));  // Assuming user_id is in session
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // Product was successfully removed from the cart
                // You can set a message here or redirect to the cart page
                out.println("<script> window.location.href='cust_cart.jsp';</script>");
            } else {
                // Handle case where the product is not found in the cart
                out.println("<script> window.location.href='cust_cart.jsp';</script>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script> window.location.href='cust_cart.jsp';</script>");
        } finally {
            // Close resources
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    // Redirect back to the cart page after removal
    response.sendRedirect("cust_cart.jsp");
%>
