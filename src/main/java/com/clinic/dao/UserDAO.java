package com.clinic.dao;

import com.clinic.model.User;
import com.clinic.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt; // Importing BCrypt for hashing

public class UserDAO {

    // Hash Password with BCrypt
    public String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12)); // Hashing the password with BCrypt
    }

    public Integer getDoctorId(String email) {
        Integer doctorId = null;
        String query = "SELECT id FROM doctors WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    doctorId = rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return doctorId; // returns null if no doctor found
    }

    // ✅ Check if email is already registered
    public boolean isEmailRegistered(String email) {
        boolean exists = false;
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    // ✅ Register User (Signup)
    public boolean registerUser(User user) {
        System.out.println("Registering User from userDAO.");
        if (isEmailRegistered(user.getEmail())) {
            return false; // ❌ Email already exists
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

            // Password is already hashed, so we store the hashed password
            stmt.setString(7, user.getPassword());
            stmt.setString(8, user.getRole());

            if (stmt.executeUpdate() > 0) {
                System.out.println("✅ User Registered Successfully: " + user.getEmail());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Authenticate User (Login) - FIXED Password Matching Issue using BCrypt
    public User authenticateUser(String email, String password) {
        User user = null;
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password"); // Fetch Password from DB

                    // ✅ Password comparison using BCrypt
                    if (BCrypt.checkpw(password, storedPassword)) { // Check if entered password matches hashed password
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
                    } else {
                        System.out.println("❌ Password Mismatch: Login Failed");
                    }
                } else {
                    System.out.println("❌ No User Found with this Email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ Insert Default Admin (if not exists)
    public void insertDefaultAdmin() {
        if (!isEmailRegistered("admin@example.com")) {
            String hashedAdminPassword = BCrypt.hashpw("admin123", BCrypt.gensalt()); // Hashing admin password
            String query = "INSERT INTO users (fullname, age, address, gender, contact, email, password, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setString(1, "Admin");
                stmt.setInt(2, 30);
                stmt.setString(3, "Admin Address");
                stmt.setString(4, "Male");
                stmt.setString(5, "1234567890");
                stmt.setString(6, "admin@example.com");
                stmt.setString(7, hashedAdminPassword);
                stmt.setString(8, "admin");

                stmt.executeUpdate();
                System.out.println("✅ Default admin inserted successfully!");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public User getUserById(int userId) {
        User user = null;
        String query = "SELECT * FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("fullname"),
                        rs.getInt("age"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("contact"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE users SET fullname = ?, age = ?, address = ?, gender = ?, contact = ?, email = ?, password = ?, role = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getFullname());
            stmt.setInt(2, user.getAge());
            stmt.setString(3, user.getAddress());
            stmt.setString(4, user.getGender());
            stmt.setString(5, user.getContact());
            stmt.setString(6, user.getEmail());
            stmt.setString(7, user.getPassword());  // Ensure password is already hashed if changed
            stmt.setString(8, user.getRole());
            stmt.setInt(9, user.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;  // Return true if at least one row is updated

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if update fails
    }


}