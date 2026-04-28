<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.util.DBConnection" %>
<%@ page import="com.clinic.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Appointment</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body { background-color: #e8f5e9; }
        .form-container {
            background-color: #fff;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            padding: 30px;
            border-radius: 10px;
            margin-top: 50px;
        }
        .btn-primary { background-color: #28a745; border:none; }
        .btn-primary:hover { background-color: #218838; }
    </style>
</head>
<body>

<!-- ✅ Navbar Added -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-clinic-medical"></i> Clinic System
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Book Appointment</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="user_appointment.jsp"><i class="fas fa-list"></i> My Appointments</a>
                </li>

                <% if (user == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link">👋 <%= user.getFullname() %></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="LogoutServlet">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE appointments SET patient_name=?, patient_contact=?, patient_email=?, appointment_date=?, appointment_time=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, request.getParameter("patient_name"));
            stmt.setString(2, request.getParameter("patient_contact"));
            stmt.setString(3, request.getParameter("patient_email"));
            stmt.setString(4, request.getParameter("appointment_date"));
            stmt.setString(5, request.getParameter("appointment_time"));
            stmt.setInt(6, Integer.parseInt(id));
            stmt.executeUpdate();
            response.sendRedirect("manage-doctor.jsp?msg=Appointment+updated+successfully");
            return;
        } catch(Exception e){
            out.println("<div class='alert alert-danger'>Error updating: " + e.getMessage() + "</div>");
        }
    }

    String patientName="", patientContact="", patientEmail="", appointmentDate="", appointmentTime="";
    if(id != null){
        try(Connection conn = DBConnection.getConnection()){
            String sql = "SELECT * FROM appointments WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                patientName = rs.getString("patient_name");
                patientContact = rs.getString("patient_contact");
                patientEmail = rs.getString("patient_email");
                appointmentDate = rs.getString("appointment_date");
                appointmentTime = rs.getString("appointment_time");
            }
        }catch(Exception e){ out.println("<div class='alert alert-danger'>Error loading: "+e.getMessage()+"</div>"); }
    }
%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="form-container">
                <h2 class="text-center">Edit Appointment</h2>
                <form method="post" action="update-doctor.jsp?id=<%=id%>">
                    <div class="form-group">
                        <label>Patient Name:</label>
                        <input type="text" name="patient_name" class="form-control" value="<%=patientName%>" required>
                    </div>
                    <div class="form-group">
                        <label>Contact:</label>
                        <input type="text" name="patient_contact" class="form-control" value="<%=patientContact%>" required>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="patient_email" class="form-control" value="<%=patientEmail%>" required>
                    </div>
                    <div class="form-group">
                        <label>Appointment Date:</label>
                        <input type="date" name="appointment_date" class="form-control" value="<%=appointmentDate%>" required>
                    </div>
                    <div class="form-group">
                        <label>Appointment Time:</label>
                        <input type="time" name="appointment_time" class="form-control" value="<%=appointmentTime%>" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Update Appointment</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>