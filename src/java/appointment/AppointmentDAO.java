package appointment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class AppointmentDAO {

    // Lấy tất cả các cuộc hẹn
    public List<AppointmentDTO> getAllAppointments() throws Exception {
        List<AppointmentDTO> appointments = new ArrayList<>();
        String sql = "SELECT * FROM tblAppointments";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AppointmentDTO appointment = new AppointmentDTO(
                        rs.getInt("appointmentID"),
                        rs.getInt("childID"),
                        rs.getInt("centerID"),
                        rs.getDate("appointmentDate"),
                        rs.getString("serviceType"),
                        rs.getString("notificationStatus"),
                        rs.getString("status")
                );
                appointments.add(appointment);
            }
        }
        return appointments;
    }

    public boolean addAppointment(AppointmentDTO appointment) throws Exception {
    String sql = "INSERT INTO tblAppointments (childID, centerID, appointmentDate, serviceType, notificationStatus, status) VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection conn = DBUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, appointment.getChildID());
        ps.setInt(2, appointment.getCenterID());
        ps.setDate(3, new java.sql.Date(appointment.getAppointmentDate().getTime())); // Fix lỗi
        ps.setString(4, appointment.getServiceType());
        ps.setString(5, appointment.getNotificationStatus());
        ps.setString(6, appointment.getStatus());

        return ps.executeUpdate() > 0;
    }
}


    // Cập nhật trạng thái thông báo
    public boolean updateNotificationStatus(int appointmentID, String status) throws Exception {
        String sql = "UPDATE tblAppointments SET notificationStatus = ? WHERE appointmentID = ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, appointmentID);

            return ps.executeUpdate() > 0;
        }
    }

    // Tìm cuộc hẹn theo ID
    public AppointmentDTO findAppointmentById(int appointmentID) throws Exception {
        String sql = "SELECT * FROM tblAppointments WHERE appointmentID = ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appointmentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new AppointmentDTO(
                            rs.getInt("appointmentID"),
                            rs.getInt("childID"),
                            rs.getInt("centerID"),
                            rs.getDate("appointmentDate"),
                            rs.getString("serviceType"),
                            rs.getString("notificationStatus"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }
}
