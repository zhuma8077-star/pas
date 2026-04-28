<%@ page import="java.sql.*, com.clinic.util.DBConnection" %>
<%@ page import="com.clinic.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession session1 = request.getSession(false);
    User user = (session1 != null) ? (User) session1.getAttribute("user") : null;

    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp?login=unauthorized");
        return;
    }

    // ✅ DELETE FUNCTION (FIXED REDIRECT)
    String deleteId = request.getParameter("delete");
    if (deleteId != null) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM contact_messages WHERE id=?"
            );
            ps.setInt(1, Integer.parseInt(deleteId));
            ps.executeUpdate();

            response.sendRedirect("contact-dashboard.jsp?deleted=success");
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Dashboard</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        th { background-color:#28a745; color:white; }
        .btn-delete { background-color:#dc3545; color:white; }
        .footer { background-color:#28a745; color:white; padding:20px 0; }
    </style>
</head>

<body>

<!-- ✅ OLD NAVBAR WITH LOGOUT (ADDED) -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success sticky-top">
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
                    <a class="nav-link" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp"><i class="fas fa-phone-alt"></i> Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <h2 class="text-center mb-3">Contact Requests</h2>

    <div class="d-flex justify-content-end mb-3">
        <a href="admin-dashboard.jsp" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back
        </a>
    </div>

    <!-- Success Message -->
    <% if ("success".equals(request.getParameter("deleted"))) { %>
        <div class="alert alert-success text-center">
            Request deleted successfully!
        </div>
    <% } %>

    <!-- Table -->
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Message</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT * FROM contact_messages ORDER BY submitted_at DESC"
                );

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("message") %></td>
                <td><%= rs.getTimestamp("submitted_at") %></td>

                <td>
                    <button class="btn btn-delete btn-sm"
                            data-toggle="modal"
                            data-target="#deleteModal"
                            onclick="setDeleteId('<%= rs.getInt("id") %>')">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>

</div>

<!-- DELETE MODAL -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Confirm Delete</h5>
                <button type="button" class="close text-white" data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body text-center">
                <p>Are you sure you want to delete this request?</p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                    Cancel
                </button>

                <form method="get" action="contact-dashboard.jsp">
                    <input type="hidden" name="delete" id="deleteId">
                    <button type="submit" class="btn btn-danger">
                        Yes, Delete
                    </button>
                </form>
            </div>

        </div>
    </div>
</div>

<footer class="footer text-white text-center mt-5">
    <p>&copy; 2026 Patient Appointment System</p>
</footer>

<script>
    function setDeleteId(id) {
        document.getElementById("deleteId").value = id;
    }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>