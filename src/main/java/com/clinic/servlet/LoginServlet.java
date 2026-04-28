package com.clinic.servlet;

import com.clinic.dao.UserDAO;
import com.clinic.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();

        // get emails from database
        java.util.List<String> emails = userDAO.getAllEmails();

        // send to JSP
        request.setAttribute("emailList", emails);

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.authenticateUser(email, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin-dashboard.jsp");

            } else if ("doctor".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("manage-doctor.jsp");

            } else {
                response.sendRedirect("user-dashboard.jsp");
            }

        } else {
            response.sendRedirect("login.jsp?loginError=fail");
        }
    }
}