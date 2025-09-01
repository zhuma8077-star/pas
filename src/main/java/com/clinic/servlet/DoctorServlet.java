package com.clinic.servlet;

import com.clinic.dao.DoctorDAO;
import com.clinic.dao.UserDAO;
import com.clinic.model.User;
import com.clinic.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;
@MultipartConfig
@WebServlet("/DoctorServlet")
public class DoctorServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DoctorServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String _method = request.getParameter("_method");
        System.out.println("Method is : "+_method);
        if(_method!=null&&_method.equals("DELETE")){
            doDelete(request,response);
            response.sendRedirect("doctors_dashboard.jsp?success=true");
            return;
        }else if(_method!=null&&_method.equals("PUT")){
            doPut(request,response);
            return;
        }

        System.out.println("getting user parameters: doctor servlet");
        String name = request.getParameter("name");
        Integer age = request.getIntHeader("age");
        String gender = request.getParameter("gender");
        String specialization = request.getParameter("specialization");
        String experience = request.getParameter("experience");
        String qualification = request.getParameter("qualification");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        if (userDAO.isEmailRegistered(email)) {
            response.sendRedirect("signup.jsp?signup=exists");
            return;
        }



        String address = request.getParameter("address");
        String availability = request.getParameter("availability");
        String password = request.getParameter("password");
        System.out.println("getting image url:");
        Part filePart = request .getPart( "image_url");
        System.out.println("after filePart is creaded.");
        InputStream inputstream = null;
        if (filePart != null && filePart.getSize() > 0){
            System.out.println(filePart.getSize()+" "+filePart);
            inputstream = filePart.getInputStream();
        }else{
            System.out.println("could not load image");
        }

        System.out.println("after getting image url");

        String hashedPassword = userDAO.hashPassword(password);

        // Create and register user
        User user = new User(name, age, address, gender, contact, email, hashedPassword, "doctor");
        System.out.println("User info: Doctor Servlet: " + user.toString());
        boolean result = userDAO.registerUser(user);
        if(result) {
            System.out.println("Adding Doctor form doctor Servlet.");
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO doctors (name, specialization, experience, qualification, contact, email, address, availability, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, specialization);
                stmt.setString(3, experience);
                stmt.setString(4, qualification);
                stmt.setString(5, contact);
                stmt.setString(6, email);
                stmt.setString(7, address);
                stmt.setString(8, availability);
                if (inputstream != null) {
                    stmt.setBlob(9, inputstream);
                } else {
                    stmt.setNull(9, Types.BLOB);
                }
                stmt.executeUpdate();

                LOGGER.info("Doctor added successfully: " + name);
                response.sendRedirect("doctors.jsp?success=true");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Database Error: Unable to add doctor", e);
                response.sendRedirect("doctors.jsp?error=true");
            }
        }
        else{

                response.sendRedirect("add_doctor.jsp?signup=fail");

        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String doctorIdStr = request.getParameter("doctorId");
        System.out.println("Doctor Id:"+doctorIdStr);
        if (doctorIdStr != null) {
            try {
                int doctorId = Integer.parseInt(doctorIdStr);
                DoctorDAO doctorDao = new DoctorDAO();

                boolean isDeleted = doctorDao.deleteDoctorById(doctorId);


            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Doctor ID format.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Doctor ID is required.");
        }
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the doctor ID to update the specific doctor record
        String doctorIdStr = request.getParameter("id");
        int doctorId = 0;

        if (doctorIdStr != null && !doctorIdStr.isEmpty()) {
            try {
                doctorId = Integer.parseInt(doctorIdStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Doctor ID.");
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Doctor ID is required.");
            return;
        }

        // Get the updated doctor details from the form
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String experience = request.getParameter("experience");
        String qualification = request.getParameter("qualification");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String availability = request.getParameter("availability");

        try (Connection conn = DBConnection.getConnection()) {
            // SQL query to update the doctor record based on doctor ID
            String sql = "UPDATE doctors SET name = ?, specialization = ?, experience = ?, qualification = ?, contact = ?, email = ?, address = ?, availability = ? WHERE id = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, specialization);
            stmt.setString(3, experience);
            stmt.setString(4, qualification);
            stmt.setString(5, contact);
            stmt.setString(6, email);
            stmt.setString(7, address);
            stmt.setString(8, availability);
            stmt.setInt(9, doctorId);

            // Execute the update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                LOGGER.info("Doctor updated successfully: " + name);
                response.sendRedirect("doctors_dashboard.jsp?success=true");
            } else {
                LOGGER.warning("No rows updated. Doctor ID not found.");
                response.sendRedirect("doctors_dashboard.jsp?error=true");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database Error: Unable to update doctor", e);
            response.sendRedirect("doctors_dashboard.jsp?error=true");
        }
    }
}
