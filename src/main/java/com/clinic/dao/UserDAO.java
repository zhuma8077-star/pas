package com.clinic.dao;

import com.clinic.model.User;
import com.clinic.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    public String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    public Integer getDoctorId(String email) {
        Integer doctorId = null;
        String query = "SELECT id FROM doctors WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                doctorId = rs.getInt("id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return doctorId;
    }

    public boolean isEmailRegistered(String email) {
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerUser(User user) {

        if (isEmailRegistered(user.getEmail())) {
            return false;
        }

        String query = "INSERT INTO users (fullname, age, address, gender, contact, email, password, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getFullname());
            stmt.setInt(2, user.getAge());
            stmt.setString(3, user.getAddress());
            stmt.setString(4, user.getGender());
            stmt.setString(5, user.getContact());
            stmt.setString(6, user.getEmail());
            stmt.setString(7, user.getPassword());
            stmt.setString(8, user.getRole());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public User authenticateUser(String email, String password) {
        User user = null;

        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (BCrypt.checkpw(password, storedPassword)) {
                    user = new User(
                            rs.getString("fullname"),
                            rs.getInt("age"),
                            rs.getString("address"),
                            rs.getString("gender"),
                            rs.getString("contact"),
                            rs.getString("email"),
                            storedPassword,
                            rs.getString("role")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public List<String> getAllEmails() {
        List<String> emails = new ArrayList<>();
        String query = "SELECT email FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                emails.add(rs.getString("email"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return emails;
    }
}