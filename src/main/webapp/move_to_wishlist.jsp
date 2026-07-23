<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
    // Get the product ID from the request
    String productId = request.getParameter("pro_id");
    String customerId = (String) session.getAttribute("user_id"); // Assuming customer ID is stored in session

    // Database connection variables
    Connection con = null;
    PreparedStatement psRemoveFromCart = null;
    PreparedStatement psAddToWishlist = null;
    PreparedStatement psCheckWishlist = null;
    ResultSet rsCheckWishlist = null;

    try {
        // Validate input
        if (productId != null && customerId != null) {
            // Establish a connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = project.connection.getcon();

            // Step 1: Remove the product from the cart
            String removeCartQuery = "DELETE FROM cart WHERE c_id = ? AND pro_id = ?";
            psRemoveFromCart = con.prepareStatement(removeCartQuery);
            psRemoveFromCart.setString(1, customerId);
            psRemoveFromCart.setString(2, productId);
            psRemoveFromCart.executeUpdate();

            // Step 2: Check if the product already exists in the wishlist
            String checkWishlistQuery = "SELECT * FROM wishlist WHERE c_id = ? AND pro_id = ?";
            psCheckWishlist = con.prepareStatement(checkWishlistQuery);
            psCheckWishlist.setString(1, customerId);
            psCheckWishlist.setString(2, productId);
            rsCheckWishlist = psCheckWishlist.executeQuery();

            if (rsCheckWishlist.next()) {
                // Product already exists in the wishlist
                out.println("<script>alert('Item already exists in your wishlist.'); window.location.href='cust_cart.jsp';</script>");
            } else {
                // Step 3: Add the product to the wishlist
                String addToWishlistQuery = "INSERT INTO wishlist (c_id, pro_id) VALUES (?, ?)";
                psAddToWishlist = con.prepareStatement(addToWishlistQuery);
                psAddToWishlist.setString(1, customerId);
                psAddToWishlist.setString(2, productId);
                psAddToWishlist.executeUpdate();

                // Redirect back to the cart page with a success message
                out.println("<script>alert('Item moved to wishlist.'); window.location.href='cust_cart.jsp';</script>");
            }
        } else {
            // Redirect with an error message if productId or customerId is missing
            out.println("<script>alert('Please try again. Move to wishlist failed.'); window.location.href='cust_cart.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Redirect with an error message in case of failure
        out.println("<script>alert('Please try again. Move to wishlist failed.'); window.location.href='cust_cart.jsp';</script>");
    } finally {
        try {
            if (rsCheckWishlist != null) rsCheckWishlist.close();
            if (psCheckWishlist != null) psCheckWishlist.close();
            if (psRemoveFromCart != null) psRemoveFromCart.close();
            if (psAddToWishlist != null) psAddToWishlist.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
