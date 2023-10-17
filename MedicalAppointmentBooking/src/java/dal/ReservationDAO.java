/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dbContext.DBConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Appointment;
import model.Patient;
import model.Reservation;
import model.Service;
import model.UserAccount;

/**
 *
 * @author Admin
 */
public class ReservationDAO {

    DBConnection dbc = new DBConnection();
    private ServicesDAO sDAO = new ServicesDAO();
    private PatientDAO pDAO = new PatientDAO();

    public List<Reservation> getWatingReservation() {
        List<Reservation> list = new ArrayList<>();
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        String sql = "select * from reservations where reservation_status = 'PENDING'";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("reservation_id");
                String note = rs.getString("reservation_note");
                Date date = rs.getDate("reservation_date");
                String time = rs.getString("reservation_time");
                String result = rs.getString("test_result");
                String status = rs.getString("reservation_status");
                int serviceId = rs.getInt("service_id");
                Service service = sDAO.getServiceById(serviceId);
                System.out.println(service);
                int patientId = rs.getInt("patient_id");
                Patient patient = pDAO.getPatientById(patientId);
                Reservation resv = new Reservation(id, note, date, time, result, status, service, patient);
                list.add(resv);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
        return list;
    }

    public void insertNewReservation(Reservation resv) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "INSERT INTO `mabs`.`reservations`\n"
                + "(\n"
                + "`reservation_note`,\n"
                + "`reservation_date`,\n"
                + "`reservation_time`,\n"
                + "`reservation_status`,\n"
                + "`service_id`,\n"
                + "`patient_id`)\n"
                + "VALUES\n"
                + "(? ,?,?,?,?,?);";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, resv.getResvNote());
            ps.setDate(2, resv.getResvDate());
            ps.setString(3, resv.getResvTime());
            ps.setString(4, resv.getStatus());
            ps.setInt(5, resv.getService().getService_id());
            ps.setInt(6, resv.getPatient().getPatientId());
            ps.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
    }

    public void assignReservation(int resvId, UserAccount account) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`reservation_status` = 'CONFIRMED',\n"
                + "`staff_id` = ? "
                + "WHERE `reservation_id` =?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, account.getUserId());
            ps.setInt(2, resvId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
    }

    public void cancelReservation(int resvId, UserAccount account) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`reservation_status` = ?,\n"
                + "`staff_id` = ? "
                + "WHERE `reservation_id` =?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, "REJECTED");
            ps.setInt(2, account.getUserId());
            ps.setInt(3, resvId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
    }
    private final int MAX_APPOINTMENT = 2;

    public boolean checkAvailability(Reservation resv) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) AS appointment_count\n"
                + "FROM appointments\n"
                + "WHERE service_id = ? AND reservation_date = ? AND reservation_time = ? ";
        try {
            connection = dbc.getConnection();
            ps.setInt(1, resv.getService().getService_id());
            ps.setDate(2, resv.getResvDate());
            ps.setString(3, resv.getResvTime());
            rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) >= MAX_APPOINTMENT) {
                    return false;
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
        return true;
    }

}
