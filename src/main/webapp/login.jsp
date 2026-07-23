
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="project.connection"%>
<%@page import="java.sql.*"%>
<%@page import="jakarta.servlet.http.Cookie"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="project.HashPassword"%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    String emailError = "", passwordError = "";
    boolean hasError = false;

    // Regular expressions for validation
    String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
    
    		
    // Validate the fields if form is submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {

        // Validate email
        if (email == null || email.isEmpty()) {
            emailError = "required.";
            hasError = true;
        } else if (!email.matches(emailPattern)) {
            emailError = "Invalid email format.";
            hasError = true;
        }

        // Validate password
        if (password == null || password.isEmpty()) {
            passwordError = "required.";
            hasError = true;
        } else if (password.length() < 3 || password.length() > 8) {
            passwordError = "Password must be 3-8 characters.";
            hasError = true;
        }

        // If no errors, proceed with login validation
        if (!hasError) {
            try {
                Connection con = connection.getcon();
                String sql = "SELECT c_id, username,password FROM customer WHERE email=? ";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");  // Get the hashed password from DB
                    int c_id = rs.getInt("c_id");
                    String name = rs.getString("username");

                    // Use the HashPassword method to verify the entered password
                    if (HashPassword.verifyPassword(password, storedHashedPassword)) {
                    
                 // Set session attributes
                    HttpSession x = request.getSession();
                    x.setAttribute("user_id", String.valueOf(c_id));
                    x.setAttribute("username", name);
                    x.setAttribute("user_email", email);

                    
                 // User is logged in, now check if the special_product_id cookie exists
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if ("special_product_id".equals(cookie.getName())) {
                                String productId = cookie.getValue();  // Get the product ID from the cookie
                                
                                // Remove the cookie after redirect
                                cookie.setMaxAge(0);  // Set max age to 0 to delete it
                                response.addCookie(cookie);

                                // Redirect to the product detail page with the product ID as a query parameter
                                response.sendRedirect("product_detail.jsp?pro_id=" + productId);
                                return;  // Stop further processing
                            }
                        }
                    }
                    
                    
                    response.sendRedirect("index.jsp");
                } 
                }else {
                    passwordError = "Invalid email or password.";
                    hasError = true;
                }  
            }catch (Exception e) {
                System.out.println("Error: " + e);
                response.sendRedirect("login.jsp");
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop Zone - Login</title>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
	width: 360px;
	padding: 8% 0 0;
	margin: auto;
}

.form {
	position: relative;
	z-index: 1;
	background: #FFFFFF;
	max-width: 360px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
}

.form input {
	font-family: "Roboto", sans-serif;
	outline: 0;
	background: #f2f2f2;
	width: 100%;
	border: 0;
	margin: 0 0 15px;
	padding: 15px;
	box-sizing: border-box;
	font-size: 14px;
}

.form button {
	font-family: "Roboto", sans-serif;
	text-transform: uppercase;
	outline: 0;
	background: #4CAF50;
	width: 100%;
	border: 0;
	padding: 15px;
	color: #FFFFFF;
	font-size: 14px;
	-webkit-transition: all 0.3 ease;
	transition: all 0.3 ease;
	cursor: pointer;
}

.form button:hover, .form button:active, .form button:focus {
	background: #43A047;
}

.form .message {
	margin: 15px 0 0;
	color: #b3b3b3;
	font-size: 12px;
}

.form .message a {
	color: #4CAF50;
	text-decoration: none;
}

.error {
	color: red;
	text-align: left;
	margin-bottom: 6px;
	margin-left: 0px;
}

body {
	font-family: "Roboto", sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	background-color: #f5f5f5;
}
</style>
</head>
<body>

	<div class="login-page">
		<div class="form">
			<form class="login-form" action="login.jsp" method="POST">
				<h1>SHOP ZONE</h1>

				<input type="email" placeholder="email" name="email"
					value="<%= email != null ? email : "" %>" autocomplete="off" /> <span
					class="error">*<%= emailError %></span> <input type="password"
					placeholder="password" name="password" autocomplete="off" /> <span
					class="error">*<%= passwordError %></span>

				<button type="submit" class="l-b">Login</button>
				<p class="message">
					Not registered? <a href="signup.jsp">Create an account</a>
				</p>
			</form>
		</div>
	</div>

</body>
</html>
