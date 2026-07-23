<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="project.connection"%>
<!-- Import your connection provider class -->

<%@page import="jakarta.servlet.http.HttpSession"%>
<% 
    // Get the session object
    HttpSession s = request.getSession(false);


    // Check if the session is valid and if the cust is logged in
//       String adminId = (String) s.getAttribute("admin_id");
    
    String username = (String) s.getAttribute("username");
    String user_id = (String) s.getAttribute("user_id");
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
							<a href="wish_list.jsp" class="btn px-0"> <i
								class="fas fa-heart text-primary"></i> <span
								class="badge text-secondary border border-secondary rounded-circle"
								style="padding-bottom: 2px;"> <%=wishListCount%>
							</span>
							</a> <a href="cust_cart.jsp" class="btn px-0 ml-3"> <i
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


	<!-- Carousel Start -->
	<div class="container-fluid mb-3">
		<div class="row px-xl-5">
			<div class="col-lg-8">
				<div id="header-carousel"
					class="carousel slide carousel-fade mb-30 mb-lg-0"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#header-carousel" data-slide-to="0"
							class="active"></li>
						<li data-target="#header-carousel" data-slide-to="1"></li>
						<li data-target="#header-carousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item position-relative active"
							style="height: 430px;">
							<img class="position-absolute w-100 h-100"
								src="img/carousel-1.jpg" style="object-fit: cover;">
							<div
								class="carousel-caption d-flex flex-column align-items-center justify-content-center">
								<div class="p-3" style="max-width: 700px;">
									<h1
										class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Men
										Fashion</h1>
									<!-- <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p> -->
									<a
										class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp"
										href="shop.jsp?filter_option_gender=1">Shop Now</a>
								</div>
							</div>
						</div>
						<div class="carousel-item position-relative"
							style="height: 430px;">
							<img class="position-absolute w-100 h-100"
								src="img/carousel-2.jpg" style="object-fit: cover;">
							<div
								class="carousel-caption d-flex flex-column align-items-center justify-content-center">
								<div class="p-3" style="max-width: 700px;">
									<h1
										class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Women
										Fashion</h1>
									<!--                                     <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p> -->
									<a
										class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp"
										href="shop.jsp?filter_option_gender=2">Shop Now</a>
								</div>
							</div>
						</div>
						<div class="carousel-item position-relative"
							style="height: 430px;">
							<img class="position-absolute w-100 h-100"
								src="img/carousel-3.jpg" style="object-fit: cover;">
							<div
								class="carousel-caption d-flex flex-column align-items-center justify-content-center">
								<div class="p-3" style="max-width: 700px;">
									<h1
										class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Kid
										Fashion</h1>
									<!--                                     <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p> -->
									<a
										class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp"
										href="shop.jsp?filter_option_gender=3">Shop Now</a>
								</div>
							</div>
						</div>
						<!-- 						<div class="carousel-item position-relative" -->
						<!-- 							style="height: 430px;"> -->
						<!-- 							<img class="position-absolute w-100 h-100" -->
						<!-- 								src="img/carousel-3.jpg" style="object-fit: cover;"> -->
						<!-- 							<div -->
						<!-- 								class="carousel-caption d-flex flex-column align-items-center justify-content-center"> -->
						<!-- 								<div class="p-3" style="max-width: 700px;"> -->
						<!-- 									<h1 -->
						<!-- 										class="display-4 text-white mb-3 animate__animated animate__fadeInDown">Boy Kid -->
						<!-- 										Fashion</h1> -->
						<!-- 									                                    <p class="mx-md-5 px-5 animate__animated animate__bounceIn">Lorem rebum magna amet lorem magna erat diam stet. Sadips duo stet amet amet ndiam elitr ipsum diam</p> -->
						<!-- 									<a -->
						<!-- 										class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" -->
						<!-- 										href="shop.jsp?filter_option_gender=4">Shop Now</a> -->
						<!-- 								</div> -->
						<!-- 							</div> -->
						<!-- 						</div> -->
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="product-offer mb-30" style="height: 200px;">
					<img class="img-fluid" src="img/product_img/img_kids.jpg" alt="">
					<div class="offer-text">
						<!-- 						<h6 class="text-white text-uppercase">20% Discount</h6> -->
						<h3 class="text-white mb-3">Kid Fashion</h3>
						<a href="shop.jsp?filter_option_gender=3" class="btn btn-primary">Shop
							Now</a>
					</div>
				</div>
				<div class="product-offer mb-30" style="height: 200px;">
					<img class="img-fluid" src="img/offer-2.jpg" alt="">
					<div class="offer-text">
						<!-- 						<h6 class="text-white text-uppercase">60% Discount</h6> -->
						<h3 class="text-white mb-3">Women Fashion</h3>
						<a href="shop.jsp?filter_option_gender=2" class="btn btn-primary">Shop
							Now</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Carousel End -->


	<!-- Featured Start -->
	<div class="container-fluid pt-5">
		<div class="row px-xl-5 pb-3">
			<div class="col-lg-4 col-md-6 col-sm-12 pb-1">
				<div class="d-flex align-items-center bg-light mb-4"
					style="padding: 30px;">
					<h1 class="fa fa-check text-primary m-0 mr-3"></h1>
					<h5 class="font-weight-semi-bold m-0">Quality Product</h5>
				</div>
			</div>
			<div class="col-lg-4 col-md-6 col-sm-12 pb-1">
				<div class="d-flex align-items-center bg-light mb-4"
					style="padding: 30px;">
					<h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>
					<h5 class="font-weight-semi-bold m-0">Free Shipping</h5>
				</div>
			</div>
			<div class="col-lg-4 	col-md-6 col-sm-12 pb-1">
				<div class="d-flex align-items-center bg-light mb-4"
					style="padding: 30px;">
					<h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>
					<h5 class="font-weight-semi-bold m-0">14-Day cancel order</h5>
				</div>
			</div>
		</div>
	</div>
	<!-- Featured End -->

	<!-- Categories Start -->
	<div class="container-fluid pt-5">
		<h2
			class="section-title position-relative text-uppercase mx-xl-5 mb-4">
			<span class="bg-secondary pr-3">Shop by Category</span>
		</h2>

		<% 
    // Establish a database connection
    Connection con = connection.getcon();
    if (con != null) { 
        // Map of group names to their p_cat_id
        LinkedHashMap<String, Integer> categoryMap = new LinkedHashMap<>();
        categoryMap.put("Men", 1); // p_cat_id for Men
        categoryMap.put("Women", 2); // p_cat_id for Women
        categoryMap.put("Kids", 3); // p_cat_id for Girl Kid
//         categoryMap.put("Boy Kid", 4); // p_cat_id for Boy Kid

        // Loop through the category map
        for (Map.Entry<String, Integer> entry : categoryMap.entrySet()) {
            String group = entry.getKey();
            int pCatId = entry.getValue();
    %>
		<h3 class="section-subtitle text-uppercase mx-xl-5 mt-4 mb-3">
			<span class="bg-gray pr-2"><%= group %></span>
		</h3>
		<div class="row px-xl-5 pb-3">
			<%
            // Fetch subcategories for the current p_cat_id
            String sqlSub = "SELECT * FROM sub_category WHERE p_cat_id = ? ORDER BY sub_cat_name"; // Fetch sorted subcategories
            PreparedStatement psSub = con.prepareStatement(sqlSub);
            psSub.setInt(1, pCatId);
            ResultSet r = psSub.executeQuery();

            while (r.next()) {
                String sub_cat_id = r.getString("sub_cat_id");
                String subCatName = r.getString("sub_cat_name");
                String subCatPicPath = r.getString("sub_cat_pic_path");
                int total_pro = r.getInt("total_products");

            %>

			<div class="col-lg-3 col-md-4 col-sm-6 pb-1">
				<a class="text-decoration-none"
					href="shop.jsp?filter_option_gender=<%= pCatId %>&category=<%= sub_cat_id %>">
					<div class="cat-item d-flex align-items-center mb-4">
						<div class="overflow-hidden" style="width: 100px; height: 100px;">
							<img class="img-fluid" src="<%= subCatPicPath %>"
								alt="<%= subCatName %>">
						</div>
						<div class="flex-fill pl-3">
							<h6><%= subCatName %></h6>
							<%--                             <small class="text-body"><%= total_pro + " Products" %></small> --%>
						</div>
					</div>
				</a>
			</div>

			<%
            }
            r.close();
            psSub.close();
            %>
		</div>
		<% 
        }
        con.close(); // Close the connection
    } else { 
        out.println("<p>Failed to connect to the database.</p>");
    } 
    %>
	</div>
	<!-- Categories End -->



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
					<div class="col-md-4 mb-5">
						<!-- 						<h5 class="text-secondary text-uppercase mb-4">Quick Shop</h5> -->
						<!-- 						<div class="d-flex flex-column justify-content-start"> -->
						<!-- 							<a class="text-secondary mb-2" href="#"><i -->
						<!-- 								class="fa fa-angle-right mr-2"></i>Home</a> <a -->
						<!-- 								class="text-secondary mb-2" href="#"><i -->
						<!-- 								class="fa fa-angle-right mr-2"></i>Our Shop</a> <a -->
						<!-- 								class="text-secondary mb-2" href="#"><i -->
						<!-- 								class="fa fa-angle-right mr-2"></i>Shop Detail</a> <a -->
						<!-- 								class="text-secondary mb-2" href="#"><i -->
						<!-- 								class="fa fa-angle-right mr-2"></i>Shopping Cart</a> <a -->
						<!-- 								class="text-secondary mb-2" href="#"><i -->
						<!-- 								class="fa fa-angle-right mr-2"></i>Checkout</a> <a -->
						<!-- 								class="text-secondary" href="#"><i -->
						<!-- 								class="fa fa-angle-right mr-2"></i>Contact Us</a> -->
						<!-- 						</div> -->
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