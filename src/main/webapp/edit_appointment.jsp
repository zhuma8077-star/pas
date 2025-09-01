<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String id = request.getParameter("id");

    String doctor = "";
    String appointmentDate = "";
    String appointmentTime = "";
    String patientName = "";
    String patientContact = "";
    String patientEmail = "";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    // If form submitted
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("update") != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/PAS", "root", "root");

            String updateSql = "UPDATE appointments SET doctor=?, appointment_date=?, appointment_time=?, patient_name=?, patient_contact=?, patient_email=? WHERE id=?";
            pst = conn.prepareStatement(updateSql);

            pst.setString(1, request.getParameter("doctor"));
            pst.setString(2, request.getParameter("appointmentDate"));
            pst.setString(3, request.getParameter("appointmentTime"));
            pst.setString(4, request.getParameter("patientName"));
            pst.setString(5, request.getParameter("patientContact"));
            pst.setString(6, request.getParameter("patientEmail"));
            pst.setString(7, id);

            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("appointment_dashboard.jsp");
                return;
            } else {
                out.println("<p style='color:red;'>Update failed.</p>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }
    }

    // On page load: get data
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/PAS", "root", "root");

        String sql = "SELECT * FROM appointments WHERE id=?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, id);
        rs = pst.executeQuery();

        if (rs.next()) {
            doctor = rs.getString("doctor");
            appointmentDate = rs.getString("appointment_date");
            appointmentTime = rs.getString("appointment_time");
            patientName = rs.getString("patient_name");
            patientContact = rs.getString("patient_contact");
            patientEmail = rs.getString("patient_email");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Appointment</title>
   <style>
       body {
           background-color: #f0f8ff;
           font-family: Arial;
           text-align: center;
       }
       form {
           background-color: #ffffff;
           max-width: 500px;
           margin: auto;
           padding: 20px;
           border-radius: 8px;
           box-shadow: 0 0 10px #ccc;
       }
       input {
           width: 100%;
           margin: 10px 0;
           padding: 8px;
       }
       button {
           padding: 10px;
           background-color: #4CAF50; /* Green */
           color: white;
           border: none;
           width: 100%;
           border-radius: 5px;
           font-size: 16px;
       }
       button:hover {
           background-color: #388E3C; /* Darker green on hover */
       }
   </style>
</head>
<body>

<h2>Edit Appointment</h2>

<form method="post">
    <input type="hidden" name="id" value="<%= id %>">

    <label>Doctor:</label>
    <input type="text" name="doctor" value="<%= doctor %>" required>

    <label>Appointment Date:</label>
    <input type="date" name="appointmentDate" value="<%= appointmentDate %>" required>

    <label>Appointment Time:</label>
    <input type="time" name="appointmentTime" value="<%= appointmentTime %>" required>

    <label>Patient Name:</label>
    <input type="text" name="patientName" value="<%= patientName %>" required>

    <label>Patient Contact:</label>
    <input type="text" name="patientContact" value="<%= patientContact %>" required>

    <label>Patient Email:</label>
    <input type="email" name="patientEmail" value="<%= patientEmail %>" required>

    <button type="submit" name="update">Update Appointment</button>
</form>

</body>
</html>
