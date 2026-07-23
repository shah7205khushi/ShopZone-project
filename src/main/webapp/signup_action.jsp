<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="project.connection"%>
<%@page import="java.sql.*"%>

<%  
String name = request.getParameter("name");
String email  = request.getParameter("email");
String password = request.getParameter("password");
String default_address = "";
String phone_number = "";



try{
	Connection con = connection.getcon();
// Class.forName("com.mysql.cj.jdbc.Driver");
// 			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop_zone","root","jinal@NEW123");
	String sql = "insert into customer(username,email,password,default_address,phone_number) values(?,?,?,?,?)";
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, name);
	ps.setString(2, email);
	ps.setString(3, password);
	ps.setString(4, default_address);
	ps.setString(5, phone_number);
	
	ps.executeUpdate();
	response.sendRedirect("index.jsp");
	
}catch(Exception e)
{
	System.out.println("hii login");
	System.out.println(e);
	response.sendRedirect("login.jsp");
}
%>