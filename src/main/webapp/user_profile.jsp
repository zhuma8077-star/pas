<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String fullname = "", age = "", address = "", gender = "", contact = "", email = "", role = "";

    if (id != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
            PreparedStatement ps = con.prepareStatement("SELECT fullname, age, address, gender, contact, email, role FROM users WHERE id = ?");
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fullname = rs.getString("fullname");
                age = rs.getString("age");
                address = rs.getString("address");
                gender = rs.getString("gender");
                contact = rs.getString("contact");
                email = rs.getString("email");
                role = rs.getString("role");
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #eafaf1;
        }
        .navbar {
            background-color: #2e7d32;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h1 { margin: 0; font-size: 20px; }
        .container {
            max-width: 500px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.1);
        }
        h2 { text-align: center; color: #2e7d32; }
        .profile-info { margin: 12px 0; padding: 10px; border-bottom: 1px solid #ccc; }
        .profile-info:last-child { border-bottom: none; }
        .label { font-weight: bold; color: #333; }
        .back-btn {
            display: block;
            width: 100%;
            margin-top: 20px;
            padding: 10px;
            background-color: #2e7d32;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }
        .back-btn:hover { background-color: #1b5e20; }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>User Profile</h1>
        <a href="manage-users.jsp" style="color: white; text-decoration: underline;">Back to Users</a>
    </div>
    <div class="container">
        <h2>User Details</h2>
        <div class="profile-info"><span class="label">Full Name:</span> <%= fullname %></div>
        <div class="profile-info"><span class="label">Age:</span> <%= age %></div>
        <div class="profile-info"><span class="label">Address:</span> <%= address %></div>
        <div class="profile-info"><span class="label">Gender:</span> <%= gender %></div>
        <div class="profile-info"><span class="label">Contact:</span> <%= contact %></div>
        <div class="profile-info"><span class="label">Email:</span> <%= email %></div>
        <div class="profile-info"><span class="label">Role:</span> <%= role %></div>
        <div class="profile-info"><span class="label">Password:</span> ********</div>
        <a href="edit_user.jsp?id=<%= id %>" class="back-btn">Edit User</a>
        <a href="manage-users.jsp" class="back-btn">Back to Manage Users</a>
    </div>
    <footer class="footer text-white py-4 bg-success">
        <div class="container text-center">
            <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
