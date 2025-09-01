package com.clinic.servlet;

import com.clinic.model.User;
import com.clinic.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if User is Logged In
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        // Get Parameters from Form
        String doctor = request.getParameter("doctor");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
        String patientName = user.getFullname();  // Auto-filled
        String patientContact = request.getParameter("patientContact");
        String patientEmail = user.getEmail();   // Auto-filled

        try (Connection conn = DBConnection.getConnection()) {
            // SQL Query to Insert Data
            String sql = "INSERT INTO appointments (doctor, appointment_date, appointment_time, patient_name, patient_contact, patient_email) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, doctor);
            stmt.setString(2, appointmentDate);
            stmt.setString(3, appointmentTime);
            stmt.setString(4, patientName);
            stmt.setString(5, patientContact);
            stmt.setString(6, patientEmail);
            stmt.executeUpdate();

            // Redirect with Success Message
            response.sendRedirect("appointments.jsp?success=true");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("appointments.jsp?error=true");
        }

        String method = request.getParameter("_method");
        if ("DELETE".equalsIgnoreCase(method)) {
            String idStr = request.getParameter("appointmentId");
            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement ps = con.prepareStatement("DELETE FROM appointments WHERE id = ?");
                ps.setInt(1, Integer.parseInt(idStr));
                ps.executeUpdate();
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            return;
        }

    }
}
