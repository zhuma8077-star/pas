<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Patient Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
       body {
                font-family: Arial, sans-serif;
                background-color: #e8f5e9; /* Light Green */
                text-align: center;
            }
        .profile-card {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
        .profile-card h3, .profile-card h5 {
            margin-bottom: 20px;
        }
        .profile-card p {
            font-size: 16px;
            margin: 8px 0;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <h2 class="text-center">Patient Profile</h2>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card profile-card">
                <div class="card-body text-center">
                    <%
                        String appointmentIdParam = request.getParameter("id");
                        if (appointmentIdParam == null || appointmentIdParam.isEmpty()) {
                            out.println("<p class='text-danger'>Error: Appointment ID is missing.</p>");
                            return;
                        }

                        int appointmentId = Integer.parseInt(appointmentIdParam);
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM appointments WHERE id = ?");
                            ps.setInt(1, appointmentId);
                            ResultSet rs = ps.executeQuery();

                            if (rs.next()) {
                    %>
                    <!-- Patient Name Heading -->
                    <h3><strong>Patient Name:</strong> <%= rs.getString("patient_name") %></h3>

                    <!-- Appointment Info -->
                    <p><strong>Doctor:</strong> <%= rs.getString("doctor") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("appointment_date") %></p>
                    <p><strong>Time:</strong> <%= rs.getTime("appointment_time") %></p>
                    <p><strong>Contact:</strong> <%= rs.getString("patient_contact") %></p>

                    <!-- Patient Email Heading -->
                    <h5 class="mt-4"><strong>Patient Email:</strong> <a href="mailto:<%= rs.getString("patient_email") %>"><%= rs.getString("patient_email") %></a></h5>

                    <!-- Back Button -->
                    <a href="appointment_dashboard.jsp" class="btn btn-success mt-4">
                        <i class="fas fa-arrow-left"></i> Back to Appointments
                    </a>

                    <%
                            } else {
                                out.println("<p class='text-danger'>No appointment found with ID: " + appointmentId + "</p>");
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
