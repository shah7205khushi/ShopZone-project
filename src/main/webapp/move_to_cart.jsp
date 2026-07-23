<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, project.connection"%>
<%
    // Get product and user IDs from the form submission
    int pro_id = Integer.parseInt(request.getParameter("pro_id"));
    int user_id = Integer.parseInt(request.getParameter("user_id"));

    Connection con = null;
    PreparedStatement psCheck = null;
    PreparedStatement psInsert = null;
    PreparedStatement psUpdate = null;
    PreparedStatement psDeleteFromWishlist = null;
    ResultSet rs = null;

    try {
        con = connection.getcon();

        // Check if product is already in the cart for this user
        String checkQuery = "SELECT quantity FROM cart WHERE c_id = ? AND pro_id = ?";
        psCheck = con.prepareStatement(checkQuery);
        psCheck.setInt(1, user_id);
        psCheck.setInt(2, pro_id);
        rs = psCheck.executeQuery();

        if (rs.next()) {
            // If product exists, update quantity
            int currentQuantity = rs.getInt("quantity");
            String updateQuery = "UPDATE cart SET quantity = ? WHERE c_id = ? AND pro_id = ?";
            psUpdate = con.prepareStatement(updateQuery);
            psUpdate.setInt(1, currentQuantity + 1); // Increment quantity by 1
            psUpdate.setInt(2, user_id);
            psUpdate.setInt(3, pro_id);
            psUpdate.executeUpdate();
        } else {
            // If product doesn't exist, insert it into the cart
            String insertQuery = "INSERT INTO cart (c_id, pro_id, quantity) VALUES (?, ?, ?)";
            psInsert = con.prepareStatement(insertQuery);
            psInsert.setInt(1, user_id);
            psInsert.setInt(2, pro_id);
            psInsert.setInt(3, 1); // Default quantity = 1
            psInsert.executeUpdate();
        }

        // After adding to the cart, remove the item from the wishlist
        String deleteQuery = "DELETE FROM wishlist WHERE c_id = ? AND pro_id = ?";
        psDeleteFromWishlist = con.prepareStatement(deleteQuery);
        psDeleteFromWishlist.setInt(1, user_id);
        psDeleteFromWishlist.setInt(2, pro_id);
        psDeleteFromWishlist.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (psCheck != null) psCheck.close();
        if (psInsert != null) psInsert.close();
        if (psUpdate != null) psUpdate.close();
        if (psDeleteFromWishlist != null) psDeleteFromWishlist.close();
        if (con != null) con.close();
    }

    // Redirect back to the wishlist page
    response.sendRedirect("wish_list.jsp");
%>
