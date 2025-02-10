/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package reports;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Windows
 */
public class ReportDAO {

    // Lấy tất cả các báo cáo
    public List<ReportDTO> getAllReports() throws Exception {
        List<ReportDTO> reports = new ArrayList<>();
        String sql = "SELECT reportID, centerID, reportDate, totalAppointments,totalRevenue FROM tblReports";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReportDTO report = new ReportDTO(
                    rs.getInt("reportID"),
                    rs.getInt("centerID"),
                    rs.getString("reportDate"),
                    rs.getInt("totalAppointments"),
                    rs.getDouble("totalRevenue")
                );
                reports.add(report);
            }
        }
        return reports;
    }

    // Thêm báo cáo mới
    public boolean addReport(ReportDTO report) throws Exception {
        String sql = "INSERT INTO tblReports(reportID, centerID, reportDate, totalAppointments, totalRevenue) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, report.getReportID());
            ps.setInt(2, report.getCenterID());
            ps.setString(3, report.getReportDate());
            ps.setInt(4, report.getTotalAppointments());
            ps.setDouble(5, report.getTotalRevenue());
            
            return ps.executeUpdate() > 0;
        }
    }
}
