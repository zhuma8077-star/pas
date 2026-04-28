<%@ page import="java.sql.*" %>
<html>
<head>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
 <title>Manage Users Dashboard</title>
 <style>
    table { width: 100%; border-collapse: collapse; }
    th, td { border: 1px solid black; padding: 10px; text-align: left; }
    th { background-color:#28a745; color: white; }
    .btn { padding: 5px 10px; margin: 2px; text-decoration: none; color: white; border-radius: 5px; display: inline-block; }
    .edit { background-color: #007bff; }
    .view { background-color: #28a745; }
    .delete { background-color: #dc3545; }
    .add-doctor { background-color: #17a2b8; padding: 10px; margin: 10px 0; display: inline-block; color: white; text-decoration: none; border-radius: 5px; }
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

<%
    // ✅ Handle Add User form submission
    if("POST".equalsIgnoreCase(request.getMethod())){
        String fullname = request.getParameter("fullname");
        String age = request.getParameter("age");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if(fullname != null && email != null){
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas","root","root");
                PreparedStatement ps = con.prepareStatement(
                  "INSERT INTO users(fullname, age, address, gender, contact, email, password, role) VALUES(?,?,?,?,?,?,?,?)"
                );
                ps.setString(1, fullname);
                ps.setString(2, age);
                ps.setString(3, address);
                ps.setString(4, gender);
                ps.setString(5, contact);
                ps.setString(6, email);
                ps.setString(7, password);
                ps.setString(8, role);

                int i = ps.executeUpdate();
                con.close();
                if(i > 0){
                    request.setAttribute("message", "✅ User Added Successfully!");
                } else {
                    request.setAttribute("error", "⚠️ Failed to add user. Try again.");
                }
            } catch(Exception e){
                request.setAttribute("error", "Error: " + e.getMessage());
            }
        }
    }
%>

<div class="container mt-3">
    <!-- ✅ Show Success/Error Messages -->
    <%
        if(request.getAttribute("message") != null){ %>
            <div class="alert alert-success"><%= request.getAttribute("message") %></div>
    <%  }
        if(request.getAttribute("error") != null){ %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <%  }
    %>

    <!-- ✅ Buttons Row (Add User Left, Back Right) -->
    <div class="d-flex justify-content-between">
        <!-- Add User Button -->
        <button type="button" class="btn add-doctor" data-toggle="modal" data-target="#addUserModal">
            <i class="fas fa-user-plus"></i> Add User
        </button>

        <!-- Back Button -->
        <a href="admin-dashboard.jsp" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back
        </a>
    </div>
</div>

<h2 class="mt-3">Manage Users Dashboard</h2>
<table>
    <tr>
        <th>ID</th>
        <th>FullName</th>
        <th>Age</th>
        <th>Address</th>
        <th>Gender</th>
        <th>Contact</th>
        <th>Email</th>
        <th>Password</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("fullname") %></td>
        <td><%= rs.getString("age") %></td>
        <td><%= rs.getString("address") %></td>
        <td><%= rs.getString("gender") %></td>
        <td><%= rs.getInt("contact") %></td>
        <td><%= rs.getString("email") %></td>
        <td>********</td>
        <td><%= rs.getString("role") %></td>
        <td>
            <a href="user_profile.jsp?id=<%= rs.getInt("id") %>" class="btn view">View</a>
            <a href="edit_user.jsp?id=<%= rs.getInt("id") %>" class="btn edit">Edit</a>
            <a href="delete_user.jsp?id=<%= rs.getInt("id") %>" class="btn delete" onclick="return confirm('Are you sure?');">Delete</a>
        </td>
    </tr>
    <%
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</table>

<!-- ✅ Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title">Add New User</h5>
        <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form method="post" action="manage-users.jsp">
            <div class="form-group"><label>Full Name:</label><input type="text" name="fullname" class="form-control" required></div>
            <div class="form-group"><label>Age:</label><input type="number" name="age" class="form-control" required></div>
            <div class="form-group"><label>Address:</label><input type="text" name="address" class="form-control" required></div>
            <div class="form-group"><label>Gender:</label>
                <select name="gender" class="form-control">
                    <option>Male</option><option>Female</option>
                </select>
            </div>
            <div class="form-group"><label>Contact:</label><input type="text" name="contact" class="form-control" required></div>
            <div class="form-group"><label>Email:</label><input type="email" name="email" class="form-control" required></div>
            <div class="form-group"><label>Password:</label><input type="password" name="password" class="form-control" required></div>
            <div class="form-group"><label>Role:</label>
                <select name="role" class="form-control">
                    <option value="user">User</option>
                    <option value="doctor">Doctor</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Add User</button>
        </form>
      </div>
    </div>
  </div>
</div>

<footer class="footer text-white py-4 bg-success">
    <div class="container text-center">
        <p>&copy; 2026 Patient Appointment and Sheduling System. All Rights Reserved.</p>
    </div>
</footer>

<!-- ✅ Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
