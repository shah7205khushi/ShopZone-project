<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Management</title>
<!-- Bootstrap link -->
<link rel="stylesheet" href="../bootstrap.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- JavaScript for Bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	margin: 0;
	padding: 0;
}

.insert {
	width: 30%;
	text-align: center;
	font-size: larger;
	border-radius: 30px;
	margin-left: 35%;
	margin-bottom: 20px;
}

.table img {
	width: 100px;
	height: 100px;
	object-fit: cover;
}

.navbar-brand {
	font-size: 1.5rem;
}

.n {
	font-size: 35px;
}

.btn-custom {
	width: 200px;
	font-size: 16px;
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="bg-dark navbar navbar-expand-lg navbar-custom">
		<div class="container">
			<a class="n fs-1 navbar-brand text-light" href="#">Shop Zone</a>
			<div class="mr-5">
				<a href="admin_logout.jsp" class="btn btn-danger">Logout</a> <a
					href="admin_dashboard.jsp" class="btn btn-warning">Back</a>
			</div>
		</div>
	</nav>

	<div class="container mt-5">
		<center>
			<!-- Sales Report Button -->
			<a href="generate_sales_report.jsp"
				class="btn btn-success btn-custom">Sales Report</a>
			<!-- Sales Report Button -->
			<a href="generate_sales_by_product.jsp"
				class="btn btn-success btn-custom"> Product Report</a>
		</center>
	</div>
</body>
</html>
