package feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class FeedbackDAO {

    // Lấy danh sách tất cả phản hồi
    public List<FeedbackDTO> getAllFeedbacks() throws Exception {
        List<FeedbackDTO> feedbacks = new ArrayList<>();
        String sql = "SELECT feedbackID, customerID,centerID, feedbackText, rating, feedbackDate FROM tblFeedback";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FeedbackDTO feedback = new FeedbackDTO(
                    rs.getInt("feedbackID"),
                    rs.getInt("customerID"),
                    rs.getInt("centerID"),
                    rs.getString("feedbackText"),
                    rs.getInt("rating"),
                    rs.getDate("feedbackDate")
                );
                feedbacks.add(feedback);
            }
        }
        return feedbacks;
    }

    // Thêm phản hồi mới
    public boolean addFeedback(FeedbackDTO feedback) throws Exception {
        String sql = "INSERT INTO tblFeedback (customerID, feedbackText, feedbackDate) VALUES (?, ?, ?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, feedback.getCustomerID());
            ps.setString(2, feedback.getFeedbackText());
            ps.setDate(3, new java.sql.Date(feedback.getFeedbackDate().getTime()));

            return ps.executeUpdate() > 0;
        }
    }

    // Xóa phản hồi theo feedbackID
    public boolean deleteFeedback(int feedbackID) throws Exception {
        String sql = "DELETE FROM tblFeedback WHERE feedbackID = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, feedbackID);
            return ps.executeUpdate() > 0;
        }
    }
}
