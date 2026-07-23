<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project.connection"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="project.HashPassword"%>

<%
   
    String userId = (String) session.getAttribute("user_id");
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("user_email");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String newUsername = request.getParameter("username");
    String oldPassword = request.getParameter("old_password");
    String newPassword = request.getParameter("new_password");
    String confirmPassword = request.getParameter("confirm_password");

    String usernameError = "", oldPasswordError = "", newPasswordError = "", confirmPasswordError = "";
    boolean hasError = false;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Validate new username
        if (newUsername == null || newUsername.isEmpty()) {
            usernameError = "Username is required.";
            hasError = true;
        }

        // Validate passwords
        if (oldPassword == null || oldPassword.isEmpty()) {
            oldPasswordError = "Old password is required.";
            hasError = true;
        }

        if (newPassword != null && (newPassword.length() < 3 || newPassword.length() > 8)) {
            newPasswordError = "Password must be 3-8 characters.";
            hasError = true;
        }

        if (newPassword != null && !newPassword.equals(confirmPassword)) {
            confirmPasswordError = "Passwords do not match.";
            hasError = true;
        }

        if (!hasError) {
        	try {
        	    Connection con = connection.getcon();

        	    // Verify old password
        	    String sql = "SELECT password FROM customer WHERE c_id=?";
        	    PreparedStatement ps = con.prepareStatement(sql);
        	    ps.setString(1, userId);
        	    ResultSet rs = ps.executeQuery();

        	    String storedHashedPassword = null; // Initialize the variable
        	    if (rs.next()) {
        	        storedHashedPassword = rs.getString("password");
        	        if (!HashPassword.verifyPassword(oldPassword, storedHashedPassword)) {
        	            oldPasswordError = "Incorrect old password.";
        	            hasError = true;
        	        }
        	    }

        	    if (!hasError) {
        	        // Update username and/or password
        	        String updateSql = "UPDATE customer SET username=?, password=? WHERE c_id=?";
        	        PreparedStatement updatePs = con.prepareStatement(updateSql);
        	        updatePs.setString(1, newUsername);
        	        updatePs.setString(2, newPassword != null ? HashPassword.hashPassword(newPassword) : storedHashedPassword);
        	        updatePs.setString(3, userId);

        	        int updated = updatePs.executeUpdate();
        	        if (updated > 0) {
        	            session.setAttribute("username", newUsername);
        	            response.sendRedirect("index.jsp");
        	            return;
        	        } else {
        	            oldPasswordError = "Failed to update profile. Please try again.";
        	        }
        	    }
        	} catch (Exception e) {
        	    e.printStackTrace();
        	}

        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop Zone - Edit Profile</title>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.profile-page {
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

.error {
	color: red;
	text-align: left;
	margin-bottom: 6px;
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

	<div class="profile-page">
		<div class="form">
			<form class="edit-form" action="edit_profile.jsp" method="POST">
				<h1>Edit Profile</h1>

				<input type="text" placeholder="New Username" name="username"
					value="<%= username %>" autocomplete="off" /> <span class="error">*<%= usernameError %></span>

				<input type="password" placeholder="Old Password"
					name="old_password" autocomplete="off" /> <span class="error">*<%= oldPasswordError %></span>

				<input type="password" placeholder="New Password"
					name="new_password" autocomplete="off" /> <span class="error">*<%= newPasswordError %></span>

				<input type="password" placeholder="Confirm New Password"
					name="confirm_password" autocomplete="off" /> <span class="error">*<%= confirmPasswordError %></span>

				<button type="submit">Update Profile</button>
			</form>
		</div>
	</div>

</body>
</html>