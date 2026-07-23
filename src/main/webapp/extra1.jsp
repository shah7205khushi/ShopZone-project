<%@ page import="java.sql.*, project.connection"%>

<%@ page import="java.sql.*, project.connection"%>
<%@ page session="true"%>
<%
    // Check session for admin login
//     if (session.getAttribute("admin_name") == null) {
//         response.sendRedirect("index.jsp");
//         return;
//     } 

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Use project.connection class for database connection
    	Class.forName("com.mysql.cj.jdbc.Driver");
        con = connection.getcon();
        if(con != null)
        {
        	out.println("connction success");
        }

    } catch (Exception e) {
        out.println("<script> alert('Database connection error: " + e.getMessage().replace("'", "\\'") + "'); </script>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<!-- Product List -->
	<h1 class="text-center">List of Products</h1>

	<table class="table table-bordered border-warning">
		<thead>
			<tr>
				<th>ID</th>
				<th>Title</th>


			</tr>
		</thead>
		<tbody>
			<%
                String query = "SELECT pro_id, title from product limit 5" ;
                try {
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    while (rs.next()) {
            %>
			<tr>
				<td><%= rs.getInt("pro_id") %></td>
				<td><%= rs.getString("title") %></td>




			</tr>
			<%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='16' class='text-danger text-center'>Error: " + e.getMessage().replace("'", "\\'") + "</td></tr>");
                }
            %>
		</tbody>
	</table>

</body>
</html>

<%
    // Close resources
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (Exception e) {
        out.println("<script> alert('Error closing resources: " + e.getMessage().replace("'", "\\'") + "'); </script>");
    }
%>