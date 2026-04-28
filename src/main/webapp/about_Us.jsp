<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
    String role = (user != null) ? user.getRole() : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Healthcare System</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-clinic-medical"></i> Clinic System
        </a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">

                <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                <li class="nav-item"><a class="nav-link active" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="fas fa-phone-alt"></i> Contact</a></li>

                <% if (user != null) { %>
                    <li class="nav-item">
                        <a class="nav-link">👋 Welcome, <%= user.getFullname() %></a>
                    </li>

                    <% if ("admin".equals(role)) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-dashboard.jsp">
                                <i class="fas fa-user-shield"></i> Admin Dashboard
                            </a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="user-dashboard.jsp">
                                <i class="fas fa-user"></i> My Dashboard
                            </a>
                        </li>
                    <% } %>

                    <li class="nav-item">
                        <a class="nav-link text-danger" href="LogoutServlet">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                <% } %>

            </ul>
        </div>
    </div>
</nav>

<!-- HERO SECTION (UPDATED STYLE) -->
<header class="jumbotron jumbotron-fluid text-center bg-light mb-0">
    <div class="container">

        <h2 class="font-weight-bold text-success mb-3" style="font-size: 28px;">
            About Our Patient Appointment & Scheduling System
        </h2>

    </div>
</header>

<!-- INTRO PARAGRAPH CARD -->
<div class="container my-4 text-center">
    <div class="p-4 bg-white shadow-sm rounded">
        <p class="text-muted mb-0" style="font-size: 15px; line-height: 1.8;">
            We provide the best platform that helps patients easily book appointments.
            This system allows users to view doctor details, check appointments, and book appointments after registration and login.
            It is designed to provide a simple, efficient, and user-friendly experience for all users.
        </p>
    </div>
</div>

<!-- MISSION & VISION SECTION -->
<div class="container my-5">

    <div class="text-center mb-5">
        <h3 class="font-weight-bold text-success" style="font-size: 24px;">
            About Our System
        </h3>
        <p class="text-muted" style="font-size: 14px;">
            Learn more about our mission and vision
        </p>
    </div>

    <div class="row">

        <div class="col-md-6 mb-4">
            <div class="card shadow p-4 h-100">
                <h4 class="text-success mb-3">Our Mission</h4>
                <p style="font-size: 15px; line-height: 1.8;">
                    Our goal is to provide a simple and efficient platform for patients to book appointments easily.
                    Users can sign up, login, and access doctor schedules without any difficulty.
                    We aim to improve healthcare accessibility through digital solutions.
                </p>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="card shadow p-4 h-100">
                <h4 class="text-success mb-3">Our Vision</h4>
                <p style="font-size: 15px; line-height: 1.8;">
                    We aim to create a modern healthcare system where patients can easily connect with doctors.
                    Our vision is to make appointment booking fast, secure, and user-friendly for everyone.
                </p>
            </div>
        </div>

    </div>

</div>

<!-- FOOTER -->
<footer class="footer text-white py-4 bg-success">
    <div class="container text-center">
        <p>&copy; 2026 Patient Appointment and Sheduling System. All Rights Reserved.</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>