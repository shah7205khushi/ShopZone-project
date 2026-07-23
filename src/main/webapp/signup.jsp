<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="project.connection"%>
<%@page import="java.sql.*"%>
<%-- <%@page import="jakarta.servlet.http.Cookie"%> --%>
<%@page import="jakarta.servlet.http.HttpSession , project.HashPassword"%>

<%

String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

String nameError = "", emailError = "", passwordError = "";
boolean hasError = false;

// Regular expressions for validation
String namePattern = "^[a-zA-Z_]+$";
String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
String passwordPattern = "^[a-zA-Z0-9_@]+$";

// Validate the fields if form is submitted
if (request.getMethod().equalsIgnoreCase("POST")) {

	// Validate name
	if (name == null || name.isEmpty()) {
		nameError = "required";
		hasError = true;
	} else if (!name.matches(namePattern)) {
		nameError = "alphabets and underscores only.";
		hasError = true;
	} else if (name.length() < 3 || name.length() > 8) {
		nameError = "Name must be 3-8 characters.";
		hasError = true;
	}

	// Validate email
	if (email == null || email.isEmpty()) {
		emailError = "required.";
		hasError = true;
	} else if (!email.matches(emailPattern)) {
		emailError = "Invalid email format.";
		hasError = true;
	}

	// Validate password (between 3 and 8 characters)
	if (password == null || password.isEmpty()) {
		passwordError = "required.";
		hasError = true;
	} else if (password.length() < 3 || password.length() > 50) {
		passwordError = "Password must be 3-8 characters.";
		hasError = true;
	} else if (!password.matches(passwordPattern)) {
		passwordError = "Password must contain only alphabets, numbers, and underscores.";
		hasError = true;
	}

	// If no errors, proceed with form submission (e.g., save to database)
	if (!hasError) {
		String default_address = "";
		String phone_number = "";
		Connection con = connection.getcon();
		try {
	

	// Check for duplicate email
	String checkEmailSQL = "SELECT * FROM customer WHERE email=?";
	PreparedStatement checkEmailStmt = con.prepareStatement(checkEmailSQL);
	checkEmailStmt.setString(1, email);
	ResultSet rs = checkEmailStmt.executeQuery();

	if (rs.next()) {
		emailError = "email already exists.";
		hasError = true;
	} else {
		// Insert new customer
String sql = "INSERT INTO customer(username, email, password) VALUES(?,?,?)";
PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

// Hash the password before storing it
String hashedPassword = HashPassword.hashPassword(password);

ps.setString(1, name);
ps.setString(2, email);
ps.setString(3, hashedPassword); // Store the hashed password
		int result = ps.executeUpdate();
		if (result > 0) {
			// Retrieve the generated customer ID (c_id)
			ResultSet generatedKeys = ps.getGeneratedKeys();
			if (generatedKeys.next()) {
				int customerId = generatedKeys.getInt(1); // Get the c_id

				// Set session attributes
                HttpSession x = request.getSession();
                x.setAttribute("user_id", String.valueOf(customerId));
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
		} else {
			response.sendRedirect("index.jsp");
		}
	}
		} catch (Exception e) {
	System.out.println("Error: " + e);
	response.sendRedirect("signup.jsp");
		}
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop Zone - Sign Up</title>
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
	margin-bottom: 1px;
	margin-top: 10px;
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
			<form class="register-form" action="signup.jsp" method="POST">
				<h1>SHOP ZONE</h1>
				<input type="text" placeholder="name" name="name"
					value="<%=name != null ? name : ""%>" autocomplete="off" /> <span
					class="error">*<%=nameError%></span> <input type="email"
					placeholder="email address" name="email"
					value="<%=email != null ? email : ""%>" autocomplete="off" /> <span
					class="error">*<%=emailError%></span> <input type="password"
					placeholder="password" name="password" autocomplete="off" /> <span
					class="error">*<%=passwordError%></span>

				<button type="submit">Sign Up</button>
				<p class="message">
					Already registered? <a href="login.jsp">Sign In</a>
				</p>
			</form>
		</div>
	</div>

</body>
</html>
