<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.model.User" %>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String doctor = "", date="", time="", contact="";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas","root","root");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM appointments WHERE id=?");
        ps.setInt(1,id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            doctor = rs.getString("doctor");
            date = rs.getString("appointment_date");
            time = rs.getString("appointment_time");
            contact = rs.getString("patient_contact");
        }
        con.close();
    } catch(Exception e){ out.println(e); }

    String updateMessage = request.getParameter("message");
%>
<html>
<head>
    <title>Update Appointment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#28a745;">
    <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">Patient Appointment System</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/doctors.jsp">Doctors</a></li>
            <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/appointments.jsp">Book Appointment</a></li>
            <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user_appointment.jsp">My Appointments</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container mt-5">
    <h2>Update Appointment</h2>
    <% if(updateMessage != null){ %>
        <div class="alert alert-success"><%= updateMessage %></div>
    <% } %>

    <form method="post" action="">
        <input type="hidden" name="id" value="<%=id%>">

        <!-- ✅ UPDATED Doctor Dropdown FROM DATABASE -->
        <div class="form-group">
            <label>Doctor</label>
            <select name="doctor" class="form-control" required>
                <option value="">-- Select Doctor --</option>
                <%
                    Connection con2 = null;
                    PreparedStatement ps2 = null;
                    ResultSet rs2 = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas","root","root");

                        ps2 = con2.prepareStatement("SELECT name FROM doctors");
                        rs2 = ps2.executeQuery();

                        while(rs2.next()){
                            String dbDoctor = rs2.getString("name");
                %>
                            <option value="<%=dbDoctor%>"
                                <%= dbDoctor.equals(doctor) ? "selected" : "" %>>
                                <%=dbDoctor%>
                            </option>
                <%
                        }
                    } catch(Exception e){
                        out.println(e);
                    } finally {
                        try { if(rs2!=null) rs2.close(); } catch(Exception e){}
                        try { if(ps2!=null) ps2.close(); } catch(Exception e){}
                        try { if(con2!=null) con2.close(); } catch(Exception e){}
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label>Date</label>
            <input type="date" name="appointmentDate" class="form-control" value="<%=date%>" required>
        </div>
        <div class="form-group">
            <label>Time</label>
            <input type="time" name="appointmentTime" class="form-control" value="<%=time%>" required>
        </div>
        <div class="form-group">
            <label>Contact</label>
            <input type="text" name="patientContact" class="form-control" value="<%=contact%>" required>
        </div>
        <button type="submit" class="btn btn-success">Update</button>
    </form>
</div>

<%
    if(request.getMethod().equalsIgnoreCase("POST")){
        try{
            String newDoctor = request.getParameter("doctor");
            String newDate = request.getParameter("appointmentDate");
            String newTime = request.getParameter("appointmentTime");
            String newContact = request.getParameter("patientContact");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas","root","root");
            PreparedStatement ps = con.prepareStatement("UPDATE appointments SET doctor=?, appointment_date=?, appointment_time=?, patient_contact=? WHERE id=?");
            ps.setString(1,newDoctor);
            ps.setString(2,newDate);
            ps.setString(3,newTime);
            ps.setString(4,newContact);
            ps.setInt(5,id);
            int updated = ps.executeUpdate();
            con.close();

            if(updated > 0){
                response.sendRedirect("user_appointment.jsp?message=Appointment+updated+successfully");
            }else{
                out.println("<div class='alert alert-danger'>Update failed!</div>");
            }
        }catch(Exception e){ out.println(e); }
    }
%>

</body>
</html>