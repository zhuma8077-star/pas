package com.clinic.servlet;

import com.clinic.dao.UserDAO;
import com.clinic.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getParameter("_method");
        if(method!=null&&method.equals("PUT")){
            doPut(request,response);
            response.sendRedirect("manage-users.jsp");
            return;
        }
        try {
            // Retrieve user data from form
            String fullname = request.getParameter("fullname");
            String ageStr = request.getParameter("age");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String contact = request.getParameter("contact");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validate age input
            int age;
            try {
                age = Integer.parseInt(ageStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("signup.jsp?signup=invalid-age");
                return;
            }

            // Set default role if not provided
            String role = request.getParameter("role");
            if (role == null || role.isEmpty()) {
                role = "user"; // Default role
            }

            // Password Hashing
            UserDAO userDAO = new UserDAO();
            String hashedPassword = userDAO.hashPassword(password);

            // Check if email already exists
            if (userDAO.isEmailRegistered(email)) {
                response.sendRedirect("signup.jsp?signup=exists");
                return;
            }

            // Create and register user
            User user = new User(fullname, age, address, gender, contact, email, hashedPassword, role);
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

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String fullname = request.getParameter("fullname");
            String ageStr = request.getParameter("age");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String contact = request.getParameter("contact");
            String email = request.getParameter("email");

            // Validate age input
            int age;
            try {
                age = Integer.parseInt(ageStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("updateUser.jsp?update=invalid-age");
                return;
            }

            UserDAO userDAO = new UserDAO();
            User existingUser = userDAO.getUserById(userId);

            if (existingUser == null) {
                response.sendRedirect("updateUser.jsp?update=not-found");
                return;
            }

            // Hash password only if changed
            String hashedPassword = existingUser.getPassword();
            String role = existingUser.getRole();
            // Update user information
            User updatedUser = new User(userId, fullname, age, address, gender, contact, email, hashedPassword, role);
            boolean updateSuccess = userDAO.updateUser(updatedUser);

            /*if (updateSuccess) {
                response.sendRedirect("profile.jsp?update=success");
            } else {
                response.sendRedirect("updateUser.jsp?update=fail");
            }*/

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateUser.jsp?update=error");
        }
    }
}
