<%@ page import="java.sql.*, project.connection"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>

<%
    String message = "";
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Check for admin session
    session = request.getSession(false);
    if (session == null || session.getAttribute("admin_name") == null) {
        response.sendRedirect("index.jsp");
        return;
    } 

    // Fetch areas from the address table
    List<String[]> areas = new ArrayList<>();
    try {
        con = project.connection.getcon();
        String fetchAreasQuery = "SELECT a_id, area_name, pin_code FROM address";
        pstmt = con.prepareStatement(fetchAreasQuery);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            areas.add(new String[]{
                rs.getString("a_id"), 
                rs.getString("area_name"), 
                rs.getString("pin_code")
            });
        }
    } catch (Exception e) {
        message = "Error fetching areas: " + e.getMessage();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String orderArea1 = request.getParameter("order_area1");
        String orderArea2 = request.getParameter("order_area2");
        String salaryStr = request.getParameter("salary");

        if (name == null || email == null || orderArea1 == null || orderArea2 == null || salaryStr == null ||
            name.isEmpty() || email.isEmpty() || orderArea1.isEmpty() || orderArea2.isEmpty() || salaryStr.isEmpty()) {
            message = "Please fill all the fields.";
        } else if (orderArea1.equals(orderArea2)) {
            message = "Order Area 1 and Order Area 2 cannot be the same.";
        } else {
            try {
                double salary = Double.parseDouble(salaryStr);

                String query = "INSERT INTO delivery_person (name, email, password, order_area1, order_area2, join_date, total_delivery, salary) " +
                               "VALUES (?, ?, ?, ?, ?, CURDATE(), 0, ?)";
                pstmt = con.prepareStatement(query);

                String defaultPassword = "123"; // Default password
                String hashedPassword = defaultPassword; // Use a hashing library if needed (e.g., BCrypt)

                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, hashedPassword);
                pstmt.setString(4, orderArea1);
                pstmt.setString(5, orderArea2);
                pstmt.setDouble(6, salary);

                int rowsInserted = pstmt.executeUpdate();
                if (rowsInserted > 0) {
                    message = "Delivery person added successfully.";
                    response.sendRedirect("delivery_person_management.jsp"); 
                } else {
                    message = "Insertion failed.";
                }
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
                e.printStackTrace();
            } finally {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert Delivery Person - Admin Dashboard</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script>
        function validateForm() {
            const orderArea1 = document.getElementById("order_area1").value;
            const orderArea2 = document.getElementById("order_area2").value;
            if (orderArea1 === orderArea2) {
                alert("Order Area 1 and Order Area 2 cannot be the same.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="bg-light">
	<div class="container mt-3">
		<h1 class="text-center">Insert Delivery Person</h1>
		<% if (!message.isEmpty()) { %>
		<div class="alert alert-info text-center"><%= message %></div>
		<% } %>
		<form action="" method="post" onsubmit="return validateForm()"
			autocomplete="off">
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="name" class="form-label">Name:</label> <input
					type="text" name="name" id="name" class="form-control"
					placeholder="Enter name" required>
			</div>
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="email" class="form-label">Email:</label> <input
					type="email" name="email" id="email" class="form-control"
					placeholder="Enter email" required>
			</div>
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="order_area1" class="form-label">Order Area 1:</label> <select
					name="order_area1" id="order_area1" class="form-control" required>
					<option value="">Select an area</option>
					<% for (String[] area : areas) { %>
					<option value="<%= area[2] %>"><%= area[1] %> (
						<%= area[2] %>)
					</option>
					<% } %>
				</select>
			</div>
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="order_area2" class="form-label">Order Area 2:</label> <select
					name="order_area2" id="order_area2" class="form-control" required>
					<option value="">Select an area</option>
					<% for (String[] area : areas) { %>
					<option value="<%= area[2] %>"><%= area[1] %> (
						<%= area[2] %>)
					</option>
					<% } %>
				</select>
			</div>
			<div class="form-outline mb-4 w-50 m-auto">
				<label for="salary" class="form-label">Salary:</label> <input
					type="number" step="0.01" name="salary" id="salary"
					class="form-control" placeholder="Enter salary" required>
			</div>
			<div class="form-outline mb-4 w-50 m-auto">
				<input type="submit" value="Insert Delivery Person"
					class="btn btn-info mb-3 px-3">
			</div>
		</form>
	</div>
</body>
</html>
