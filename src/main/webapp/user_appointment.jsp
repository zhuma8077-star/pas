<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.model.User" %>
<%
    User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;
    if(sessionUser == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String message = request.getParameter("message");

    String userName = "";
    int userId = 0;
    String userEmail = "";
    String userContact = "";
    int userAge = 0;
    String userAddress = "";
    String userGender = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");

        PreparedStatement psUser = con.prepareStatement("SELECT * FROM users WHERE email=?");
        psUser.setString(1, sessionUser.getEmail());
        ResultSet rsUser = psUser.executeQuery();
        if(rsUser.next()) {
            userId = rsUser.getInt("id");
            userName = rsUser.getString("fullname");
            userEmail = rsUser.getString("email");
            userContact = rsUser.getString("contact");
            userAge = rsUser.getInt("age");
            userAddress = rsUser.getString("address");
            userGender = rsUser.getString("gender");
        }

        con.close();
    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Error fetching user info: " + e.getMessage() + "</div>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Appointments</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 40px; }
        h2 { margin-bottom: 20px; color: #28a745; }
        .btn-cancel { background-color: #dc3545; color: white; }
        .btn-update { background-color: #28a745; color: white; }
        .btn-cancel:hover { background-color: #c82333; }
        .btn-update:hover { background-color: #218838; }
        table { background: white; box-shadow: 0px 4px 6px rgba(0,0,0,0.1); border-radius: 10px; }
        table th { background-color: #28a745; color: white; }
        footer { margin-top: 40px; padding: 15px; background: #28a745; color: white; text-align: center; }

        /* ✅ Compact User Info */
        .user-info {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .user-info h5 {
            color: #28a745;
            margin-bottom: 10px;
        }
        .user-info .row div {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-clinic-medical"></i> Clinic System</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="doctors.jsp">Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="appointments.jsp">Book Appointment</a></li>
                <li class="nav-item"><a class="nav-link active" href="user_appointment.jsp">My Appointments</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <!-- ✅ Page Heading -->
    <div class="text-center mb-4">
        <h1 class="display-5 text-success">
            <i class="fas fa-calendar-check"></i> Patient Appointment Details
        </h1>
        <hr>
    </div>
<div class="container">
    <!-- ✅ Compact User Info Display -->
    <div class="user-info">
        <h5>Welcome, <%= userName %>!</h5>
        <div class="row">
            <div class="col-md-4"><strong>User ID:</strong> <%= userId %></div>
            <div class="col-md-4"><strong>Email:</strong> <%= userEmail %></div>
            <div class="col-md-4"><strong>Contact:</strong> <%= userContact %></div>
        </div>
        <div class="row mt-1">
            <div class="col-md-4"><strong>Age:</strong> <%= userAge %></div>
            <div class="col-md-4"><strong>Address:</strong> <%= userAddress %></div>
            <div class="col-md-4"><strong>Gender:</strong> <%= userGender %></div>
        </div>
    </div>

    <h2>My Appointments</h2>
    <% if (message != null) { %>
        <div class="alert alert-success"><%= message %></div>
    <% } %>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Doctor</th>
                <th>Date</th>
                <th>Time</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM appointments WHERE patient_email=?");
                ps.setString(1, sessionUser.getEmail());
                ResultSet rs = ps.executeQuery();
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("doctor") %></td>
                <td><%= rs.getDate("appointment_date") %></td>
                <td><%= rs.getString("appointment_time") %></td>
                <td><%= rs.getString("patient_contact") %></td>
                <td><%= rs.getString("patient_email") %></td>
                <td>
                    <a href="update_appointment.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-update">Update</a>
                    <a href="cancel_appointment.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-cancel" onclick="return confirm('Cancel this appointment?');">Cancel</a>
                </td>
            </tr>
        <%
                }
                if (!hasData) {
                    out.println("<tr><td colspan='7' class='text-center text-muted'>No Appointments Found</td></tr>");
                }
                con.close();
            } catch(Exception e) {
                out.println("<tr><td colspan='7' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>

<footer>
    <p>&copy; 2026 Patient Appointment and Sheduling System | All Rights Reserved</p>
</footer>

</body>
</html>
