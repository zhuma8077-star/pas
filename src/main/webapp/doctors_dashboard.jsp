<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // ================= DELETE DOCTOR =================
    String deleteId = request.getParameter("deleteId");

    if (deleteId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pas", "root", "root"
            );

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM doctors WHERE id=?"
            );
            ps.setInt(1, Integer.parseInt(deleteId));
            ps.executeUpdate();

            con.close();

            response.sendRedirect(request.getRequestURI() + "?msg=deleted");
            return;

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<html>
<head>
    <title>Doctor Dashboard</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        .table { width: 100%; table-layout: auto; margin: 0; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        th { background-color: #28a745; color: white; }

        .btn { padding: 5px 10px; margin: 2px; color: white; border-radius: 5px; }

        .doctor-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
        }
    </style>
</head>

<body>

<!-- ================= NAVBAR ================= -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success sticky-top">
    <div class="container">

        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-clinic-medical"></i> Clinic System
        </a>

        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">

                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="doctors.jsp">Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="appointments.jsp">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>

            </ul>
        </div>

    </div>
</nav>

<!-- ================= SUCCESS MESSAGE ================= -->
<div class="container mt-3">
<%
    String msg = request.getParameter("msg");
    if ("deleted".equals(msg)) {
%>
    <div class="alert alert-success">
        Doctor deleted successfully!
    </div>
<%
    }
%>
</div>

<!-- ================= HEADER ================= -->
<div class="container-fluid mt-3">

    <div class="d-flex justify-content-between align-items-center mb-3">

        <!-- LEFT: Heading + Add Button -->
        <div class="d-flex align-items-center">
            <h2 class="mb-0 mr-3">Doctor Dashboard</h2>

            <!-- ✅ ADD NEW DOCTOR BUTTON -->
            <a href="add_doctor.jsp" class="btn btn-success">
                <i class="fas fa-user-plus"></i> Add New Doctor
            </a>
        </div>

        <!-- RIGHT: Back Button -->
        <div>
            <a href="admin-dashboard.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>

    </div>

</div>

<!-- ================= TABLE ================= -->
<div class="container-fluid">

<table class="table">
    <thead>
    <tr>
        <th>ID</th>
        <th>Pic</th>
        <th>Name</th>
        <th>Specialization</th>
        <th>Experience</th>
        <th>Qualification</th>
        <th>Contact</th>
        <th>Email</th>
        <th>Address</th>
        <th>Availability</th>
        <th>Actions</th>
    </tr>
    </thead>

    <tbody>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pas", "root", "root"
            );

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM doctors");

            while (rs.next()) {
    %>

    <tr>
        <td><%= rs.getInt("id") %></td>

        <td>
            <img src="DoctorImageServlet?id=<%= rs.getInt("id") %>" class="doctor-img">
        </td>

        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("specialization") %></td>
        <td><%= rs.getString("experience") %></td>
        <td><%= rs.getString("qualification") %></td>
        <td><%= rs.getString("contact") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("address") %></td>
        <td><%= rs.getString("availability") %></td>

        <td>
            <a href="doctor_profile.jsp?id=<%= rs.getInt("id") %>" class="btn btn-info">View</a>
            <a href="edit_doctor.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning">Edit</a>

            <button class="btn btn-danger"
                    data-toggle="modal"
                    data-target="#deleteModal"
                    onclick="setDoctorId('<%= rs.getInt("id") %>')">
                Delete
            </button>
        </td>
    </tr>

    <%
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>

    </tbody>
</table>

</div>

<!-- ================= DELETE MODAL ================= -->
<div class="modal fade" id="deleteModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-danger text-white">
                <h5>Delete Doctor</h5>
                <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">
                Do you want to delete this doctor?
            </div>

            <div class="modal-footer">

                <form method="post" action="<%= request.getRequestURI() %>">
                    <input type="hidden" name="deleteId" id="deleteDoctorId">

                    <button type="submit" class="btn btn-danger">Yes Delete</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </form>

            </div>

        </div>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<footer class="footer text-white py-4 bg-success">
    <div class="container text-center">
        <p>&copy; 2026 Patient Appointment and Scheduling System</p>
    </div>
</footer>

<script>
    function setDoctorId(id) {
        document.getElementById("deleteDoctorId").value = id;
    }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>