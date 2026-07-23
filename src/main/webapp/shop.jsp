<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, project.connection"%>
<%
// String filterGender = request.getParameter("filter_option_gender");
%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%
String filterGenderParam = request.getParameter("filter_option_gender");
String[] categoryParams = request.getParameterValues("category");
String[] colorParams = request.getParameterValues("color");
String[] priceRangeParams = request.getParameterValues("priceRange");
String[] discountParams = request.getParameterValues("discount");
String[] sizeParams = request.getParameterValues("size");


// Get the session object
HttpSession s = request.getSession(false);

// Check if the session is valid and if the cust is logged in
//       String adminId = (String) s.getAttribute("admin_id");

String username = (String) s.getAttribute("username");
String user_id = (String) s.getAttribute("user_id");
//     String adminEmail = (String) s.getAttribute("admin_email");

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

	<!-- Shop Start -->
	<div class="container-fluid">
		<div class="row px-xl-5">
			<!-- Shop Sidebar Start -->
			<%
			// Check if filter_option_gender exists in the request parameters
			String filterOptionGender = request.getParameter("filter_option_gender");

			if (filterOptionGender != null && !filterOptionGender.isEmpty()) {
			%>
			<div class="col-lg-3 col-md-4">


				<!-- Filter by Gender Start -->
				<%
				conn = null;

				PreparedStatement psParentCategory = null;

				ResultSet rsParentCategory = null;

				int x = Integer.parseInt(request.getParameter("filter_option_gender")); // Get the filter option for gender

				String parentCatName = "";
				; // Variable to store the parent category name
				%>



				<h5 class="section-title position-relative text-uppercase mb-3">

					<span class="bg-secondary pr-3">Gender</span>

				</h5>

				<div class="bg-light p-4 mb-30">

					<%
					try {

						// Get the connection using your project connection class

						conn = connection.getcon();

						// Query to get the parent category name based on filter_option_gender

						String sqlParentCategory = "SELECT p_cat_name FROM parent_category WHERE p_cat_id = ?";

						psParentCategory = conn.prepareStatement(sqlParentCategory);

						psParentCategory.setInt(1, x); // Bind the filter_option_gender value to the query

						rsParentCategory = psParentCategory.executeQuery();

						// If a matching parent category is found, get its name

						if (rsParentCategory.next()) {
							parentCatName = rsParentCategory.getString("p_cat_name");
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						if (rsParentCategory != null)
							rsParentCategory.close();
						if (psParentCategory != null)
							psParentCategory.close();
						if (conn != null)
							conn.close();
					}
					%>

					<button type="button" class="btn btn-warning rounded"><%=parentCatName.isEmpty() ? "Select Gender" : parentCatName%></button>

					<!-- </button> -->

				</div>

				<!-- Filter by Gender End -->



				<!-- Category Filter Start -->

				<%
				conn = null;

				PreparedStatement psSubCategory = null;

				ResultSet rsSubCategory = null;

				String[] selectedCategories = request.getParameterValues("category"); // Get selected categories

				filterOptionGender = request.getParameter("filter_option_gender"); // Get gender filter option

				int genderFilter = 0;

				try {

					if (filterOptionGender != null && !filterOptionGender.isEmpty()) {

						genderFilter = Integer.parseInt(filterOptionGender); // Convert to integer

					}

				} catch (NumberFormatException e) {

					e.printStackTrace(); // handle exception for invalid gender filter input

				}

				String currentParentCategory = ""; // To track the current parent category heading
				%>



				<h5 class="section-title position-relative text-uppercase mb-3">

					<span class="bg-secondary pr-3">Categories</span>

				</h5>

				<div class="bg-light p-4 mb-30">

					<form id="filterForm" method="get" action="">

						<!-- Hidden input to maintain the gender filter value -->

						<input type="hidden" name="filter_option_gender"
							value='<%=filterOptionGender != null ? filterOptionGender : ""%>' />



						<%
						try {

							// Get the connection using your project connection class

							conn = connection.getcon();

							// Query to get subcategories based on the selected gender (filter_option_gender)

							String sqlSubCategory = "SELECT pc.p_cat_name, sc.sub_cat_id, sc.sub_cat_name, sc.total_products " +

							"FROM sub_category sc " +

							"JOIN parent_category pc ON sc.p_cat_id = pc.p_cat_id " +

							"WHERE pc.p_cat_id = ?";

							psSubCategory = conn.prepareStatement(sqlSubCategory);

							psSubCategory.setInt(1, genderFilter); // filter based on gender (parent category)

							rsSubCategory = psSubCategory.executeQuery();

							// Loop through the subcategories and display them as checkboxes under their parent category

							while (rsSubCategory.next()) {

								parentCatName = rsSubCategory.getString("p_cat_name");

								String subCatId = rsSubCategory.getString("sub_cat_id");

								String subCatName = rsSubCategory.getString("sub_cat_name");

								// 								int totalProducts = rsSubCategory.getInt("total_products");

								// If we encounter a new parent category, display its name as a heading

								if (!parentCatName.equals(currentParentCategory)) {

							if (!currentParentCategory.isEmpty()) {
						%>
					</form>
				</div>
				<%
				// Close the previous category group

				}

				currentParentCategory = parentCatName;
				%>

				<h6 class="text-uppercase mb-3"><%=parentCatName%></h6>

				<div class="category-group">

					<%
					}

					// Check if this subcategory is selected by comparing it with the selected categories array

					boolean isChecked = selectedCategories != null && Arrays.asList(selectedCategories).contains(subCatId);
					%>

					<div
						class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">

						<input type="checkbox" class="custom-control-input"
							id="subcat-<%=subCatId%>" name="category" value="<%=subCatId%>"
							<%=isChecked ? "checked" : ""%>
							onchange="document.getElementById('filterForm').submit();">
						<!-- Automatically submit form when checkbox is toggled -->

						<label class="custom-control-label" for="subcat-<%=subCatId%>"><%=subCatName%></label>

						<%-- 						<span class="badge border font-weight-normal"><%=totalProducts%></span> --%>

					</div>

					<%
					}

					if (!currentParentCategory.isEmpty()) {
					%>
				</div>
				<%
				// Close the last category group

				}

				} catch (Exception e) {

				e.printStackTrace();

				} finally {

				if (rsSubCategory != null)
				rsSubCategory.close();

				if (psSubCategory != null)
				psSubCategory.close();

				if (conn != null)
				conn.close();

				}
				%>

				<!-- 				<form action=""></form> -->

			</div>

			<!-- Category Filter End -->

			<!-- Color Filter -->

			<%
			// Retrieve the color parameter(s) from the request
			String[] selectedColors = request.getParameterValues("color");
			List<String> selectedColorsList = selectedColors != null ? Arrays.asList(selectedColors) : new ArrayList<>();
			%>

			<!-- Color Filter -->
			<h5 class="section-title position-relative text-uppercase mb-3">
				<span class="bg-secondary pr-3">Filter by color</span>
			</h5>
			<div class="bg-light p-4 mb-30">
				<!--     <form id="filterForm" method="get" action="your-action-url.jsp"> -->
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input"
						id="color-black" name="color" value="black"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("black") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-black">Black</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="color-blue"
						name="color" value="blue"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("blue") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-blue">Blue</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="color-red"
						name="color" value="red"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("red") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-red">Red</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input"
						id="color-green" name="color" value="green"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("green") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-green">Green</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input"
						id="color-yellow" name="color" value="yellow"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("yellow") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-yellow">Yellow</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input"
						id="color-purple" name="color" value="purple"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("purple") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-purple">Purple</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input"
						id="color-orange" name="color" value="orange"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("orange") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-orange">Orange</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="color-pink"
						name="color" value="pink"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("pink") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-pink">Pink</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="color-gray"
						name="color" value="gray"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("gray") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-gray">Gray</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input"
						id="color-white" name="color" value="white"
						onchange="document.getElementById('filterForm').submit();"
						<%=selectedColorsList.contains("white") ? "checked" : ""%>>
					<label class="custom-control-label" for="color-white">White</label>
				</div>
				<!-- Add more colors as needed -->
			</div>




			<!-- 			filter by price start -->
			<%
    // Retrieve the priceRange parameter(s) from the request
    String[] selectedPriceRangesArray = request.getParameterValues("priceRange");
    List<String> selectedPriceRanges = selectedPriceRangesArray != null ? Arrays.asList(selectedPriceRangesArray) : new ArrayList<>();
%>
			<h5 class="section-title position-relative text-uppercase mb-3">
				<span class="bg-secondary pr-3">Filter by price</span>
			</h5>
			<div class="bg-light p-4 mb-30">
				<!-- Add form wrapper with id 'filterForm' -->
				<!--     <form id="filterForm" method="GET" action="yourFilterAction.jsp"> -->
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="price-1"
						name="priceRange" value="0-1000"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedPriceRanges != null && selectedPriceRanges.contains("0-1000") ? "checked" : "" %>>
					<label class="custom-control-label" for="price-1">₹0 -
						₹1000</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="price-2"
						name="priceRange" value="1000-2000"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedPriceRanges != null && selectedPriceRanges.contains("1000-2000") ? "checked" : "" %>>
					<label class="custom-control-label" for="price-2">₹1000 -
						₹2000</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="price-3"
						name="priceRange" value="2000-3000"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedPriceRanges != null && selectedPriceRanges.contains("2000-3000") ? "checked" : "" %>>
					<label class="custom-control-label" for="price-3">₹2000 -
						₹3000</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="price-4"
						name="priceRange" value="3000-4000"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedPriceRanges != null && selectedPriceRanges.contains("3000-4000") ? "checked" : "" %>>
					<label class="custom-control-label" for="price-4">₹3000 -
						₹4000</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between">
					<input type="checkbox" class="custom-control-input" id="price-5"
						name="priceRange" value="4000-5000"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedPriceRanges != null && selectedPriceRanges.contains("4000-5000") ? "checked" : "" %>>
					<label class="custom-control-label" for="price-5">₹4000 -
						₹5000</label>
				</div>
				<!--     </form> -->
			</div>


			<!-- 			filter by price start -->

			<!-- 			filter by discount start  -->
			<%
    // Retrieve the discount parameter(s) from the request
    String[] selectedDiscountsArray = request.getParameterValues("discount");
    List<String> selectedDiscounts = selectedDiscountsArray != null ? Arrays.asList(selectedDiscountsArray) : new ArrayList<>();
%>

			<h5 class="section-title position-relative text-uppercase mb-3">
				<span class="bg-secondary pr-3">Filter by Discount</span>
			</h5>
			<div class="bg-light p-4 mb-30">
				<!--     <form id="filterForm" method="GET" action="yourFilterAction.jsp"> -->
				<!-- Discount Filters -->
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="discount-1"
						name="discount" value="0-5"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedDiscounts != null && selectedDiscounts.contains("0-5") ? "checked" : "" %>>
					<label class="custom-control-label" for="discount-1">0% -
						5%</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="discount-2"
						name="discount" value="5-10"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedDiscounts != null && selectedDiscounts.contains("5-10") ? "checked" : "" %>>
					<label class="custom-control-label" for="discount-2">5% -
						10%</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="discount-3"
						name="discount" value="10-15"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedDiscounts != null && selectedDiscounts.contains("10-15") ? "checked" : "" %>>
					<label class="custom-control-label" for="discount-3">10% -
						15%</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="discount-4"
						name="discount" value="15-20"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedDiscounts != null && selectedDiscounts.contains("15-20") ? "checked" : "" %>>
					<label class="custom-control-label" for="discount-4">15% -
						20%</label>
				</div>
				<div
					class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
					<input type="checkbox" class="custom-control-input" id="discount-5"
						name="discount" value="20-25"
						onchange="document.getElementById('filterForm').submit();"
						<%= selectedDiscounts != null && selectedDiscounts.contains("20-25") ? "checked" : "" %>>
					<label class="custom-control-label" for="discount-5">20% -
						25%</label>
				</div>
				<!--     </form> -->
			</div>

			<!-- 			filter by discount start  -->



			<%
			}
			%>

		</div>

		<!-- Shop Sidebar End -->






		<!-- Shop Product Start -->

		<!-- <div class="p-1"> -->



		<!-- if filter gender  all category cause no category given  -->
		<%

		
		
		
// 		filterGenderParam = request.getParameter("filter_option_gender");
// 		String categoryParam = request.getParameter("category");
//             		discountParams = request.getParameterValues("discount");
// 		if (filterGenderParam != null && !filterGenderParam.isEmpty() 
// 				&& (categoryParam == null || categoryParam.isEmpty())  
// 				&& (priceRangeParams == null || priceRangeParams.length == 0) 
// 				&& (colorParams == null || colorParams.length == 0)
// 				&& (discountParams == null || discountParams.length == 0)
				
				
// 				) {
// 			int filterGender = Integer.parseInt(filterGenderParam);
// 			//     int category = Integer.parseInt(categoryParam);

// 			Connection con = null;
// 			PreparedStatement ps = null;
// 			ResultSet rs = null;

// 			try {
// 				con = connection.getcon();

// 				// SQL query with placeholders
// 				String query = "SELECT p.pro_id,p.title, p.description, p.show_price, p.discount, i.path, c.p_cat_name, s.sub_cat_name "
// 				+ "FROM product p " + "JOIN image i ON p.pro_id = i.pro_id "
// 				+ "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id "
// 				+ "JOIN parent_category c ON c.p_cat_id = s.p_cat_id where c.p_cat_id=?";

// 				ps = con.prepareStatement(query);
// 				ps.setInt(1, filterGender); // Set the value for filterGender
// 				//         ps.setInt(2, category);      // Set the value for category

// 				rs = ps.executeQuery();

				// Shop Product Start
		%>
		<!-- 		<div class="col-lg-9 col-md-8"> -->
		<!--             <div>Options:</div> -->
		<!-- 			<hr> -->
		<!-- 			<div class="row pb-3"> -->
		<%
				// Loop through the result set and display products with images
// 				while (rs.next()) {
// 					String title = rs.getString("title");
// 					String description = rs.getString("description");
// 					int showPrice = rs.getInt("show_price");
// 					int p_id = rs.getInt("pro_id");
// 					double discount = rs.getDouble("discount");

// 					// Get the discount value
// 					int discountPrice = showPrice - (int) ((showPrice * discount) / 100);

// 					// Get the image path and category names
// 					String imagePath = rs.getString("path");
// 					String p = rs.getString("p_cat_name");
// 					String ss = rs.getString("sub_cat_name");
				%>

		<!-- Product Card -->
		<!-- 				<div class="col-lg-4 col-md-6 mb-4"> -->
		<!-- 					<div class="dress-card h-100" style="width: 100%;"> -->
		<!-- 						<div class="dress-card-head"> -->
		<%-- 							<a href="product_detail.jsp?pro_id=<%=p_id%>"> <img --%>
		<!-- 								class="dress-card-img-top img-fluid product-image" -->
		<%-- 								src="<%=imagePath%>" alt="<%=imagePath%>"> --%>
		<!-- 							</a> -->
		<!-- 							<div class="dress-card-body"> -->
		<!-- 								Title -->
		<%-- 								<p class="dress-card-para mb-3 text-truncate"><%=title%></p> --%>

		<!-- 								Price and Discount -->
		<!-- 								<p class="dress-card-para"> -->
		<%-- 									<span class="dress-card-price">Rs. <%=discountPrice%>&ensp; --%>
		<%-- 									</span> <span class="dress-card-crossed">Rs. <%=showPrice%></span> <span --%>
		<%-- 										class="dress-card-off">&ensp;(<%=(int) discount%> % --%>
		<!-- 										OFF) -->
		<!-- 									</span> -->
		<!-- 								</p> -->

		<!-- 								Buttons -->
		<!-- 								<div class="row"> -->
		<!-- 									<div class="col-md-6 card-button"> -->
		<%-- 										<a href="add_to_bag.jsp?product_id=<%=p_id%>"><div --%>
		<!-- 												class="card-button-inner bag-button">Add to Bag</div></a> -->
		<!-- 									</div> -->
		<!-- 									<div class="col-md-6 card-button"> -->
		<%-- 										<a href="add_to_wishlist.jsp?product_id=<%=p_id%>"><div --%>
		<!-- 												class="card-button-inner wish-button">Wishlist</div></a> -->
		<!-- 									</div> -->
		<!-- 								</div> -->

		<!-- 								<div class="bg-light text-dark mt-2 justify-space-between"> -->
		<!-- 									<div> -->
		<%-- 										<p><%="shop / " + p + " / " + ss%></p> --%>
		<!-- 									</div> -->
		<!-- 								</div> -->
		<!-- 							</div> -->
		<!-- 						</div> -->
		<!-- 					</div> -->
		<!-- 				</div> -->
		<%
// 				}
				%>
		<!-- 			</div> -->
		<!-- 		</div> -->
		<!-- Shop Product End -->
		<%
// 		} catch (Exception e) {
// 		e.printStackTrace();
// 		} finally {
// 		try {
// 			if (rs != null)
// 				rs.close();
// 			if (ps != null)
// 				ps.close();
// 			if (con != null)
// 				con.close();
// 		} catch (SQLException e) {
// 			e.printStackTrace();
// 		}
// 		}
// 		}

		// 	out.prinln("<script type='text/javascript'>console.log('else part');</script>");
		%>
		<!-- filter gendeer  closed -->





		<% boolean hasFilter = false; 
boolean firstCondition = true;%>
		<!-- filter gender + multiple category		 -->
		<%
    filterGenderParam = request.getParameter("filter_option_gender");
    categoryParams = request.getParameterValues("category");
    priceRangeParams = request.getParameterValues("priceRange");
    discountParams = request.getParameterValues("discount");
    
    int filterGender = Integer.parseInt(filterGenderParam);

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = connection.getcon();

        // Base query
        StringBuilder queryBuilder = new StringBuilder(
            "SELECT p.pro_id, p.title,p.color, p.description, p.show_price, p.discount, p.stock, " +
            "i.path, c.p_cat_name, s.sub_cat_name, " +
            "(p.show_price - (p.show_price * p.discount / 100)) AS discountPrice " +
            "FROM product p " +
            "JOIN image i ON p.pro_id = i.pro_id " +
            "JOIN sub_category s ON p.sub_cat_id = s.sub_cat_id " +
            "JOIN parent_category c ON c.p_cat_id = s.p_cat_id " +
            "WHERE c.p_cat_id = ? "
        		);

     // Start combining filters
     if ((categoryParams != null && categoryParams.length > 0) ||
         (priceRangeParams != null && priceRangeParams.length > 0) ||
         (colorParams != null && colorParams.length > 0) ||
         (discountParams != null && discountParams.length > 0)
    		 ) {
         queryBuilder.append(" AND ("); // Open filter grouping

//           firstCondition = true;

         // Apply category filter
         if (categoryParams != null && categoryParams.length > 0) {
             queryBuilder.append(" s.sub_cat_id IN (");
             for (int i = 0; i < categoryParams.length; i++) {
                 queryBuilder.append("?");
                 if (i < categoryParams.length - 1) {
                     queryBuilder.append(", ");
                 }
             }
             queryBuilder.append(") ");
             firstCondition = false;
         }

      // Apply price range filter
         if (priceRangeParams != null && priceRangeParams.length > 0) {
        	 
             if (!firstCondition) {queryBuilder.append(" and "); 
             firstCondition = true;
             }// Add 'and' if other conditions already exist
             queryBuilder.append("("); // Start grouping price range conditions
             for (int i = 0; i < priceRangeParams.length; i++) {
                 String[] range = priceRangeParams[i].split("-"); // Split the range into lower and upper bounds
                 if (range.length == 2) { // Ensure the range has both lower and upper bounds
                     queryBuilder.append("(p.show_price - ((p.show_price * p.discount) / 100) BETWEEN ? AND ?)");
                 }
                 if (i < priceRangeParams.length - 1) {
                     queryBuilder.append(" OR "); // Add 'OR' between multiple price range conditions
                 }
             }
             queryBuilder.append(")"); // Close grouping of price range conditions
             firstCondition = false; // Mark that a condition has been added
         }

      
      

      
         // Apply color filter
         if (colorParams != null && colorParams.length > 0) {
             if (!firstCondition) {queryBuilder.append(" and ");
             firstCondition = true;
             
             }
             queryBuilder.append("(");
             for (int i = 0; i < colorParams.length; i++) {
                 queryBuilder.append("p.color = ?");
                 if (i < colorParams.length - 1) {
                     queryBuilder.append(" OR ");
                 }
             }
             queryBuilder.append(")");
         }

      // Apply discount filter
         if (discountParams != null && discountParams.length > 0) {
             if (!firstCondition) {queryBuilder.append(" and ");
             
             firstCondition = true;
             }
             queryBuilder.append("("); // Start grouping discount conditions
             for (int i = 0; i < discountParams.length; i++) {
                 String[] range = discountParams[i].split("-");
                 if (range.length == 2) {
                     // Handle range (e.g., 5-10)
                     queryBuilder.append("(p.discount BETWEEN ? AND ?)");
                 } else if (range.length == 1 && range[0].endsWith("+")) {
                     // Handle x+ (e.g., 5+)
                     queryBuilder.append("(p.discount >= ?)");
                 }
                 if (i < discountParams.length - 1) {
                     queryBuilder.append(" OR "); // Add 'OR' between multiple discount conditions
                 }
             }
             queryBuilder.append(")"); // Close grouping of discount conditions
             firstCondition = false; // Mark that a condition has been added
         }
         
         
         queryBuilder.append(")"); // Close filter grouping
     }
		
     
     
     
     
     // Add final ordering
     queryBuilder.append(" ORDER BY p.pro_id desc");
     
        String query = queryBuilder.toString();
        ps = con.prepareStatement(query);

        // Set filter_gender
        int paramIndex = 1;
        ps.setInt(paramIndex++, filterGender);

        // Set category parameters
        if (categoryParams != null && categoryParams.length > 0) {
            for (String category : categoryParams) {
                ps.setInt(paramIndex++, Integer.parseInt(category));
            }
        }
     


        // Set price range parameters
        if (priceRangeParams != null && priceRangeParams.length > 0) {
            for (String priceRange : priceRangeParams) {
                String[] range = priceRange.split("-");
                if (range.length == 2) {
                    ps.setInt(paramIndex++, Integer.parseInt(range[0]));
                    ps.setInt(paramIndex++, Integer.parseInt(range[1]));
                } else if (range.length == 1 && range[0].endsWith("+")) {
                    ps.setInt(paramIndex++, Integer.parseInt(range[0].replace("+", "")));
                }
            }
        }
        
     // Set discount parameters
//         if (discountParams != null && discountParams.length > 0) {
//             for (String discount : discountParams) {
//                 String[] range = discount.split("-");
//                 if (range.length == 2) {
//                     ps.setInt(paramIndex++, Integer.parseInt(range[0]));
//                     ps.setInt(paramIndex++, Integer.parseInt(range[1]));
//                 } else if (range[0].endsWith("+")) {
//                     ps.setInt(paramIndex++, Integer.parseInt(range[0].replace("+", "")));
//                 }
//             }
//         }
        
     
     

     // Set color parameters
        if (colorParams != null && colorParams.length > 0) {
            for (String color : colorParams) {
                ps.setString(paramIndex++, color);
            }
        }

     // Set discount parameters
        if (discountParams != null && discountParams.length > 0) {
            for (String discount : discountParams) {
                String[] range = discount.split("-");
                if (range.length == 2) {
                    ps.setInt(paramIndex++, Integer.parseInt(range[0].trim()));
                    ps.setInt(paramIndex++, Integer.parseInt(range[1].trim()));
                } else if (range.length == 1 && range[0].endsWith("+")) {
                    ps.setInt(paramIndex++, Integer.parseInt(range[0].replace("+", "").trim()));
                }
            }
        }
        
        rs = ps.executeQuery();

        // Render the products
%>
		<div class="col-lg-9 col-md-8">
			<hr>
			<div class="row pb-3">
				<%
        while (rs.next()) {
            String title = rs.getString("title");
            String description = rs.getString("description");
            double showPrice = rs.getDouble("show_price");
            int p_id = rs.getInt("pro_id");
            double discount = rs.getDouble("discount");
            double discountPrice = rs.getDouble("discountPrice");
            String imagePath = rs.getString("path");
            String p = rs.getString("p_cat_name");
            String color = rs.getString("color");
            String sx = rs.getString("sub_cat_name");
        %>
				<!-- Product Card -->
				<div class="col-lg-4 col-md-6 mb-4">
					<div class="dress-card h-100" style="width: 100%;">
						<a href='product_detail.jsp?pro_id=<%=p_id%>'> <img
							class="dress-card-img-top img-fluid product-image"
							src="<%=imagePath%>" alt="<%=title%>">
						</a>
						<div class="dress-card-body">
							<p class="dress-card-para mb-3 text-truncate"><%=title%></p>
							<p class="dress-card-para">
								<span class="dress-card-price">₹ <%=discountPrice%>&ensp;
								</span> <span class="dress-card-crossed">₹ <%=showPrice%></span> <span
									class="dress-card-off">&ensp;(<%=(int) discount%> % OFF)
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
								<p><%="shop / " + p + " / " + sx%></p>
							</div>
							<div class="bg-light text-dark mt-2 justify-space-between">
								<p>
									Color :
									<%= color %></p>
							</div>
						</div>
					</div>
				</div>
				<%
        }
        %>
			</div>
		</div>
		<%
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


		<!-- filter gender + multiple category	+ one category	 -->





		<!-- Shop Product Start -->

		<!-- Shop Product End -->

	</div>

	<div></div>

	<!-- </div> -->

	<!-- Shop End -->



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