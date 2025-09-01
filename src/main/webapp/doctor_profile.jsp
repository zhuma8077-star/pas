<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String name = "", specialization = "", experience = "", qualification = "",
           contact = "", email = "", address = "", availability = "";

    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
            PreparedStatement ps = con.prepareStatement(
                "SELECT name, specialization, experience, qualification, contact, email, address, availability " +
                "FROM doctors WHERE id = ?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

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
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Profile</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f1f8e9; margin: 0; }
        .navbar { background: #2e7d32; color: white; padding: 15px; }
        .container { max-width: 700px; margin: 40px auto; background: white; padding: 25px;
                     border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #2e7d32; }
        .profile-info { margin: 10px 0; padding: 8px; border-bottom: 1px solid #ddd; }
        .profile-info:last-child { border-bottom: none; }
        .label { font-weight: bold; color: #333; }
        .doctor-img { display: block; margin: 20px auto; max-width: 200px; border-radius: 8px; }
        .back-btn { display: block; text-align: center; background: #2e7d32; color: white;
                    padding: 10px; border-radius: 5px; margin-top: 20px; text-decoration: none; }
        .back-btn:hover { background: #1b5e20; }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Doctor Profile</h1>
    </div>
    <div class="container">
        <h2>Doctor Details</h2>
        <img src="DoctorImageServlet?id=<%= id %>" alt="Doctor Image" class="doctor-img" />
        <div class="profile-info"><span class="label">Name:</span> <%= name %></div>
        <div class="profile-info"><span class="label">Specialization:</span> <%= specialization %></div>
        <div class="profile-info"><span class="label">Experience:</span> <%= experience %></div>
        <div class="profile-info"><span class="label">Qualification:</span> <%= qualification %></div>
        <div class="profile-info"><span class="label">Contact:</span> <%= contact %></div>
        <div class="profile-info"><span class="label">Email:</span> <%= email %></div>
        <div class="profile-info"><span class="label">Address:</span> <%= address %></div>
        <div class="profile-info"><span class="label">Availability:</span> <%= availability %></div>
        <a href="doctors_dashboard.jsp" class="back-btn">Back to Doctors</a>
    </div>
</body>
</html>
