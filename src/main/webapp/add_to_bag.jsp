<%@ page
	import="java.sql.*, jakarta.servlet.http.Cookie, project.connection"%>
<%
    String productIdParam = request.getParameter("product_id");
    if (productIdParam == null || productIdParam.isEmpty()) {
        out.println("<script>alert('No product ID provided.'); window.location.href='shop.jsp';</script>");
        return;
    }

    int productId = Integer.parseInt(productIdParam);
 // Get the session object
    HttpSession s = request.getSession(false);

    // Check if the session is valid and if the cust is logged in
//           String adminId = (String) s.getAttribute("admin_id");

    String user_id = (String) s.getAttribute("user_id");
    String username = (String) s.getAttribute("username");

    // If userId or username is not found, redirect to login page
//     if (user_id == null || username == null) {
//     	response.sendRedirect("login.jsp"); // Redirect to your login page
//     	return; // Ensure the rest of the code is not executed
//     }


    if (user_id == null) {
    	
    	
    	// User is not logged in, so set the cookie and redirect to login page
        Cookie specialProductCookie = new Cookie("special_product_id", productIdParam);
        specialProductCookie.setMaxAge(3600); // Cookie expires in 1 hour
        response.addCookie(specialProductCookie);
        
        
        out.println("<script>alert('Please login to add items to your cart.'); window.location.href='login.jsp';</script>");
        return;
    }

    try (Connection con = connection.getcon()) {
        // Check if product exists
        String checkProductQuery = "SELECT * FROM product WHERE pro_id = ?";
        PreparedStatement psCheckProduct = con.prepareStatement(checkProductQuery);
        psCheckProduct.setInt(1, productId);
        ResultSet rsProduct = psCheckProduct.executeQuery();

        if (!rsProduct.next()) {
            out.println("<script>alert('Invalid product selected.'); window.location.href='shop.jsp';</script>");
            return;
        }

        
        // Check if product is in cart
        String selectQuery = "SELECT * FROM cart WHERE c_id = ? AND pro_id = ?";
        PreparedStatement psSelect = con.prepareStatement(selectQuery);
        psSelect.setInt(1,Integer.parseInt(user_id));
        psSelect.setInt(2, productId);
        ResultSet rs = psSelect.executeQuery();

        if (rs.next()) {
            // Update quantity
            int newQuantity = rs.getInt("quantity") + 1;
            String updateQuery = "UPDATE cart SET quantity = ? WHERE c_id = ? AND pro_id = ?";
            PreparedStatement psUpdate = con.prepareStatement(updateQuery);
            psUpdate.setInt(1, newQuantity);
            psUpdate.setInt(2, Integer.parseInt(user_id));
            psUpdate.setInt(3, productId);
            psUpdate.executeUpdate();

            out.println("<script>alert('Item quantity updated in cart.'); window.location.href='product_detail.jsp?pro_id=" + productId + "';</script>");
        } else {
            // Add new item
            String insertQuery = "INSERT INTO cart (pro_id, c_id, quantity) VALUES (?, ?, 1)";
            PreparedStatement psInsert = con.prepareStatement(insertQuery);
            psInsert.setInt(1, productId);
            psInsert.setInt(2, Integer.parseInt(user_id));
            psInsert.executeUpdate();

            out.println("<script>alert('Item added to cart.'); window.location.href='product_detail.jsp?pro_id=" + productId + "';</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>
