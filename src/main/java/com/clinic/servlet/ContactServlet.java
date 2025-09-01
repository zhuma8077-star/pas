package com.clinic.servlet;

import com.clinic.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ContactServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, message);
            stmt.executeUpdate();

            LOGGER.info("Contact message saved successfully: " + name + " (" + email + ")");
            response.sendRedirect("contact.jsp?success=true");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database Error: Unable to save contact message", e);
            response.sendRedirect("contact.jsp?error=true");
        }
    }
}
