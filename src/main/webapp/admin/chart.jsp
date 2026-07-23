<%-- <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Sales Chart</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.2/Chart.min.js"></script>
</head>
<body>
    <div style="width: 70%; margin: 15px auto;">
        <h2>Product Sales by Parent Category</h2>
        <canvas id="salesChart"></canvas>
    </div>

    <%
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/shop_zone";
        String dbUser = "root";
        String dbPassword = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        StringBuilder jsonData = new StringBuilder();

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            stmt = conn.createStatement();

            // SQL query to get sales data grouped by parent category, including categories with no sales
            String query = "SELECT pc.p_cat_name AS category, COALESCE(SUM(p.show_price * p.stock), 0) AS total_sales " +
                           "FROM parent_category pc " +
                           "LEFT JOIN sub_category sc ON pc.p_cat_id = sc.p_cat_id " +
                           "LEFT JOIN product p ON sc.sub_cat_id = p.sub_cat_id " +
                           "GROUP BY pc.p_cat_name";
            rs = stmt.executeQuery(query);

            // Format data as JSON
            jsonData.append("[");
            while (rs.next()) {
                if (jsonData.length() > 1) {
                    jsonData.append(",");
                }
                jsonData.append("{");
                jsonData.append("\"category\":\"").append(rs.getString("category")).append("\",");
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

    <script>
        // Parse the JSON data from JSP
        const salesData = <%= jsonData.toString() %>;

        // Extract categories and sales data
        const categories = salesData.map(item => item.category);
        const sales = salesData.map(item => item.total_sales);

        // Create the chart
        const ctx = document.getElementById("salesChart").getContext("2d");
        const salesChart = new Chart(ctx, {
            type: "bar",
            data: {
                labels: categories,
                datasets: [{
                    label: "Sales (Total Revenue)",
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
</body>
</html>
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession"%>
<%@ page import="project.connection"%>

<%
    // Get the session object
    HttpSession s = request.getSession(false);

    // Check if the session is valid and if the admin is logged in
    String adminName = (String) s.getAttribute("admin_name");

    // Redirect to login page if session variables are not set
    if (adminName == null) {
        response.sendRedirect("index.jsp");
        return; // Stop further execution if not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Monthly Sales</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<style>
body {
	font-family: 'Arial', sans-serif;
}

.navbar-custom {
	background-color: #2a2f3a;
	padding: 15px 0;
}

.navbar-brand {
	font-size: 2rem;
	color: #f0f0f0;
	font-weight: bold;
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

.dashboard-section {
	background-color: #ffffff;
	border-radius: 12px;
	box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
	padding: 10px;
	margin-top: 30px;
}

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
</style>
</head>
<body>

	<div class="bg-secondary">
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg navbar-custom">
			<div class="container">
				<a class="navbar-brand fs-1 text-light" href="#">Shop Zone</a>
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

		<!-- Dashboard Section -->
		<div class="container-fluid dashboard-section">
			<div class="row">
				<!-- Graph Section for Monthly Sales -->
				<div class="col-lg-12 text-center">
					<h2>Monthly Sales Chart</h2>
					<canvas id="monthlySalesChart"></canvas>
				</div>
			</div>

			<%
                // Database connection setup
                String dbURL = "jdbc:mysql://localhost:3306/shop_zone";
                String dbUser = "root";
                String dbPassword = "";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                StringBuilder jsonData = new StringBuilder();

                try {
                    // Establish connection to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = connection.getcon();  
                    stmt = conn.createStatement();

                    // SQL query to get monthly sales data
                    String query = "SELECT MONTH(od.order_date) AS month, YEAR(od.order_date) AS year, " +
                                   "SUM(oli.quantity * (p.show_price - ((p.show_price * p.discount) / 100))) AS total_sales " +
                                   "FROM order_line_item oli " +
                                   "JOIN product p ON oli.pro_id = p.pro_id " +
                                   "JOIN orders od ON oli.order_id = od.order_id " +
                                   "GROUP BY YEAR(od.order_date), MONTH(od.order_date) " +
                                   "ORDER BY year DESC, month DESC";
                    rs = stmt.executeQuery(query);

                    // Format the data as JSON
                    jsonData.append("[");
                    while (rs.next()) {
                        if (jsonData.length() > 1) {
                            jsonData.append(",");
                        }
                        jsonData.append("{");
                        jsonData.append("\"month\":").append(rs.getInt("month")).append(",");
                        jsonData.append("\"year\":").append(rs.getInt("year")).append(",");
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
			<script>
    // Parse the JSON data from JSP
    const salesData = <%= jsonData.toString() %>;

    // Create a mapping of months with their sales (0 if no data exists for that month)
    const allMonths = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];

    // Initialize sales data for each month as 0
    const sales = new Array(12).fill(0);

    // Map the sales data to the correct months
    salesData.forEach(item => {
        // Correct the mapping by using the month index (0-based)
        const monthIndex = item.month - 1; // Since month is 1-based (1=January, 12=December)
        sales[monthIndex] = item.total_sales; // Assign sales to the correct month index
    });

    // Create the chart
    const ctx = document.getElementById("monthlySalesChart").getContext("2d");
    const monthlySalesChart = new Chart(ctx, {
        type: "bar", // Bar chart
        data: {
            labels: allMonths, // All 12 months on X-axis
            datasets: [{
                label: "Monthly Sales",
                data: sales, // Y-axis: Sales data (with 0s for no sales months)
                backgroundColor: "rgba(75, 192, 192, 0.6)", // Bar color
                borderColor: "rgba(75, 192, 192, 1)", // Border color for the bars
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: {
                    title: {
                        display: true,
                        text: "Month"
                    },
                    ticks: {
                        autoSkip: false,  // Prevent skipping labels
                        maxRotation: 45, // Rotate X-axis labels if needed
                        minRotation: 45
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: "Total Sales (Currency)"
                    },
                    ticks: {
                        beginAtZero: true,  // Ensure the Y-axis starts at 0
                    }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: "top"
                }
            }
        }
    });
</script>
		</div>
	</div>

	<!-- Bootstrap JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
