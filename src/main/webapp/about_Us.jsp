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

    <!-- ✅ Navbar Start -->
         <nav class="navbar navbar-expand-lg navbar-dark bg-success sticky-top">
              <div class="container">
                  <a class="navbar-brand" href="index.jsp"><i class="fas fa-clinic-medical"></i> Clinic System</a>
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
                              <li class="nav-item"><a class="nav-link">👋 Welcome, <%= user.getFullname() %></a></li>
                              <% if ("admin".equals(role)) { %>
                                  <li class="nav-item"><a class="nav-link" href="admin-dashboard.jsp"><i class="fas fa-user-shield"></i> Admin Dashboard</a></li>
                              <% } else { %>
                                  <li class="nav-item"><a class="nav-link" href="user-dashboard.jsp"><i class="fas fa-user"></i> My Dashboard</a></li>
                              <% } %>
                              <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                          <% } else { %>
                              <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                              <li class="nav-item"><a class="nav-link" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                          <% } %>
                      </ul>
                  </div>
              </div>
          </nav>
          <!-- ✅ Navbar End -->

    <!-- ✅ About Us Section -->
    <header class="jumbotron jumbotron-fluid text-center bg-light">
        <div class="container">
            <h1 class="display-4">About Our Healthcare System</h1>
            <p class="lead">We are dedicated to providing top-notch medical care with compassion and advanced treatments.</p>
        </div>
    </header>

    <section class="container py-5">
        <div class="row">
            <div class="col-md-6">
                <h2>Our Mission</h2>
                <p>Our goal is to deliver exceptional healthcare services to patients with integrity, efficiency, and empathy.</p>
            </div>
            <div class="col-md-6">
                <h2>Our Vision</h2>
                <p>We strive to create a healthier world by making quality healthcare accessible to everyone.</p>
            </div>
        </div>
    </section>

    <!-- ✅ Footer -->
    <footer class="footer text-white py-4 bg-success">
        <div class="container text-center">
            <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
