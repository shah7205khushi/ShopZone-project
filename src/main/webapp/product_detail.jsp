<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, project.connection"%>
<% 
HttpSession s = request.getSession(false);

//Check if the session is valid and if the cust is logged in
//    String adminId = (String) s.getAttribute("admin_id");

String username = (String) s.getAttribute("username");
String user_id = (String) s.getAttribute("user_id");
Connection con = null;
%>
<!DOCTYPE html>
<html lang="en">


<head>
<meta charset="utf-8">
<title>shop zone</title>
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


<!-- Bootstrap CSS -->
<!--     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->

<!-- Font Awesome CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Bootstrap Bundle JS -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
div.stars {
	width: 270px;
	display: inline-block;
}

.mt-200 {
	margin-top: 20px;
}

input.star {
	display: none;
}

label.star {
	float: right;
	padding: 10px;
	font-size: 36px;
	color: red;
	transition: all .2s;
}

input.star:checked ~ label.star:before {
	content: '\f005';
	color: #FD4;
	transition: all .25s;
}

input.star-5:checked ~ label.star:before {
	color: #FE7;
	text-shadow: 0 0 20px #952;
}

input.star-1:checked ~ label.star:before {
	color: #F62;
}

label.star:hover {
	transform: rotate(-15deg) scale(1.3);
}

label.star:before {
	content: '\f006';
	font-family: FontAwesome;
}

.i {
	max-width: 500px;
	max-height: 700px;
}

.x {
	font-size: 25px;
}

.dress-card-img-top {
	width: 100%;
	border-radius: 7px 7px 0 0;
}

.dress-card-body {
	padding: 1rem;
	background: #fff;
	/* background-color: #FFD333 !important; */
	border-radius: 0 0 7px 7px;
}

.dress-card-title {
	line-height: 0.5rem;
}

.dress-card-crossed {
	text-decoration: line-through;
}

.dress-card-price {
	font-size: 1rem;
	font-weight: bold;
}

.dress-card-off {
	color: #E06C9F;

	/* color: #FFD333 !important; */
}

.dress-card-para {
	margin-bottom: 0.2rem;
	font-size: 1.0rem;
	margin-bottom: 0rem;
}

.dress-card {
	border-radius: 14x;
}

.dress-card-heart {
	font-size: 1em;
	/* color: #DB2763; */
	color: #FFD333;
	margin: 4.5px;
	position: absolute;
	left: 4px;
	top: 0px;
}

.surprise-bubble {
	position: absolute;
	bottom: 12rem;
	right: 2rem;
	border-radius: 50%;
	width: 30px;
	height: 30px;
	background: #fff;
	background-color: #FFD333 !important;
	padding: 1rem;
	color: white;
	-webkit-transition: all 0.55s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.55s cubic-bezier(0.645, 0.045, 0.355, 1);
}

.surprise-bubble a {
	font-size: 0.65em;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: white;
	font-family: arial;
	text-decoration: none;
	position: absolute;
	top: 9px;
	left: 20px;
	opacity: 0;
	-webkit-transition-delay: 2s;
	/* Safari */
	transition-delay: 2s;
	-webkit-transition: all 0.25s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.25s cubic-bezier(0.645, 0.045, 0.355, 1);
}

.surprise-bubble:hover {
	border-radius: 999rem;
	padding: 1rem;
	width: 26%;
	height: 30px;
	background: #DB2763;
	color: white;
	-webkit-transition: all 0.55s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: all 0.55s cubic-bezier(0.645, 0.045, 0.355, 1);
}

.surprise-bubble:hover a {
	opacity: 1;
	-webkit-transition-delay: 2s;
	/* Safari */
	transition-delay: 2s;
	-webkit-transition: opacity 1s cubic-bezier(0.645, 0.045, 0.355, 1);
	transition: opacity 1s cubic-bezier(0.645, 0.045, 0.355, 1);
}

.card-button {
	text-align: center;
	text-transform: uppercase;
	font-size: 17px;
	padding: 9px;
}

.card-button a {
	text-decoration: none;
}

.card-button-inner {
	padding: 10px;
	border-radius: 3px;
}

.bag-button {
	background: #343A40;
	color: white;
	border: 1px solid #E06C9F;
}

.bag-button :hover {
	background: #6C757D;
}

.wish-button {
	border: 1px solid #E06C9F;
	background: #3b3d3e;
	color: white;
}
/* CSS for image size */
.product-image {
	max-width: 100%; /* Ensures it scales within its container */
	max-height: 200px; /* Limits the height to 200px */
	object-fit: cover; /* Maintains aspect ratio and covers the box */
}

.product-image {
	max-width: 100%; /* Ensures it scales within its container */
	max-height: 300px; /* Limits the height to 200px */
	object-fit: contain; /* Ensures the entire image fits within the box */
	border: 1px solid #ddd;
	/* Optional: Adds a border for better visibility */
	padding: 5px; /* Optional: Adds padding around the image */
}

.fa-star {
	font-size: 20px;
	color: gray;
}

.fa-star.checked {
	color: gold;
}
</style>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"> -->

</head>

<body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

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


			<!-- 			_____________________________________search bar____________________________________ -->
			<%
			String xx = request.getParameter("filter_option_gender");
			%>
			<div class="col-lg-4 col-6 text-left">
				<form action="search_product.jsp" method="get"
					onsubmit="return validateSearch()">
					<div class="input-group">
						<input type="text" class="form-control" id="searchQuery"
							placeholder="Search for products" name="search_query"> <input
							type="hidden" class="form-control" name="filter_gender"
							value="<%=xx%>">

						<div class="input-group-append">
							<button class="btn btn-primary text-dark" id="searchButton"
								type="submit">Search</button>
						</div>
					</div>
				</form>
			</div>

			<script>
				function validateSearch() {
					var searchQuery = document.getElementById('searchQuery').value;
					var searchButton = document.getElementById('searchButton');

					// If search query is empty, disable the button and highlight the input field
					if (searchQuery.trim() === "") {
						searchButton.disabled = true;
						document.getElementById('searchQuery').style.borderColor = "red";
						return false; // Prevent form submission
					}

					// If query is not empty, enable the button and reset the input field styling
					searchButton.disabled = false;
					document.getElementById('searchQuery').style.borderColor = "";
					return true; // Allow form submission
				}

				// Enable the button and reset input styling when the user starts typing
				document.getElementById('searchQuery').addEventListener(
						'input',
						function() {
							var searchQuery = this.value;
							var searchButton = document
									.getElementById('searchButton');
							if (searchQuery.trim() !== "") {
								searchButton.disabled = false;
								this.style.borderColor = "";
							}
						});
			</script>

			<!-- 			_____________________________________search bar____________________________________ -->
			<div class="col-lg-4 col-6 text-right">
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
									data-bs-toggle="dropdown">My Account</button>

								<!-- 								<button type="button" -->
								<!-- 									class="btn btn-sm btn-light dropdown-toggle rounded" -->
								<!-- 									data-toggle="dropdown">My Account</button> -->
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
							int wishListCount = 0;
							int cartCount = 0;

							// If customer_id is available, query the database for wishlisted and cart items
							if (user_id != null) {
								try {
									 con = connection.getcon();

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


	<%@ page import="java.sql.*, java.util.*, project.connection"%>
	<%
	// Get the product_id from the query string
	String productIdParam = request.getParameter("pro_id");
	if (productIdParam == null || productIdParam.isEmpty()) {
		out.println("<script>alert('Product not found.'); window.location.href='shop.jsp';</script>");
		return;
	}

	int productId = Integer.parseInt(productIdParam);

	// Variables to hold product data
	 con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	// Variables for product details
	String title = "", description = "", imagePath = "", p = "", sub = "",color = "";
	int showPrice = 0, discountPrice = 0, stock = 0,pro_id = 3;
	double discount = 0.0;
	String about_pro;

	try {
		con = connection.getcon(); // Ensure your connection class is properly implemented

		// SQL query with placeholders
		String query = "SELECT p.stock,p.pro_id, p.title,p.color, p.about, p.description, p.show_price, p.discount, i.path, c.p_cat_name, s.sub_cat_name "
		+ "FROM product p " + "JOIN image i ON p.pro_id = i.pro_id "
		+ "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id "
		+ "JOIN parent_category c ON c.p_cat_id = s.p_cat_id " + "WHERE p.pro_id = ?";

		ps = con.prepareStatement(query);
		ps.setInt(1, productId);

		rs = ps.executeQuery();

		if (rs.next()) {
			title = rs.getString("title");
			description = rs.getString("description");
			color = rs.getString("color");
			showPrice = rs.getInt("show_price");
			pro_id = rs.getInt("pro_id");
			stock = rs.getInt("stock");
			discount = rs.getDouble("discount");
			discountPrice = showPrice - (int) ((showPrice * discount) / 100);
			imagePath = rs.getString("path");
			p = rs.getString("p_cat_name");
			sub = rs.getString("sub_cat_name");
			about_pro = rs.getString("about");
		} else {
			out.println("<script>alert('Product not found.'); window.location.href='shop.jsp';</script>");
			return;
		}
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("<script>alert('Database error: " + e.getMessage() + "');</script>");
		return;
	} finally {
		try {
			if (rs != null)
		rs.close();
			if (ps != null)
		ps.close();
			if (con != null)
		con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>

	<!-- Product Detail Page -->
	<div class="container-fluid pb-5">
		<div class="row px-xl-5">
			<!-- Product Image Carousel -->
			<div class="col-lg-5 mb-30">
				<div id="product-carousel" class="carousel slide"
					data-ride="carousel">
					<div class="carousel-inner bg-light">
						<div class="carousel-item active">
							<img class="w-100 h-100" src="<%=imagePath%>" alt="Product Image">
						</div>
						<!-- Add more carousel items if needed -->
					</div>
				</div>
			</div>

			<!-- Product Details -->
			<div class="col-lg-7 h-auto mb-30">
				<div class="h-100 bg-light p-30 ">
					<%
					if (stock == 0) {
					%>
					<h3 class="text-danger">OUT OF STOCK</h3>
					<%
					} else {
					%>
					<h3 class="text-success">IN STOCK</h3>
					<%
					}
					%>

					<h3><%=title%></h3>

					<div class="d-flex mt-4">
						<h3 class="font-weight-semi-bold mb-4 mr-4">
							Rs.
							<%=discountPrice%></h3>
						<h3
							class="font-weight-semi-bold mb-4 mr-4 text-muted text-decoration-line-through"
							style="text-decoration: line-through">
							Rs.
							<%=showPrice%></h3>
						<h4 class="font-weight-semi-bold mb-4 mr-4 text-success">
							(<%=(int) discount%>
							% OFF)
						</h4>
					</div>
					<p class="mb-4 x ">
						<span class="font-weight-bold">Product Description: <span><br><%=description%>
					</p>
					<h4>
						<span style="display: inline-flex; align-items: center;">
							Color : <%= color %>
						</span>
					</h4>


					<div class="d-flex align-items-center mb-4 pt-2">
						<a href="add_to_bag.jsp?product_id=<%=productId%>" class="mr-4">
							<button class="btn btn-primary px-3">
								<i class="fa fa-shopping-cart mr-1"></i> Add To Cart
							</button>
						</a> <a href="add_to_wishlist.jsp?product_id=<%=productId%>"
							class="mr-4">
							<button class="btn btn-primary px-3">
								<i class="fa fa-heart mr-1"></i> Add To Wishlist
							</button>
						</a>

						<%
					if (stock != 0) {
					%>
						<a href="buy_now.jsp?product_id=<%=productId%>" class="mr-4">
							<button class="btn btn-primary px-3">
								<i class="fa fa-bolt mr-1"></i> Buy Now
							</button>
						</a>
						<%
					} 
					%>






					</div>
					<div class="d-flex align-items-center mb-4 pt-2">
						<div class="bg-light p-30">
							<h4 class="mb-3">About this Product</h4>
							<%
							String[] parts = about_pro.split("\\|");
							// Loop through each part and display it in a new line
							for (String part : parts) {
							%>
							<p><%=part%></p>
							<%
							}
							%>
						</div>
					</div>
					<!-- Feedback Form Section -->
					<!-- _________________________________________________________ -->
					<!-- Feedback Form Section -->

					<%
    // Check if the user is logged in
    HttpSession my_session = request.getSession(false);
    boolean isLoggedIn = (my_session != null && my_session.getAttribute("user_id") != null);

    // Retrieve feedback details from the database
     con = null;
     ps = null;
     rs = null;

    String feedbackMessage = null;
    int feedbackRating = 0;
    boolean hasGivenFeedback = false;
    String userId = null;

    if (isLoggedIn) {
        userId = (String) session.getAttribute("user_id");
        try {
            con = connection.getcon();

            // Check if the user has already given feedback
            String query = "SELECT rating, content FROM feedback WHERE c_id = ? and pro_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(userId));
            ps.setInt(2, pro_id);
            rs = ps.executeQuery();

            if (rs.next()) {
                hasGivenFeedback = true;
                feedbackRating = rs.getInt("rating");
                feedbackMessage = rs.getString("content");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>

					<div class="feedback-section">
						<% if (isLoggedIn) { %>
						<% if (hasGivenFeedback) { %>
						<!-- Scenario 1: User is logged in and has given feedback before -->
						<h4>Your Feedback</h4>
						<p>
							<strong>Message:</strong>
							<%= feedbackMessage %></p>
						<div class="rating-display">
							<strong>Rating:</strong>
							<%
        int ff = 3; // Example rating, replace with your actual variable
        for (int i = 1; i <= 5; i++) {
            if (i <= ff) {
    %>
							<i class="fas fa-star text-warning"></i>
							<%
            } else {
    %>
							<i class="far fa-star text-warning"></i>
							<%
            }
        }
    %>
						</div>

						<%--             <p><strong>Rating:</strong> <%= feedbackRating %>/5</p> --%>
						<p>Thank you for your feedback!</p>
						<% } else { %>
						<!-- Scenario 2: User is logged in but has not given feedback -->
						<h4 class="mb-3">Your Feedback</h4>
						<form action="submit_feedback.jsp?pro_id=<%=productId%>"
							method="post">
							<div class="form-group">
								<label for="feedbackText">Your Feedback</label>
								<textarea class="form-control" id="feedbackText"
									name="feedbackText" rows="1" required></textarea>
							</div>

							<div class="container d-flex mt-200">
								<div class="row">
									<div class="col-md-12">
										<div class="stars">
											<input class="star star-5" id="star-5" type="radio"
												name="star" value="5" required /> <label
												class="star star-5" for="star-5"></label> <input
												class="star star-4" id="star-4" type="radio" name="star"
												value="4" required /> <label class="star star-4"
												for="star-4"></label> <input class="star star-3" id="star-3"
												type="radio" name="star" value="3" required checked /> <label
												class="star star-3" for="star-3"></label> <input
												class="star star-2" id="star-2" type="radio" name="star"
												value="2" required /> <label class="star star-2"
												for="star-2"></label> <input class="star star-1" id="star-1"
												type="radio" name="star" value="1" required /> <label
												class="star star-1" for="star-1"></label>
										</div>
									</div>
								</div>
							</div>
							<input type="hidden" name="productId" value="<%=productId%>">
							<button type="submit" class="btn btn-primary">Submit
								Feedback</button>
						</form>
						<% } %>
						<% } else { %>
						<!-- Scenario 3: User is not logged in -->
						<h4>Feedback</h4>
						<p>Please log in to submit your feedback.</p>
						<a href="login.jsp" class="btn btn-secondary">Log In</a>
						<% } %>
					</div>
					<!-- ________________________________________________________ -->

					<!-- 					<h4 class="mb-3">Your Feedback</h4> -->
					<%-- <form action="submit_feedback.jsp?pro_id=<%=productId%>" method="post"> --%>
					<!--     <div class="form-group"> -->
					<!--         <label for="feedbackText">Your Feedback</label> -->
					<!--         <textarea class="form-control" id="feedbackText" name="feedbackText" rows="1" required></textarea> -->
					<!--     </div> -->

					<!--     <div class="container d-flex mt-200"> -->
					<!--         <div class="row"> -->
					<!--             <div class="col-md-12"> -->
					<!--                 <div class="stars"> -->
					<!--                     <input class="star star-5" id="star-5" type="radio" name="star" value="5" required /> -->
					<!--                     <label class="star star-5" for="star-5"></label> -->
					<!--                     <input class="star star-4" id="star-4" type="radio" name="star" value="4" required /> -->
					<!--                     <label class="star star-4" for="star-4"></label> -->
					<!--                     <input class="star star-3" id="star-3" type="radio" name="star" value="3" required /> -->
					<!--                     <label class="star star-3" for="star-3"></label> -->
					<!--                     <input class="star star-2" id="star-2" type="radio" name="star" value="2" required /> -->
					<!--                     <label class="star star-2" for="star-2"></label> -->
					<!--                     <input class="star star-1" id="star-1" type="radio" name="star" value="1" required /> -->
					<!--                     <label class="star star-1" for="star-1"></label> -->
					<!--                 </div> -->
					<!--             </div> -->
					<!--         </div> -->
					<!--     </div> -->

					<%--     <input type="hidden" name="productId" value="<%=productId%>"> --%>
					<!--     <button type="submit" class="btn btn-primary">Submit Feedback</button> -->
					<!-- </form> -->










				</div>
			</div>

			<!-- Product Description -->
			<div class="row px-xl-5">
				<div class="col">
					<div class="bg-light p-30">
						<h4 class="mb-3">More Like This</h4>




						<!-- if filter gender  all category -->
						<%
					// Assuming productId is passed as a request parameter
					productIdParam = request.getParameter("pro_id");

					if (productIdParam != null && !productIdParam.isEmpty()) {
						productId = Integer.parseInt(productIdParam);

						con = null;
						PreparedStatement ps1 = null;
						PreparedStatement ps2 = null;
						ResultSet rs1 = null;
						ResultSet rs2 = null;

						try {
							con = connection.getcon();

							// Step 1: Get parent_category and sub_category for the given product
							String query1 = "SELECT s.p_cat_id, p.sub_cat_id FROM product p "
							+ "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id " + "WHERE p.pro_id = ?";
							ps1 = con.prepareStatement(query1);
							ps1.setInt(1, productId);
							rs1 = ps1.executeQuery();

							int parentCategoryId = -1;
							int subCategoryId = -1;

							if (rs1.next()) {
						parentCategoryId = rs1.getInt("p_cat_id");
						subCategoryId = rs1.getInt("sub_cat_id");
							}

							// Step 2: Fetch products from the same parent_category and sub_category
							String query2 = "SELECT p.pro_id, p.title, p.color, p.description, p.show_price, p.discount, i.path, c.p_cat_name, s.sub_cat_name "
							+ "FROM product p " + "JOIN image i ON p.pro_id = i.pro_id "
							+ "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id "
							+ "JOIN parent_category c ON c.p_cat_id = s.p_cat_id " + "WHERE s.p_cat_id = ? AND p.pro_id != ? "
							+ "ORDER BY RAND() limit 6";
							ps2 = con.prepareStatement(query2);
							ps2.setInt(1, parentCategoryId);
							//             ps2.setInt(2, subCategoryId);
							ps2.setInt(2, productId); // Exclude the current product
							rs2 = ps2.executeQuery();

							// Shop Product Start
					%>
						<div class="col-lg-12 col-md-8">
							<hr>
							<div class="row pb-3">
								<%
							// Loop through the result set and display products with images
							while (rs2.next()) {
								title = rs2.getString("title");
								description = rs2.getString("description");
								color = rs2.getString("color");
								showPrice = rs2.getInt("show_price");
								int p_id = rs2.getInt("pro_id");
								discount = rs2.getDouble("discount");

								// Get the discount value
								discountPrice = showPrice - (int) ((showPrice * discount) / 100);

								// Get the image path and category names
								imagePath = rs2.getString("path");
								p = rs2.getString("p_cat_name");
								String ss = rs2.getString("sub_cat_name");
							%>

								<!-- Product Card -->
								<div class="col-lg-4 col-md-6 mb-4">
									<div class="dress-card h-100" style="width: 100%;">
										<div class="dress-card-head">
											<a href="product_detail.jsp?pro_id=<%=p_id%>"> <img
												class="dress-card-img-top img-fluid product-image"
												src="<%=imagePath%>" alt="<%=imagePath%>">
											</a>
											<div class="dress-card-body">
												<!-- Title -->
												<p class="dress-card-para mb-3 text-truncate"><%=title%></p>

												<!-- Price and Discount -->
												<p class="dress-card-para">
													<span class="dress-card-price">Rs. <%=discountPrice%>&ensp;
													</span> <span class="dress-card-crossed">Rs. <%=showPrice%></span>
													<span class="dress-card-off">&ensp;(<%=(int) discount%>
														% OFF)
													</span>
												</p>
												<!-- Buttons -->
												<div class="row">
													<div class="col-md-6 card-button">
														<a href="add_to_bag.jsp?product_id=<%=p_id%>"><div
																class="card-button-inner bag-button">Add to Bag</div></a>
													</div>
													<div class="col-md-6 card-button">
														<a href="add_to_wishlist.jsp?product_id=<%=p_id%>"><div
																class="card-button-inner wish-button">Wishlist</div></a>
													</div>
												</div>

												<div class="bg-light text-dark mt-2 justify-space-between">
													<div>
														<p><%="shop / " + p + " / " + ss%></p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>


								<%
							}
							%>
							</div>
						</div>
						<!-- Shop Product End -->
						<%
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					// Close resources
					if (rs1 != null)
						try {
							rs1.close();
						} catch (SQLException ignored) {
						}
					if (ps1 != null)
						try {
							ps1.close();
						} catch (SQLException ignored) {
						}
					if (rs2 != null)
						try {
							rs2.close();
						} catch (SQLException ignored) {
						}
					if (ps2 != null)
						try {
							ps2.close();
						} catch (SQLException ignored) {
						}
					if (con != null)
						try {
							con.close();
						} catch (SQLException ignored) {
						}
					}
					}
					%>

						<!-- filter gendeer  closed -->



						<!-- filter gender and multiple categories -->






					</div>
				</div>
			</div>
		</div>


		<!-- Footer Start -->
		<div class="container-fluid bg-dark text-secondary mt-5 pt-5">
			<div class="row px-xl-5 pt-5">
				<div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
					<h5 class="text-secondary text-uppercase mb-4">Get In Touch</h5>
					<p class="mb-4">At Shop Zone, we offer a wide variety of
						stylish and comfortable clothing for men, women, and kids. From
						trendy outfits to classic wardrobe essentials. Explore our
						collection and find the perfect pieces for you and your family!</p>

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