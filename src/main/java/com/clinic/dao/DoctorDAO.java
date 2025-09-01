package com.clinic.dao;

import com.clinic.model.Doctor;
import com.clinic.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt; // Importing BCrypt for hashing passwords

public class DoctorDAO {


    // ✅ Get Doctor by ID
    public Doctor getDoctorById(int doctorId) {
        Doctor doctor = null;
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM doctors WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, doctorId);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                doctor = new Doctor();
                doctor.setId(resultSet.getInt("id"));
                doctor.setName(resultSet.getString("name"));
                doctor.setSpecialization(resultSet.getString("specialization"));
                doctor.setExperience(resultSet.getString("experience"));
                doctor.setQualification(resultSet.getString("qualification"));
                doctor.setContact(resultSet.getString("contact"));
                doctor.setEmail(resultSet.getString("email"));
                doctor.setAddress(resultSet.getString("address"));
                doctor.setAvailability(resultSet.getString("availability"));
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println("❌ Error Fetching Doctor by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return doctor;
    }

    // ✅ Method to fetch all doctors from the database
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctorList = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM doctors";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(resultSet.getInt("id"));
                doctor.setName(resultSet.getString("name"));
                doctor.setSpecialization(resultSet.getString("specialization"));
                doctor.setExperience(resultSet.getString("experience"));
                doctor.setQualification(resultSet.getString("qualification"));
                doctor.setContact(resultSet.getString("contact"));
                doctor.setEmail(resultSet.getString("email"));
                doctor.setAddress(resultSet.getString("address"));
                doctor.setAvailability(resultSet.getString("availability"));

                doctorList.add(doctor);
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println("❌ Error Fetching Doctors: " + e.getMessage());
            e.printStackTrace();
        }
        return doctorList;
    }


    // ✅ Delete Doctor by ID
    public boolean deleteDoctorById(int doctorId) {
        boolean isDeleted = false;
        try {
            Connection conn = DBConnection.getConnection();
            String query = "DELETE FROM doctors WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, doctorId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }

            conn.close();
        } catch (SQLException e) {
            System.out.println("❌ Error Deleting Doctor: " + e.getMessage());
            e.printStackTrace();
        }
        return isDeleted;
    }

}

