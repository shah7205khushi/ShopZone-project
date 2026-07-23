<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page session="true"%>
<%@ page import="java.sql.*, javax.sql.*, java.util.*"%>

<%
    // Check if the user is logged in
    String deliveryPerson = (String) session.getAttribute("delivery_person_of_shop_zone");
    Integer deliveryPersonId = (Integer) session.getAttribute("dp_id");

    /* if (deliveryPerson == null || deliveryPersonId == null) {
        out.println("<script> alert('Please login first.'); window.location.href = 'dp_login.jsp'; </script>");
        return;
    } */

    // Get the order ID from the URL
    String orderIdParam = request.getParameter("see_order_details");
    if (orderIdParam == null) {
        out.println("<script> alert('Invalid order ID.'); window.location.href = 'see_order_detail_of_delivery.jsp'; </script>");
        return;
    }

    int orderId = Integer.parseInt(orderIdParam);

    // Database connection setup
    Connection conn = null;
    PreparedStatement psCheck = null, psUpdate = null;
    ResultSet rsCheck = null;

    try {
        // Assuming you have a method to get the DB connection
        conn = project.connection.getcon();

        // Check the current status of the order
        String checkQuery = "SELECT order_status FROM orders WHERE order_id = ?";
        psCheck = conn.prepareStatement(checkQuery);
        psCheck.setInt(1, orderId);
        rsCheck = psCheck.executeQuery();

        if (rsCheck.next()) {
            String orderStatus = rsCheck.getString("order_status");

            if ("delivered".equals(orderStatus)) {
                out.println("<script> alert('Order is already delivered.'); window.location.href = 'see_order_detail_of_delivery.jsp'; </script>");
            } else {
                // Update order status to 'delivered'
                String updateQuery = "UPDATE orders SET order_status = 'delivered' WHERE order_id = ?";
                psUpdate = conn.prepareStatement(updateQuery);
                psUpdate.setInt(1, orderId);
                int rowsUpdated = psUpdate.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<script> alert('Order status updated to delivered.'); window.location.href = 'see_order_detail_of_delivery.jsp'; </script>");
                } else {
                    out.println("<script> alert('Failed to update order status.'); window.location.href = 'see_order_detail_of_delivery.jsp'; </script>");
                }
            }
        } else {
            out.println("<script> alert('Invalid order ID.'); window.location.href = 'see_order_detail_of_delivery.jsp'; </script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script> alert('Database error. Please try again later.'); window.location.href = 'see_order_detail_of_delivery.jsp'; </script>");
    } finally {
        // Close resources
        try {
            if (rsCheck != null) rsCheck.close();
            if (psCheck != null) psCheck.close();
            if (psUpdate != null) psUpdate.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
