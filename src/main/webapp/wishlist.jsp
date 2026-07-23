<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, project.connection"%>

<%
Cookie[] c = request.getCookies();
String u = null;
int userId = -1; // Initialize userId with a default value

if (c != null) {
	for (Cookie cookie : c) {
		if (cookie.getName().equals("username")) {
	u = cookie.getValue();
		}
		if (cookie.getName().equals("user_id")) {
	userId = Integer.parseInt(cookie.getValue());
		}
	}
}

// If userId or username is not found, redirect to login page
if (userId == -1 || u == null) {
	response.sendRedirect("login.jsp"); // Redirect to your login page
	return; // Ensure the rest of the code is not executed
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>SHOP ZONE</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="Free HTML Templates" name="keywords">
<meta content="Free HTML Templates" name="description">

<!-- Favicon -->
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">

<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="css/style.css" rel="stylesheet">
</head>

<body>
	<!-- Topbar Start -->
	<div class="container-fluid">

		<div
			class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex">
			<div class="col-lg-4">
				<a href="" class="text-decoration-none"> <span
					class="h1 text-uppercase text-primary bg-dark px-2">SHOP</span> <span
					class="h1 text-uppercase text-dark bg-primary px-2 ml-n1">ZONE</span>
				</a>
			</div>

			<div class="col-lg-8 col-6 text-right">
				<p class="m-0">

					<%
					Cookie[] cookies = request.getCookies();
					String username = null;
					int user_id = -1;

					if (cookies != null) {
						for (Cookie cookie : cookies) {
							if (cookie.getName().equals("username")) {
						username = cookie.getValue();
						break;
							}
						}
					}

					if (cookies != null) {
						for (Cookie cookie : cookies) {
							if (cookie.getName().equals("user_id")) {
						String s = cookie.getValue();
						user_id = Integer.parseInt(s);
						break;
							}
						}
					}
					%>
				</p>
				<h5 class="mr-0">
					<%
					boolean is_logged = false;
					if (username != null) {
						out.print("Welcome " + username);
						is_logged = true;
					} else {
						out.print("Welcome User");
						is_logged = false;
					}
					%>
				</h5>

			</div>
		</div>
	</div>
	<!-- Topbar End -->


	<!-- Navbar Start -->


	<%--     <%@ page import="java.sql.*, project.connection" %> --%>
	<%
	// Declare all variables outside the try block to avoid redeclaration
	Connection conn = null;
	Statement stmtParent = null;
	Statement stmtSub = null;
	ResultSet rsParent = null;
	ResultSet rsSub = null;
	%>

	<div class="container-fluid bg-dark mb-30">
		<div class="row px-xl-5">
			<div class="col-lg-3 d-none d-lg-block">
				<a
					class="btn d-flex align-items-center justify-content-between bg-primary w-100"
					data-toggle="collapse" href="#navbar-vertical"
					style="height: 65px; padding: 0 30px;">
					<h6 class="text-dark m-0">
						<i class=" mr-2"></i>Categories
					</h6> <i class="fa fa-angle-down text-dark"></i>
				</a>
				<nav
					class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 bg-light"
					id="navbar-vertical"
					style="width: calc(100% - 30px); z-index: 999;">
					<div class="navbar-nav w-100">
						<%
						try {
							// Get the connection using your project connection class
							conn = connection.getcon();

							// Parent categories query
							stmtParent = conn.createStatement();
							rsParent = stmtParent.executeQuery("SELECT * FROM parent_category");

							// Loop through parent categories
							while (rsParent.next()) {
								int parentCatId = rsParent.getInt("p_cat_id");
								String parentCategoryName = rsParent.getString("p_cat_name");
						%>
						<div class="nav-item dropdown dropright">
							<a href="#" class="nav-link dropdown-toggle"
								data-toggle="dropdown"> <%=parentCategoryName%> <i
								class="fa fa-angle-right float-right mt-1"></i>
							</a>
							<div
								class="dropdown-menu position-absolute rounded-0 border-0 m-0">
								<%
								// Subcategory query for the current parent category
								stmtSub = conn.createStatement();
								rsSub = stmtSub.executeQuery("SELECT * FROM sub_category WHERE p_cat_id = " + parentCatId);

								while (rsSub.next()) {
									String subCategoryName = rsSub.getString("sub_cat_name");
								%>
								<a href="#" class="dropdown-item"><%=subCategoryName%></a>
								<%
								}
								rsSub.close();
								stmtSub.close(); // Close subcategory statement and result set after use
								%>
							</div>
						</div>
						<%
						}
						} catch (Exception e) {
						e.printStackTrace();
						} finally {
						// Close resources
						if (rsParent != null)
						rsParent.close();
						if (stmtParent != null)
						stmtParent.close();
						if (conn != null)
						conn.close();
						}
						%>
					</div>
				</nav>


			</div>

			<div class="col-lg-9">
				<nav
					class="navbar navbar-expand-lg bg-dark navbar-dark py-3 py-lg-0 px-0">
					<!--                     <a href="" class="text-decoration-none d-block d-lg-none"> -->
					<!--                         <span class="h1 text-uppercase text-dark bg-light px-2">Multi</span> -->
					<!--                         <span class="h1 text-uppercase text-light bg-primary px-2 ml-n1">Shop</span> -->
					<!--                     </a> -->

					<button type="button" class="navbar-toggler" data-toggle="collapse"
						data-target="#navbarCollapse">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse justify-content-between"
						id="navbarCollapse">
						<div class="navbar-nav mr-auto py-0">
							<a href="index.jsp" class="nav-item nav-link active">Home</a> <a
								href="shop.jsp" class="nav-item nav-link">Shop</a>
						</div>
						<div class="navbar-nav ml-auto py-0 d-none d-lg-block">
							<div class="btn-group mr-2 ">
								<button type="button"
									class="btn btn-sm btn-light dropdown-toggle rounded"
									data-toggle="dropdown">My Account</button>
								<div class="dropdown-menu dropdown-menu-right">


									<%
									if (is_logged) {
									%>
									<a href="logout.jsp"><button class="dropdown-item"
											type="button">Logout</button></a>
									<%
									} else {
									%>
									<a href="signup.jsp"><button class="dropdown-item"
											type="button">Sign up</button></a> <a href="login.jsp"><button
											class="dropdown-item" type="button">Sign in</button></a>
									<%
									}
									%>

									<!-- <a href="logout.jsp"><button class="dropdown-item" type="button">logout</button></a> -->
								</div>
							</div>
							<!-- 							<a href="wish_list.jsp" class="btn px-0"> <i -->
							<!-- 								class="fas fa-heart text-primary"></i> <span -->
							<!-- 								class="badge text-secondary border border-secondary rounded-circle" -->
							<!-- 								style="padding-bottom: 2px;">0</span> -->
							<!-- 							</a> -->
							<a href="cust_cart.jsp" class="btn px-0 ml-3"> <i
								class="fas fa-shopping-cart text-primary"></i> <span
								class="badge text-secondary border border-secondary rounded-circle"
								style="padding-bottom: 2px;">0</span>
							</a>
						</div>
					</div>
				</nav>
			</div>
		</div>
	</div>
	<!-- Navbar End -->


	<div class="center text-center text-uppercase h1">
		<p>Wishlist</p>
	</div>


	<!-- Cart Start -->
	<%
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	try {
		// Assuming you have a connection provider class
		con = project.connection.getcon();

		// Replace 1 with the actual customer ID (c_id)
		
// 		String query = "SELECT p.pro_id, p.title, p.show_price, c.quantity, (p.show_price * c.quantity) AS total, i.path FROM wishlist c JOIN product p ON c.pro_id = p.pro_id JOIN image i ON p.pro_id = i.pro_id WHERE c.c_id = ?";
		
// 		SELECT p.pro_id, p.title, p.show_price, c.quantity, 
//        (p.show_price * c.quantity) AS total, i.path
// FROM wishlist c
// JOIN product p ON c.pro_id = p.pro_id
// JOIN image i ON p.pro_id = i.pro_id
// WHERE c.c_id = ?

		
		String query = "SELECT p.pro_id, p.title, p.show_price, c.quantity, (p.show_price * c.quantity) AS total, i.path "
		+ "FROM wishlist c " + "JOIN product p ON c.pro_id = p.pro_id " + "JOIN image i ON p.pro_id = i.pro_id "
		+ "WHERE c.c_id = ?"; // Assuming session contains customer id

		ps = con.prepareStatement(query);
		ps.setInt(1, user_id); // Replace 1 with the actual customer ID

		rs = ps.executeQuery();
	%>
	<div class="container-fluid">
		<div class="row px-xl-5">
			<div class="col-lg-8 table-responsive mb-5">
				<table
					class="table table-light table-borderless table-hover text-center mb-0">
					<thead class="thead-dark">
						<tr>
							<th>Products</th>
							<th>Price</th>
							<!--                         <th>Quantity</th> -->
							<!--                         <th>Total</th> -->
							<th>Move To Cart</th>
							<th>Remove</th>
						</tr>
					</thead>
					<tbody class="align-middle">
						<%
						double grandTotal = 0;
						while (rs.next()) {
							String proId = rs.getString("pro_id");
							String title = rs.getString("title");
							double price = rs.getDouble("show_price");
							int quantity = rs.getInt("quantity");
							double total = rs.getDouble("total");
							String imgPath = rs.getString("path");

							grandTotal += total;
						%>

						<tr>
							<td class="align-middle"><a
								href="product_detailed_page.jsp?pro_id=<%=proId%>"
								class="text-dark"> <img src="<%=imgPath%>" alt="<%=title%>"
									style="width: 130px; height: 150px"> <%=title%>

							</a></td>
							<td class="align-middle">$<%=price%></td>

							<td class="align-middle">
								<button class="btn btn-sm btn-warning"
									onclick="removeFromCart('<%=proId%>')">
									<!-- <i class="fa fa-times"></i> -->
									Move to Cart
								</button>
							</td>
							<td class="align-middle">
								<button class="btn btn-sm btn-danger"
									onclick="removeFromCart('<%=proId%>')">
									<i class="fa fa-times"></i>
								</button>
							</td>

						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
			<!--         <div class="col-lg-4"> -->
			<!--             <h5 class="section-title position-relative text-uppercase mb-3"><span class="bg-secondary pr-3">Cart Summary</span></h5> -->
			<!--             <div class="bg-light p-30 mb-5"> -->
			<!--                 <div class="border-bottom pb-2"> -->
			<!--                     <div class="d-flex justify-content-between mb-3"> -->
			<!--                         <h6>Subtotal</h6> -->
			<%--                         <h6>Rs. <%=grandTotal%></h6> --%>
			<!--                     </div> -->
			<!--                     <div class="d-flex justify-content-between"> -->
			<!--                         <h6 class="font-weight-medium">Shipping</h6> -->
			<!--                         <h6 class="font-weight-medium">Rs. 0</h6> -->
			<!--                     </div> -->
			<!--                 </div> -->
			<!--                 <div class="pt-2"> -->
			<!--                     <div class="d-flex justify-content-between mt-2"> -->
			<!--                         <h5>Total</h5> -->
			<%--                         <h5><%= "Rs. "+grandTotal %></h5> --%>
			<!--                     </div> -->
			<!--                     <button class="btn btn-block btn-primary font-weight-bold my-3 py-3">Proceed To Checkout</button> -->
			<!--                 </div> -->
			<!--             </div> -->
			<!--         </div> -->
		</div>
	</div>

	<script>
		function updateQuantity(proId, quantity) {
			if (quantity <= 0)
				return; // Prevent quantity from going below 1

			// Send an AJAX request to update the quantity in the cart
			var xhr = new XMLHttpRequest();
			xhr.open('POST', 'update_cart.jsp', true);
			xhr.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					location.reload(); // Reload the page to reflect changes
				}
			};
			xhr.send('pro_id=' + proId + '&quantity=' + quantity);
		}

		function removeFromCart(proId) {
			// Send an AJAX request to remove the product from the cart
			var xhr = new XMLHttpRequest();
			xhr.open('POST', 'remove_cart.jsp', true);
			xhr.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					location.reload(); // Reload the page to reflect changes
				}
			};
			xhr.send('pro_id=' + proId);
		}
	</script>

	<%
	} catch (SQLException e) {
	e.printStackTrace();
	} finally {
	if (rs != null)
		rs.close();
	if (ps != null)
		ps.close();
	if (con != null)
		con.close();
	}
	%>


	<!-- Cart End -->


	<!-- Footer Start -->
	<div class="container-fluid bg-dark text-secondary mt-5 pt-5">
		<div class="row px-xl-5 pt-5">
			<div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
				<h5 class="text-secondary text-uppercase mb-4">Get In Touch</h5>
				<p class="mb-4">No dolore ipsum accusam no lorem. Invidunt sed
					clita kasd clita et et dolor sed dolor. Rebum tempor no vero est
					magna amet no</p>
				<p class="mb-2">
					<i class="fa fa-map-marker-alt text-primary mr-3"></i>j-112,
					shivalik complex, new-ranip road, ahmedabad, gujarat, india
				</p>
				<p class="mb-2">
					<i class="fa fa-envelope text-primary mr-3"></i>shop_zone@gmail.com
				</p>
				<!--                 <p class="mb-0"><i class="fa fa-phone-alt text-primary mr-3"></i>+012 345 67890</p> -->
			</div>
			<div class="col-lg-8 col-md-12">
				<div class="row">
					<div class="col-md-4 mb-5">
						<h5 class="text-secondary text-uppercase mb-4">Quick Shop</h5>
						<div class="d-flex flex-column justify-content-start">
							<a class="text-secondary mb-2" href="#"><i
								class="fa fa-angle-right mr-2"></i>Home</a> <a
								class="text-secondary mb-2" href="#"><i
								class="fa fa-angle-right mr-2"></i>Our Shop</a> <a
								class="text-secondary mb-2" href="#"><i
								class="fa fa-angle-right mr-2"></i>Shop Detail</a> <a
								class="text-secondary mb-2" href="#"><i
								class="fa fa-angle-right mr-2"></i>Shopping Cart</a> <a
								class="text-secondary mb-2" href="#"><i
								class="fa fa-angle-right mr-2"></i>Checkout</a> <a
								class="text-secondary" href="#"><i
								class="fa fa-angle-right mr-2"></i>Contact Us</a>
						</div>
					</div>

				</div>
			</div>
		</div>

	</div>
	<!-- Footer End -->



	<!-- Back to Top -->
	<!--     <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a> -->


	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>

	<!-- Contact Javascript File -->
	<script src="mail/jqBootstrapValidation.min.js"></script>
	<script src="mail/contact.js"></script>

	<!-- Template Javascript -->
	<script src="js/main.js"></script>
</body>

</html>