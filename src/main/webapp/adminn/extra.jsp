<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, jakarta.servlet.http.HttpSession ,project.connection"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.jfree.chart.entity.*"%>
<%@ page import="org.jfree.chart.labels.*"%>
<%@ page import="org.jfree.chart.plot.*"%>
<%@ page import="org.jfree.chart.renderer.*"%>
<%@ page import="org.jfree.chart.urls.*"%>
<%@ page import="org.jfree.data.category.*"%>
<%@ page import="org.jfree.data.general.*"%>
<%@ page import="org.jfree.chart.axis.*"%>
<%@ page import="org.jfree.data.category.*"%>
<% 
    // Get the session object
    HttpSession s = request.getSession(false);

    // Check if the session is valid and if the admin is logged in
//       String adminId = (String) s.getAttribute("admin_id");
    
    String adminName = (String) s.getAttribute("admin_name");
//     String adminEmail = (String) s.getAttribute("admin_email");

    if (adminName == null ) {
        // Redirect to login page if session variables are not set
        response.sendRedirect("admin_login.jsp");
        return; // Stop further execution if not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<style>
/* Body background with gradient */
body {
	/*             background: linear-gradient(135deg, #6a11cb, #2575fc); */
	font-family: 'Arial', sans-serif;
	overflow: hidden;
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
					<div
						class="w-75 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
						<!--     		<div class="fs-1 "> -->
						<a href="customer_management.jsp" class="btn btn-success  fs-3">Customer</a>
						<!--     		</div> -->
					</div>

					<div
						class="w-75 bg-success justify-content-center d-flex text-center rounded-3 mb-3">
						<!--     		<div class="fs-1 "> -->
						<a href="order_management.jsp" class="btn btn-success  fs-3">Order</a>
						<!--     		</div> -->
					</div>

					<div
						class="w-75 bg-success justify-content-center d-flex text-center rounded-3 mb-3">
						<!--     		<div class="fs-1 "> -->
						<a href="product_management.jsp" class="btn btn-success  fs-3">Product</a>
						<!--     		</div> -->
					</div>

					<div
						class="w-75 bg-success justify-content-center d-flex text-center rounded-3 mb-3">
						<!--     		<div class="fs-1 "> -->
						<a href="insert_category.jsp" class="btn btn-success  fs-3">Category</a>
						<!--     		</div> -->
					</div>
					<div
						class="w-75 bg-success justify-content-center d-flex text-center rounded-3 mb-3">
						<!--     		<div class="fs-1 "> -->
						<a href="delivery_person_management.jsp"
							class="btn btn-success  fs-3">Delivery Person</a>
						<!--     		</div> -->
					</div>
					<div
						class="w-75 bg-success justify-content-center d-flex text-center rounded-3 mb-3">
						<!--     		<div class="fs-1 "> -->
						<a href="report.jsp" class="btn btn-success  fs-3">report</a>
						<!--     		</div> -->
					</div>
				</div>


				<!-- graph -->
				<div>
					<%
    final double[][] data = new double[][]{
        {210, 300, 320, 265, 299},
        {200, 230, 300, 320, 340}
    };
    
    final CategoryDataset dataset = DatasetUtilities.createCategoryDataset("Cricket Team", "", data);
    JFreeChart chart = null;
    BarRenderer renderer3D = null;
    CategoryPlot plot = null;
    
    final CategoryAxis3D categoryAxis = new CategoryAxis3D("Match");
    final ValueAxis valueAxis = new NumberAxis3D("Run");
    
    plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer3D);
    plot.setOrientation(PlotOrientation.VERTICAL);
    chart = new JFreeChart("Score Board", JFreeChart.DEFAULT_TITLE_FONT, plot, true); // Fixed the typo here
    chart.setBackgroundPaint(new Color(249, 231, 238));
    
    try {
        final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection()); // Fixed typo: Standerd to Standard
        final File file1 = new File("img/admin_dashboard.jpg"); // Adjust path accordingly
        ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
    } catch (Exception e) {
        out.println(e);
    }
%>

				</div>

			</div>

			<!--        
    </div>

    <!-- Dynamic Content Section -->
			<!--     <div class="container my-5" > -->
			<%--         <% --%>
			<!-- //             String pageName = request.getParameter("insert_category"); -->
			<!-- //             if (pageName != null && pageName.equals("insert_category")) { -->
			<!-- //                 RequestDispatcher rd = request.getRequestDispatcher("insert_category.jsp"); -->
			<!-- //                 rd.include(request, response); -->
			<!-- //             } -->

			<!-- //             pageName = request.getParameter("view_products"); -->
			<!-- //             if (pageName != null && pageName.equals("view_products")) { -->
			<!-- //                 RequestDispatcher rd = request.getRequestDispatcher("view_products.jsp"); -->
			<!-- //                 rd.include(request, response); -->
			<!-- //             } -->
			<%--         %> --%>
			<!--     </div> -->
		</div>
		<!-- Bootstrap JS Bundle -->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>