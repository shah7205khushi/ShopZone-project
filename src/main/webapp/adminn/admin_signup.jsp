<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="project.*"%>
<%@page import="java.sql.*"%>
<%@page import="jakarta.servlet.http.HttpSession"%>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

String nameError = "", emailError = "", passwordError = "", signupError = "";
boolean hasError = false;

// Regular expressions for validation
String namePattern = "^[a-zA-Z_]+$";
String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
String passwordPattern = "^[a-zA-Z0-9_]+$";

// Validate the fields if form is submitted
if (request.getMethod().equalsIgnoreCase("POST")) {

    // Validate name
    if (name == null || name.isEmpty()) {
        nameError = "Name is required.";
        hasError = true;
    } else if (!name.matches(namePattern)) {
        nameError = "Name can contain only alphabets and underscores.";
        hasError = true;
    } else if (name.length() < 3 || name.length() > 8) {
        nameError = "Name must be 3-8 characters long.";
        hasError = true;
    }

    // Validate email
    if (email == null || email.isEmpty()) {
        emailError = "Email is required.";
        hasError = true;
    } else if (!email.matches(emailPattern)) {
        emailError = "Invalid email format.";
        hasError = true;
    }

    // Validate password
    if (password == null || password.isEmpty()) {
        passwordError = "Password is required.";
        hasError = true;
    } else if (password.length() < 3 || password.length() > 8) {
        passwordError = "Password must be 3-8 characters long.";
        hasError = true;
    } else if (!password.matches(passwordPattern)) {
        passwordError = "Password can contain only alphabets, numbers, and underscores.";
        hasError = true;
    }

    // If no errors, proceed with form submission (e.g., save to database)
    if (!hasError) {
        try {
            Connection con = connection.getcon();

            // Check for duplicate email
            String checkEmailSQL = "SELECT * FROM employee WHERE email=?";
            PreparedStatement checkEmailStmt = con.prepareStatement(checkEmailSQL);
            checkEmailStmt.setString(1, email);
            ResultSet rs = checkEmailStmt.executeQuery();

            if (rs.next()) {
                emailError = "Email already exists.";
                hasError = true;
            } else {
                // Hash the password
                String hashedPassword = HashPassword.hashPassword(password);

                // Insert new employee with hashed password
                String sql = "INSERT INTO employee(username, email, password) VALUES(?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, hashedPassword); // Use hashed password

                int result = ps.executeUpdate();
                if (result > 0) {
                    // Retrieve the generated employee ID
                    ResultSet generatedKeys = ps.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int empId = generatedKeys.getInt(1);

                        // Set session attributes
                        HttpSession s = request.getSession();
                        s.setAttribute("admin_id", empId);
                        s.setAttribute("admin_name", name);
                        s.setAttribute("admin_email", email);

                        response.sendRedirect("admin_dashboard.jsp");
                    }
                } else {
                    signupError = "Signup failed. Please try again.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            signupError = "Database error: " + e.getMessage();
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Sign Up</title>
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
	cursor: pointer;
}

.form button:hover {
	background: #43A047;
}

.error {
	color: red;
	text-align: left;
	margin-bottom: 6px;
	margin-left: 0px;
}

body {
	font-family: "Roboto", sans-serif;
	background-color: #f5f5f5;
}
</style>
</head>
<body>

	<div class="login-page">
		<div class="form">
			<form class="register-form" action="admin_signup.jsp" method="POST">
				<h1>Admin Sign Up</h1>
				<input type="text" placeholder="Name" name="name"
					value="<%=name != null ? name : ""%>" /> <span class="error"><%=nameError%></span>

				<input type="email" placeholder="Email Address" name="email"
					value="<%=email != null ? email : ""%>" /> <span class="error"><%=emailError%></span>

				<input type="password" placeholder="Password" name="password" /> <span
					class="error"><%=passwordError%></span>

				<button type="submit">Sign Up</button>
				<p class="error"><%=signupError%></p>
				<p class="message">
					Already registered? <a href="index.jsp">Sign In</a>
				</p>
			</form>
		</div>
	</div>

</body>
</html>