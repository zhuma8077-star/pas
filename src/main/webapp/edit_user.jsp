<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, org.mindrot.jbcrypt.BCrypt" %>

<%
    String id = request.getParameter("id");
    String fullname = "", age = "", address = "", gender = "", contact = "", email = "";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/PAS", "root", "root");

        // ✅ Handle Update
        if(request.getParameter("update") != null) {
            String f = request.getParameter("fullname");
            String a = request.getParameter("age");
            String add = request.getParameter("address");
            String g = request.getParameter("gender");
            String c = request.getParameter("contact");
            String e = request.getParameter("email");
            String p = request.getParameter("password");

            // Hash password using BCrypt
            String hashedPass = BCrypt.hashpw(p, BCrypt.gensalt());

            String sqlUpdate = "UPDATE users SET fullname=?, age=?, address=?, gender=?, contact=?, email=?, password=? WHERE id=?";
            pst = conn.prepareStatement(sqlUpdate);
            pst.setString(1, f);
            pst.setString(2, a);
            pst.setString(3, add);
            pst.setString(4, g);
            pst.setString(5, c);
            pst.setString(6, e);
            pst.setString(7, hashedPass);
            pst.setString(8, id);
            pst.executeUpdate();

            // ✅ Redirect to manage-users.jsp with success message
            response.sendRedirect("manage-users.jsp?msg=updated");
            return; // taake neeche ka code execute na ho
        }

        // ✅ Fetch existing user data
        String sql = "SELECT * FROM users WHERE id=?";
        pst = conn.prepareStatement(sql);
        pst.setString(1, id);
        rs = pst.executeQuery();
        if(rs.next()) {
            fullname = rs.getString("fullname");
            age = rs.getString("age");
            address = rs.getString("address");
            gender = rs.getString("gender");
            contact = rs.getString("contact");
            email = rs.getString("email");
        }
    } catch(Exception e){ e.printStackTrace(); }
    finally {
        if(rs != null) try{rs.close();}catch(Exception e){}
        if(pst != null) try{pst.close();}catch(Exception e){}
        if(conn != null) try{conn.close();}catch(Exception e){}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body { font-family: Arial; background:#e8f5e9; }
        .container { max-width: 500px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 10px; }
        .form-control { margin-bottom: 15px; }
        button { width: 100%; padding: 10px; border:none; background:#388e3c; color:white; border-radius:5px; cursor:pointer; }
        button:hover { background:#2e7d32; }
        h2 { text-align: center; margin-bottom: 20px; }
    </style>
</head>
<body>
<div class="container">
<h2>Edit User</h2>
<form method="post">
    <input type="hidden" name="userId" value="<%= id %>">
    <input type="text" name="fullname" class="form-control" value="<%= fullname %>" placeholder="Full Name" required>
    <input type="number" name="age" class="form-control" value="<%= age %>" placeholder="Age" required>
    <input type="text" name="address" class="form-control" value="<%= address %>" placeholder="Address" required>
    <select name="gender" class="form-control" required>
        <option value="Male" <%= "Male".equals(gender)?"selected":"" %>>Male</option>
        <option value="Female" <%= "Female".equals(gender)?"selected":"" %>>Female</option>
        <option value="Other" <%= "Other".equals(gender)?"selected":"" %>>Other</option>
    </select>
    <input type="text" name="contact" class="form-control" value="<%= contact %>" placeholder="Contact" required>
    <input type="email" name="email" class="form-control" value="<%= email %>" placeholder="Email" required>
    <input type="password" name="password" class="form-control" placeholder="Enter new password" required>
    <button type="submit" name="update">Update User</button>
</form>
</div>
</body>
</html>
