<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="project.*"%>
	
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession"%>

<%
    // Get the session object
    HttpSession s = request.getSession(false);

    // Check if the session is valid and if the admin is logged in
    String adminName = (String) s.getAttribute("admin_name");

    if (adminName == null) {
        // Redirect to login page if session variables are not set
        response.sendRedirect("index.jsp");
        return; // Stop further execution if not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<style>
/* Body background with gradient */
body {
	overflow:;
	font-family: 'Arial', sans-serif;
}

/* Navbar styling */
.navbar-custom {
	background-color: #2a2f3a;
	padding: 15px 0;
}

.navbar-brand {
	font-size: 2rem;
	color: #f0f0f0;
	font-weight: bold;
	font-family: 'Poppins', sans-serif;
}

.navbar-brand:hover {
	color: #ffffff;
}

.content-title {
	background-color: #2a2f3a;
	color: #ffffff;
	padding: 12px;
	text-align: center;
	margin-top: 20px;
	border-radius: 8px;
	font-size: 24px;
	font-weight: 600;
}

.dashboard-btns {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	justify-content: center;
	margin-top: 30px;
}

/* Button styling */
.dashboard-btns .btn {
	font-size: 18px;
	padding: 15px 25px;
	border-radius: 12px;
	transition: background-color 0.3s ease;
}

.dashboard-btns .btn:hover {
	background-color: #1d8cf8;
	color: #fff;
}

/* Content section */
.dashboard-section {
	background-color: #ffffff;
	border-radius: 12px;
	box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
	padding: 10px;
	margin-top: 30px;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.navbar-brand {
		font-size: 1.5rem;
	}
}
</style>
</head>
<body class="bg-gray">

	<div class="bg-Sacondary">

		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg navbar-custom">
			<div class="container">
				<a class="navbar-brand fs-1 text-light" href="#">Shop zone</a>
				<div class="ms-auto">
					<a href="admin_logout.jsp" class="btn btn-danger">Logout</a>
				</div>
			</div>
		</nav>

		<!-- Welcome message -->
		<div class="container">
			<h2 class="content-title fs-2">
				<%
                if (adminName != null) {
                    out.print("Welcome, Admin " + adminName);
                }
                %>
			</h2>
		</div>

		<!-- Dashboard Buttons -->
		<div class="container-fluid dashboard-section">
			<div class="row">
				<div class="col-lg-3">
					<a href="customer_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3">
						Customer </a> <a href="order_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3">
						Order </a> <a href="product_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3">
						Product </a> <a href="admin_manage_category.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3">
						Category </a> <a href="delivery_person_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3">
						Delivery Person </a> <a href="report_managment.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3">
						Report </a>
				</div>

				<!-- Graph Section -->
				<div class="col-lg-9 mr-3">
					<div class="row">
						<!--                 _______________________________________________________________________________________ -->
						<%
    // Database connection
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    int totalCustomers = 0;

    try {
        // Initialize database connection
        conn = connection.getcon();

        // Query to get total number of customers
        String query = "SELECT COUNT(*) AS total_customers FROM customer";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        if (rs.next()) {
            totalCustomers = rs.getInt("total_customers");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

						<div
							class="col-lg-4 text-center bg-secondary text-white p-3 mb-3 rounded w-25 m-3">
							Total Customers:
							<%= totalCustomers %>
						</div>
						<!-- ____________________________________________________________________________________________ -->


						<%
    // Database connection
     conn = null;
     stmt = null;
     rs = null;
    int totalProducts = 0;

    try {
        // Initialize database connection
        conn = connection.getcon();

        // Query to get total number of products with pro_status = 1
        String query = "SELECT COUNT(*) AS total_products FROM product WHERE pro_status = 1";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        if (rs.next()) {
            totalProducts = rs.getInt("total_products");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

						<div
							class="col-lg-4 text-center bg-secondary text-white p-3 mb-3 rounded w-25 m-3">
							Total Products:
							<%= totalProducts %>
						</div>
						<!-- ___________________________________________________________________________________________________ -->

						<%
    // Database connection
     conn = null;
     stmt = null;
     rs = null;
    int totalOrders = 0;

    try {
        // Initialize database connection
        conn = connection.getcon();

        // Query to get total number of orders
        String query = "SELECT COUNT(*) AS total_orders FROM orders";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        if (rs.next()) {
            totalOrders = rs.getInt("total_orders");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

						<div
							class="col-lg-4 text-center bg-secondary text-white p-3 mb-3 rounded w-25 m-3">
							Total Orders:
							<%= totalOrders %>
						</div>

						<!-- _______________________________________________________________________________________ -->
					</div>

					<div class="row">
						<!-- Graph Section 1 (Sales Chart) -->
						<div class="col-lg-6 text-center text-white p-3 mb-3 rounded">
							<h3 style="color: black;">Sales by Categories</h3>
							<canvas id="salesChart"></canvas>

							<%
   	

    // Database connection
  
     conn = null;
     stmt = null;
     rs = null;
    StringBuilder jsonData = new StringBuilder();

    try {
        // Establish connection to the database
       conn =connection.getcon();
            stmt = conn.createStatement();
        // SQL query to get sales data for each parent category, including categories with no orders
        String query = "SELECT pc.p_cat_name AS parent_category, " +
                       "COALESCE(SUM(oli.quantity * (p.show_price - ((p.show_price * p.discount) / 100))), 0) AS total_sales " +
                       "FROM parent_category pc " +
                       "LEFT JOIN sub_category sc ON pc.p_cat_id = sc.p_cat_id " +
                       "LEFT JOIN product p ON sc.sub_cat_id = p.sub_cat_id " +
                       "LEFT JOIN order_line_item oli ON p.pro_id = oli.pro_id " +
                       "LEFT JOIN orders od ON oli.order_id = od.order_id " +
                       "WHERE pc.p_cat_name IN ('Men', 'Women', 'Kid') " +
                       "GROUP BY pc.p_cat_name " +
                       "ORDER BY total_sales DESC";
        rs = stmt.executeQuery(query);

        // Format the data as JSON
     // Format the data as JSON
        jsonData.append("[");

        while (rs.next()) {
            if (jsonData.length() > 1) {
                jsonData.append(",");
            }
            jsonData.append("{");
            jsonData.append("\"parent_category\":\"").append(rs.getString("parent_category")).append("\",");
            jsonData.append("\"total_sales\":").append(rs.getDouble("total_sales"));
            jsonData.append("}");
        }
        jsonData.append("]");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>

							<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

							<div class="col-lg-6 text-center text-white p-3 mb-3 rounded">

								<canvas id="salesChart"></canvas>
							</div>


							<script>
    // Parse the JSON data from JSP
    const salesData = <%= jsonData.toString() %>;

    // Extract categories and sales data
    const categories = salesData.map(item => item.parent_category);
    const sales = salesData.map(item => item.total_sales);

    // Create the chart
    const ctx = document.getElementById("salesChart").getContext("2d");
    const salesChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: categories,
            datasets: [{
                label: "Sales",
                data: sales,
                backgroundColor: "rgba(75, 192, 192, 0.6)",
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                },
            },
        },
    });
</script>

						</div>

						<!-- Graph Section 2 -->
						<div class="col-lg-6 text-center text-white p-3 mb-3 rounded">
							<h2 style="color: black;">Monthly Sales</h2>
							<canvas id="monthlySalesChart"></canvas>

							<%
        StringBuilder monthlyJsonData = new StringBuilder();

        try {
            // Establish connection to the database
           
            conn =connection.getcon();
            stmt = conn.createStatement();

            // SQL query to calculate monthly sales
            String monthlyQuery = "SELECT DATE_FORMAT(od.order_date, '%Y-%m') AS month, " +
                                  "COALESCE(SUM(oli.quantity * (p.show_price - ((p.show_price * p.discount) / 100))), 0) AS total_sales " +
                                  "FROM orders od " +
                                  "LEFT JOIN order_line_item oli ON od.order_id = oli.order_id " +
                                  "LEFT JOIN product p ON oli.pro_id = p.pro_id " +
                                  "GROUP BY DATE_FORMAT(od.order_date, '%Y-%m') " +
                                  "ORDER BY DATE_FORMAT(od.order_date, '%Y-%m')";
            rs = stmt.executeQuery(monthlyQuery);

            // Format the data as JSON
            monthlyJsonData.append("[");
            while (rs.next()) {
                if (monthlyJsonData.length() > 1) {
                    monthlyJsonData.append(",");
                }
                monthlyJsonData.append("{");
                monthlyJsonData.append("\"month\":\"").append(rs.getString("month")).append("\",");
                monthlyJsonData.append("\"total_sales\":").append(rs.getDouble("total_sales"));
                monthlyJsonData.append("}");
            }
            monthlyJsonData.append("]");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    %>

							<script>
        // Parse the JSON data from JSP
        const monthlySalesData = <%= monthlyJsonData.toString() %>;

        // Extract months and sales data
        const months = monthlySalesData.map(item => item.month);
        const monthlySales = monthlySalesData.map(item => item.total_sales);

        // Create the chart
        const monthlyCtx = document.getElementById("monthlySalesChart").getContext("2d");
        const monthlySalesChart = new Chart(monthlyCtx, {
            type: "line",
            data: {
                labels: months,
                datasets: [{
                    label: "Monthly Sales",
                    data: monthlySales,
                    borderColor: "rgba(75, 192, 192, 0.8)",
                    backgroundColor: "rgba(75, 192, 192, 0.4)",
                    fill: true,
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    </script>
						</div>


						<!-- Graph Section 3 -->
						<!-- <div class="col-lg-4 text-center  text-dark p-3 mb-3 rounded">1 of 3</div> -->
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>