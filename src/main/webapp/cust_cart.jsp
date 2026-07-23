<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, project.connection"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%
// Get the session object
HttpSession s = request.getSession(false);

// Check if the session is valid and if the cust is logged in
//       String adminId = (String) s.getAttribute("admin_id");

String username = (String) s.getAttribute("username");
String user_id = (String) s.getAttribute("user_id");
//     String adminEmail = (String) s.getAttribute("admin_email");

if (username == null || user_id == null) {
	// Redirect to login page if session variables are not set
	response.sendRedirect("login.jsp");
	return; // Stop further execution if not logged in
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

.xc {
	font-size: 25px;
}

.disabled {
	pointer-events: none; /* Prevent clicking */
	opacity: 0.5; /* Optional: make it visually look disabled */
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
			<div class="col-lg-8 col-6 text-right">
				<p class="m-0"></p>
				<h5 class="mr-0">
					<%
					boolean is_logged = false;
					if (username != null) {
						out.print("Welcome " + username);
						is_logged = true;
					}
					%>
				</h5>
			</div>
		</div>
	</div>
	<!-- Topbar End -->
	<!-- Navbar Start -->
	<%
	Connection c = null;
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
											type="button">Logout</button></a> <a href="order_history.jsp"><button
											class="dropdown-item" type="button">Order History</button></a> <a
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
// 									String cartSQL = "SELECT COUNT(*) FROM cart WHERE c_id = ?";
// 									PreparedStatement psCart = con.prepareStatement(cartSQL);
// 									psCart.setString(1, user_id);
// 									ResultSet rsCart = psCart.executeQuery();
// 									if (rsCart.next()) {
// 								cartCount = rsCart.getInt(1); // Get the cart count
// 									}
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
							</a>
							<!-- 							<a href="cust_cart.jsp" class="btn px-0 ml-3"> <i -->
							<!-- 								class="fas fa-shopping-cart text-primary"></i> <span -->
							<!-- 								class="badge text-secondary border border-secondary rounded-circle" -->
							<%-- 								style="padding-bottom: 2px;"> <%=cartCount%> --%>
							<!-- 							</span> -->
							<!-- 							</a> -->
						</div>
					</div>
				</nav>
			</div>
		</div>
	</div>
	<!-- Navbar End -->

	<div class="center text-center text-uppercase h1">
		<p>cart</p>
	</div>

	<!-- Cart Start -->
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.servlet.http.*"%>

	<%
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	user_id = (String) session.getAttribute("user_id");
	boolean isCartEmpty = true;

	try {
		con = project.connection.getcon();
		int us = Integer.parseInt(user_id);

		String query = "SELECT c.cart_id,p.pro_id, p.stock,p.title, p.show_price, p.discount, c.quantity, (p.show_price * c.quantity) AS total, i.path "
		+ "FROM cart c " + "JOIN product p ON c.pro_id = p.pro_id " + "JOIN image i ON p.pro_id = i.pro_id "
		+ "WHERE c.c_id = ?";

		ps = con.prepareStatement(query);
		ps.setInt(1, us);
		rs = ps.executeQuery();

		if (rs.next()) {
			isCartEmpty = false;
		}
	%>

	<div class="container-fluid">
		<div class="row px-xl-5 mt-5">
			<%
			if (isCartEmpty) {
			%>
			<div class="col-12 text-center">
				<h3>Your cart is empty!</h3>
			</div>
			<%
			} else {
			%>
			<div class="col-lg-12 table-responsive mb-5">
				<form action="checkout.jsp" method="post" id="cartForm">
					<table
						class="table table-light table-borderless table-hover text-center mb-0">
						<thead class="thead-dark">
							<tr>
								<th><input type="checkbox" id="selectAll"
									onclick="toggleAllCheckboxes(this)"> Select All</th>
								<th>Products</th>
								<th>Price</th>
								<th>Quantity</th>
								<th>Total</th>
								<th>Remove</th>
								<th>Move to Wishlist</th>
							</tr>
						</thead>
						<tbody class="align-middle">
							<%
							double grandTotal = 0;
							do {
								String proId = rs.getString("pro_id");
								String title = rs.getString("title");
								int price = rs.getInt("show_price");
								int quantity = rs.getInt("quantity");
								int cart_id = rs.getInt("cart_id");
								double discount = rs.getDouble("discount");
								double total = rs.getDouble("total");
								String imgPath = rs.getString("path");
int discountPrice = (int) (price - ((price * discount) / 100));

								grandTotal += total;
							%>
							<tr>
								<td class="align-middle">
									<%-- 								<%= total  %> --%> <% 
    // Get the stock quantity from the database
    int stock = rs.getInt("stock");
    // Check if the stock is 0 (or if the product is out of stock)
    boolean isOutOfStock = (stock < quantity); 
%> <input type="checkbox" name="selectedProducts" value="<%= total %>"
									data-cart-id="<%= rs.getInt("cart_id") %>"
									class="productCheckbox" onclick="updateSelectedTotal()"
									<% if (isOutOfStock) { %> disabled <% } %>> <!-- Disable the checkbox if out of stock -->
									<br> <%-- Display error message if product is out of stock or selected quantity exceeds stock --%>
									<%
    if (quantity > rs.getInt("stock")) {
%>
									<div class="text-danger mt-2">out of stock.</div> <%
    }
%>
								</td>
								<td class="align-middle"><a
									href="product_detail.jsp?pro_id=<%=proId%>"> <img
										src="<%=imgPath%>" alt="<%=title%>"
										style="width: 130px; height: 150px;">
								</a><br> <%=title%></td>
								<td class="align-middle">Rs. <%=discountPrice%></td>
								<td class="align-middle">
									<div class="input-group quantity mx-auto" style="width: 100px;">
										<a href="update_quantity.jsp?pro_id=<%=proId%>&update=0">
											<div class="input-group-btn">
												<div class="btn btn-sm btn-primary btn-minus">
													<i class="fa fa-minus"></i>
												</div>
											</div>
										</a> <input type="text"
											class="form-control form-control-sm bg-secondary border-0 text-center"
											value="<%=quantity%>" readonly> <a
											href="update_quantity.jsp?pro_id=<%=proId%>&update=1"
											<%
                // Check if quantity exceeds stock and disable the "Increase" button if true
                if (quantity >= rs.getInt("stock")) {
           %>
											class="disabled" <%
                }
           %>>
											<div class="input-group-btn">
												<div class="btn btn-sm btn-primary btn-plus">
													<i class="fa fa-plus"></i>
												</div>
											</div>
										</a>
									</div>
								<td class="align-middle">Rs. <%=discountPrice * quantity%></td>
								<td class="align-middle"><a
									href="remove_from_cart.jsp?pro_id=<%=proId%>">
										<div class="btn btn-sm btn-danger">
											<i class="fa fa-times"></i>
										</div>
								</a></td>
								<td class="align-middle"><a
									href="move_to_wishlist.jsp?pro_id=<%=proId%>">
										<div class="btn btn-sm btn-warning">
											<i class="fa fa-heart"></i>
										</div>
								</a></td>
							</tr>
							<%
							} while (rs.next());
							%>
						</tbody>
					</table>
					<!--                 ________________________________ -->
					<div class="row">
						<div class="col-lg-4 mt-4">
							<h5
								class="section-title position-relative text-uppercase mb-3 mt-54">
								<span class="bg-secondary pr-3">Cart Summary</span>
							</h5>
							<div class="bg-light p-30 mb-5">
								<div class="border-bottom pb-2">
									<div class="d-flex justify-content-between mb-3">
										<h6>Selected products</h6>
										<h6>
											Rs. <span id="selectedTotal">0</span>

											<%-- 										<%=grandTotal%> --%>
										</h6>
									</div>
								</div>
								<div class="pt-2">
									<div
										class="btn btn-block btn-primary font-weight-bold my-3 py-3"
										onclick="proceedToCheckout()">
										<!-- Call the proceedToCheckout function -->
										Proceed to Checkout
									</div>
								</div>
								<!-- Error message div -->
								<div id="errorMessage" style="color: red; display: none;">
									Please select at least one product before proceeding to
									checkout.</div>

							</div>
						</div>


						<!-- 			________________________________ -->

						<div class="col-lg-8 mt-4 align-item-end fs-4">
							<h5
								class="section-title position-relative text-uppercase mb-3 mt-54">
								<p class="fs-1">
									<span
										class="bg-primary pr-3 btn btn-block btn-primary font-weight-bold my-3 py-3 fs-1 xc">
										Total cart value: <%=grandTotal%>
									</span>
								</p>
							</h5>

						</div>
				</form>
			</div>
			<%
			}
			%>
		</div>
	</div>

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
	<!-- <span id="queryStringDisplay"></span> -->
	<script>
	let queryString ="";
	function updateSelectedTotal() {
	    const checkboxes = document.querySelectorAll('.productCheckbox:checked'); // Get selected checkboxes
	    let selectedTotal = 0;  // To hold the total price
	    let selectedCartIds = [];  // To hold the cart_ids of selected products

	    // Loop through each selected checkbox
	    checkboxes.forEach((checkbox) => {
	        selectedTotal += parseFloat(checkbox.value);  // Add the total price for the selected product
	        selectedCartIds.push(checkbox.getAttribute('data-cart-id'));  // Get the cart_id of the selected product
	    });

	    // Update the total price displayed on the page
	    document.getElementById('selectedTotal').textContent = selectedTotal.toFixed(2);  // Format to two decimal places

	    // Log the selected cart_ids to the console (optional)
	    console.log("Selected cart_ids: ", selectedCartIds.join(", "));

	    // Build the query string with selected cart_ids
	    queryString = "cart_ids=" + selectedCartIds.join(",");  // Convert array to a comma-separated string

	 // Display the query string in the span
	    document.getElementById('queryStringDisplay').textContent = queryString; 
	    // Redirect to the checkout page with the query string
// 	    window.location.href = "checkout.jsp?" + queryString;  // You can change 'checkout.jsp' to the correct checkout page URL
	}


	function toggleAllCheckboxes(selectAll) {
	    const checkboxes = document.querySelectorAll('.productCheckbox');
	    checkboxes.forEach((checkbox) => {
	        checkbox.checked = selectAll.checked;
	    });
	    updateSelectedTotal();
	}

	
	function proceedToCheckout() {
	    const checkboxes = document.querySelectorAll('.productCheckbox:checked'); // Get selected checkboxes

	    // Check if any products are selected
	    if (checkboxes.length === 0) {
	        // If no products are selected, show error message
	        document.getElementById('errorMessage').style.display = 'block';  // Display error message
	    } else {
	        // If products are selected, hide error message (if any) and redirect to checkout
	        document.getElementById('errorMessage').style.display = 'none';  // Hide error message

	        // Redirect to the checkout page with the query string
	        window.location.href = "checkout.jsp?" + queryString;
	    }
	}
	
</script>

	<!-- cart end -->



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