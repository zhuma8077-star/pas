<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
    String role = (user != null) ? user.getRole() : "";
    String loginError = request.getParameter("loginError"); // ✅ Fix added
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Clinic System</title>

    <!-- ✅ Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 80px auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .form-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #28a745;
        }
        .form-control {
            padding-left: 35px;
        }
        .btn-login {
            background-color: #28a745;
            color: white;
            font-weight: bold;
        }
        .btn-login:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <!-- ✅ Navbar -->
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
                    <% if (user == null) { %>
                        <li class="nav-item"><a class="nav-link active" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link">👋 Welcome, <%= user.getFullname() %></a></li>
                        <% if ("admin".equals(role)) { %>
                            <li class="nav-item"><a class="nav-link" href="admin-dashboard.jsp"><i class="fas fa-user-shield"></i> Admin Dashboard</a></li>
                        <% } else { %>
                            <li class="nav-item"><a class="nav-link" href="user-dashboard.jsp"><i class="fas fa-user"></i> My Dashboard</a></li>
                        <% } %>
                        <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="login-container text-center">
            <h3 class="mb-4">Login</h3>

            <% if ("fail".equals(loginError)) { %>
                <div class="alert alert-danger">❌ Invalid Email or Password</div>
            <% } %>
            <% if ("unauthorized".equals(loginError)) { %>
                <div class="alert alert-warning">⚠ Unauthorized Access! Please log in.</div>
            <% } %>

            <form action="LoginServlet" method="post">
                <div class="form-group position-relative">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                </div>
                <div class="form-group position-relative">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-login btn-block">Login</button>
            </form>

            <p class="mt-3">Don't have an account? <a href="signup.jsp">Sign Up</a></p>
        </div>
    </div>
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
