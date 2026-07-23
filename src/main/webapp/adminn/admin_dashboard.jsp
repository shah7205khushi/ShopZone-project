<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, jakarta.servlet.http.HttpSession ,project.connection"%>

<%
// Get the session object
HttpSession s = request.getSession(false);

// Check if the session is valid and if the admin is logged in
//       String adminId = (String) s.getAttribute("admin_id");

String adminName = (String) s.getAttribute("admin_name");
//     String adminEmail = (String) s.getAttribute("admin_email");

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
<!-- <link rel="stylesheet" href="../css/bootstrap.css"> -->
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
	/* 	overflow: hidden; */
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

			<div class="row  ">
				<div class="col-lg-3">
					<a href="customer_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3"><div
							class="w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
							<!--     		<div class="fs-1 "> -->
							Customer
							<!--     		</div> -->
						</div></a> <a href="order_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3"><div
							class="w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
							<!--     		<div class="fs-1 "> -->
							Order
							<!--     		</div> -->
						</div></a> <a href="product_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3"><div
							class="w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
							<!--     		<div class="fs-1 "> -->
							Product
							<!--     		</div> -->
						</div></a> <a href="admin_manage_category.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3"><div
							class="w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
							<!--     		<div class="fs-1 "> -->
							Category
							<!--     		</div> -->
						</div></a> <a href="delivery_person_management.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3"><div
							class="w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
							<!--     		<div class="fs-1 "> -->
							Delivery Person
							<!--     		</div> -->
						</div></a> <a href="report_managment.jsp"
						class="btn btn-success w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2 fs-3"><div
							class="w-100 bg-success justify-content-center d-flex text-center rounded-3 mb-2">
							<!--     		<div class="fs-1 "> -->
							Report
							<!--     		</div> -->
						</div></a>

				</div>
				<!--     graph -->
				<div class="col-lg-9 mr-3">
					<div class="row">
						<div
							class="col-lg-4 text-center bg-primary text-white p-3 mb-3 rounded">1
							of 2</div>
						<div
							class="col-lg-4 text-center bg-success text-white p-3 mb-3 rounded">2
							of 2</div>
						<div
							class="col-lg-4 text-center bg-warning text-dark p-3 mb-3  rounded">1
							of 3</div>
					</div>
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










