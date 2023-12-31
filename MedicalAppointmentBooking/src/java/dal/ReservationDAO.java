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
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Patient;
import model.Reservation;
import model.Service;
import utils.TimeUtil;

/**
 *
 * @author Admin
 */
public class ReservationDAO {

    DBConnection dbc = new DBConnection();
    private ServicesDAO sDAO = new ServicesDAO();
    private PatientDAO pDAO = new PatientDAO();

    public List<Reservation> getAllReservation() {
        List<Reservation> list = new ArrayList<>();
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        String sql = "select * from reservations ORDER BY reservation_date ASC , reservation_time ASC";
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

    public List<Reservation> getListByPage(List<Reservation> list, int start, int end) {
        List<Reservation> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
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
                + "`created_time`,\n"
                + "`service_id`,\n"
                + "`patient_id`)\n"
                + "VALUES\n"
                + "(? ,?,?,?,?,?,?);";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, resv.getResvNote());
            ps.setDate(2, resv.getResvDate());
            ps.setString(3, resv.getResvTime());
            ps.setString(4, resv.getStatus());
            ps.setTimestamp(5, resv.getCreatedTime());
            ps.setInt(6, resv.getService().getService_id());
            ps.setInt(7, resv.getPatient().getPatientId());
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

    public List<String> getAvailableTimeSlot(int patientId, int serviceId, String date) {
        PreparedStatement ps = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        Connection connection = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        List<String> timeSlot = new ArrayList<>();
        List<String> remainingTimeSlots = new ArrayList<>();
        timeSlot.add("07:00:00");
        timeSlot.add("08:00:00");
        timeSlot.add("09:00:00");
        timeSlot.add("10:00:00");
        timeSlot.add("11:00:00");
        timeSlot.add("13:00:00");
        timeSlot.add("14:00:00");
        timeSlot.add("15:00:00");
        timeSlot.add("16:00:00");
        timeSlot.add("17:00:00");
        String sql = "SELECT reservation_time\n"
                + "FROM reservations\n"
                + "WHERE service_id = ? AND reservation_date = ?"
                + "and reservation_status in ('PENDING' , 'RESCHEDULING' , 'RESCHEDULED', 'CONFIRMED')";
        String sql1 = "select appointment_time from appointments "
                + "where patient_id = ?  and appointment_date = ? "
                + " and appointment_status in ('PENDING' , 'RESCHEDULING' , 'RESCHEDULED', 'CONFIRMED')";
        String sql2 = "select reservation_time from reservations where patient_id = ?  and reservation_date = ?"
                + "and reservation_status in ('PENDING' , 'RESCHEDULING' , 'RESCHEDULED', 'CONFIRMED')";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setDate(2, TimeUtil.dateConverter1(date));
            ps.setInt(1, serviceId);
            rs = ps.executeQuery();
            //------------------------
            ps1 = connection.prepareStatement(sql1);
            ps1.setInt(1, patientId);
            ps1.setDate(2, TimeUtil.dateConverter1(date));
            rs1 = ps1.executeQuery();
            //------------------------
            ps2 = connection.prepareStatement(sql2);
            ps2.setInt(1, patientId);
            ps2.setDate(2, TimeUtil.dateConverter1(date));
            rs2 = ps2.executeQuery();
            while (rs.next()) {
                if (timeSlot.contains(rs.getString(1))) {
                    timeSlot.remove(rs.getString(1));
                }
            }
            while (rs1.next()) {
                if (timeSlot.contains(rs1.getString(1))) {
                    timeSlot.remove(rs1.getString(1));
                }
            }
            while (rs2.next()) {
                if (timeSlot.contains(rs2.getString(1))) {
                    timeSlot.remove(rs2.getString(1));
                }
            }

            List<String> bookedAppointmentInDay = getBookedAppointmentSlotTime(patientId, date);
            for (String s : bookedAppointmentInDay) {
                timeSlot.remove(s);
            }
            LocalDate parsedDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate currentDate = LocalDate.now();
            if (parsedDate.isEqual(currentDate)) {
                LocalTime currentTime = LocalTime.now();
                for (String time : timeSlot) {
                    LocalTime slotTime = LocalTime.parse(time);
                    if (currentTime.isBefore(slotTime)) {
                        remainingTimeSlots.add(time);
                    }
                }
                return remainingTimeSlots;
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
        return timeSlot;
    }

    public List<String> getBookedAppointmentSlotTime(int patientId, String date) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        List<String> resultList = new ArrayList<>();
        String sql = "Select appointment_time from appointments where patient_id = ?"
                + " and appointment_date = ? and appointment_status not in ('CANCELLED')";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, patientId);
            ps.setDate(2, TimeUtil.dateConverter1(date));
            rs = ps.executeQuery();
            while (rs.next()) {
                resultList.add(rs.getString("appointment_time"));
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
        return resultList;
    }

    public void updateStatus(Reservation resv) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`reservation_status` = ?\n"
                + "WHERE `reservation_id` = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, resv.getStatus());
            ps.setInt(2, resv.getResvId());
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

    public void rejectReservation(Reservation resv) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`reservation_status` = ?,\n"
                + "`reject_reason` = ?\n"
                + "WHERE `reservation_id` = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, resv.getStatus());
            ps.setString(2, resv.getRejectReason());
            ps.setInt(3, resv.getResvId());
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

    public List<Reservation> getFilteredReservationList(String text) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        List<Reservation> listResv = new ArrayList<>();
        String sql = "select resv.* from reservations resv \n"
                + "INNER JOIN patients p on p.patient_id = resv.patient_id\n"
                + "INNER JOIN user_account u on u.user_id = p.user_id\n"
                + "where resv.reservation_status = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, text);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("reservation_id");
                String note = rs.getString("reservation_note");
                Date date = rs.getDate("reservation_date");
                String time = rs.getString("reservation_time");
                String diagnosis = rs.getString("test_result");
                String status = rs.getString("reservation_status");
                int serviceId = rs.getInt("service_id");
                Service s = sDAO.getServiceById(serviceId);
                int patientId = rs.getInt("patient_id");
                Patient patient = pDAO.getPatientById(patientId);
                Reservation resv = new Reservation(id, note, date, time, diagnosis, status, s, patient);
                listResv.add(resv);
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
        return listResv;
    }

    public List<Reservation> searchReservationByPatientName(String text) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        List<Reservation> listResv = new ArrayList<>();
        String sql = "select resv.* from reservations resv \n"
                + "INNER JOIN patients p on p.patient_id = resv.patient_id\n"
                + "INNER JOIN user_account u on u.user_id = p.user_id\n"
                + "where u.full_name like ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + text + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("reservation_id");
                String note = rs.getString("reservation_note");
                Date date = rs.getDate("reservation_date");
                String time = rs.getString("reservation_time");
                String diagnosis = rs.getString("test_result");
                String status = rs.getString("reservation_status");
                int serviceId = rs.getInt("service_id");
                Service s = sDAO.getServiceById(serviceId);
                int patientId = rs.getInt("patient_id");
                Patient patient = pDAO.getPatientById(patientId);
                Reservation resv = new Reservation(id, note, date, time, diagnosis, status, s, patient);
                listResv.add(resv);
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
        return listResv;
    }

    public Reservation getReservationById(int resvId) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        String sql = "select resv.* from reservations resv where resv.reservation_id = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, resvId);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("reservation_id");
                String note = rs.getString("reservation_note");
                Date date = rs.getDate("reservation_date");
                String time = rs.getString("reservation_time");
                String diagnosis = rs.getString("test_result");
                String status = rs.getString("reservation_status");
                int serviceId = rs.getInt("service_id");
                Service s = sDAO.getServiceById(serviceId);
                int patientId = rs.getInt("patient_id");
                Patient patient = pDAO.getPatientById(patientId);
                Reservation resv = new Reservation(id, note, date, time, diagnosis, status, s, patient);
                return resv;
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
        return null;
    }

    public void rescheduleReservation(Reservation reservation) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`reservation_date` = ?,\n"
                + "`reservation_time` = ?\n"
                + "WHERE `reservation_id` = ?;";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setDate(1, reservation.getResvDate());
            ps.setString(2, reservation.getResvTime());
            ps.setInt(3, reservation.getResvId());
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

    public void rescheduleReservationForPatient(Reservation reservation) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`reservation_date` = ?,\n"
                + "`reservation_time` = ?,\n"
                + "`reservation_status` = ?,\n"
                + "`updated_time` = ?,\n"
                + "`other_charge` = ?\n"
                + "WHERE `reservation_id` = ?;";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setDate(1, reservation.getResvDate());
            ps.setString(2, reservation.getResvTime());
            ps.setString(3, reservation.getStatus());
            ps.setTimestamp(4, reservation.getUpdatedTime());
            ps.setDouble(5, reservation.getOtherCharge());
            ps.setInt(6, reservation.getResvId());
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

    public void deleteRecord(int resvId) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "delete from reservations where reservation_id = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, resvId);
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

    public List<Reservation> getPatientReservationByUserId(int userId) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        List<Reservation> listResv = new ArrayList<>();
        String sql = "select * from reservations resv\n"
                + "inner join patients p on p.patient_id = resv.patient_id \n"
                + "inner join user_account ua on ua.user_id = p.user_id\n"
                + "where ua.user_id = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("reservation_id");
                Reservation resv = getReservationById(id);
                listResv.add(resv);
            }
            return listResv;
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
        return null;
    }

    public List<Reservation> getFilteredPatientReservation(int userId, String status) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        List<Reservation> listResv = new ArrayList<>();
        String sql = "select * from reservations resv\n"
                + "inner join patients p on p.patient_id = resv.patient_id \n"
                + "inner join user_account ua on ua.user_id = p.user_id\n"
                + "where ua.user_id = ? "
                + "and resv.reservation_status = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("reservation_id");
                Reservation appt = getReservationById(id);
                listResv.add(appt);
            }
            return listResv;
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
        return null;
    }

    private final int MAX_LIMIT_TIME_PER_MONTH = 2;

    public boolean checkLimitedTime(Reservation resv, String status1, String status2) {
        PreparedStatement ps = null;
        Connection connection = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) AS resv_count\n"
                + "FROM reservations\n"
                + "WHERE patient_id = ? AND (reservation_status = ? OR reservation_status = ? ) AND MONTH(updated_time) = MONTH(CURDATE()) ;";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, resv.getPatient().getPatientId());
            ps.setString(2, status1);
            ps.setString(3, status2);
            rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) >= MAX_LIMIT_TIME_PER_MONTH) {
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

    public void updateTime(Reservation resv) {
        PreparedStatement ps = null;
        Connection connection = null;
        String sql = "UPDATE `mabs`.`reservations`\n"
                + "SET\n"
                + "`updated_time` = ?\n"
                + "WHERE `reservation_id` = ?";
        try {
            connection = dbc.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setTimestamp(1, resv.getUpdatedTime());
            ps.setInt(2, resv.getResvId());
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
}
