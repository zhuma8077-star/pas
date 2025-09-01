<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
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
    <title>Our Doctors - Healthcare System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .doctor-card:hover {
            transform: scale(1.05);
            transition: transform 0.3s ease;
        }
        .btn {
            background: #28a745;
            color: #fff;
        }
        .btn:hover {
            background-color: #218838;
            color: #fff;
            transform: scale(1.1);
            transition: transform 0.3s ease;
        }
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
            object-position: top;
        }
        .doctor-img { display: block; margin: 20px auto; max-width: 200px; border-radius: 8px; }

    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"> <i class="fas fa-clinic-medical"></i> Clinic System</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
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
                        <li class="nav-item"><a class="nav-link" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
 <<%@ page import="java.sql.*" %>
  <%@ page import="java.util.Base64" %>
<!-- Heading Section: Only once at the top -->
<div class="container text-center py-4">
    <h2>Meet Our Expert Doctors</h2>
    <p>Our doctors are highly trained and experienced in their respective fields.</p>
</div>

  <%
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
          Statement stmt = con.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT * FROM doctors");

          int count = 0; // to manage rows
          while (rs.next()) {
              String doctorName = rs.getString("name");
              String specialization = rs.getString("specialization");
              String experience = rs.getString("experience");
              String qualification = rs.getString("qualification");
              String contact = rs.getString("contact");
              String email = rs.getString("email");
              String address = rs.getString("address");
              String availability = rs.getString("availability");
              int doctorId = rs.getInt("id");



              // Open new row if needed
              if (count % 3 == 0) {
  %>
  <div class="row mb-4">
  <%
              }
  %>

      <div class="col-md-4">
          <div class="card doctor-card shadow-sm h-100">
          <img src="DoctorImageServlet?id=<%= rs.getInt("id") %>" alt="Doctor Image" class="doctor-img" />
              <div class="card-body">
                  <h5 class="card-title text-center"><%= doctorName %></h5>
                  <p class="card-text"><strong>Specialization:</strong> <%= specialization %></p>
                  <p class="card-text"><strong>Experience:</strong> <%= experience %></p>
                  <p class="card-text"><strong>Qualification:</strong> <%= qualification %></p>
                  <p class="card-text"><strong>Contact:</strong> <%= contact %></p>
                  <p class="card-text"><strong>Email:</strong> <%= email %></p>
                  <p class="card-text"><strong>Address:</strong> <%= address %></p>
                  <p class="card-text"><strong>Availability:</strong> <%= availability %></p>
                  <div class="text-center mt-2">
                      <a href="appointments.jsp?doctorId=<%= doctorId %>" class="btn btn-success">Book Appointment</a>
                  </div>
              </div>
          </div>
      </div>
  <%
              count++;
              // Close row after 3 columns
              if (count % 3 == 0) {
  %>
  </div>
  <%
              }
          }
          // Close last row if not multiple of 3
          if (count % 3 != 0) {
  %>
  </div>
  <%
          }
          con.close();
      } catch (Exception e) {
          out.println("<p>Error loading doctors: " + e.getMessage() + "</p>");
      }
  %>




    <footer class="footer bg-success text-white py-4 text-center">
        <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
    </footer>
</body>
</html>
