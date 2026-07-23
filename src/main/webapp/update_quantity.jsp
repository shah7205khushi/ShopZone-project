<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String proId = request.getParameter("pro_id");
    String updateParam = request.getParameter("update");

    if (proId != null && updateParam != null) {
        try {
            // Assuming you have a connection provider class
            con = project.connection.getcon();
            int pro_id = Integer.parseInt(proId);
            int update = Integer.parseInt(updateParam);

            // Query to fetch current quantity of the product in the cart
            String fetchQuery = "SELECT quantity FROM cart WHERE pro_id = ? AND c_id = ?";
            ps = con.prepareStatement(fetchQuery);
            ps.setInt(1, pro_id);
            ps.setInt(2, Integer.parseInt((String) session.getAttribute("user_id")));  // Assuming user_id is in session
            rs = ps.executeQuery();

            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");

                // Calculate new quantity
                int newQuantity = update == 1 ? currentQuantity + 1 : currentQuantity - 1;

                // If the new quantity is zero, delete the product from the cart
                if (newQuantity <= 0) {
                    String deleteQuery = "DELETE FROM cart WHERE pro_id = ? AND c_id = ?";
                    ps = con.prepareStatement(deleteQuery);
                    ps.setInt(1, pro_id);
                    ps.setInt(2, Integer.parseInt((String) session.getAttribute("user_id")));
                    ps.executeUpdate();
                } else {
                    // Update the quantity in the cart
                    String updateQuery = "UPDATE cart SET quantity = ? WHERE pro_id = ? AND c_id = ?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setInt(1, newQuantity);
                    ps.setInt(2, pro_id);
                    ps.setInt(3, Integer.parseInt((String) session.getAttribute("user_id")));
                    ps.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    // Redirect back to the cart page after updating the quantity
    response.sendRedirect("cust_cart.jsp");
%>
