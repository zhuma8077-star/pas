<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
   HttpSession session1 = request.getSession(false);
       User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
       String role = (user != null) ? user.getRole() : ""; // ✅ This line fixes the issue
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Healthcare System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .contact-section {
            padding: 50px 0;
        }
        .contact-section h2 {
            font-size: 36px;
            margin-bottom: 30px;
        }
        .contact-info i {
            font-size: 30px;
            color: #28a745;
        }
        .contact-info p {
            font-size: 18px;
            margin-left: 10px;
        }
        .footer {
            background-color: #28a745;
            color: white;
            padding: 20px 0;
        }
    </style>
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
                       <li class="nav-item"><a class="nav-link active" href="contact.jsp"><i class="fas fa-phone-alt"></i> Contact</a></li>

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

    <!-- ✅ Contact Section -->
    <section class="contact-section bg-light">
        <div class="container">
            <h2 class="text-center">Contact Us</h2>
            <p class="text-center">Have questions? Feel free to reach out!</p>

            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success">Your message has been sent successfully!</div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">Something went wrong. Please try again!</div>
            <% } %>

            <div class="row">
                <!-- Contact Form -->
                <div class="col-md-6">
                    <h4>Send Us a Message</h4>
                    <form action="ContactServlet" method="POST">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" class="form-control" name="name" placeholder="Enter your full name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Your Message</label>
                            <textarea class="form-control" name="message" rows="5" placeholder="Write your message here..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-success">Send Message</button>
                    </form>
                </div>

                <!-- Contact Information -->
                <div class="col-md-6 contact-info">
                    <h4>Our Contact Information</h4>
                    <p><i class="fas fa-map-marker-alt"></i> 123 Healthcare Street, Kharian, Pakistan</p>
                    <p><i class="fas fa-phone-alt"></i> +92 301 2345678</p>
                    <p><i class="fas fa-envelope"></i> contact@clinic.pk</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ✅ Footer -->
    <footer class="footer text-white text-center">
        <div class="container">
            <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>