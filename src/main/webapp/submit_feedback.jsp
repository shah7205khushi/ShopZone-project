<%@ page import="java.sql.*"%>
<%
// Get the session object
String productIdParam = request.getParameter("pro_id");
    if (productIdParam == null || productIdParam.isEmpty()) {
        out.println("<script>alert('No product ID provided.'); window.location.href='shop.jsp';</script>");
        return;
    }

//     int productId = Integer.parseInt(productIdParam);
 // Get the session object
    HttpSession s = request.getSession(false);

    // Check if the session is valid and if the cust is logged in
//           String adminId = (String) s.getAttribute("admin_id");

    String user_id = (String) s.getAttribute("user_id");
    String username = (String) s.getAttribute("username");

    if (user_id == null) {
    	
    	
    	// User is not logged in, so set the cookie and redirect to login page
        Cookie specialProductCookie = new Cookie("special_product_id", productIdParam);
        specialProductCookie.setMaxAge(3600); // Cookie expires in 1 hour
        response.addCookie(specialProductCookie);
        
        
        out.println("<script>window.location.href='login.jsp';</script>");
        return;
    }

    // Retrieve form parameters
    String feedbackText = request.getParameter("feedbackText");
    String ratingStr = request.getParameter("star");
    String productId = request.getParameter("pro_id");
    int customerId = Integer.parseInt(user_id); 
    
    // Validation
    if (feedbackText == null || feedbackText.trim().isEmpty() || ratingStr == null || productId == null) {
        out.println("Invalid feedback. Please try again.");
        return;
    }

    int rating = Integer.parseInt(ratingStr);

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = project.connection.getcon();
        
        // Insert feedback into the database
        String sql = "INSERT INTO feedback (c_id, pro_id, content, rating) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, customerId);
        pstmt.setInt(2, Integer.parseInt(productId));
        pstmt.setString(3, feedbackText);
        pstmt.setInt(4, rating);

        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            // Redirect to product detail page with pro_id
            response.sendRedirect("product_detail.jsp?pro_id=" + productId);
        } else {
            out.println("Failed to submit feedback. Please try again.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // Close resources
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>


