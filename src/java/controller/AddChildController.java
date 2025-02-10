package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import registration.RegistrationDAO;
import registration.RegistrationDTO;

@WebServlet(name = "AddChildController", urlPatterns = {"/AddChildController"})
public class AddChildController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            // Lấy thông tin từ form
            String childName = request.getParameter("childName");
            String dateOfBirth = request.getParameter("dateOfBirth"); // Sửa lại tên parameter
            String gender = request.getParameter("gender");
            String appointmentDate = request.getParameter("appointmentDate");
            String appointmentTime = request.getParameter("selectedTime");
            String[] vaccineIds = request.getParameterValues("selectedVaccines");

            // Validate dữ liệu đầu vào
            if (childName == null || childName.trim().isEmpty()
                    || dateOfBirth == null || dateOfBirth.trim().isEmpty()
                    || gender == null || gender.trim().isEmpty()
                    || appointmentDate == null || appointmentDate.trim().isEmpty()
                    || appointmentTime == null || appointmentTime.trim().isEmpty()
                    || vaccineIds == null || vaccineIds.length == 0) {

                jsonResponse.put("success", false);
                jsonResponse.put("message", "Vui lòng điền đầy đủ thông tin");
                String json = String.format("{\"success\":false,\"message\":\"%s\"}", "Vui lòng điền đầy đủ thông tin");
                out.print(json);
                return;
            }

            // Tạo đối tượng RegistrationDTO
            RegistrationDTO registration = new RegistrationDTO();
            registration.setChildName(childName);
            registration.setDateOfBirth(Date.valueOf(dateOfBirth));
            registration.setGender(gender);
            registration.setAppointmentDate(Date.valueOf(appointmentDate));
            registration.setAppointmentTime(appointmentTime);
            registration.setStatus("Pending");

            // Xử lý danh sách vaccine
            List<Integer> selectedVaccines = new ArrayList<>();
            for (String id : vaccineIds) {
                selectedVaccines.add(Integer.parseInt(id));
            }
            registration.setSelectedVaccines(selectedVaccines);

            // Lưu vào database
            RegistrationDAO dao = new RegistrationDAO();
            int registrationId = dao.addRegistration(registration);

            if (registrationId > 0) {
                // Lưu vào session
                request.getSession().setAttribute("REGISTRATION_INFO", registration);
                request.getSession().setAttribute("REGISTRATION_ID", registrationId);

                // Tạo JSON response thành công
                String json = String.format(
                        "{\"success\":true,\"registrationId\":%d,\"message\":\"%s\"}",
                        registrationId,
                        "Đăng ký thành công"
                );
                out.print(json);
            } else {
                // Tạo JSON response thất bại
                String json = String.format(
                        "{\"success\":false,\"message\":\"%s\"}",
                        "Đăng ký thất bại"
                );
                out.print(json);
            }

        } catch (Exception e) {
            // Tạo JSON response lỗi
            String json = String.format(
                    "{\"success\":false,\"message\":\"%s\"}",
                    "Có lỗi xảy ra: " + e.getMessage()
            );
            out.print(json);
            log("Error at AddChildController: " + e.toString());
        } finally {
            out.flush();

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
}
