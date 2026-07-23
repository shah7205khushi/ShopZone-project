<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="project.connection"%>
<%@page import="java.sql.*"%>


<%

    String userId = (String) session.getAttribute("user_id");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = "", email = "";

    try {
        Connection con = connection.getcon();
        String sql = "SELECT username, email FROM customer WHERE c_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            username = rs.getString("username");
            email = rs.getString("email");
        } else {
            response.sendRedirect("login.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shop Zone - Profile</title>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Roboto:300);

.profile-page {
	width: 360px;
	padding: 8% 0 0;
	margin: auto;
}

.profile {
	position: relative;
	z-index: 1;
	background: #FFFFFF;
	max-width: 360px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: left;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
}

.profile h1 {
	text-align: center;
	color: #4CAF50;
}

.profile p {
	font-family: "Roboto", sans-serif;
	font-size: 16px;
	margin: 10px 0;
	color: #333;
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
		<div class="profile">
			<h1>Your Profile</h1>
			<p>
				<strong>Username:</strong>
				<%= username %></p>
			<p>
				<strong>Email:</strong>
				<%= email %></p>
			<p style="text-align: center;">
				<a href="edit_profile.jsp"
					style="color: #4CAF50; text-decoration: none;">Edit Profile</a>
			</p>
		</div>
	</div>

</body>
</html>