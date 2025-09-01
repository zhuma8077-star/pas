package com.clinic.servlet;

import com.clinic.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;

@WebServlet("/DoctorImageServlet")
public class DoctorImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Doctor ID required");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT image_url FROM doctors WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                byte[] imgData = rs.getBytes("image_url");
                if (imgData != null) {
                    response.setContentType("image/jpeg"); // or png if needed
                    OutputStream out = response.getOutputStream();
                    out.write(imgData);
                    out.flush();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No image found for doctor");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Doctor not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading doctor image");
        }
    }
}
