<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.io.File, java.io.FileOutputStream, java.io.InputStream, java.sql.*"%>

<%@ page import="jakarta.servlet.http.Part"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Image</title>
</head>
<body>
	<h1 style="color: red" align="center">ADD IMAGE DETAIL</h1>

	<div align="center">
		<form action="fileupload.jsp" method="post"
			enctype="multipart/form-data">
			Select Image: <input type="file" name="image" required> <input
				type="submit" value="Add Image">
		</form>
	</div>

	<% 
    // Handle the form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Part file = request.getPart("image");  // Get the uploaded file
        String imageFileName = file.getSubmittedFileName();  // Get file name
        String uploadPath = application.getRealPath("/") + "img/product_img/";

        // Ensure the directory exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            // Save the uploaded image to the server
            FileOutputStream fos = new FileOutputStream(new File(uploadPath, imageFileName));
            InputStream is = file.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();

            // Insert the image filename into the database
            String dbURL = "jdbc:mysql://localhost:3306/shop_zone";
            String dbUsername = "root";
            String dbPassword = "Jinal@123";
            Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            String query = "INSERT INTO image(imageFileName) VALUES(?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, imageFileName);
            int row = stmt.executeUpdate();

            if (row > 0) {
                out.println("<p>Image uploaded and added to the database successfully!</p>");
            } else {
                out.println("<p>Failed to upload image.</p>");
            }

            // Close the database connection
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error occurred while uploading the image: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
