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
    <title>Healthcare System</title>

    <!-- Bootstrap & Icons -->
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

                <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
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

<!-- HERO SECTION -->
<header class="jumbotron jumbotron-fluid text-center bg-light mb-0">
    <div class="container">

        <h2 class="font-weight-bold text-success mb-3" style="font-size: 28px;">
            Welcome to Patient Appointment and Scheduling System
        </h2>

        <% if (user != null) { %>
            <p class="lead text-muted">
                Hello, <%= user.getFullname() %>! Book your next appointment now.
            </p>
        <% } %>

    </div>
</header>

<!-- PARAGRAPH SECTION (NEW DESIGN) -->
<div class="container my-4 text-center">

    <div class="p-4 bg-white shadow-sm rounded">

        <p class="text-muted mb-0" style="font-size: 15px; line-height: 1.8;">
            We provide you the best platform to book online appointments easily from this system.
            This patient appointment and scheduling system contains three modules: appointments, doctors, and patients.
            The admin can manage all modules and make changes when needed.
            The login system helps admins access the admin panel, doctors to view appointments, and patients to book appointments.
            Patients can easily book appointments after sign up and login and view available doctors.
        </p>

    </div>
</div>

<!-- SERVICES SECTION -->
<div class="container my-5">

    <div class="text-center mb-5">
        <h3 class="font-weight-bold text-success" style="font-size: 24px;">
            Our Services & Features
        </h3>
        <p class="text-muted" style="font-size: 14px;">
            Manage our system easily and efficiently
        </p>
    </div>

    <div class="row text-center">

        <div class="col-md-4 mb-4">
            <div class="card shadow p-4">
                <i class="fas fa-calendar-check fa-2x text-success mb-3"></i>
                <h5>Book Appointment</h5>
                <p>Schedule appointments quickly without waiting.</p>
                <a href="appointments.jsp" class="btn btn-success btn-sm">Book Now</a>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow p-4">
                <i class="fas fa-user-md fa-2x text-success mb-3"></i>
                <h5>Find Doctors</h5>
                <p>View doctor profiles and choose the best one.</p>
                <a href="doctors.jsp" class="btn btn-success btn-sm">View Doctors</a>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card shadow p-4">
                <i class="fas fa-headset fa-2x text-success mb-3"></i>
                <h5>Support</h5>
                <p>Contact us anytime for help and assistance.</p>
                <a href="contact.jsp" class="btn btn-success btn-sm">Contact</a>
            </div>
        </div>

    </div>

    <div class="row text-center mt-5">
        <div class="col-md-4">
            <h5 class="text-success">Fast</h5>
            <p style="font-size: 14px;">Quick booking system with no delays.</p>
        </div>

        <div class="col-md-4">
            <h5 class="text-success">Secure</h5>
            <p style="font-size: 14px;">Your data is protected and safe.</p>
        </div>

        <div class="col-md-4">
            <h5 class="text-success">Easy</h5>
            <p style="font-size: 14px;">Simple interface for all users.</p>
        </div>
    </div>

    <div class="row text-center mt-5">
        <div class="col-md-4">
            <h3 class="text-success">5+</h3>
            <p>Doctors</p>
        </div>

        <div class="col-md-4">
            <h3 class="text-success">15+</h3>
            <p>Patients</p>
        </div>

        <div class="col-md-4">
            <h3 class="text-success">10+</h3>
            <p>Appointments</p>
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