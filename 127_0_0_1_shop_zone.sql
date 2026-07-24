--
-- Database: `shop_zone`
--
CREATE DATABASE IF NOT EXISTS `shop_zone` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `shop_zone`;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `a_id` int(11) NOT NULL,
  `dp_id` int(11) DEFAULT NULL,
  `area_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`a_id`, `dp_id`, `area_name`) VALUES
(1, 1, 'baroda'),
(2, 1, 'naroda');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `c_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `pro_id`, `c_id`, `quantity`) VALUES
(6, 4, 1, 2),
(7, 3, 1, 2),
(9, 11, 1, 1),
(10, 7, 1, 2),
(11, 16, 1, 1),
(12, 24, 1, 3),
(13, 25, 1, 1),
(21, 17, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `c_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `default_address` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`c_id`, `username`, `email`, `default_address`, `password`, `phone_number`) VALUES
(1, 'jinal', 'jinal@gmail.com', '', '123', ''),
(2, 'aasima', 'aasimamansuri56@gmail.com', '', '123', ''),
(3, 'sujal', 'suujal@gmail.com', '', '123', ''),
(4, 'jin', 'jin@gmail.com', '', '123', ''),
(5, 'jinu', 'jinu@gmail.com', '', '123', ''),
(6, 'poonam', 'poonam@gmail.com', '', '123', ''),
(7, 'jjj', 'jjj@gmail.com', '', '123', ''),
(8, 'aaa', 'aaa@gmail.xom', '', '123', ''),
(9, 'pravin', 'pravin@gmail.com', '', '123', ''),
(10, 'xxx', 'xxx@gmail.com', '', '123', ''),
(11, 'aaaa', 'aaaa@gmail.com', '', '123', ''),
(12, 'jimmy', 'jimmy@gmail.com', '', '12345', '');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_person`
--

CREATE TABLE `delivery_person` (
  `dp_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `order_area1` varchar(100) DEFAULT NULL,
  `order_area2` varchar(100) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `total_delivery` int(11) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `delivery_person`
--

INSERT INTO `delivery_person` (`dp_id`, `name`, `email`, `password`, `order_area1`, `order_area2`, `join_date`, `total_delivery`, `salary`) VALUES
(1, 'jinal', 'jinal@gmail.com', '1234', '380013', '380001', '2024-06-23', 2, '220000.00'),
(3, 'x', 'x@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 'naroda', 'baroda', '2024-12-01', 0, '500000.00'),
(4, 'aasima', 'a@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 'baroda', 'naroda', '2024-12-01', 0, '50000.00');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `e_id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`e_id`, `username`, `email`, `password`, `role`, `hire_date`, `salary`) VALUES
(4, 'yamin', 'yamin@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', NULL, NULL, NULL),
(5, 'aasma', 'x@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', NULL, NULL, NULL),
(6, 'jin', 'jin@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL),
(7, 'xxx', 'xxx@gmail.com', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL, NULL, NULL),
(8, 'kkk', 'kkk@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL, NULL, NULL),
(9, 'xxx', 'xxxx@gmail.com', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL, NULL, NULL),
(10, 'khushi', 'khushi123@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `c_id` int(11) DEFAULT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `img_id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`img_id`, `path`, `pro_id`, `created_at`) VALUES
(3, 'img/product_img/p3.jpg', 3, '2024-12-01 17:40:37'),
(4, 'img/product_img/p4.jpg', 4, '2024-12-01 17:40:37'),
(5, 'img/product_img/p5.jpg', 5, '2024-12-01 17:40:37'),
(6, 'img/product_img/p6.jpg', 6, '2024-12-01 17:40:37'),
(7, 'img/product_img/p7.jpg', 7, '2024-12-01 17:40:37'),
(8, 'img/product_img/p8.jpg', 8, '2024-12-01 17:40:37'),
(9, 'img/product_img/p9.jpg', 9, '2024-12-01 17:40:37'),
(10, 'img/product_img/p10.jpg', 10, '2024-12-01 17:40:37'),
(11, 'img/product_img/p11.jpg', 11, '2024-12-01 17:40:37'),
(12, 'img/product_img/p12.jpg', 12, '2024-12-01 17:40:37'),
(13, 'img/product_img/p13.jpg', 13, '2024-12-01 17:40:37'),
(14, 'img/product_img/p14.jpg', 14, '2024-12-01 17:40:37'),
(15, 'img/product_img/p15.jpg', 15, '2024-12-01 17:40:37'),
(16, 'img/product_img/p16.jpg', 16, '2024-12-01 17:40:37'),
(17, 'img/product_img/p17.jpg', 17, '2024-12-01 17:40:37'),
(18, 'img/product_img/p18.jpg', 18, '2024-12-01 17:40:37'),
(19, 'img/product_img/p19.jpg', 19, '2024-12-01 17:40:37'),
(20, 'img/product_img/p20.jpg', 20, '2024-12-01 17:40:37'),
(21, 'img/product_img/p21.jpg', 21, '2024-12-01 17:40:37'),
(22, 'img/product_img/p22.jpg', 22, '2024-12-01 17:40:37'),
(23, 'img/product_img/p23.jpg', 23, '2024-12-01 17:40:37'),
(24, 'img/product_img/p24.jpg', 24, '2024-12-01 17:40:37'),
(25, 'img/product_img/p25.jpg', 25, '2024-12-01 17:40:37'),
(26, 'img/product_img/p26.jpg', 26, '2024-12-01 17:40:37'),
(27, 'img/product_img/p27.jpg', 27, '2024-12-01 17:40:37'),
(28, 'img/product_img/p28.jpg', 28, '2024-12-01 17:40:37'),
(29, 'img/product_img/p29.jpg', 29, '2024-12-01 17:40:37'),
(30, 'img/product_img/p30.jpg', 30, '2024-12-01 17:40:37'),
(31, 'img/product_img/p31.jpg', 31, '2024-12-01 17:40:37'),
(32, 'img/product_img/p32.jpg', 32, '2024-12-01 17:40:37'),
(33, 'img/product_img/p33.jpg', 33, '2024-12-01 17:40:37'),
(34, 'img/product_img/p34.jpg', 34, '2024-12-01 17:40:37'),
(35, 'img/product_img/p35.jpg', 35, '2024-12-01 17:40:37'),
(36, 'img/product_img/p36.jpg', 36, '2024-12-01 12:10:37'),
(37, 'img/product_img/p37.jpg', 37, '2024-12-01 12:10:37'),
(38, 'img/product_img/p38.jpg', 38, '2024-12-01 12:10:37'),
(39, 'img/product_img/p39.jpg', 39, '2024-12-01 12:10:37'),
(42, 'img/product_img/p42.jpg', 42, '2024-12-01 12:10:37'),
(43, 'img/product_img/p43.jpg', 43, '2024-12-01 12:10:37'),
(44, 'img/product_img/p44.jpg', 44, '2024-12-01 12:10:37'),
(45, 'img/product_img/p45.jpg', 45, '2024-12-01 12:10:37'),
(46, 'img/product_img/p46.jpg', 46, '2024-12-01 12:10:37'),
(47, 'img/product_img/p47.jpg', 47, '2024-12-01 12:10:37'),
(48, 'img/product_img/p48.jpg', 48, '2024-12-01 12:10:37'),
(49, 'img/product_img/p49.jpg', 49, '2024-12-01 12:10:37'),
(50, 'img/product_img/p50.jpg', 50, '2024-12-01 12:10:37'),
(51, 'img/product_img/p51.jpg', 51, '2024-12-01 12:10:37'),
(52, 'img/product_img/p52.jpg', 52, '2024-12-01 12:10:37'),
(53, 'img/product_img/p53.jpg', 53, '2024-12-01 12:10:37'),
(54, 'img/product_img/p54.jpg', 54, '2024-12-01 12:10:37'),
(55, 'img/product_img/p55.jpg', 55, '2024-12-01 12:10:37'),
(56, 'img/product_img/p56.jpg', 56, '2024-12-01 12:10:37'),
(57, 'img/product_img/p57.jpg', 57, '2024-12-01 12:10:37'),
(58, 'img/product_img/p58.jpg', 58, '2024-12-01 12:10:37'),
(59, 'img/product_img/p59.jpg', 59, '2024-12-01 12:10:37'),
(60, 'img/product_img/p60.jpg', 60, '2024-12-01 12:10:37'),
(61, 'img/product_img/p61.jpg', 61, '2024-12-01 12:10:37'),
(62, 'img/product_img/p62.jpg', 62, '2024-12-01 12:10:37'),
(63, 'img/product_img/p63.jpg', 63, '2024-12-01 12:10:37'),
(64, 'img/product_img/p64.jpg', 64, '2024-12-01 12:10:37'),
(65, 'img/product_img/p65.jpg', 65, '2024-12-01 12:10:37'),
(66, 'img/product_img/p66.jpg', 66, '2024-12-01 12:10:37'),
(67, 'img/product_img/p67.jpg', 67, '2024-12-01 12:10:37'),
(68, 'img/product_img/p68.jpg', 68, '2024-12-01 12:10:37'),
(69, 'img/product_img/p69.jpg', 69, '2024-12-01 12:10:37'),
(70, 'img/product_img/p70.jpg', 70, '2024-12-01 12:10:37'),
(71, 'img/product_img/p71.jpg', 71, '2024-12-01 12:10:37'),
(72, 'img/product_img/p72.jpg', 72, '2024-12-01 12:10:37'),
(73, 'img/product_img/p73.jpg', 73, '2024-12-01 12:10:37'),
(74, 'img/product_img/p74.jpg', 74, '2024-12-01 12:10:37'),
(75, 'img/product_img/p75.jpg', 75, '2024-12-01 12:10:37'),
(76, 'img/product_img/p76.jpg', 76, '2024-12-01 12:10:37'),
(77, 'img/product_img/p77.jpg', 77, '2024-12-01 12:10:37'),
(78, 'img/product_img/p78.jpg', 78, '2024-12-01 12:10:37'),
(79, 'img/product_img/p79.jpg', 79, '2024-12-01 12:10:37'),
(80, 'img/product_img/p80.jpg', 80, '2024-12-01 12:10:37'),
(81, 'img/product_img/p81.jpg', 81, '2024-12-01 12:10:37'),
(82, 'img/product_img/p82.jpg', 82, '2024-12-30 06:35:20'),
(83, 'img/product_img/p83.jpg', 83, '2024-12-30 06:35:20'),
(84, 'img/product_img/p84.jpg', 84, '2024-12-30 06:35:20');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `p_id` int(11) DEFAULT NULL,
  `c_id` int(11) DEFAULT NULL,
  `dp_id` int(11) DEFAULT NULL,
  `order_status` varchar(100) DEFAULT NULL,
  `num_of_items` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `pincode` varchar(6) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `upi_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_line_item`
--

CREATE TABLE `order_line_item` (
  `order_line_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `pro_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `parent_category`
--

CREATE TABLE `parent_category` (
  `p_cat_id` int(11) NOT NULL,
  `p_cat_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parent_category`
--

INSERT INTO `parent_category` (`p_cat_id`, `p_cat_name`) VALUES
(1, 'men'),
(2, 'women'),
(3, 'girl_kid'),
(4, 'boy_kid');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `p_id` int(11) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_status` varchar(50) DEFAULT NULL,
  `upi_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `pro_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sub_cat_id` int(11) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `show_price` decimal(10,2) DEFAULT NULL,
  `actual_price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `pro_status` int(11) DEFAULT NULL,
  `reorder_limit` int(11) DEFAULT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `about` varchar(255) NOT NULL,
  `colour` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`pro_id`, `title`, `description`, `sub_cat_id`, `keywords`, `show_price`, `actual_price`, `stock`, `pro_status`, `reorder_limit`, `discount`, `create_date`, `update_date`, `about`, `colour`) VALUES
(3, 'Fit Zip-Up Jacket with Full Zipper', 'Men\'s Cruze French Terry Cotton Regular Fit Zip-Up Jacket with Full Zipper Closure and Side Pockets', 8, 'zipper brown  jacket men regular terry cotton side pocket  2100', '2100.00', '1000.00', 4, 1, 3, '11.00', '2024-12-01', NULL, 'Soft and breathable:Our Cruze collection is crafted from a sumptuous French terry cotton-rich fabric that feels buttery-soft and ultra-breathable', 'brown'),
(4, 'MUFTI Mens Ankle Length Jeans', 'Mufti Ankle-length jeans for men which have emerged as a stylish and contemporary twist on traditional denim, redefining the boundaries of casual fashion.', 9, 'black jeans ankel-length men  MUFTI 1200', '1200.00', '1000.00', 4, 1, 3, '12.00', '2024-12-01', NULL, 'intentionally shorter length, typically ending just above the ankle. This design choice not only adds a touch of modern flair but also allows for greater emphasis on footwear, making them a versatile and on-trend option in the world of men\'s fashion.|Clas', 'black'),
(5, 'Denim Baggy Jeans', 'London Hills Men Jeans || Relaxed Pants || Denim Baggy Jeans', 9, 'baggy denim blue jeans 1000', '900.00', '700.00', 5, 1, 3, '3.00', '2024-12-01', NULL, 'Unique product with stretchable jeans for men: Baggy Jeans, Comfortable Quality knitted with stylish Design, fits for summer wear.|This Jeans are Loose Fit to provide you more comforts for any movements, Accurate to wear it in the Office, Casual Parties.|', 'blue'),
(6, 'Regular Fit jeans', 'STUDIO NEXX Men\'s Regular Fit Stretch Jeans (Brown)', 9, 'STUDIO NEXX Men\'s Regular Fit Stretch Jeans Brown', '1100.00', '800.00', 5, 1, 3, '10.00', '2024-12-01', NULL, 'Cotton & Elastane blend; Lycra Blend with Cotton for Superior Comfort.|Mid Rise Stretchable; Comfort fit denim|This pair of jeans from Studio Nexx will add instant style to your casual wardrobe and belongs to series of \'must have jeans\'|Zip fly with butto', 'brown'),
(7, 'Collar Cotton Casual Shirt', 'Arrow Men\'s Checkered Full Sleeve Point Collar Cotton Casual Shirt', 10, 'Arrow Men\'s Checkered Full Sleeve Point Collar Cotton Casual Shirt cheks  black men shirt ', '1800.00', '1000.00', 5, 1, 3, '12.00', '2024-12-01', NULL, 'This Full Sleeve Casual Shirt features a classic front, Point Collar , and a well-defined back yoke. A combition of fine tailored Slim Fit along with Oxford weave fabric provides a fitted silhouette.|Truly comfortable and easy to wear in every season it i', 'black'),
(8, 'Formal Fit Shirt', 'Arrow Men\'s Structured Slim Fit Shirt', 10, 'Arrow Men\'s Structured Slim Fit Shirt brown shirt formal ', '1200.00', '800.00', 7, 1, 3, '13.00', '2024-12-01', NULL, 'This Full Sleeve Formal Shirt features a classic front, Cutaway collar, and a well-defined back yoke. A combination of fine tailored Slim fit along provides a fitted silhouette.|Truly comfortable and easy to wear in every season it is insulating in winter', 'brown'),
(9, 'Regular Fit Shirt', 'Arrow Men\'s Printed Regular Fit Shirt', 10, 'pinted dotted dot brown half sleevs ', '800.00', '700.00', 7, 1, 3, '4.00', '2024-12-01', NULL, 'Color name: Burgundy|Material: Cotton|Short Sleeves|Machine Wash', 'brown'),
(10, ' Blend Men Hooded SweatshirtNOBERO Cotton Blend Men Hooded Sweatshirt', 'NOBERO Cotton Blend Men Hooded Sweatshirt', 11, 'hoodie sweartshirt green winterwear winter men ', '1500.00', '1000.00', 4, 1, 3, '10.00', '2024-12-01', NULL, 'Material composition:60% Cotton, 40% Polyester|Sleeve type:Long Sleeve|Material type:Polyester, Fleece, Cotton|Length:Standard Length', 'green'),
(11, 'Men Crew Neck Sweatshirt', 'NOBERO Cotton Blend Men Crew Neck Sweatshirt', 11, 'hoodie sweartshirt sky blue winterwear winter men ', '1000.00', '900.00', 5, 1, 3, '10.00', '2024-12-01', NULL, 'Adjustable|Breathable|Lightweight', 'sky blue'),
(12, 'Neck Full Sleeve SweatshirtNeostreak Men\'s Cotton Round Neck Full Sleeve Sweatshirt', 'Neostreak Men\'s Cotton Round Neck Full Sleeve Sweatshirt', 11, 'hoodie sweartshirt purple winterwear winter men ', '2000.00', '1000.00', 7, 1, 3, '12.00', '2024-12-01', NULL, 'Material composition:Brushed Terry Cotton|Sleeve type:Fleece|Fit type:Regular|Length:Standard Length|Neck style:Round Neck', 'purple'),
(13, 'Trackpants with Zipper Pockets', 'Jockey MV24 Men\'s Lightweight Microfiber Slim Fit Trackpants with Zipper Pockets and Stay Fresh Treatment', 12, 'track pant black men', '3000.00', '2000.00', 4, 1, 3, '3.00', '2024-12-01', NULL, 'Premium & Soft Brushed Terry Cotton|Stylish Solid Pattern with Rib on Sleeve & Waistline Hem|Round Neck; Closed Front ; Full Sleeve|Regular Length; Perfect for Winter Season, Casual, Athleisure & Evening Wear', 'black'),
(14, 'Trackpants with StayFresh Treatment', 'Jockey SP27 Men\'s Super Combed Cotton Rich Slim Fit Trackpants with StayFresh Treatment', 12, 'gray track pant men', '1000.00', '2000.00', 5, 1, 3, '10.00', '2024-12-01', NULL, 'Material type:Blended|Length:Ankle Length|Style:Flat Front|Closure type:Drawstring', 'grey'),
(15, 'Straight Fit Track Pants', 'Van Heusen Men Straight Fit Black Track Pants', 12, 'black track pant men ', '2000.00', '1000.00', 6, 1, 3, '12.00', '2024-12-01', NULL, 'Material type:Blended|Length:Ankle Length|Style:Flat Front|Closure type:Drawstring', 'black'),
(16, ' Plain T Shirt', 'Lymio Men T-Shirt || T-Shirt for Men || Plain T Shirt || T-Shirt (Polo-18-21)', 13, 'blue Lymio Men T-Shirt  T-Shirt for Men Plain T-Shirt ', '1000.00', '800.00', 5, 1, 3, '4.00', '2024-12-01', NULL, 'Material composition:Cotton Blend|Pattern:Solid|Fit type:Regular Fit|Sleeve type:Half Sleeve|Collar style:Collared Neck', 'blue'),
(17, 'Fit Drop Shoulder Mens T-Shirt', 'NETCLICKÂ® Mens Solid Dotted Unique Design Oversized Tshirt for Men - Round Neck Loose Fit Drop Shoulder Mens T-Shirt', 13, 'NETCLICKÂ® Mens Solid Dotted Unique Design Oversized Tshirt for Men - Round Neck Loose Fit Drop Shoulder Mens T-Shirt', '1500.00', '1000.00', 6, 1, 3, '6.00', '2024-12-01', NULL, 'Material composition:Polycotton|Pattern:Solid|Fit type:Oversized Fit|Sleeve type:Half Sleeve|Collar style:Round Neck', 'blue'),
(18, 'Modi Waistcoat/Nehru Jacket', 'ECOLINE Clothing Eco-Friendly Menâ€™s Sleveless Polycotton Mandarin Collar Modi Waistcoat/Nehru Jacket', 14, 'ECOLINE Clothing Eco-Friendly Menâ€™s Sleveless Polycotton Mandarin Collar Modi Waistcoat/Nehru Jacket', '3000.00', '2000.00', 5, 1, 3, '10.00', '2024-12-01', NULL, 'Material composition:Polycotton|Neck style:Mandarin Neck|Fit type:Regular Fit', 'grey'),
(19, 'Pants | Chinos | Trousers (Regular Fit)', 'Amazon Brand - Symbol Men\'s Casual Cotton Pants | Chinos | Trousers (Regular Fit)', 15, 'Amazon Brand - Symbol Men\'s Casual Cotton Pants | Chinos | Trousers (Regular Fit)', '4001.00', '2000.00', 4, 1, 3, '10.00', '2024-12-01', NULL, 'Material type:Cotton|Length:Standard Length|Style:Chino|Closure type:Zipper|Occasion type:Casual', 'green'),
(20, 'Ethnic Jacket-Waistcoat for Men', 'KISAH Men\'s Printed Sleeveless Jacquard Nehru Jacket | Ethnic Jacket-Waistcoat for Men', 14, 'KISAH Men\'s Printed Sleeveless Jacquard Nehru Jacket | Ethnic Jacket-Waistcoat for Men nehru', '1999.00', '1000.00', 6, 1, 3, '3.00', '2024-12-01', NULL, 'Material composition:Jacquard|Neck style:Mandarin Neck|Fit type:Regular Fit|Closure type:Button', 'lightgreen'),
(21, 'Stylish Mens Cargo Pant, Trouser, Lowers for Men', 'Boldfit Cargo Pant for Men Solid Cargo Joggers for Men & Boys Casual Wear Cargo Pants for Men Regular Fit Cargos for Men Stylish Mens Cargo Pant, Trouser, Lowers for Men', 15, 'Boldfit Cargo Pant for Men Solid Cargo Joggers for Men & Boys Casual Wear Cargo Pants for Men Regular Fit Cargos for Men Stylish Mens Cargo Pant Trouser Lowers for Men', '2000.00', '1000.00', 5, 1, 3, '4.00', '2024-12-01', NULL, 'VERSATILE STYLE FOR EVERY OCCASION:Discover the perfect blend of style and functionality with our cargo pants for men. Tailored for versatility, these pants effortlessly transition from casual outings to outdoor adventures, offering a comfortable and fash', 'black'),
(22, 'Women\'s Elegant Navy Blue Paisley Kurta', 'Chemistry Women\'s Elegant Navy Blue Paisley Kurta | Soft Viscose Fabric | Flowy and Comfortable | Crochet Trim for Feminine Detail | Flattering Regular Fit | Versatile Ethnic Look', 16, 'Chemistry Women\'s Elegant Navy Blue Paisley Kurta | Soft Viscose Fabric | Flowy and Comfortable | Crochet Trim for Feminine Detail | Flattering Regular Fit | Versatile Ethnic Look', '2231.00', '1000.00', 5, 1, 3, '12.00', '2024-12-01', NULL, 'Premium Viscose Fabric:The Chemistry Women\'s Regular Fit Navy Blue Viscose Paisley Printed Kurta with Crochet Trimming is crafted from high-quality viscose fabric, known for its luxurious texture, breathability, and durability. It offers a comfortable and', 'navy blue'),
(23, 'Calf Length Striped Front Slit Kurti', 'rangita Rayon Calf Length Striped Front Slit Kurti for Women | Kurta for Women', 16, 'rangita Rayon Calf Length Striped Front Slit Kurti for Women | Kurta for Women BLUE', '4000.00', '3000.00', 5, 1, 3, '9.00', '2024-12-01', NULL, 'Colour:Blue|Fabric:Rayon|Style:Front Slit|Neck:Mandarin Neck', 'blue'),
(24, 'Womens Kanjivaram Banarasi Silk Saree ', 'SWORNOF Womens Kanjivaram Banarasi Silk Saree Patola saree with Unstitched blouse piece', 18, 'SWORNOF Womens Kanjivaram Banarasi Silk Saree Patola saree with Unstitched blouse piece PINK PEECH', '1230.00', '1000.00', 4, 1, 3, '12.00', '2024-12-01', NULL, 'Material:Organza SAREE|Design:Zari Weaving SAREE|Features :Saree With Blouse Piece|Style:The Texture And Weight Of The Saree Brings Image Prints One Step Closer To The Originals And Invites Attention', 'pink peech'),
(25, 'Soft Cotton & Silk Saree', 'OM SAI LATEST CREATION Soft Cotton & Silk Saree for Women Banarasi Saree Under 399 2021 Beautiful for Women Saree', 18, 'OM SAI LATEST CREATION Soft Cotton & Silk Saree for Women Banarasi Saree Under 399 2021 Beautiful for Women Saree BLUE PINK', '3000.00', '2000.00', 6, 1, 3, '10.00', '2024-12-01', NULL, 'With blouse piece|Dry clean only|Ceremony wear', 'blue pink'),
(26, 'Art Silk Dupatta', 'The SDF India Women\'s Zari Design Art Silk Dupatta', 19, 'The SDF India Women\'s Zari Design Art Silk Dupatta BLACK GOLDEN', '400.00', '300.00', 4, 1, 3, '3.00', '2024-12-01', NULL, 'Package contents:Pure Silk Dupatta|Ocassion:Wedding, Party & Festive|Pattern:Banarasi Jacquard Woven', 'black'),
(27, 'Cotton Dupatta With Pom Pom Border', 'Cotton Dupatta With Pom Pom Border', 19, 'Cotton Dupatta With Pom Pom Border PINK', '500.00', '300.00', 6, 1, 3, '6.00', '2024-12-01', NULL, 'Package Contents:Printed Readymade Cotton Dupatta with Pom Pom border for Women and Girls. Package contains 1 Dupatta|Dupatta Material:100% pure Cotton Dupatta material for comfortable fit all-day long|Dupatta Length:2.25 Meters Dupatta Width:24 Inches|Fa', 'pink'),
(28, 'Necklace Design Readymade Blouse', 'Pujia Mills Women\'s Embroidery Handwork Sequence Work Necklace Design Readymade Blouse', 20, 'Pujia Mills Women\'s Embroidery Handwork Sequence Work Necklace Design Readymade Blouse PINK', '1000.00', '900.00', 4, 1, 3, '8.00', '2024-12-01', NULL, 'Fabric:Milan silk|Work:Embroidery codding|eadymade blouse for women comes with both side margin so these are easily altered according the size. It is latest blouse designer readymade designer blouse good for wedding festive and party wear blouse. Occasion', 'pink'),
(29, 'Readymade Saree Blouse for Women', 'FINESTFIT Round Neck 100% Cotton Dobby Fabric Stretchable Elbow Sleeve Readymade Saree Blouse for Women black', 20, 'FINESTFIT Round Neck 100% Cotton Dobby Fabric Stretchable Elbow Sleeve Readymade Saree Blouse for Women BLACK', '2000.00', '1000.00', 5, 1, 3, '10.00', '2024-12-01', NULL, 'Experience timeless elegance in our round neckline blouse with elbow sleeves a perfect blend of style and grace|eady-to-Wear Convenience: Pre-stitched blouses, ready for instant wear without the need for tailoring|Diverse Styles and Designs:Explore a wide', 'black'),
(30, 'Fit Cotton Leggings', 'GO COLORS Women\'s Skinny Fit Cotton Leggings', 21, 'GO COLORS Women\'s Skinny Fit Cotton Leggings  red ', '3300.00', '200.00', 6, 1, 3, '13.00', '2024-12-01', NULL, 'Made with a blend of 95% cotton and 5% elastane, Go Colors Ankle length leggings offer the perfect balance of softness and stretch for a flattering slim fit.|The leggings feature a mid-rise waist, slip-on closure, and elasticized waistband. Designed ankle', 'red'),
(31, 'Cotton Knit Jegging', 'GO COLORS Women Mid Rise Cotton Knit Jegging', 21, 'GO COLORS Women Mid Rise Cotton Knit Jegging black', '2000.00', '1000.00', 4, 1, 3, '10.00', '2024-12-01', NULL, 'Made with a blend of Cotton, Polyester, and Spandex, Go Colors Knit Jeggings offer the perfect balance of softness and super stretch for a flattering slim fit|Our knit jeggings feature a mid-rise waist and elasticized waistband with back patch pockets. De', 'black'),
(32, 'lengha with full length ', 'Studio Shringaar Women\'s Readymade Polyester Taffeta Floor Length Skirt Lahenga Ghaghra', 22, 'Studio Shringaar Women\'s Readymade Polyester Taffeta Floor Length Skirt Lahenga Ghaghra red mehroon', '2000.00', '1500.00', 6, 1, 3, '10.00', '2024-12-01', NULL, 'Readymade Skirt With Soft Crepe Lining|This skirt is good for waist size 29 to 32|FLAIR:4| Meters:40', 'red mehroon'),
(33, ' Divided Skirts for Women ', 'W for Woman W Strechable Divided Skirts for Women | Culottes for Women', 22, 'W for Woman W Strechable Divided Skirts for Women | Culottes for Women pink', '5200.00', '1000.00', 7, 1, 3, '20.00', '2024-12-01', NULL, 'Partially Elasticated Mid Rise Divided Skirts For Women|Fuschia Pink Divided Skirts for Women|PAIR THESE CULOTTES WITH A CONTRAST KURTA AND DANGLER EARRINGS FOR A FESTIVE LOOK', 'pink'),
(34, ' Knee-Length A-Line Dress', 'Amazon Brand - Myx Women\'s Rayon Knee-Length A-Line Dress', 23, 'Amazon Brand - Myx Women\'s Rayon Knee-Length A-Line Dress yellow frok', '3000.00', '2000.00', 4, 1, 3, '10.00', '2024-12-01', NULL, 'Non-sheer fabric without lining|Knee length, A-line tiered sleeveless dress|Style with statement earrings, chunky sneakers or statement heels', 'yellow'),
(35, 'Sleeve One Piece Western Dress', 'Miss ika Women\'s Printed Cotton Round Neck 3/4 Sleeve One Piece Western Dress', 23, 'Miss ika Women\'s Printed Cotton Round Neck 3/4 Sleeve One Piece Western Dress pink white', '900.00', '700.00', 4, 1, 3, '6.00', '2024-12-01', NULL, 'This is a perfect gifting option for every woman. You can give it to your friend, spouse, colleagues, and relatives on several occasions.This Western Dress for women western wear is rendered with beautiful multicolor.|The images shown are for representati', 'pink white'),
(36, 'Womens Printed Full Sleeves Top & Joggers', 'SN SWEET NIGHT Cotton Track Suit for Womens', 24, 'purple joggers  full sleeves winter', '4999.00', '1300.00', 2, 1, 3, '15.00', '2024-12-01', NULL, 'Ideal For : Jogging, Running, Gymwear & Activewear', 'purple'),
(37, 'Mickey Mouse Printed Cotton joggers', 'SWEET NIGHT Women’s Mickey Mouse Printed Cotton Tracksuit', 24, 'pink  joggers mickey mouse cotton', '2500.00', '1300.00', 5, 1, 3, '7.00', '2024-12-01', NULL, 'Designed with a comfortable and relaxed fit, this tracksuit allows for easy movement and all-day comfort.', 'pink'),
(38, 'Jacket and Lower Set For Women', ' London Teddy Printed Classic Tracksuit Set', 24, 'white joggers Teddy Printed Jacket and Lower Set For Women ', '8000.00', '1800.00', 2, 1, 3, '20.00', '2024-12-01', NULL, 'Smooth front zipper, side pockets for both tops and bottoms, practical and convenient.', 'white'),
(39, 'Sweet Dreams Women Solid Track Suit joggers', 'Full sleeves Round Neck sweatshirt', 24, 'yellow Full sleeves Round Neck sweatshirt joggers winter', '2200.00', '900.00', 4, 1, 3, '10.00', '2024-12-01', NULL, 'Full sleeves Round Neck sweatshirt Trackpants with pockets on either side to keep essentials', 'yellow'),
(42, 'Girl\'s Cotton Hooded Sweatshirt', 'Available in  Pink', 25, 'pink hoodie winter wear ', '9500.00', '1200.00', 3, 1, 3, '25.00', '2024-12-01', NULL, 'Winter Wear; Ideal for School, Sports, Casual wear, Outings, etc.', 'pink'),
(43, ' One Shoulder Crepe Fit & Flare SKU Blue Trendy Dress', 'Pspeaches  Girl\'s Striped One Shoulder Crepe Fit & Flare SKU Blue Trendy Dress', 26, 'skyblue flare Blue Trendy Dress', '2000.00', '800.00', 5, 1, 3, '8.00', '2024-12-01', NULL, 'Material type:Crepe|Length:Above the Knee|Sleeve type : Sleeveless|Style:Fit And Flare', 'skyblue'),
(44, 'Fashion Dream Girl\'s Printed Maxi Length Dress', 'Printed Dress for Girls Ethnic Dress', 26, 'pink maxi dress ankle length dress flare dress', '2200.00', '1000.00', 1, 1, 3, '9.00', '2024-12-01', NULL, 'Fabric: Weight Less Georgette|Style: Fit and Flare Maxi Dress For Girls.|Neck: Round-Neck', 'pink'),
(45, 'Baby Girl Knee Length Casual Dress', 'Red Solid Fit & Flare Dress', 26, 'Red Solid Fit & Flare Dress', '6400.00', '1200.00', 2, 1, 3, '19.00', '2024-12-01', NULL, 'Red Solid Fit & Flare Dress has one shoulder, sleeveless, knee length in flared hem.|It is made of high quality materials, durable enough for your daily wear.', 'red'),
(46, 'Glitter Sequins Long Sleeves Flower Girls Dresses', 'Glitter Sequins Long Sleeves Flower Girls Dresses for Wedding Tulle Birthday Party Christmas Dress for Girl', 26, 'purple Glitter Sequins Long Sleeves Flower Girls Dresses for Wedding Tulle Birthday Party Christmas Dress for Girl', '2500.00', '1300.00', 3, 1, 3, '8.00', '2024-12-01', NULL, 'Very soft premium net used in bottom part and sequen work with velvet fabric used for top with astar. Zipper open at back side, Full Sleeve, Round neck pattern', 'purple'),
(47, 'Girl flare Dress', 'Easter, Wedding, Prom Homecoming, Birthday, Cocktail Party dress', 26, 'black Easter, Wedding, Prom Homecoming, Birthday, Cocktail Party', '5700.00', '1500.00', 4, 1, 3, '17.00', '2024-12-01', NULL, 'Soft Breathable Fabric|Material Composition: 100% Polyester|Type: Sleeveless', 'black'),
(48, 'Pyjama Set for Boys', 'Sleepwear Night Suit, Night Wear', 28, 'white Sleepwear Night Suit  Night Wear', '1500.00', '450.00', 5, 1, 3, '10.00', '2024-12-01', NULL, 'Cozy Comfort for Sweet Dreams! Get your little ones ready for bed in our delightful Kids Pure Cotton Pyjama Set! Crafted from 100% soft, breathable cotton, this set ensures a comfortable night\'s sleep for your child.', 'white'),
(49, 'Night Dress for Boys', 'Nightwear/Sleepsuit/Sleepwear/Loungewear Night Suit for Boys', 28, 'black Nightwear Sleepsuit Sleepwear Loungewear Night Suit for Boys', '9700.00', '500.00', 4, 1, 3, '25.00', '2024-12-01', NULL, 'This shirt pajama sets is convenient in summers, winters, spring and fall. Perfect for night wear, sleep wear, daily wear, playwear, home, school, outside wear, sport wear, camp wear etc.', 'black'),
(50, 'Mickey Print Nightsuit for Kids', 'Mickey Print Nightsuit for Kids - Stylish and Comfortable Sleepwear', 28, 'pink Mickey Print Nightsuit for Kids', '1900.00', '600.00', 3, 1, 3, '6.00', '2024-12-01', NULL, 'Cool Mickey Print: Featuring a vibrant Mickey print on both the top and bottom, this nightsuit adds a touch of fun to bedtime.', 'pink'),
(51, 'Boys Cotton Printed Night Suit Set', 'orange night suit for boys', 28, 'orange night suit for boys', '1100.00', '800.00', 2, 1, 3, '5.00', '2024-12-01', NULL, 'Soft, Breathable, and Durable: Tailored for kids, our nightwear stands out for its soft, breathable, and durable fabric. Your child will stay comfortable in any season, ensuring a good night\'s sleep and long-lasting wear.', 'orange'),
(52, 'Boys Nightwear Set', 'Clothe Funn Boys Co-Ordinate Set, Boys Nightwear Set', 28, 'red blue Boys Nightwear Set', '3300.00', '1000.00', 1, 1, 3, '13.00', '2024-12-01', NULL, 'Cotton Day and Night dress for Boys, sleep - loungewear - home wear - Nightwear, Loungewear, Sleepwear, Extremely Comfortable For All Night', 'red'),
(53, 'Camouflage Shorts', 'Alan Jones Clothing Boys Camouflage Shorts', 27, 'green Camouflage Shorts', '1500.00', '300.00', 3, 1, 3, '5.00', '2024-12-01', NULL, 'Material: Cotton | Fit Type: Regular Fit |Knee length Short for boys.|Durable and Soft Fabric.', 'green'),
(54, 'Boys Regular Fit Cotton Blend Fashion Shorts', 'comfortable, easy-to-wear pair of shorts', 27, 'yellow Boys Regular Fit Cotton Blend Fashion Shorts', '1600.00', '500.00', 5, 1, 3, '4.00', '2024-12-01', NULL, 'These shorts are made from a lightweight and durable fabric that is perfect for both play and everyday wear. The versatile Classic Solid Pastel pattern also makes them perfect for any child\'s wardrobe..', 'yellow'),
(55, 'Boys Knee Length Cargo Short', 'Comfortable fit and easy to wear pattern short', 27, 'grey short man', '2700.00', '600.00', 4, 1, 3, '14.00', '2024-12-01', NULL, 'Made from Cotton Single Jersey Knit Fabric|Comfortable fit and easy to wear pattern|2 front pockets 2 Cargo pocket', 'grey'),
(56, 'Boys Cotton Cargo Capri Shorts', 'Pure cotton material shorts', 27, 'sky blue Boys Cotton Cargo Capri Shorts', '1900.00', '700.00', 3, 1, 3, '5.00', '2024-12-01', NULL, 'Pure cotton material and suitable for all seasons.|Side Pockets and Elastic waist band with drawstring.|Comfortable and Relax Fit', 'skyblue'),
(57, 'Men Shorts ', 'FASHION Men Shorts || Men Shorts Cotton || Men Shorts Casual || Men Cotton Chino Shorts || Bermuda (Short)', 27, 'sandle cream men shorts', '3800.00', '800.00', 2, 1, 3, '15.00', '2024-12-01', NULL, 'men shorts casual|Side slant pockets and back welt pockets|Pair with a classic T-shirt or Polo for a casual summer look', 'sandle cream'),
(58, 'Tracksuit for Kid\'s', 'Tracksuit for Kid\'s | Soft and Comfortable|Track Suit for Boy\'s ', 29, 'blue tracksuit winter for kids', '1900.00', '900.00', 1, 1, 3, '6.00', '2024-12-01', NULL, 'Soft Polyester Material: Made from high-quality polyester, ensuring a soft and comfortable feel, perfect for active kids.|Provides extra warmth and coverage, making it perfect for cooler days and active play.', 'blue'),
(59, 'Tracksuit For Kids', 'Boys Fleece Cotton Winter Wear High Neck Tracksuit For Kids', 29, 'yellow tracksuit for kids', '4100.00', '1000.00', 5, 1, 3, '16.00', '2024-12-01', NULL, 'Material composition:Cotton Blend|Closure type:Zipper|Care instructions:Machine Wash|Pocket style:Utility Pocket', 'yellow'),
(60, 'cordset tracksuit', 'Alan Jones Clothing Boys Colorblocked Co-ords Set Tracksuit', 29, 'red blue cordset tracksuit', '2200.00', '1100.00', 4, 1, 3, '7.00', '2024-12-01', NULL, 'Tracksuit in colorblock Cottonblend fabric and Soft inside|Ideal For: Casual Wear, Outerwear & Sportswear', 'blue red'),
(61, 'Boys Solid Tracksuit Set', 'Solid Sweatshirt fabric tracksuit', 29, 'green olive Boys Solid Tracksuit Set', '5300.00', '1200.00', 3, 1, 3, '17.00', '2024-12-01', NULL, 'Tracksuit in Solid Sweatshirt fabric and Soft Brushed inside|Top: Zipper Hooded Jacket : Bottom: Joggers with Ribbed, elasticated, drawstring waist, pockets in the side seams and ribbed hems.', 'green olive'),
(62, 'Comfortable Track Suit For Boys', 'Comfortable Track Suit For Boys, Regular Fit Design, Zip Closure with Minimalist Style orange', 29, 'orange Comfortable Track Suit For Boys', '2400.00', '1300.00', 2, 1, 3, '8.00', '2024-12-01', NULL, 'Pure Woolen Material: Crafted from pure woolen fabric, this tracksuit offers exceptional warmth and comfort, perfect for chilly weather.|Soft and Comfortable: The soft texture of the woolen fabric ensures a cozy fit, keeping your child comfortable all day', 'orange'),
(63, 'Clothing Cotton Hooded Sweatshirt for Girls', 'Premium Export Quality Branded Full Sleeve sweatshirt for Girls', 25, 'pink Premium Export Quality Branded Full Sleeve sweatshirt for Girls hoodie', '6000.00', '1800.00', 1, 1, 3, '18.00', '2024-12-01', NULL, 'Fabric: Rich Cotton ; Premium Export Quality Branded Full Sleeve sweatshirt for Girls; Unique Collection to your wardrobe casuals a hit of effortless cool with this best looking Sweatshirt', 'pink'),
(64, 'Hooded Sweatshirt', 'Girl\'s Tie-Dye Cotton Hooded Sweatshirt', 25, 'purple black Girl\'s Tie-Dye Cotton Hooded Sweatshirt', '3100.00', '1900.00', 2, 1, 3, '9.00', '2024-12-01', NULL, 'Style: Fashionable, Perfect for Trending Stylish Look.|Perfect for Winters & Casual Wear', 'purple black'),
(65, 'Hooded Sweatshirt with Zipper', 'green Girls Winter Hooded Sweatshirt with Zipper', 25, 'green Girls Winter Hooded Sweatshirt with Zipper', '7200.00', '2000.00', 3, 1, 3, '19.00', '2024-12-01', NULL, 'Fabric:type of sweatshirt|Neck style:Hooded Neck|Style:Casual', 'green'),
(66, 'Hoody Sweater for Girls', 'N.FASHION  yellow Wool Solid Hoody Sweater for Girls', 25, 'N.FASHION  yellow Wool Solid Hoody Sweater for Girls', '3300.00', '2100.00', 4, 1, 3, '5.00', '2024-12-01', NULL, 'Adorable and charming designed, perfect for casual occasions|Suitable for every occassion', 'yellow'),
(67, 'blue Jogger Set ', 'Girls Never Mind Printed Top with Jogger Set', 24, 'blue Jogger Set ', '8500.00', '2300.00', 5, 1, 3, '20.00', '2024-12-01', NULL, 'Fabric:- Cotton|Neck Type:- Round|Sleeves:- Half Sleeves', 'blue'),
(68, 'red Straight Kurta', 'Women\'s Rayon Straight Kurta', 16, 'red Straight Kurta', '3600.00', '2230.00', 4, 1, 3, '5.00', '2024-12-01', NULL, 'Product Description: This red coloured kurta for women has straight silhouette and regular fit. It is designed in keyhole neckline and has three-quarter sleeves. This beautiful printed kurta for women with crafted in premium rayon fabric which is flowy, b', 'red'),
(69, 'Ethnic Kurta Set for Women ', 'Ethnic Kurta Set for Women 3/4 Sleeve, Round Neck Cotton A-line Solid Kurta with Palazzo Pant Set', 16, 'yellow Ethnic Kurta Set for Women ', '3700.00', '2450.00', 3, 1, 3, '5.00', '2024-12-01', NULL, 'Elegant Cotton Kurta Sets for Women - Our Mustard traight Cotton Kurta with Palazzo Pant Set is great for those seeking designer kurta sets that are both stylish and comfortable for festive occasions.', 'yellow'),
(70, 'Chikankari Embroidered Kurta', 'Women\'s Rayon Blend Straight Chikankari Embroidered Kurta', 16, 'green women Chikankari Embroidered Kurta', '3800.00', '2340.00', 2, 1, 3, '5.00', '2024-12-01', NULL, 'Kurta Fabric: Rayon Blend |Kurta Color :- Green|Style: Straight | Length: Calf Length', 'green'),
(71, 'Anarkali Printed Kurta with Palazzo & Dupatta', 'Women\'s Rayon Blend Anarkali Printed Kurta with Palazzo & Dupatta', 17, 'yellow salwar Women\'s Rayon Blend Anarkali Printed Kurta with Palazzo & Dupatta', '4900.00', '2890.00', 1, 1, 3, '3.00', '2024-12-01', NULL, 'Kurta and Bottom Fabric: Rayon Blend |Kurta Set Color :- Yellow|Style: Anarkali | Length: Calf Length | Sleeves: 3/4 Sleeves', 'yellow'),
(72, 'orange Anarkali Solid Kurta with Pant & Dupatta', 'Women\'s Rayon Blend Anarkali Solid Kurta with Pant & Dupatta', 17, 'orange salwar  Anarkali Solid Kurta with Pant & Dupatta', '7000.00', '2790.00', 5, 1, 3, '13.00', '2024-12-01', NULL, 'Kurta and Bottom Fabric: Cotton Blend | Kurta Set Color :- Orange|Style: Anarkali | Length: Calf Length | Sleeves: 3/4 Sleeves ', 'orange'),
(73, 'Embroidered Angarkha Kurta Pant With Dupatta', 'purple Royal Export Women\'s Viscose Floral Embroidered Angarkha Kurta Pant With Dupatta', 17, 'purple Embroidered Angarkha Kurta Pant With Dupatta salwar', '5100.00', '2901.00', 4, 1, 3, '4.00', '2024-12-01', NULL, 'Kurta Work- Embroidered, Pant Work- Solid, Dupatta Work- Embroidered Work Type- Floral', 'purple'),
(74, 'black Embroidery Kurta Set ', 'Women\'s Viscose Embroidery Kurta And Pant Set With Dupatta | Embroidery Kurta Set | Suit', 17, 'black salwar Embroidery Kurta Set ', '5250.00', '3167.00', 3, 1, 3, '14.00', '2024-12-01', NULL, 'Fit Type: Straight; Ethnic Sets: Straight Kurta Pant and Embroidery Dupatta Set |Product Material :- Viscose | Colour :- Black | Pattern :- Embroidery Kurta Set', 'black'),
(75, ' Nyra Cut Salwar Suit Set for women', 'Women\'s Rayon Nayra Cut Embroidery Kurta with Pant and Dupatta Set', 17, 'blue  Nyra Cut Salwar Suit Set for women', '4467.00', '3345.00', 2, 1, 3, '5.00', '2024-12-01', NULL, 'nayra cut Kurta Set with dupatta for Women: This elegant nayra cut set is designed specifically for women, offering a stylish and fashionable choice for various occasions|Style: nayra cut | Length: Calf Length | Sleeves: 3/4 Sleeves | Fabric : Rayon | Wor', 'blue'),
(76, 'Printed Saree with Blouse Piece', 'MIRCHI FASHION Women\'s Latest Chiffon Batik Printed Saree with Blouse Piece', 18, 'green MIRCHI FASHION Women\'s Latest Chiffon Batik Printed Saree with Blouse Piece', '4569.00', '3170.00', 1, 1, 3, '5.00', '2024-12-01', NULL, 'Saree Work: Batik Printed|Fabric :: Saree - Chiffon|Blouse - Chiffon|Color :: Saree - Parrot Green, Off White | Blouse - Parrot Green', 'green'),
(77, 'Saree with Unstitched Blouse Material', ' Women\'s Hot Fix Solid Color Satin Moss Saree with Unstitched Blouse Material', 18, 'blue rama saree', '4670.00', '3267.00', 2, 1, 3, '6.00', '2024-12-01', NULL, 'Elegant Design: This saree features a stunning shade of RAMA with a smooth satin moss finish, offering a glossy, luxurious appearance that enhances your style.', 'blue rama'),
(78, 'Kanjeevaram Saree With Unstitched Blouse Piece', 'Women\'s Banarasi Jacquard Soft Kanjeevaram Saree With Unstitched Blouse Piece', 18, 'red Kanjeevaram Saree for women', '6780.00', '3450.00', 5, 1, 3, '15.00', '2024-12-01', NULL, 'Occassion: This Saree Is Suitable To Get A Contemporary Stylish Look In Normal Occasions, College Farewell, Family Get Together, Regular Or Daily Use, Office Or Work Or Gifting To Loved One|Saree Fabric: Silk | Blouse Fabric: Silk', 'red'),
(79, 'Silk Printed Dupatta', 'RANI SAAHIBA Women\'s Art Silk Printed Dupatta', 19, 'blue Silk Printed Dupatta', '1500.00', '450.00', 4, 1, 3, '7.00', '2024-12-01', NULL, 'Rani Saahiba Soft Art Silk Printed Dupatta With Tassels|Occasion : Daily, Party, Festival and Occasion Wear Dupatta', 'blue'),
(80, 'Silk Blend Dupatta', 'Women\'s Floral Silk Blend Dupatta', 19, 'yellow Women\'s Floral Silk Blend Dupatta', '4750.00', '560.00', 3, 1, 3, '17.00', '2024-12-01', NULL, 'Woven Banarasi Woven Floral Zari Dupatta|Dupatta Fabric : Silk Blend |Dupatta Work : Woven Motifs|This Dupatta goes With Both Ethnic And Western Outfits, Just Pair it with any basic Outfit and Highlight Your Occasion.', 'yellow'),
(81, 'Cotton Dupatta', 'brown Women\'s Solid Cotton Dupatta', 19, 'brown Women\'s Solid Cotton Dupatta', '1654.00', '650.00', 2, 1, 3, '8.00', '2024-12-01', NULL, 'Material: Cotton|Color: Maroon|Occasion: Casual; Other Features: Authentic Kutchi Bandhani Soft Cotton Dupatta', 'brown'),
(82, 'Elbow Length Sleeves Saree Blouse', 'Women\'s Readymade Pastel Brocade Elbow Length Sleeves Saree Blouse', 20, 'golden Women\'s Readymade Pastel Brocade Elbow Length Sleeves Saree Blouse', '7560.00', '3245.00', 1, 1, 3, '18.00', '2024-12-01', NULL, 'Readymade Saree Blouse. Non-Padded.|Boat Neck. Elbow Length Sleeves|Opens from the Back With Hook & Eye.', 'golden'),
(83, 'Readymade Silky Saree Blouse ', ' Women\'s Readymade Silky Saree Blouse Elbow Length Sleeves With Embroidered Neckline Choli', 20, 'blue  Women\'s Readymade Silky Saree Blouse Elbow Length Sleeves With Embroidered Neckline Choli', '3456.00', '2890.00', 5, 1, 3, '9.00', '2024-12-01', NULL, 'V Neck. Elbow Length Sleeves.|Lined With Pure Cotton. Margins Provided.Silky embroidered with golden gota petals', 'blue'),
(84, 'Half Sleeves Neck Blouse', 'Womens Jacquard Boat Half Sleeves Neck Blouse', 20, 'red Womens Jacquard Boat Half Sleeves Neck Blouse', '6563.00', '3425.00', 4, 1, 3, '19.00', '2024-12-01', NULL, 'Jaquard blouse with boat neck and high back|Buttons at back|Cotton Lining', 'red');

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `sub_cat_id` int(11) NOT NULL,
  `sub_cat_name` varchar(100) NOT NULL,
  `sub_cat_pic_path` varchar(100) NOT NULL,
  `p_cat_id` int(11) DEFAULT NULL,
  `total_products` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`sub_cat_id`, `sub_cat_name`, `sub_cat_pic_path`, `p_cat_id`, `total_products`) VALUES
(8, 'Jackets & Coats', 'img/cat_img/c1.jpg', 1, 1),
(9, 'Jeans', 'img/cat_img/c2.jpg', 1, 3),
(10, 'Shirts', 'img/cat_img/c3.jpg', 1, 3),
(11, 'Sweatshirts & Hoodies', 'img/cat_img/c4.jpg', 1, 3),
(12, 'Track Pants', 'img/cat_img/c5.jpg', 1, 3),
(13, 'T-shirts', 'img/cat_img/c6.jpg', 1, 2),
(14, 'Nehru Jackets', 'img/cat_img/c7.jpg', 1, 2),
(15, 'Trousers', 'img/cat_img/c8.jpg', 1, 2),
(16, 'Kurtas', 'img/cat_img/c9.jpg', 2, 5),
(17, 'Salwars ', 'img/cat_img/c10.jpg', 2, 5),
(18, 'Sarees', 'img/cat_img/c11.jpg', 2, 5),
(19, 'Dupattas', 'img/cat_img/c12.jpg', 2, 5),
(20, 'Blouses', 'img/cat_img/c13.jpg', 2, 5),
(21, 'Leggings', 'img/cat_img/c14.jpg', 2, 2),
(22, 'Skirts & Ghagras', 'img/cat_img/c15.jpg', 2, 2),
(23, 'froks', 'img/cat_img/c16.jpg', 2, 2),
(24, 'jogger set', 'img/cat_img/c17.jpg', 3, 5),
(25, 'hoodie', 'img/cat_img/c18.jpg', 3, 5),
(26, 'flare dress', 'img/cat_img/c19.jpg', 3, 5),
(27, 'shorts', 'img/cat_img/c20.jpg', 4, 5),
(28, 'nightwear', 'img/cat_img/c21.jpg', 4, 5),
(29, ' tracksuit ', 'img/cat_img/c22.jpg', 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `w_id` int(11) NOT NULL,
  `c_id` int(11) DEFAULT NULL,
  `pro_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`w_id`, `c_id`, `pro_id`) VALUES
(8, 1, 24),
(14, 12, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`a_id`),
  ADD KEY `dp_id` (`dp_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `pro_id` (`pro_id`),
  ADD KEY `c_id` (`c_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`c_id`);

--
-- Indexes for table `delivery_person`
--
ALTER TABLE `delivery_person`
  ADD PRIMARY KEY (`dp_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`e_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`img_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `p_id` (`p_id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `dp_id` (`dp_id`);

--
-- Indexes for table `order_line_item`
--
ALTER TABLE `order_line_item`
  ADD PRIMARY KEY (`order_line_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- Indexes for table `parent_category`
--
ALTER TABLE `parent_category`
  ADD PRIMARY KEY (`p_cat_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`pro_id`),
  ADD KEY `sub_cat_id` (`sub_cat_id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`sub_cat_id`),
  ADD KEY `p_cat_id` (`p_cat_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`w_id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `pro_id` (`pro_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `delivery_person`
--
ALTER TABLE `delivery_person`
  MODIFY `dp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `e_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_line_item`
--
ALTER TABLE `order_line_item`
  MODIFY `order_line_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parent_category`
--
ALTER TABLE `parent_category`
  MODIFY `p_cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `pro_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `sub_cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `w_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`dp_id`) REFERENCES `delivery_person` (`dp_id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `product` (`pro_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`pro_id`) REFERENCES `product` (`pro_id`);

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`pro_id`) REFERENCES `product` (`pro_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `payment` (`p_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`dp_id`) REFERENCES `delivery_person` (`dp_id`);

--
-- Constraints for table `order_line_item`
--
ALTER TABLE `order_line_item`
  ADD CONSTRAINT `order_line_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_line_item_ibfk_2` FOREIGN KEY (`pro_id`) REFERENCES `product` (`pro_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`sub_cat_id`) REFERENCES `sub_category` (`sub_cat_id`);

--
-- Constraints for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD CONSTRAINT `sub_category_ibfk_1` FOREIGN KEY (`p_cat_id`) REFERENCES `parent_category` (`p_cat_id`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`pro_id`) REFERENCES `product` (`pro_id`);
