<%@ page import="java.sql.*"%>
<%
// Get the session object
HttpSession s = request.getSession(false);

String user_id = (String) s.getAttribute("user_id");
// String username = (String) s.getAttribute("username");
String productId = request.getParameter("product_id");

if (user_id == null) {
    	
    	
    	// User is not logged in, so set the cookie and redirect to login page
        Cookie specialProductCookie = new Cookie("special_product_id", productId);
        specialProductCookie.setMaxAge(3600); // Cookie expires in 1 hour
        response.addCookie(specialProductCookie);
        
        
        out.println("<script>alert('Please login to buy products.'); window.location.href='login.jsp';</script>");
        return;
    }
%>

<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/shop_zone";
    String username = "root";
    String password = "jinal@NEW123";

    // Get the product_id from the query string
     productId = request.getParameter("product_id");
    int cartId = 0;

    if (productId == null || productId.isEmpty()) {
        out.println("Product ID is required.");
        return;
    }

    // Simulate a logged-in user ID (Replace with your actual user session logic)
    int userId =Integer.parseInt(user_id) ; // Example user ID

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = project.connection.getcon();

        // Check if the product already exists in the user's cart
        String checkQuery = "SELECT cart_id FROM cart WHERE c_id = ? AND pro_id = ?";
        ps = con.prepareStatement(checkQuery);
        ps.setInt(1, userId);
        ps.setInt(2, Integer.parseInt(productId));
        rs = ps.executeQuery();

        if (rs.next()) {
            // Product exists, update its quantity to 1
            cartId = rs.getInt("cart_id");
            String updateQuery = "UPDATE cart SET quantity = 1 WHERE cart_id = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } else {
            // Product does not exist, add it to the cart with quantity 1
            String insertQuery = "INSERT INTO cart (c_id, pro_id, quantity) VALUES (?, ?, 1)";
            ps = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setInt(2, Integer.parseInt(productId));
            ps.executeUpdate();

            // Get the generated cart_id
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                cartId = rs.getInt(1);
            }
        }

        // Redirect to checkout.jsp with cart_id
        response.sendRedirect("checkout.jsp?cart_ids=" + cartId);

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
