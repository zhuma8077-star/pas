<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Healthcare System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .navbar { background-color: #28a745 !important; }
        .footer { background-color: #28a745; color: white; }
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .card:hover { transform: translateY(-5px); }
        .btn-appointments {
            background-color: #28a745;
            color: white;
            border-radius: 5px;
        }
        .btn-appointments:hover { background-color: #218838; color: white; }
        .card-title { color: #28a745; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-clinic-medical"></i> Clinic System</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <% if (user != null) { %>
                    <li class="nav-item"><a class="nav-link">👋 Welcome, <%= user.getFullname() %></a></li>
                    <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="jumbotron jumbotron-fluid text-center bg-light">
    <div class="container">
        <h1 class="display-4">User Dashboard</h1>
        <p class="lead">Hello, <%= user.getFullname() %>! Manage your appointments easily.</p>
    </div>
</header>

<!-- Dashboard Content -->
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card text-center p-4 mb-4">
                <h5 class="card-title"><i class="fas fa-calendar-check"></i> My Appointments</h5>
                <p class="card-text">View and manage your upcoming and past appointments.</p>
                <a href="user_appointment.jsp" class="btn btn-appointments">View Appointments</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer text-white py-4 text-center">
    <div class="container">
        <p>&copy; 2026 Patient Appointment and Sheduling System. All Rights Reserved.</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
