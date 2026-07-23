<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, jakarta.servlet.*, jakarta.servlet.http.*,project.connection"%>
<%
// Get the session object
HttpSession s = request.getSession(false);

// Check if the session is valid and if the cust is logged in
//       String adminId = (String) s.getAttribute("admin_id");
String order_id = (String) request.getParameter("order_id");
String user_id = (String) s.getAttribute("user_id");
String username = (String) s.getAttribute("username");

// If userId or username is not found, redirect to login page
if (user_id == null || username == null) {
	response.sendRedirect("login.jsp"); // Redirect to your login page
	return; // Ensure the rest of the code is not executed
}
//If userId or username is not found, redirect to login page
if (order_id == null) {
	response.sendRedirect("order_history.jsp"); // Redirect to your login page
	return; // Ensure the rest of the code is not executed
}
//  page = 0;
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
<style>
body {
	margin: 0;
	padding: 0;
	overflow: none;
}

.top-navbar {
	font-size: 35px;
	font-family: "Orbitron", sans-serif;
	font-optical-sizing: auto;
	font-weight: 300;
	font-style: normal;
}

.top-navbar {
	font-family: "Noto Serif Display", serif;
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
	font-variation-settings: "wdth" 100;
}

.nav-item {
	margin-left: 5px;
	margin-right: 5px;
	font-size: large;
	text-decoration: none;
}

.box {
	background-color: #fff;
	margin: 0px 0px 30px;
	border: solid 1px #e6e6e6;
	padding: 20px;
	box-shadow: 0 1ox 5px rgba(0, 0, 0, 0.1);
}

#advantage {
	text-align: center;
	display: flex;
	justify-content: space-between;
}

#advantage .box .icon {
	position: absolute;
	font-size: 120px;
	width: 100%;
	text-align: center;
	top: -20px;
	height: 100%;
	float: left;
	color: #eeeeee;
	transition: all 0.2s ease-out;
	z-index: 1;
	box-sizing: border-box;
}

#advantages .box h3 {
	position: relative;
	margin: 0px 0px 20px;
	font-weight: 300;
	/*             text-transform: uppercase; */
	z-index: 2;
}

#advantages .box h3 a:hover {
	text-decoration: none;
}

#advantages .box p {
	position: relative;
	color: #555555;
	z-index: 2;
}

#hotbox {
	/*             text-transform: uppercase; */
	font-size: 36px;
	color: #4993e4;
	font-weight: 100;
	text-align: center;
	/* margin-top: 20px; */
}

.shop_by_cat {
	padding: 20px;
	border-radius: 35px;
	font-family: "Noto Serif Display", serif;
	font-optical-sizing: auto;
	font-weight: 700;
	font-style: normal;
	font-variation-settings: "wdth" 100;
	color: aqua;
}

.custom-hr {
	border: 7px solid red;
	width: 100%;
	/* Adjust the width as needed */
}

small {
	font-size: large;
}

.nav-item:hover {
	/* border: 1px solid brown; */
	border-bottom: 1px solid black;
}

.card {
	width: 100px;
	height: 300px;
}

.card-img-top {
	width: 100%;
	height: 300px;
	object-fit: contain;
}

.fun:hover {
	background-color: #4993e4;
	color: black;
}

.n {
	margin-left: 5px;
	margin-right: 5px;
	font-size: large;
}

img {
	width: 200px;
	height: 250px;
	object-fit: contain;
}

.dash {
	text-align: center;
}

.a, .b, .c, .d {
	margin-right: 3px;
	width: 245px;
}

.c {
	width: 560px;
	word-wrap: break-word;
}

.x {
	margin-right: 0%;
	margin-left: 0%;
	display: flex;
	/* display: c\ ; */
}
</style>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


<!-- Bootstrap CSS for model -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"> -->

</head>

<body>
	<!-- Topbar Start -->
	<div class="container-fluid">

		<div
			class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex">
			<div class="col-lg-4">
				<a href="" class="text-decoration-none"> <span
					class="h1 text-uppercase text-warning bg-dark px-2">SHOP</span> <span
					class="h1 text-uppercase text-dark bg-warning px-2 ml-n1">ZONE</span>
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
	Connection c = null;
	Statement stmtParent = null;
	Statement stmtSub = null;
	ResultSet rsParent = null;
	ResultSet rsSub = null;
	%>

	<div class="container-fluid bg-dark mb-30">
		<div class="row px-xl-5">
			<div class="col-lg-3 d-none d-lg-block">
				<a
					class="btn d-flex align-items-center justify-content-between bg-warning w-100 "
					data-toggle="collapse" href="#navbar-vertical"
					style="height: 65px; padding: 0 30px;">
					<h4 class="text-dark m-0 ">
						<i class=" mr-2"></i>Categories
					</h4> <i class="fa fa-angle-down text-dark"></i>
				</a>
				<nav
					class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 bg-light"
					id="navbar-vertical"
					style="width: calc(100% - 30px); z-index: 999;">
					<div class="navbar-nav w-100">
						<%
						try {
							// Get the connection using your project connection class
							c = connection.getcon();

							// Parent categories query
							stmtParent = c.createStatement();
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
						if (c != null)
						c.close();
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
							<!-- 							<a -->
							<!-- 								href="shop.jsp" class="nav-item nav-link">Shop</a> -->
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
							<a href="wish_list.jsp" class="btn px-0 "> <i
								class="fas fa-heart text-warning"></i> <span
								class="badge text-secondary border border-secondary rounded-circle"
								style="padding-bottom: 2px;"> <%=wishListCount%>
							</span>
							</a> <a href="cust_cart.jsp" class="btn px-0 ml-3"> <i
								class="fas fa-shopping-cart text-warning"></i> <span
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


	<div class="container-fluid">

		<%
		String user = (String) session.getAttribute("username");
		String custId = (String) session.getAttribute("user_id");

		if (user == null || custId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String orderDetailsQuery = "";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = project.connection.getcon();

			if (request.getParameter("order_id") != null) {
				int fetchOrderId = Integer.parseInt(request.getParameter("order_id"));
				//             orderDetailsQuery = "SELECT * FROM orders WHERE order_id = ? and c_id = ?";

				orderDetailsQuery = "SELECT c.username, o.order_id,p.payment_method, o.order_date, p.amount, o.order_status, o.pincode, "
				+ "o.num_of_items as item_count, o.shipping_address  "
				+ "FROM orders o JOIN payment p ON o.p_id = p.p_id " + "JOIN customer c ON o.c_id = c.c_id  " + // Added a space before WHERE
				"WHERE o.order_id = ? AND o.c_id = ?";

				ps = con.prepareStatement(orderDetailsQuery);
				ps.setInt(1, fetchOrderId);
				ps.setInt(2, Integer.parseInt(custId));
				rs = ps.executeQuery();

				if (rs.next()) {
		%>
		<div class="container">
			<div id="hotbox">
				<div class="box">
					<div class="shop_by_cat container bg-gray text-dark text-center">
						<div class="col-md-12">
							<h1>ORDER DETAILS</h1>
						</div>
					</div>
					<div class="row">
						<div class="col-6 border border-dark rounded text-left ">
							<p class='mb-0 text-dark'>Shop zone</p>
							<h4>j-112, shivalik complex, new-ranip road, ahmedabad,
								gujarat, india</h4>
						</div>
						<div class="col-6 border border-dark rounded  text-left ">
							<p class='mb-0 text-dark'>
								Order ID:
								<%=rs.getInt("order_id")%></p>
							<!--                     <h4></h4> -->
							<p class='mb-0 text-dark'>
								Order Date:
								<%=rs.getDate("order_date")%></p>
							<!--                     <h4></h4> -->
						</div>

						<div class="col-6 border border-dark rounded text-left ">
							<p class='mb-0 text-dark'>Bill to:</p>

							<h4>
								<%="Name : " + rs.getString("username")%><br>
								<%="Address : " + rs.getString("shipping_address")%><br>
								<%="Pincode : " + rs.getString("pincode")%>
							</h4>
						</div>
						<div class="col-6 border border-dark text-black rounded text-left">
							<h4 class='mb-0 text-dark'>
								Payment Mode :
								<%=rs.getString("payment_method")%>

							</h4>
							<h4 class='mb-0 text-dark'>
								Total number of items :
								<%=rs.getString("item_count")%>

							</h4>
							<p class='mb-0 text-dark'>
								Total amount : Rs.
								<%=rs.getString("amount")%>
							</p>
							<!--                     <h4></h4> -->
						</div>
					</div>



					<div class="row text-center m-auto mt-3">
						<h3 class="d-flex justify-content-center text-center fs-2">Items
							in Order</h3>
						<table class="table table-bordered border border-dark">
							<thead>
								<tr>
									<th class="fs-2">Product Image</th>
									<th class="fs-2">Product Name</th>
									<th class="fs-2">Quantity</th>
									<th class="fs-2">Price</th>
									<!-- 									<th >total</th> -->
								</tr>
							</thead>
							<tbody>
								<%
								PreparedStatement psItems = con.prepareStatement(
										"SELECT p.pro_id,p.title, o.quantity, i.path,p.show_price,p.discount FROM order_line_item o JOIN product p ON o.pro_id = p.pro_id JOIN image i ON p.pro_id = i.pro_id  WHERE o.order_id = ?");
								psItems.setInt(1, fetchOrderId);
								ResultSet rsItems = psItems.executeQuery();
								while (rsItems.next()) {
									
									int discountPrice = (int) (rsItems.getDouble("show_price") - ((rsItems.getDouble("show_price") * rsItems.getDouble("discount")) / 100));
%>

								<tr>
									<!-- 									<td  class="fs-3"></td> -->
									<td class="align-middle fs-3"><a
										href="product_detail.jsp?pro_id=<%=rsItems.getString("pro_id")%>"
										class="text-dark"> <img
											src="<%=rsItems.getString("path")%>"
											alt="<%=rsItems.getString("title")%>"
											style="width: 130px; height: 150px"></a></td>
									<td class="align-middle fs-3"><%=rsItems.getString("title")%>
									</td>
									<td class="fs-3"><%=rsItems.getInt("quantity")%></td>
									<td class="fs-3"><%=discountPrice * rsItems.getInt("quantity")%></td>
								</tr>
								<%
								}
								rsItems.close();
								psItems.close();
								%>
							</tbody>
						</table>
					</div>


					<!-- 					track order -->

					<!-- fetching order status  -->


					<%
  // Initialize variables
  String orderStatus = "";
  String[] statuses = {"Order placed", "Processing", "Out for Delivery", "Delivered"};
  int statusIndex = -1;

  try {
    // Fetch the order status from the database
    con = connection.getcon(); // Use your connection object
    ps = con.prepareStatement("SELECT order_status FROM orders WHERE order_id = ?");
    ps.setInt(1, Integer.parseInt(request.getParameter("order_id"))); // Use the provided order_id
    rs = ps.executeQuery();

    if (rs.next()) {
      orderStatus = rs.getString("order_status"); // Fetch order_status
    }

    // Find the index of the current order status
    for (int i = 0; i < statuses.length; i++) {
      if (statuses[i].equalsIgnoreCase(orderStatus)) {
        statusIndex = i;
        break;
      }
    }

    rs.close();
    ps.close();
  } catch (Exception e) {
    out.println("<p>Error fetching order status: " + e.getMessage() + "</p>");
  }
%>

					<!-- Pass the order status to JavaScript -->
					<script type="text/javascript">
  // Store the order status in a JavaScript variable
  var orderStatus = "<%= orderStatus %>";
  var statusIndex = <%= statusIndex %>; // You can also pass the status index if needed

  // You can now use the orderStatus and statusIndex in your JavaScript code
  console.log("Order Status: " + orderStatus);
  console.log("Status Index: " + statusIndex);

  // Example: Updating modal content based on order status
  document.addEventListener("DOMContentLoaded", function() {
    var modalStatus = document.getElementById("orderStatusModal");
    var statusText = document.getElementById("statusText");

    // Update the modal content based on the order status
//     statusText.textContent = orderStatus;

    // Update progress circles in the modal (example)
    var statusElements = document.querySelectorAll(".status-circle");
    statusElements.forEach(function(element, index) {
      if (index < statusIndex) {
        element.classList.add("text-success");
      } else if (index === statusIndex) {
        element.classList.add("text-warning");
      } else {
        element.classList.add("text-muted");
      }
    });
  });
</script>


					<!-- fetching order status  end-->

					<section class="" style="background-color: #eee;">
						<div class="container py-5 h-100">
							<div
								class="row d-flex justify-content-center align-items-center  text-center">
								<div class="col">
									<button type="button" class="btn btn-warning btn-lg"
										data-mdb-toggle="modal" data-mdb-target="#exampleModal1">
										Track your order</button>


									<!-- Modal -->
									<div class="modal fade" id="exampleModal1" tabindex="-1"
										aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-lg">
											<div class="modal-content text-white"
												style="background-color: #6d5b98; border-radius: 10px;">
												<!--       <div class="modal-header border-bottom-0"> -->
												<!--         <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button> -->
												<!--       </div> -->
												<div class="modal-body">
													<h5 class="text-center" id="statusText">Order Status</h5>
													<!-- Dynamic status text -->
													<div class="d-flex justify-content-between mb-5">
														<div class="text-center status-circle">
															<i class="fas fa-circle"></i>
															<p>Order placed</p>
														</div>
														<div class="text-center status-circle">
															<i class="fas fa-circle"></i>
															<p>Processing</p>
														</div>
														<div class="text-center status-circle">
															<i class="fas fa-circle"></i>
															<p>Out for Delivery</p>
														</div>
														<div class="text-center status-circle">
															<i class="fas fa-circle"></i>
															<p>Delivered</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>


								</div>
							</div>
						</div>
					</section>


					<!-- 					track order -->
					<%
					}
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					try {
					if (rs != null)
					rs.close();
					if (ps != null)
					ps.close();
					if (con != null)
					con.close();
					} catch (Exception e) {
					}
					}
					%>

				</div>
			</div>
		</div>
		<!-- table start -->




	</div>
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