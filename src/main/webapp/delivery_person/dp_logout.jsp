<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>

<%
    // Check if the session attribute "delivery_person_of_shop_zone" is set
    HttpSession s = request.getSession(false);

    // If a session exists, invalidate it
    if (s != null) {
        s.invalidate();  // This will remove all attributes from the session
    

        // Redirect to the dashboard page
        response.sendRedirect("dp_dashboard.jsp");
    } else {
        // If the session attribute is not set, redirect to the dashboard page
        response.sendRedirect("dp_dashboard.jsp");
    }
%>
