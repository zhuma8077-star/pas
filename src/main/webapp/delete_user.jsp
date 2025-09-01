<%@ page import="com.clinic.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String idStr = request.getParameter("id");
    if (idStr != null) {
        int id = Integer.parseInt(idStr);
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Establish connection
            con = DBConnection.getConnection();
            ps = con.prepareStatement("DELETE FROM users WHERE id = ?");
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();

            // Check if the user was deleted
            if (rowsAffected > 0) {
%>
                <html>
                <head>
                    <title>Delete Confirmation</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            background-color: #f8f9fa;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            height: 100vh;
                            margin: 0;
                        }
                        .confirmation-box {
                            background-color: #28a745;
                            color: white;
                            padding: 20px;
                            border-radius: 8px;
                            text-align: center;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                        }
                        .confirmation-box a {
                            color: white;
                            text-decoration: none;
                            font-weight: bold;
                        }
                    </style>
                </head>
                <body>
                    <div class="confirmation-box">
                        <h2>User successfully deleted!</h2>
                        <p>You will be redirected back to the Manage Users page.</p>
                        <p><a href="manage-users.jsp">Click here if you're not redirected automatically.</a></p>
                    </div>

                    <script>
                        // Redirect after 3 seconds
                        setTimeout(function() {
                            window.location.href = "manage-users.jsp";
                        }, 3000);
                    </script>
                </body>
                </html>
<%
            } else {
%>
                <html>
                <head>
                    <title>Deletion Error</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            background-color: #f8f9fa;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            height: 100vh;
                            margin: 0;
                        }
                        .confirmation-box {
                            background-color: #dc3545;
                            color: white;
                            padding: 20px;
                            border-radius: 8px;
                            text-align: center;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                        }
                    </style>
                </head>
                <body>
                    <div class="confirmation-box">
                        <h2>Error: User deletion failed.</h2>
                        <p><a href="manage-users.jsp">Back to Manage Users</a></p>
                    </div>
                </body>
                </html>
<%
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            // Ensure resources are cleaned up
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    } else {
%>
    <html>
    <head>
        <title>Invalid Request</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .confirmation-box {
                background-color: #ffc107;
                color: black;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>
    <body>
        <div class="confirmation-box">
            <h2>Invalid Deletion Request</h2>
            <p>No user ID was provided for deletion.</p>
            <p><a href="manage-users.jsp">Back to Manage Users</a></p>
        </div>
    </body>
    </html>
<%
    }
%>
