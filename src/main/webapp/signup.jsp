<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    User user = null;
    String role = "";

    if (session1 != null) {
        user = (User) session1.getAttribute("user");
        if (user != null) {
            role = user.getRole();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Healthcare System - Signup</title>
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
                    <li class="nav-item"><a class="nav-link" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
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
                        <li class="nav-item"><a class="nav-link active" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
    <!-- ✅ Navbar End -->

    <!-- ✅ Signup Form -->
    <div class="container mt-5">
        <h2 class="text-center">Sign Up</h2>

        <!-- Show Success/Failure Message -->
        <%
            String signupMessage = request.getParameter("signup");
            if (signupMessage != null) {
        %>
            <% if (signupMessage.equals("success")) { %>
                <div class="alert alert-success text-center">✅ Signup Successful! Please <a href="login.jsp">Login</a>.</div>
            <% } else if (signupMessage.equals("fail")) { %>
                <div class="alert alert-danger text-center">❌ Signup Failed! Try Again.</div>
            <% } %>
        <% } %>

        <form action="SignupServlet" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" class="form-control" name="fullname" placeholder="Full Name" required>
            </div>
            <div class="form-group">
                <label>Age</label>
                <input type="number" class="form-control" name="age" placeholder="Age" required>
            </div>
            <div class="form-group">
                <label>Address</label>
                <input type="text" class="form-control" name="address" placeholder="Address" required>
            </div>
            <div class="form-group">
                <label>Gender</label>
                <select class="form-control" name="gender" required>
                    <option value="">Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>
            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" class="form-control" name="contact" placeholder="Contact Number" required>
            </div>
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" class="form-control" name="email" placeholder="Email Address" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>

            <!-- ✅ Hidden Role Field (Fixed) -->
            <input type="hidden" name="role" value="user">

            <button type="submit" class="btn btn-success btn-block">Sign Up</button>
        </form>
    </div>

    <!-- ✅ Footer -->
    <footer class="footer text-white py-4 bg-success mt-5">
        <div class="container text-center">
            <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

