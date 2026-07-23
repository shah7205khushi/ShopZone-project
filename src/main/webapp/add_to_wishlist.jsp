<%@ page import="java.sql.*, jakarta.servlet.http.Cookie ,java.util.*"%>
<%
    String productIdParam = request.getParameter("product_id");
    if (productIdParam == null || productIdParam.isEmpty()) {
        out.println("<script>alert('No product ID provided.'); window.location.href='shop.jsp';</script>");
        return;
    }

    int productId = Integer.parseInt(productIdParam);
    // Get the session object
    HttpSession s = request.getSession(false);
    
    String user_id = (String) s.getAttribute("user_id");
    String username = (String) s.getAttribute("username");

    if (user_id == null) {
    	// User is not logged in, so set the cookie and redirect to login page
        Cookie specialProductCookie = new Cookie("special_product_id", productIdParam);
        specialProductCookie.setMaxAge(3600); // Cookie expires in 1 hour
        response.addCookie(specialProductCookie);

        out.println("<script>alert('Please login to add items to your wishlist.'); window.location.href='login.jsp';</script>");
        return;
    }

    try (Connection con = project.connection.getcon()) {
        String selectQuery = "SELECT * FROM wishlist WHERE c_id = ? AND pro_id = ?";
        PreparedStatement psSelect = con.prepareStatement(selectQuery);
        psSelect.setInt(1, Integer.parseInt(user_id));
        psSelect.setInt(2, productId);
        ResultSet rs = psSelect.executeQuery();

        if (rs.next()) {
            out.println("<script>alert('Item already exists in your wishlist.'); window.location.href='product_detail.jsp?pro_id=" + productId + "';</script>");
        } else {
            String insertQuery = "INSERT INTO wishlist (c_id, pro_id) VALUES (?, ?)";
            PreparedStatement psInsert = con.prepareStatement(insertQuery);
            psInsert.setInt(1, Integer.parseInt(user_id));
            psInsert.setInt(2, productId);
            psInsert.executeUpdate();

            out.println("<script>alert('Item added to your wishlist.'); window.location.href='product_detail.jsp?pro_id=" + productId + "';</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>
