<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.util.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");

    // Form submitted -> update
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

    // Load appointment data
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
