<%@ page import="java.sql.*" %>
<%@ page import="com.clinic.model.User" %>
<%
    // Use existing session
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    String message = "";

    if(idStr != null){
        int id = Integer.parseInt(idStr);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pas", "root", "root");
            PreparedStatement ps = con.prepareStatement("DELETE FROM appointments WHERE id=? AND patient_email=?");
            ps.setInt(1, id);
            ps.setString(2, user.getEmail());
            int row = ps.executeUpdate();
            if(row > 0){
                message = "Appointment cancelled successfully!";
            } else {
                message = "Failed to cancel appointment!";
            }
            con.close();
        } catch(Exception e){
            message = "Error: " + e.getMessage();
        }
    } else {
        message = "Invalid appointment ID!";
    }

    // Redirect to user_appointment.jsp with message
    response.sendRedirect("user_appointment.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
%>
