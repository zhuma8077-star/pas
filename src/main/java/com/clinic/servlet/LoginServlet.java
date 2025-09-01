package com.clinic.servlet;

import com.clinic.dao.UserDAO;
import com.clinic.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ✅ existing UserDAO ka authenticateUser method use karna
        User user = userDAO.authenticateUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // ✅ role ke hisaab se redirect
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin-dashboard.jsp");
            } else if ("doctor".equalsIgnoreCase(user.getRole())) {
                // 👩‍⚕️ Doctor ke liye naya page
                response.sendRedirect("manage-doctor.jsp");
            } else {
                // 👨‍💻 normal user now goes to user-dashboard
                response.sendRedirect("user-dashboard.jsp");
            }
        } else {
            // ❌ login fail
            response.sendRedirect("login.jsp?loginError=fail");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
