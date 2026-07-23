<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, project.connection"%>

<%
// Get the session object
HttpSession s = request.getSession(false);

String user_id = (String) s.getAttribute("user_id");
String username = (String) s.getAttribute("username");

if (user_id == null) {
	
	
    out.println("<script>alert('Please login to add items to your wishlist.'); window.location.href='login.jsp';</script>");
    return;
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
				<p class="m-0"></p>
				<h5 class="mr-0">
					<%
					boolean is_logged = false;
					if (username != null) {
						out.print("Welcome " + username);
						// 						out.print(user_id + username+user_email);
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
						<div class="nav-item">
							<a href="shop.jsp?filter_option_gender=<%=parentCatId%>"
								class="nav-link"> <%=parentCategoryName%>
							</a>
						</div>
						<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Close resources
			if (rsParent != null) rsParent.close();
			if (stmtParent != null) stmtParent.close();
			if (conn != null) conn.close();
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
							<a href="index.jsp" class="nav-item nav-link active">Home</a>
							<!-- 							<a href="shop.jsp" class="nav-item nav-link">Shop</a> -->
						</div>
						<div class="navbar-nav ml-auto py-2 d-none d-lg-block">
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
									<!-- 											<a href="edit_profile.jsp"><button -->
									<!-- 											class="dropdown-item" type="button">Edit Profile</button></a>  -->
									<a href="order_history.jsp"><button class="dropdown-item"
											type="button">Order History</button></a> <a
										href="profile_page.jsp"><button class="dropdown-item"
											type="button">Your profile</button></a>
									<%
									} else {
									%>
									<a href="signup.jsp"><button class="dropdown-item"
											type="button">Sign up</button></a> <a href="login.jsp"><button
											class="dropdown-item" type="button">Sign in</button></a>

									<%
									}
									%>

									<!--                             <a href="logout.jsp"><button class="dropdown-item" type="button">logout</button></a> -->
								</div>
							</div>
							<%
							// Retrieve the customer_id from the cookie
							// 							String user_id = null;
							// 							Cookie[] cookies = request.getCookies();
							// 							if (cookies != null) {
							// 								for (Cookie cookie : cookies) {
							// 									if (cookie.getName().equals("user_id")) {
							// 								user_id = cookie.getValue();
							// 								break;
							// 									}
							// 								}
							// 							}

							int wishListCount = 0;
							int cartCount = 0;

							// If customer_id is available, query the database for wishlisted and cart items
							if (user_id != null) {
								try {
									Connection con = connection.getcon();

									// Query to count wishlist items
									String wishlistSQL = "SELECT COUNT(*) FROM wishlist WHERE c_id = ?";
									PreparedStatement psWishlist = con.prepareStatement(wishlistSQL);
									psWishlist.setString(1, user_id);
									ResultSet rsWishlist = psWishlist.executeQuery();
									if (rsWishlist.next()) {
								wishListCount = rsWishlist.getInt(1); // Get the wishlist count
									}

									// Query to count cart items
									String cartSQL = "SELECT COUNT(*) FROM cart WHERE c_id = ?";
									PreparedStatement psCart = con.prepareStatement(cartSQL);
									psCart.setString(1, user_id);
									ResultSet rsCart = psCart.executeQuery();
									if (rsCart.next()) {
								cartCount = rsCart.getInt(1); // Get the cart count
									}
								} catch (Exception e) {
									System.out.println("Error: " + e);
								}
							}
							%>

							<!-- Display the wishlist and cart counts -->
							<!-- 							<a href="wish_list.jsp" class="btn px-0"> <i -->
							<!-- 								class="fas fa-heart text-primary"></i> <span -->
							<!-- 								class="badge text-secondary border border-secondary rounded-circle" -->
							<%-- 								style="padding-bottom: 2px;"> <%=wishListCount%> --%>
							<!-- 							</span> -->
							<!-- 							</a> -->
							<a href="cust_cart.jsp" class="btn px-0 ml-3"> <i
								class="fas fa-shopping-cart text-primary"></i> <span
								class="badge text-secondary border border-secondary rounded-circle"
								style="padding-bottom: 2px;"> <%=cartCount%>
							</span>
							</a>
						</div>
					</div>
				</nav>
			</div>
		</div>
	</div>
	<!-- Navbar End -->


	<!-- <div class="center text-center text-uppercase h1"> -->
	<!--     <p>Wishlist</p> -->
	<!-- </div> -->


	<!-- whishlist -->
	<%
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	boolean isEmptyWishlist = true; // Flag to check if wishlist is empty

	try {
		// Assuming you have a connection provider class
		con = project.connection.getcon();
// out.print(1);
		String query = "SELECT c.pro_id, p.title, p.show_price, p.stock, p.discount, i.path " + "FROM wishlist c "
		+ "JOIN product p ON c.pro_id = p.pro_id " + "JOIN image i ON p.pro_id = i.pro_id " + "WHERE c.c_id = ?";

// 		out.print(1);
		ps = con.prepareStatement(query);
		ps.setInt(1, Integer.parseInt(user_id)); // Make sure 'userId' is used

		rs = ps.executeQuery();
		out.print(1);
		// Check if there are any results in the wishlist
		if (!rs.isBeforeFirst()) {
			// No products in the wishlist
	%>
	<div class="center text-center text-uppercase h1">
		<p>Wishlist is Empty</p>
	</div>
	<%
	} else {
	isEmptyWishlist = false;
	%>
	<div class="center text-center text-uppercase h1">
		<p>Wishlist</p>
	</div>
	<%
	}
	// Only display the wishlist table if it's not empty
	if (!isEmptyWishlist) {
	%>
	<div class="container-fluid">
		<div class="row px-xl-5">
			<div class="col-lg-10 table-responsive mb-5">
				<table
					class="table table-light table-borderless table-hover text-center mb-0">
					<thead class="thead-dark">
						<tr>
							<th>Products</th>
							<th>Price</th>
							<th>Move To Cart</th>
							<th>Remove</th>
						</tr>

					</thead>
					<tbody class="align-middle">
						<%
// 						out.print(1);
						double grandTotal = 0;
						while (rs.next()) {
							String proId = rs.getString("pro_id");
							String title = rs.getString("title");
							double price = rs.getDouble("show_price");
							double discount = rs.getDouble("discount");
							String imgPath = rs.getString("path");
							int stock = rs.getInt("stock");
							int discountPrice = (int) (price - ((price * discount) / 100));
							grandTotal += price;
						%>
						<tr>

							<td class="align-middle">
								<%
    if (rs.getInt("stock") == 0) {
%>
								<div class="text-danger mt-2 h3">out of stock.</div> <%
    }
%> <a href="product_detail.jsp?pro_id=<%=proId%>" class="text-dark">
									<img src="<%=imgPath%>" alt="<%=title%>"
									style="width: 130px; height: 150px"> <%=title%>
							</a>
							</td>
							<td class="align-middle">Rs. <%=discountPrice%></td>
							<td class="align-middle"><a
								href="move_to_cart.jsp?pro_id=<%=proId%>&user_id=<%=user_id%>">
									<button class="btn btn-sm btn-warning">Move to Cart</button>
							</a></td>
							<td class="align-middle"><a
								href="remove_from_wishlist.jsp?pro_id=<%=proId%>&user_id=<%=user_id%>">
									<button class="btn btn-sm btn-danger"
										onclick="removeFromCart('<%=proId%>')">
										<i class="fa fa-times"></i>
									</button>
							</a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%
	}
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
	<!-- whishlist -->


	<!-- Footer Start -->
	<div class="container-fluid bg-dark text-secondary mt-5 pt-5">
		<div class="row px-xl-5 pt-5">
			<div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
				<h5 class="text-secondary text-uppercase mb-4">Get In Touch</h5>
				<p class="mb-4">At Shop Zone, we offer a wide variety of stylish
					and comfortable clothing for men, women, and kids. From trendy
					outfits to classic wardrobe essentials. Explore our collection and
					find the perfect pieces for you and your family!</p>

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
					<div class="col-md-4 mb-5"></div>

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