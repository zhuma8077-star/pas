package com.clinic.dao;

import com.clinic.model.Appointment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {
    private Connection conn;

    public AppointmentDAO(Connection conn) {
        this.conn = conn;
    }

    // 1. Add appointment
    public boolean addAppointment(Appointment appt) {
        String sql = "INSERT INTO appointments (doctor, appointment_date, appointment_time, patient_name, patient_contact, patient_email) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, appt.getDoctor());
            stmt.setDate(2, appt.getAppointmentDate());
            stmt.setTime(3, appt.getAppointmentTime());
            stmt.setString(4, appt.getPatientName());
            stmt.setString(5, appt.getPatientContact());
            stmt.setString(6, appt.getPatientEmail());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Get all appointments
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments ORDER BY appointment_date DESC, appointment_time DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getInt("id"));
                appt.setDoctor(rs.getString("doctor"));
                appt.setAppointmentDate(rs.getDate("appointment_date"));
                appt.setAppointmentTime(rs.getTime("appointment_time"));
                appt.setPatientName(rs.getString("patient_name"));
                appt.setPatientContact(rs.getString("patient_contact"));
                appt.setPatientEmail(rs.getString("patient_email"));

                list.add(appt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. Get appointment by ID
    public Appointment getAppointmentById(int id) {
        String sql = "SELECT * FROM appointments WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getInt("id"));
                appt.setDoctor(rs.getString("doctor"));
                appt.setAppointmentDate(rs.getDate("appointment_date"));
                appt.setAppointmentTime(rs.getTime("appointment_time"));
                appt.setPatientName(rs.getString("patient_name"));
                appt.setPatientContact(rs.getString("patient_contact"));
                appt.setPatientEmail(rs.getString("patient_email"));

                return appt;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // 4. Update appointment
    public boolean updateAppointment(Appointment appt) {
        String sql = "UPDATE appointments SET doctor = ?, appointment_date = ?, appointment_time = ?, patient_name = ?, patient_contact = ?, patient_email = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, appt.getDoctor());
            stmt.setDate(2, appt.getAppointmentDate());
            stmt.setTime(3, appt.getAppointmentTime());
            stmt.setString(4, appt.getPatientName());
            stmt.setString(5, appt.getPatientContact());
            stmt.setString(6, appt.getPatientEmail());
            stmt.setInt(7, appt.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Delete appointment
    public boolean deleteAppointment(int id) {
        String sql = "DELETE FROM appointments WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

