<%@ page
	import="java.io.*, java.util.*, org.apache.commons.fileupload2.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*"%>

<%
    String destination = "/files"; // Directory to save the uploaded file
    String destinationRealPath = application.getRealPath(destination);
	
    // Create a factory for disk-based file items
    DiskFileItemFactory factory = new DiskFileItemFactory();
    factory.setSizeThreshold(1024); // Set factory constraints
    factory.setRepository(new File(destinationRealPath)); // Set the directory to store files

    // Create a new file upload handler
    ServletFileUpload upload = new ServletFileUpload(factory);

    try {
        // Parse the request
        List<FileItem> items = upload.parseRequest(request);
        Iterator<FileItem> iterator = items.iterator();

        while (iterator.hasNext()) {
            FileItem item = (FileItem) iterator.next();

            // Check if the item is a form field or a file
            if (!item.isFormField()) {
                File file = new File(destinationRealPath, item.getName());
                item.write(file); // Write the file to the specified directory
                out.write("<p>" + file.getName() + " was uploaded successfully!</p>");
            }
        }
    } catch (FileUploadException e) {
        out.write("<p>FileUploadException was thrown: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.write("<p>An error occurred: " + e.getMessage() + "</p>");
    }
%>
