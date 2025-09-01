<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Appointment Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #28a745; color: white; }
        .btn { padding: 5px 10px; margin: 2px; text-decoration: none; color: white; border-radius: 5px; display: inline-block; }
        .edit { background-color: #007bff; }
        .view { background-color: #28a745; }
        .delete { background-color: #dc3545; }
        .add-appointment { background-color: #17a2b8; padding: 10px; margin: 10px 0; display: inline-block; color: white; text-decoration: none; border-radius: 5px; }
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
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Appointment Dashboard</h2>
        <a href="appointments.jsp" class="btn btn-success">
            <i class="fas fa-calendar-plus"></i> Add New Appointment
        </a>

        <!-- Back Button (Fixed to go to admin-dashboard.jsp) -->
        <a href="admin-dashboard.jsp" class="btn btn-secondary float-right">
            <i class="fas fa-arrow-left"></i> Back
        </a>

        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Doctor</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Patient Name</th>
                    <th>Contact</th>
                    <th>Email</th>
                    <th>Actions <br> <small>(View | Edit | Delete)</small></th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM appointments");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("doctor") %></td>
                    <td><%= rs.getDate("appointment_date") %></td>
                    <td><%= rs.getTime("appointment_time") %></td>
                    <td><%= rs.getString("patient_name") %></td>
                    <td><%= rs.getString("patient_contact") %></td>
                    <td><%= rs.getString("patient_email") %></td>
                    <td>
                        <div class="d-flex justify-content-center">
                            <a href="appointment_profile.jsp?id=<%= rs.getInt("id") %>" class="btn btn-info mx-1">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="edit_appointment.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning mx-1">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <button class="btn btn-danger mx-1" data-toggle="modal" data-target="#deleteModal"
                                onclick="setAppointmentId('<%= rs.getInt("id") %>', this)">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </div>
                    </td>
                </tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

   <!-- Delete Confirmation Modal -->
   <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-header bg-danger text-white">
           <h5 class="modal-title" id="deleteModalLabel">
             <i class="fas fa-exclamation-triangle"></i> Confirm Deletion
           </h5>
           <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
           Are you sure you want to delete this appointment? This action cannot be undone.
         </div>
         <div class="modal-footer">
           <input type="hidden" id="deleteAppointmentId">
           <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
           <button type="button" class="btn btn-danger" onclick="deleteAppointment()">Delete</button>
         </div>
       </div>
     </div>
   </div>

   <script>
       let selectedAppointmentId = null;
       let deleteRowElement = null;

       function setAppointmentId(id, btn) {
           selectedAppointmentId = id;
           deleteRowElement = btn.closest("tr"); // store the row to remove later
           document.getElementById("deleteAppointmentId").value = id;
       }

       function deleteAppointment() {
           fetch('AppointmentServlet', {
               method: 'POST',
               headers: {
                   'Content-Type': 'application/x-www-form-urlencoded'
               },
               body: `appointmentId=${selectedAppointmentId}&_method=DELETE`
           })
           .then(response => {
               if (response.ok) {
                   $('#deleteModal').modal('hide');
                   if (deleteRowElement) {
                       deleteRowElement.remove(); // remove row from UI
                   }
                   showSuccess("Appointment deleted successfully.");
               } else {
                   showError("Failed to delete appointment.");
               }
           })
           .catch(error => {
               console.error('Error:', error);
               showError("An error occurred while deleting.");
           });
       }

       function showSuccess(msg) {
           const alertBox = document.createElement("div");
           alertBox.className = "alert alert-success text-center";
           alertBox.innerText = msg;
           document.querySelector(".container").prepend(alertBox);
           setTimeout(() => alertBox.remove(), 3000);
       }

       function showError(msg) {
           const alertBox = document.createElement("div");
           alertBox.className = "alert alert-danger text-center";
           alertBox.innerText = msg;
           document.querySelector(".container").prepend(alertBox);
           setTimeout(() => alertBox.remove(), 3000);
       }
   </script>

    <footer class="footer text-white py-4 bg-success">
        <div class="container text-center">
            <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
