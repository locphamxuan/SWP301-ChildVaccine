package controller;

import appointment.AppointmentDAO;
import appointment.AppointmentDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AppointmentController class to handle appointment scheduling requests.
 */
@WebServlet(name = "AppointmentController", urlPatterns = {"/AppointmentController"})
public class AppointmentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            int childID = Integer.parseInt(request.getParameter("childID"));
            int centerID = Integer.parseInt(request.getParameter("centerID"));
            String appointmentDate = request.getParameter("appointmentDate");
            String serviceType = request.getParameter("serviceType");

            // Tạo đối tượng AppointmentDTO
            AppointmentDTO appointment = new AppointmentDTO();
            appointment.setChildID(childID);
            appointment.setCenterID(centerID);
//            appointment.setAppointmentDate(appointmentDate);
            appointment.setServiceType(serviceType);
            appointment.setNotificationStatus("Not pending");
            appointment.setStatus("Pending");

            // Gọi DAO để thêm vào cơ sở dữ liệu
            AppointmentDAO dao = new AppointmentDAO();
            boolean result = dao.addAppointment(appointment);

            if (result) {
                // Nếu thêm thành công, chuyển hướng đến dashboard.jsp
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("ERROR", "Failed to book appointment!");
                request.getRequestDispatcher("appointmentForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            log("Error at AppointmentController: " + e.toString());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles appointment scheduling";
    }
}
