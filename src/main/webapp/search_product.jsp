<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, project.connection"%>
<%
// String filterGender = request.getParameter("filter_option_gender");
%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<% 


    // Get the session object
    HttpSession s = request.getSession(false);


    // Check if the session is valid and if the cust is logged in
//       String adminId = (String) s.getAttribute("admin_id");
    
    String username = (String) s.getAttribute("username");
    String S = (String) request.getParameter("search_query");
    String f = (String) request.getParameter("filter_gender");
    String user_id = (String) s.getAttribute("user_id");
//     String adminEmail = (String) s.getAttribute("admin_email");
// out.print(S +"  "+f);
//     if (username == null ) {
//         // Redirect to login page if session variables are not set
//         response.sendRedirect("admin_login.jsp");
//         return; // Stop further execution if not logged in
//     }
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
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap"
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
<style type="text/css">
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
</style>

</head>
<body>
	.
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


	<!-- search  -->
	<%
String searchQuery = request.getParameter("search_query");  // Get the search query from the request
String filter_gen = request.getParameter("filter_gender");  // Get the gender filter

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    // Establish the connection
//     ____________________________________________________________
//     con = connection.getcon();

//     // Base SQL query with placeholders
//     String query = "SELECT p.pro_id, p.title, p.description, p.show_price, p.discount, i.path, c.p_cat_name, s.sub_cat_name "
//                  + "FROM product p "
//                  + "JOIN image i ON p.pro_id = i.pro_id "
//                  + "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id "
//                  + "JOIN parent_category c ON c.p_cat_id = s.p_cat_id "
//                  + "WHERE c.p_cat_id = ? ";  // Gender filter condition

//     // Check if there is a search query
//     if (searchQuery != null && !searchQuery.trim().isEmpty()) {
//         String[] searchWords = searchQuery.split("\\s+");  // Split by whitespace
//         StringBuilder whereClause = new StringBuilder();
        
//         // Construct the WHERE clause dynamically based on the search words
//         for (int i = 0; i < searchWords.length; i++) {
//             if (i > 0) {
//                 whereClause.append(" OR ");  // Use OR between different words
//             }
//             whereClause.append("p.keywords LIKE ?");  // Only search in keywords
//         }

//         query += " AND (" + whereClause.toString() + ")";  // Add the dynamically created WHERE clause to the query
//     }

//     ps = con.prepareStatement(query);

//     // Set parameters for the gender filter (first parameter)
//     ps.setInt(1, Integer.parseInt(filter_gen));  // Gender filter (e.g., "1", "2", etc.)

//     int parameterIndex = 2;  // Start setting parameters for the search query

//     // Set parameters for the LIKE clauses based on the search query
//     if (searchQuery != null && !searchQuery.trim().isEmpty()) {
//         String[] searchWords = searchQuery.split("\\s+");
//         for (String word : searchWords) {
//             ps.setString(parameterIndex++, "%" + word + "%");
//         }
//     }

//     rs = ps.executeQuery();
// _________________________________________________________________________________________________

con = connection.getcon();

// Base SQL query with placeholders
String query = "SELECT p.pro_id, p.title, p.description, p.show_price, p.discount, i.path, c.p_cat_name, s.sub_cat_name "
             + "FROM product p "
             + "JOIN image i ON p.pro_id = i.pro_id "
             + "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id "
             + "JOIN parent_category c ON c.p_cat_id = s.p_cat_id "
             + "WHERE c.p_cat_id = ? ";  // Gender filter condition

// Check if there is a search query
if (searchQuery != null && !searchQuery.trim().isEmpty()) {
    String[] searchWords = searchQuery.split("\\s+");  // Split by whitespace
    StringBuilder whereClause = new StringBuilder();
    
    // Construct the WHERE clause dynamically for keywords
    for (int i = 0; i < searchWords.length; i++) {
        if (i > 0) {
            whereClause.append(" OR ");  // Use OR between different words
        }
        whereClause.append("p.keywords LIKE ?");  // Add keyword search
    }

    // Add conditions for sub_cat_name (category)
    for (int i = 0; i < searchWords.length; i++) {
        whereClause.append(" OR s.sub_cat_name LIKE ?");
    }

    // Add conditions for color
    for (int i = 0; i < searchWords.length; i++) {
        whereClause.append(" OR p.color LIKE ?");
    }

    query += " AND (" + whereClause.toString() + ")";  // Add the dynamically created WHERE clause to the query
}

ps = con.prepareStatement(query);

// Set parameters for the gender filter (first parameter)
ps.setInt(1, Integer.parseInt(filter_gen));  // Gender filter (e.g., "1", "2", etc.)

int parameterIndex = 2;  // Start setting parameters for the search query

// Set parameters for the LIKE clauses based on the search query
if (searchQuery != null && !searchQuery.trim().isEmpty()) {
    String[] searchWords = searchQuery.split("\\s+");
    for (String word : searchWords) {
        ps.setString(parameterIndex++, "%" + word + "%");  // For keywords
    }
    for (String word : searchWords) {
        ps.setString(parameterIndex++, "%" + word + "%");  // For sub_cat_name
    }
    for (String word : searchWords) {
        ps.setString(parameterIndex++, "%" + word + "%");  // For color
    }
}

rs = ps.executeQuery();
// ______________________________________________________________________________________

        // Shop Product Start
        
        if (rs.next()) {
        	
%>
	<div class="container">
		<div class="col-lg-12 col-md-8">
			<hr>
			<div class="row pb-4">
				<%
            // Loop through the result set and display products with images
            int productCount = 0;  // To count products and show 3 products per row
            while (rs.next()) {
                String title = rs.getString("title");
                String description = rs.getString("description");
                int showPrice = rs.getInt("show_price");
                int p_id = rs.getInt("pro_id");
                double discount = rs.getDouble("discount");

                // Get the discount value
                int discountPrice = showPrice - (int) ((showPrice * discount) / 100);

                // Get the image path and category names
                String imagePath = rs.getString("path");
                String p = rs.getString("p_cat_name");
                String ss = rs.getString("sub_cat_name");
                
                
           
                
                // Display the product
                if (productCount % 3 == 0 && productCount > 0) {
                    out.println("</div><div class='row pb-4'>");  // Start a new row after every 3 products
                }

                productCount++;
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
								<p class="dress-card-para mb-3 text-truncate"><%=title%></p>

								<p class="dress-card-para">
									<span class="dress-card-price">Rs. <%=discountPrice%>&ensp;
									</span> <span class="dress-card-crossed">Rs. <%=showPrice%></span> <span
										class="dress-card-off">&ensp;(<%=(int) discount%> %
										OFF)
									</span>
								</p>

								<div class="row">
									<div class="col-md-6 card-button">
										<a href="add_to_bag.jsp?product_id=<%=p_id%>">
											<div class="card-button-inner bag-button">Add to Bag</div>
										</a>
									</div>
									<div class="col-md-6 card-button">
										<a href="add_to_wishlist.jsp?product_id=<%=p_id%>">
											<div class="card-button-inner wish-button">Wishlist</div>
										</a>
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
	</div>
	<%
        }else
        {
        	out.println("<p class='text-center fs-1' style='color:red;'>No products available based on your search.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

	<!-- search  -->
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

	<!-- <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a> -->





	<!-- JavaScript Libraries -->

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		type="text/javascript"></script>

	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"
		type="text/javascript"></script>

	<script src="lib/easing/easing.min.js" type="text/javascript"></script>

	<script src="lib/owlcarousel/owl.carousel.min.js"
		type="text/javascript"></script>



	<!-- Contact Javascript File -->

	<script src="mail/jqBootstrapValidation.min.js" type="text/javascript"></script>

	<script src="mail/contact.js" type="text/javascript"></script>



	<!-- Template Javascript -->

	<script src="js/main.js" type="text/javascript"></script>

</body>

</html>