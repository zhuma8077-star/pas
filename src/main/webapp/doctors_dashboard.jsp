<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .table {
            width: 100%;         /* Full width */
            table-layout: auto;
            margin: 0;           /* No extra margin */
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
            vertical-align: middle;
        }
        th {
            background-color: #28a745;
            color: white;
        }
        .btn {
            padding: 5px 10px;
            margin: 2px;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            display: inline-block;
        }
        .edit { background-color: #007bff; }
        .view { background-color: #28a745; }
        .delete { background-color: #dc3545; }
        .add-doctor {
            background-color: #17a2b8;
            padding: 10px;
            margin: 10px 0;
            display: inline-block;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .doctor-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
            display: block;
            margin: 0 auto;
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
                </ul>
            </div>
        </div>
    </nav>

  <!-- 🔽 Full width container to remove left/right padding -->
  <div class="container-fluid mt-4">
      <!-- ✅ Buttons Row (Add Doctor Left, Back Right) -->
      <div class="d-flex justify-content-between mb-3">
          <!-- Add Doctor Button -->
          <a href="add_doctor.jsp" class="btn btn-success">
              <i class="fas fa-user-plus"></i> Add New Doctor
          </a>

          <!-- Back Button (force redirect to admin-dashboard.jsp) -->
          <a href="admin-dashboard.jsp" class="btn btn-secondary">
              <i class="fas fa-arrow-left"></i> Back
          </a>
      </div>

      <h2>Doctor Dashboard</h2>

        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>PIC</th>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Experience</th>
                    <th>Qualification</th>
                    <th>Contact</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Availability</th>
                    <th>Actions <br> <small>(View | Edit | Delete)</small></th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM doctors");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><img src="DoctorImageServlet?id=<%= rs.getInt("id") %>" alt="Doctor Image" class="doctor-img" /></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("specialization") %></td>
                    <td><%= rs.getString("experience") %></td>
                    <td><%= rs.getString("qualification") %></td>
                    <td><%= rs.getString("contact") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("availability") %></td>
                   <td>
                       <div class="d-flex justify-content-center">
                           <a href="doctor_profile.jsp?id=<%= rs.getInt("id") %>" class="btn btn-info mx-1">
                               <i class="fas fa-eye"></i> View
                           </a>
                           <a href="edit_doctor.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning mx-1">
                               <i class="fas fa-edit"></i> Edit
                           </a>
                           <button class="btn btn-danger mx-1" data-toggle="modal" data-target="#deleteModal"
                                   onclick="setDoctorId('<%= rs.getInt("id") %>')">
                               <i class="fas fa-trash-alt"></i> Delete
                           </button>
                       </div>
                   </td>
                </tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='11'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <footer class="footer text-white py-4 bg-success">
        <div class="container text-center">
            <p>&copy; 2024 Healthcare System. All Rights Reserved.</p>
        </div>
    </footer>

    <script>
        function setDoctorId(doctorId) {
           document.getElementById("deleteDoctorId").value = doctorId;
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
