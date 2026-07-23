<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="project.connection"%>

<%
    // Retrieve the order ID and the new order status
    String orderId = request.getParameter("order_id");
    String status = request.getParameter("status");

    // Database connection
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        // Initialize database connection
        conn = connection.getcon();

        // Update query to change the order status
        String updateQuery = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        ps = conn.prepareStatement(updateQuery);
        ps.setString(1, status);
        ps.setInt(2, Integer.parseInt(orderId));

        int rowsUpdated = ps.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("order_management.jsp"); // Redirect to the dashboard to refresh the page
        } else {
            out.println("<h2 class='text-danger'>Error updating order status.</h2>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2 class='text-danger'>Error: " + e.getMessage() + "</h2>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
