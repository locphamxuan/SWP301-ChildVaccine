package appointmentDetails;

import appointmentDetails.AppointmentDetailDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class AppointmentDetailDAO {

    // Lấy danh sách chi tiết lịch hẹn theo appointmentID
    public List<AppointmentDetailDTO> getAppointmentDetailsByAppointmentID(int appointmentID) throws Exception {
        List<AppointmentDetailDTO> details = new ArrayList<>();
        String sql = "SELECT appointmentDetailID, appointmentID, vaccineID, doseNumber FROM tblAppointmentDetails WHERE appointmentID = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appointmentID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AppointmentDetailDTO detail = new AppointmentDetailDTO(
                        rs.getInt("detailID"),
                        rs.getInt("appointmentID"),
                        rs.getInt("vaccineID"),
                        rs.getInt("doseNumber")
                    );
                    details.add(detail);
                }
            }
        }
        return details;
    }

    // Thêm chi tiết lịch hẹn mới
    public boolean addAppointmentDetail(AppointmentDetailDTO detail) throws Exception {
        String sql = "INSERT INTO tblAppointmentDetails (appointmentDetailID, appointmentID, vaccineID, doseNumber) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, detail.getAppointmentDetailID());
            ps.setInt(2, detail.getAppointmentID());
            ps.setInt(3, detail.getVaccineID());
            ps.setInt(4, detail.getDoseNumber());

            return ps.executeUpdate() > 0;
        }
    }

    // Xóa chi tiết lịch hẹn theo detailID
    public boolean deleteAppointmentDetail(int appointmentDetailID) throws Exception {
        String sql = "DELETE FROM tblAppointmentDetails WHERE appointmentDetailID = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appointmentDetailID);
            return ps.executeUpdate() > 0;
        }
    }
}
