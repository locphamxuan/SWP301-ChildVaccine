package registration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import utils.DBUtils;
import vaccine.VaccineDAO;

public class RegistrationDAO {

    private static final String INSERT_REGISTRATION
            = "INSERT INTO tblRegistration (childName, dateOfBirth, gender, parentName, "
            + "parentPhone, appointmentDate, appointmentTime, status) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_REGISTRATION_DETAIL
            = "INSERT INTO tblRegistrationDetail (registrationID, vaccineID, price) "
            + "VALUES (?, ?, ?)";

    public int addRegistration(RegistrationDTO registration) throws Exception {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        int registrationID = -1;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                // Bắt đầu transaction
                conn.setAutoCommit(false);

                // Insert vào bảng Registration
                ptm = conn.prepareStatement(INSERT_REGISTRATION,
                        Statement.RETURN_GENERATED_KEYS);
                ptm.setString(1, registration.getChildName());
                ptm.setDate(2, registration.getDateOfBirth());
                ptm.setString(3, registration.getGender());
                ptm.setString(4, registration.getParentName());
                ptm.setString(5, registration.getParentPhone());
                ptm.setDate(6, registration.getAppointmentDate());
                ptm.setString(7, registration.getAppointmentTime());
                ptm.setString(8, "Pending");

                int rowsAffected = ptm.executeUpdate();

                // Lấy registrationID vừa được tạo
                if (rowsAffected > 0) {
                    rs = ptm.getGeneratedKeys();

                    if (rs.next()) {
                        registrationID = rs.getInt(1);
                        registration.setRegistrationID(registrationID);

                        // Insert chi tiết vaccine
                        VaccineDAO vaccineDAO = new VaccineDAO();
                        double totalAmount = 0;

                        for (Integer vaccineID : registration.getSelectedVaccines()) {
                            PreparedStatement ptmDetail = conn.prepareStatement(
                                    INSERT_REGISTRATION_DETAIL);
                            ptmDetail.setInt(1, registrationID);
                            ptmDetail.setInt(2, vaccineID);

                            // Lấy giá vaccine
                            double price = vaccineDAO.getVaccineByID(vaccineID).getPrice();
                            ptmDetail.setDouble(3, price);
                            totalAmount += price;

                            ptmDetail.executeUpdate();
                            ptmDetail.close();
                        }

                        registration.setTotalAmount(totalAmount);
                    }
                }

                // Commit transaction
                conn.commit();
                return registrationID;
            }
        } catch (Exception e) {
            // Rollback nếu có lỗi
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }

        return registrationID;
    }

    public RegistrationDTO getRegistration(int registrationID) throws Exception {
        RegistrationDTO registration = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM tblRegistration WHERE registrationID = ?";
                ptm = conn.prepareStatement(sql);
                ptm.setInt(1, registrationID);
                rs = ptm.executeQuery();

                if (rs.next()) {
                    registration = new RegistrationDTO(
                            rs.getInt("registrationID"),
                            rs.getString("childName"),
                            rs.getDate("dateOfBirth"),
                            rs.getString("gender"),
                            rs.getString("parentName"),
                            rs.getString("parentPhone"),
                            rs.getDate("appointmentDate"),
                            rs.getString("appointmentTime"),
                            rs.getString("status")
                    );
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return registration;
    }

    public boolean updateStatus(int registrationID, String status) throws Exception {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblRegistration SET status = ? WHERE registrationID = ?";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, status);
                ptm.setInt(2, registrationID);

                success = ptm.executeUpdate() > 0;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return success;
    }
}
