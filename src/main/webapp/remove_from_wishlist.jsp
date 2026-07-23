<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, project.connection"%>
<%
    // Get product and user IDs from the form submission
    int pro_id = Integer.parseInt(request.getParameter("pro_id"));
    int user_id = Integer.parseInt(request.getParameter("user_id"));

    Connection con = null;
    PreparedStatement psDelete = null;

    try {
        con = connection.getcon();

        // Delete the product from the wishlist for the given user
        String deleteQuery = "DELETE FROM wishlist WHERE c_id = ? AND pro_id = ?";
        psDelete = con.prepareStatement(deleteQuery);
        psDelete.setInt(1, user_id);
        psDelete.setInt(2, pro_id);
        psDelete.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (psDelete != null) psDelete.close();
        if (con != null) con.close();
    }

    // Redirect back to the wishlist page
    response.sendRedirect("wish_list.jsp");
%>
