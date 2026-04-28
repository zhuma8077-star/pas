<%@ page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book an Appointment - Healthcare System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .appointment-card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
        }
        .footer {
            background-color: #28a745;
            color: white;
            padding: 20px 0;
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
                    <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                    <li class="nav-item"><a class="nav-link active" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="fas fa-phone-alt"></i> Contact</a></li>
                    <% if (user == null) { %>
                        <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                    <% } else { %>
                        <li class="nav-item"><a class="nav-link">👋 Welcome, <%= user.getFullname() %></a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Warning if not logged in -->
    <% if (user == null) { %>
        <div class="alert alert-danger text-center">⚠ Please <a href="login.jsp">Login</a> or <a href="signup.jsp">Sign Up</a> to Book an Appointment!</div>
    <% } %>

    <!-- ✅ Auto Redirect on Success -->
    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if ("true".equals(success)) {
    %>
        <script>
            window.location.href = "user_appointment.jsp?message=Appointment booked successfully!";
        </script>
    <%
        } else if ("true".equals(error)) {
    %>
        <div class="alert alert-danger text-center">
            Failed to book appointment. Please try again.
        </div>
    <%
        }
    %>

    <!-- Appointment Form Section -->
    <section class="container py-5">
        <h2 class="text-center mb-4">Book an Appointment</h2>
        <p class="text-center mb-4">Select a doctor, choose an appointment date and time, and provide your details to book an appointment.</p>

        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card appointment-card">
                    <div class="card-body">
                        <form action="AppointmentServlet" method="POST">

                            <!-- ✅ UPDATED Doctor Dropdown -->
                            <div class="form-group">
                                <label for="doctorSelect">Choose Doctor</label>
                                <select class="form-control" name="doctor" id="doctorSelect" required>
                                    <option value="">-- Select Doctor --</option>
                                    <%
                                        Connection con2 = null;
                                        PreparedStatement ps2 = null;
                                        ResultSet rs2 = null;

                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");

                                            String query = "SELECT name FROM doctors";
                                            ps2 = con2.prepareStatement(query);
                                            rs2 = ps2.executeQuery();

                                            while (rs2.next()) {
                                    %>
                                                <option value="<%= rs2.getString("name") %>">
                                                    <%= rs2.getString("name") %>
                                                </option>
                                    <%
                                            }
                                        } catch(Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            try { if(rs2!=null) rs2.close(); } catch(Exception e){}
                                            try { if(ps2!=null) ps2.close(); } catch(Exception e){}
                                            try { if(con2!=null) con2.close(); } catch(Exception e){}
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="appointmentDate">Select Appointment Date</label>
                                <input type="date" class="form-control" name="appointmentDate" required>
                            </div>
                            <div class="form-group">
                                <label for="appointmentTime">Select Appointment Time</label>
                                <input type="time" class="form-control" name="appointmentTime" required>
                            </div>
                            <div class="form-group">
                                <label for="patientName">Your Name</label>
                                <input type="text" class="form-control" name="patientName" value="<%= (user != null) ? user.getFullname() : "" %>" <%= (user == null) ? "disabled" : "" %>>
                            </div>
                            <div class="form-group">
                                <label for="patientContact">Contact Number</label>
                                <input type="tel" class="form-control" name="patientContact" required>
                            </div>
                            <div class="form-group">
                                <label for="patientEmail">Your Email</label>
                                <input type="email" class="form-control" name="patientEmail" value="<%= (user != null) ? user.getEmail() : "" %>" <%= (user == null) ? "disabled" : "" %>>
                            </div>
                            <div class="form-group text-center">
                                <button type="submit" class="btn btn-success" <%= (user == null) ? "disabled" : "" %>>Book Appointment</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="footer text-white text-center">
        <div class="container">
            <p>&copy; 2026 Patient Appointment and Sheduling  System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>