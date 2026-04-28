<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.model.User" %>
<html>
<head>
 <title>Manage Appointments</title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
 <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
 <style>
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid black; padding: 10px; text-align: left; }
    th { background-color:#28a745; color: white; }
    h2 { margin-top: 20px; }

    /* ✅ Compact Doctor Info */
    .doctor-info {
        background: white;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0px 4px 6px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    .doctor-info h5 {
        color: #28a745;
        margin-bottom: 10px;
    }
    .doctor-info .row div {
        margin-bottom: 5px;
    }
 </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-success sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-clinic-medical"></i> Clinic System</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="fas fa-phone-alt"></i> Contact</a></li>
                     <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
<%
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User doctor = (User) userObj;
    if (!"doctor".equalsIgnoreCase(doctor.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // fetch doctor details from DB
    int doctorId = 0;
    String doctorName = "";
    String doctorEmail = "";
    String doctorContact = "";
    String doctorGender = "";
    String doctorAddress = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=?");
        ps.setString(1, doctor.getEmail());
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            doctorId = rs.getInt("id");
            doctorName = rs.getString("fullname");
            doctorEmail = rs.getString("email");
            doctorContact = rs.getString("contact");
            doctorGender = rs.getString("gender");
            doctorAddress = rs.getString("address");
        }
        con.close();
    } catch(Exception e){ out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>"); }
%>
<div class="container mt-4">
<h2 class="text-center text-success mb-4">
        <i class="fas fa-calendar-check"></i> Doctor Appointment Details
    </h2>
    <!-- ✅ Doctor Info Section -->
    <div class="doctor-info">
        <h5>Welcome,<%= doctorName %>!</h5>
        <div class="row">
            <div class="col-md-4"><strong>Doctor ID:</strong> <%= doctorId %></div>
            <div class="col-md-4"><strong>Email:</strong> <%= doctorEmail %></div>
            <div class="col-md-4"><strong>Contact:</strong> <%= doctorContact %></div>
        </div>
        <div class="row mt-1">
            <div class="col-md-4"><strong>Address:</strong> <%= doctorAddress %></div>
            <div class="col-md-4"><strong>Gender:</strong> <%= doctorGender %></div>
            <div class="col-md-4"><strong>Role:</strong> <%= doctor.getRole() %></div>
        </div>
    </div>

    <h2>Appointments for <%= doctorName %></h2>

    <div id="msgContainer"></div>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Patient Name</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Date</th>
                <th>Time</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="appointmentsTableBody">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");

                String sql = "SELECT * FROM appointments WHERE doctor=? ORDER BY appointment_date ASC, appointment_time ASC";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, doctorName);
                ResultSet rs = pst.executeQuery();

                boolean hasData = false;
                while(rs.next()) {
                    hasData = true;
        %>
            <tr id="row-<%= rs.getInt("id") %>">
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("patient_name") %></td>
                <td><%= rs.getString("patient_contact") %></td>
                <td><%= rs.getString("patient_email") %></td>
                <td><%= rs.getDate("appointment_date") %></td>
                <td><%= rs.getTime("appointment_time") %></td>
                <td>
                    <a href="update-doctor.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Update</a>
                    <button class="btn btn-danger btn-sm" onclick="deleteAppointment('<%= rs.getInt("id") %>')">Delete</button>
                </td>
            </tr>
        <%
                }

                if(!hasData){
        %>
            <tr>
                <td colspan="7" class="text-center">No appointments found</td>
            </tr>
        <%
                }

                rs.close();
                pst.close();
                con.close();
            } catch(Exception e) {
        %>
            <tr>
                <td colspan="7" class="text-center text-danger">Error: <%= e.getMessage() %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<script>
function deleteAppointment(id){
    if(confirm("Are you sure you want to delete this appointment? This action cannot be undone.")){
        $.ajax({
            url: 'AppointmentServlet',
            type: 'POST',
            data: {
                _method: 'DELETE',
                appointmentId: id
            },
            success: function(){
                $('#row-' + id).remove();
                $('#msgContainer').html('<div class="alert alert-success mt-2">Appointment deleted successfully!</div>');
            },
            error: function(){
                $('#msgContainer').html('<div class="alert alert-danger mt-2">Failed to delete appointment.</div>');
            }
        });
    }
}
</script>
<footer class="footer text-white py-4 bg-success">
        <div class="container text-center">
            <p>&copy; 2026 Patient Appointment and Sheduling System. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
