<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;

    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp?login=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Clinic System</title>

    <!-- ✅ Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; }
    </style>
</head>
<body>

    <!-- ✅ Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-clinic-medical"></i> Admin Panel</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link text-light">Welcome, <%= user.getFullname() %> (Admin)</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container text-center">
        <h1>Admin Dashboard</h1>
        <p>Manage appointments, doctors, and system settings.</p>

        <div class="row">
            <div class="col-md-4">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <h5 class="card-title">Appointments</h5>
                        <a href="appointment_dashboard.jsp" class="btn btn-light">Manage</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <h5 class="card-title">Doctors</h5>
                        <a href="doctors_dashboard.jsp" class="btn btn-light">Manage</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <h5 class="card-title">Users</h5>
                        <a href="manage-users.jsp" class="btn btn-light">Manage</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ✅ Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
