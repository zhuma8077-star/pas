package com.clinic.servlet;

import com.clinic.dao.UserDAO;
import com.clinic.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String fullname = request.getParameter("fullname");
            String ageStr = request.getParameter("age");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String contact = request.getParameter("contact");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            int age;
            try {
                age = Integer.parseInt(ageStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("signup.jsp?signup=invalid-age");
                return;
            }

            String role = request.getParameter("role");
            if (role == null || role.isEmpty()) {
                role = "user";
            }

            UserDAO userDAO = new UserDAO();

            if (userDAO.isEmailRegistered(email)) {
                response.sendRedirect("signup.jsp?signup=exists");
                return;
            }

            String hashedPassword = userDAO.hashPassword(password);

            User user = new User(
                    fullname,
                    age,
                    address,
                    gender,
                    contact,
                    email,
                    hashedPassword,
                    role
            );

            boolean result = userDAO.registerUser(user);

            if (result) {
                response.sendRedirect("login.jsp?signup=success");
            } else {
                response.sendRedirect("signup.jsp?signup=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?signup=error");
        }
    }

    // ❌ IMPORTANT: REMOVE doPut completely (not needed now)
}