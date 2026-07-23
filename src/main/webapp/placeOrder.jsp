<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat"%>
<%
// int x=-1;
    // Get the session object
    HttpSession s = request.getSession(false);

    // Check if the session is valid and if the user is logged in
    String username = (String) s.getAttribute("username");
    String user_id = (String) s.getAttribute("user_id");
    String user_email = (String) s.getAttribute("user_email");

    if (username == null || user_id == null) {
        // Redirect to login page if session variables are not set
        response.sendRedirect("login.jsp");
        return; // Stop further execution if not logged in
    }
//     x=0;
    // Database Connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String cartIdsParam = request.getParameter("cart_ids"); // Cart IDs from hidden input
    String[] cartIds = cartIdsParam.split(","); // Split cart IDs into an array

    // Form Inputs
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String state = request.getParameter("state");
    String city = request.getParameter("city");
    String total_num_items = request.getParameter("total_num_items");
    String searchArea = request.getParameter("searchArea");
    String paymentMethod = request.getParameter("payment");
    String grandTotal = request.getParameter("total");

    // Generate Order and Payment Data
    int customerId = Integer.parseInt(user_id); // Example: Replace with session-based customer ID
//     double grandTotal = Integer.parseInt(total); // Example: Replace with calculated total
    String paymentStatus = "Pending";
    String orderStatus = "Order Placed";

    try {
        // 1. Establish Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = project.connection.getcon();
//         x=1;
        // Start transaction
        con.setAutoCommit(false);

        // 2. Insert into Payment Table
        String paymentQuery = "INSERT INTO payment (payment_method, payment_date, amount, payment_status, payment_submit_date) VALUES (?, ?, ?, ?, ?)";
        ps = con.prepareStatement(paymentQuery, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, paymentMethod);
        ps.setString(2, null); // Set actual payment date here
        ps.setDouble(3, Double.parseDouble(grandTotal));
        ps.setString(4, paymentStatus);
        ps.setString(5, null); // Set actual submit date here
        ps.executeUpdate();
        rs = ps.getGeneratedKeys();
        int paymentId = rs.next() ? rs.getInt(1) : 0;
//         out.println(paymentId);
//         x=2;
        // 3. Assign Delivery Person
        String deliveryPersonQuery = "SELECT dp_id FROM delivery_person WHERE order_area1 = ? or order_area2 = ? LIMIT 1";
        ps = con.prepareStatement(deliveryPersonQuery);
        ps.setString(1, searchArea);
        ps.setString(2, searchArea);
        rs = ps.executeQuery();
        int deliveryPersonId = rs.next() ? rs.getInt("dp_id") : 0;
//         out.println(deliveryPersonId);
//         out.println(searchArea);
//         out.println("cartIdsParam: " + cartIdsParam);
//         out.println("email: " + email);
//         out.println("address: " + address);
//         out.println("state: " + state);
//         out.println("city: " + city);
//         out.println("total_num_items: " + total_num_items);
//         out.println("searchArea: " + searchArea);
//         out.println("paymentMethod: " + paymentMethod);
//         out.println("grandTotal: " + grandTotal);

//         x=3;
        // 4. Insert into Orders Table
        String orderQuery = "INSERT INTO orders (p_id, c_id, dp_id, order_status, num_of_items, order_date, pincode, shipping_address) VALUES (?, ?, ?, ?, ?, now(), ?, ?)";
        ps = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, paymentId);
        ps.setInt(2, customerId);
        ps.setInt(3, deliveryPersonId);
        ps.setString(4, orderStatus);
        ps.setInt(5, Integer.parseInt(total_num_items));
        ps.setString(6, searchArea);
        ps.setString(7, address);
        ps.executeUpdate();
        rs = ps.getGeneratedKeys();
        int orderId = rs.next() ? rs.getInt(1) : 0;
        
//         x=4;
        // 5. Insert into Order Line Item Table
        for (String cartId : cartIds) {
            int cartIdInt = Integer.parseInt(cartId); // Convert cartId to integer

            // Fetch product details (pro_id, quantity) from cart
            String cartQuery = "SELECT pro_id, quantity FROM cart WHERE cart_id = ?";
            ps = con.prepareStatement(cartQuery);
            ps.setInt(1, cartIdInt);
            rs = ps.executeQuery();

            if (rs.next()) {
                int productId = rs.getInt("pro_id");
                int quantity = rs.getInt("quantity");

                // Insert into order_line_item table
                String orderLineItemQuery = "INSERT INTO order_line_item (order_id, pro_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement psInsert = con.prepareStatement(orderLineItemQuery);
                psInsert.setInt(1, orderId); // Assuming orderId is available from previous steps
                psInsert.setInt(2, productId);
                psInsert.setInt(3, quantity); // Use the actual quantity from the cart
                psInsert.executeUpdate();

                // Remove the product from the cart table
                String removeFromCartQuery = "DELETE FROM cart WHERE cart_id = ?";
                PreparedStatement psDelete = con.prepareStatement(removeFromCartQuery);
                psDelete.setInt(1, cartIdInt);
                psDelete.executeUpdate();
            }
        }

        // Commit the transaction if everything is successful
        con.commit();
//         x=5;
        // 6. Success Message
        out.println("<script>alert('Order placed successfully'); window.location.href='cust_cart.jsp';</script>");
    }catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } catch (Exception e) {
        // Rollback transaction in case of error
        if (con != null) {
            try {
                con.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
        e.printStackTrace(); 
//         x=6;
//         out.print(x);
        out.println("<script>alert('Order failed'); window.location.href='cust_cart.jsp';</script>");
    } finally {
        try {
            // Reset auto-commit to true
            if (con != null) {
                con.setAutoCommit(true);
            }
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
