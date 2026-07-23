<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="project.connection"%>
<!-- Import your connection provider class -->

<%@page import="jakarta.servlet.http.HttpSession"%>
<% 
double grandTotal = 0;
int total_num_items = 0;
    // Get the session object
    HttpSession s = request.getSession(false);


    // Check if the session is valid and if the cust is logged in
//       String adminId = (String) s.getAttribute("admin_id");
    
    String username = (String) s.getAttribute("username");
    String user_id = (String) s.getAttribute("user_id");
    String user_email = (String) s.getAttribute("user_email");
    if (username == null || user_id == null) {
    	// Redirect to login page if session variables are not set
    	response.sendRedirect("login.jsp");
    	return; // Stop further execution if not logged in
    }
%>

<%
    // Get the 'cart_ids' parameter from the query string
    String cartIdsParam = request.getParameter("cart_ids");

    // Check if the parameter exists and is not empty
    if (cartIdsParam != null && !cartIdsParam.isEmpty()) {
        // Split the comma-separated cart IDs into an array
        String[] cartIdsArray = cartIdsParam.split(",");

        // Process or use the cart IDs as needed
        List<Integer> cartIds = new ArrayList<>();
        for (String id : cartIdsArray) {
            try {
                cartIds.add(Integer.parseInt(id.trim())); // Convert to integer and trim whitespace
            } catch (NumberFormatException e) {
                out.println("Invalid cart ID: " + id); // Handle invalid numbers
            }
        }

        // Print the cart IDs for debugging (optional)
        out.println("Cart IDs: " + cartIds);
    } else {
        out.println("No cart IDs provided in the query string.");
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
				<p class="m-0">

					<%
// 					Cookie[] cookies = request.getCookies();
// 					String username = null;
// 					String user_id = null;
// 					String user_email = null;

// 					if (cookies != null) {
// 						for (Cookie cookie : cookies) {
// 							if (cookie.getName().equals("username")) {
// 						username = cookie.getValue();
// 						break;
// 							}
// 						}
// 					}

// 					if (cookies != null) {
// 						for (Cookie cookie : cookies) {
// 							if (cookie.getName().equals("user_id")) {
// 						user_id = cookie.getValue();
// 						break;
// 							}
// 						}
// 					}
					%>
				</p>
				<h5 class="mr-0">
					<%
					boolean is_logged = false;
					if (username != null) {
						out.print("Welcome " + username);
						// 						out.print(user_id + username+user_email);
						is_logged = true;
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

	<div class="center text-center text-uppercase h1">
		<p>Checkout</p>
	</div>
	<%@ page import="java.sql.*, java.util.*"%>
	<%
    // Database connection
     conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<String> areaOptions = new ArrayList<>();
    List<String> x = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = project.connection.getcon();

        // Fetch all areas and pin codes from the database
        ps = conn.prepareStatement("SELECT area_name, pin_code FROM address");
        rs = ps.executeQuery();

        while (rs.next()) {
            String areaName = rs.getString("area_name");
            String pinCode = rs.getString("pin_code");
            areaOptions.add(areaName + " (" + pinCode + ")");
            x.add(pinCode);
            
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>


	<!-- Checkout Start -->
	<div class="container-fluid">
		<div class="row px-xl-5">


			<div class="col-lg-7">
				<%
    // Assuming cartIds is already populated from the request or session
    List<Integer> cartIds = new ArrayList<>();
    
    // Example of how cart_ids might be populated (you may already have this in your code)
     cartIdsParam = request.getParameter("cart_ids");
//     out.print(cartIdsParam);
    if (cartIdsParam != null && !cartIdsParam.isEmpty()) {
        String[] cartIdsArray = cartIdsParam.split(",");
        for (String id : cartIdsArray) {
            try {
                cartIds.add(Integer.parseInt(id.trim()));
            } catch (NumberFormatException e) {
                out.println("Invalid cart ID: " + id);
            }
        }
    }

    // Check if the cartIds list is not empty
    if (!cartIds.isEmpty()) {
        // Convert the list to a comma-separated string
        String cartIdCondition = String.join(",", cartIds.stream().map(String::valueOf).toArray(String[]::new));

        // Get the database connection
        Connection con = project.connection.getcon();
        
        if (con != null) {
            // SQL query to fetch product details for the given cart_ids
            String query = "SELECT c.cart_id, c.pro_id, p.title, p.show_price, p.discount, c.quantity, " +
                           "p.stock, (c.quantity * p.show_price) AS total, i.path " +
                           "FROM cart c " +
                           "JOIN product p ON c.pro_id = p.pro_id " +
                        	"JOIN image i ON i.pro_id = p.pro_id " +
                           "WHERE c.cart_id IN (" + cartIdCondition + ")";

             ps = con.prepareStatement(query);
             rs = ps.executeQuery();

            // Start generating the table for the checkout page
            
            if (!rs.next()) {
            	out.println("<script>window.location.href='cust_cart.jsp';</script>");
            	   
            } else {
                do {%>
				<table
					class="table table-light table-borderless table-hover text-center mb-0">
					<thead class="thead-dark">
						<tr>
							<th>Products</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody class="align-middle">
						<%
						 grandTotal = 0;
						do {
							String proId = rs.getString("pro_id");
							String title = rs.getString("title");
							double price = rs.getDouble("show_price");
							double discount = rs.getDouble("discount");
							int quantity = rs.getInt("quantity");
							int cart_id = rs.getInt("cart_id");
							// Calculate the discounted price
							int discountPrice = (int) (price - ((price * discount) / 100));

							double total = quantity * discountPrice;
							String imgPath = rs.getString("path");
							grandTotal += total;
							total_num_items += quantity;
						%>
						<tr>
							<td class="align-middle"><img src="<%=imgPath%>"
								alt="<%=title%>" style="width: 130px; height: 150px;"> <br>
								<%=title%></td>
							<td class="align-middle">Rs. <%=discountPrice%></td>
							<td class="align-middle"><%=quantity%></td>
							<td class="align-middle">Rs. <%=discountPrice * quantity %></td>
						</tr>
						<%
						} while (rs.next());
						%>
					</tbody>
				</table>
				<%
                } while (rs.next());
            }

            // Close the resources
            rs.close();
            ps.close();
        } else {
            out.println("Failed to connect to the database.");
        }
    } else {
        out.println("No cart IDs provided.");
    }
%>


			</div>


			<div class="col-lg-5	">
				<h5 class="section-title position-relative text-uppercase mb-3">
					<span class="bg-secondary pr-3">Billing Address</span>
				</h5>
				<div class="bg-light p-30 mb-5">
					<form id="checkoutForm" method="post" action="placeOrder.jsp">
						<div class="row">
							<!--                     <form action="checkout.jsp" method="post"> -->
							<input type="hidden" name="cart_ids" value="<%= cartIdsParam %>">
							<input type="hidden" name="total" value="<%=grandTotal %>">
							<input type="hidden" name="total_num_items"
								value="<%=total_num_items %>">


							<!--     <button type="submit">Checkout</button> -->
							<!-- </form> -->

							<!--                         <div class="col-md-12 form-group"> -->
							<!--                             <label>Name</label> -->
							<%--                             <input class="form-control" type="text" name="firstName" value="<%=username %>" placeholder="First Name" readonly required> --%>
							<!--                         </div> -->
							<!--                         <div class="col-md-12 form-group"> -->
							<!--                             <label>Last Name</label> -->
							<!--                             <input class="form-control" type="text" name="lastName" placeholder="Last Name" required> -->
							<!--                         </div> -->
							<div class="col-md-12 form-group">
								<label>E-mail</label> <input class="form-control" type="email"
									name="email" value="<%=user_email %>"
									placeholder="example@email.com" readonly required>
							</div>
							<!--                         <div class="col-md-12 form-group"> -->
							<!--                             <label>Mobile No</label> -->
							<!--                             <input class="form-control" type="text" name="mobile" placeholder="+91 1234567890" required> -->
							<!--                         </div> -->
							<div class="col-md-12 form-group">
								<label>Address</label> <input class="form-control" type="text"
									name="address" placeholder="123 Street" required>
							</div>
							<div class="col-md-12 form-group">
								<label>State</label> <input class="form-control" type="text"
									name="state" value="Gujarat" readonly>
							</div>
							<div class="col-md-12 form-group">
								<label>City</label> <input class="form-control" type="text"
									name="city" value="Ahmedabad" readonly>
							</div>
							<div class="col-md-12 form-group">
								<label>Search Area</label> <select class="form-control"
									id="searchArea" name="searchArea" required>
									<option value="">Select Area</option>
									<% 
        for (int i = 0; i < areaOptions.size(); i++) { 
            String areaNameWithPin = areaOptions.get(i); 
            String pinCode = x.get(i); 
        %>
									<option value="<%= pinCode %>"><%= areaNameWithPin %></option>
									<% } %>
								</select>
							</div>


						</div>
						<div class="h4 " class="">
							<span>Total Amount: </span><span>Rs. <%=grandTotal %></span>
						</div>
						<div class="mb-5">
							<h5 class="section-title position-relative text-uppercase mb-3">
								<span class="bg-secondary pr-3">Payment By</span>
							</h5>
							<div class="bg-light pt	-30">
								<div class="form-group">
									<div class="custom-control custom-radio">
										<input type="radio" class="custom-control-input"
											name="payment" id="cod" value="COD" required> <label
											class="custom-control-label" for="cod">Cash on
											Delivery</label>
									</div>
								</div>
								<button class="btn btn-block btn-primary font-weight-bold py-3"
									type="submit" form="checkoutForm">Place Order</button>
							</div>
						</div>
					</form>
				</div>
			</div>


		</div>
	</div>
	<!-- Checkout End -->

	<script>
    function fetchAreas() {
        const searchArea = document.getElementById('searchArea').value;
        if (searchArea.length > 2) {
            fetch(`?searchArea=${searchArea}`)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('areaSuggestions').innerHTML = data;
                });
        }
    }
</script>


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