<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    // Retrieve the current session (without creating a new one)
    HttpSession s = request.getSession(false);

    // If a session exists, invalidate it
    if (s != null) {
        s.invalidate();  // This will remove all attributes from the session
    }

    // Redirect to the admin login page
    response.sendRedirect("index.jsp");
%>