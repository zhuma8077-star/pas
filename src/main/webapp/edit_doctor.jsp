<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.util.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Doctor</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: #e8f5e9;
        }
        .form-container {
            background-color: #fff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            border-radius: 10px;
            margin-top: 50px;
        }
        .btn-primary {
            background-color: #28a745;
            border: none;
        }
        .btn-primary:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<%
    String id = request.getParameter("id");
    String name = "", specialization = "", experience = "", qualification = "", contact = "", email = "", address = "", availability = "";

    if (id != null) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM doctors WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                specialization = rs.getString("specialization");
                experience = rs.getString("experience");
                qualification = rs.getString("qualification");
                contact = rs.getString("contact");
                email = rs.getString("email");
                address = rs.getString("address");
                availability = rs.getString("availability");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="form-container">
                <h2 class="text-center">Edit Doctor</h2>
                <form action="DoctorServlet" method="post">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="_method" value="PUT">
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" name="name" class="form-control" value="<%= name %>" required>
                    </div>
                    <div class="form-group">
                        <label>Specialization:</label>
                        <input type="text" name="specialization" class="form-control" value="<%= specialization %>" required>
                    </div>
                    <div class="form-group">
                        <label>Experience:</label>
                        <input type="text" name="experience" class="form-control" value="<%= experience %>" required>
                    </div>
                    <div class="form-group">
                        <label>Qualification:</label>
                        <input type="text" name="qualification" class="form-control" value="<%= qualification %>" required>
                    </div>
                    <div class="form-group">
                        <label>Contact:</label>
                        <input type="text" name="contact" class="form-control" value="<%= contact %>" required>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" class="form-control" value="<%= email %>" required>
                    </div>
                    <div class="form-group">
                        <label>Address:</label>
                        <input type="text" name="address" class="form-control" value="<%= address %>" required>
                    </div>
                    <div class="form-group">
                        <label>Availability:</label>
                        <input type="text" name="availability" class="form-control" value="<%= availability %>" required>
                    </div>
                   <!-- Submit Button -->
                   <button type="submit" class="btn btn-primary btn-block">Update Doctor</button>
                </form>
            </div>
        </div>
    </div>
</div>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
