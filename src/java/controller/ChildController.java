package controller;

import child.ChildDAO;
import child.ChildDTO;
import customer.CustomerDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ChildController", urlPatterns = {"/ChildController"})
public class ChildController extends HttpServlet {
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "vaccinationSchedule.jsp";
    private static final String CHILD_REGISTRATION = "childRegistration.jsp";
    private static final String LOGIN = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = ERROR;
        
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            CustomerDTO loginUser = (CustomerDTO) session.getAttribute("LOGIN_USER");
            
            if (loginUser == null) {
                request.setAttribute("ERROR_MESSAGE", "Vui lòng đăng nhập để tiếp tục!");
                url = LOGIN;
                return;
            }

            switch (action) {
                case "ShowAddChild":
                    String vaccineId = request.getParameter("vaccineId");
                    ChildDAO dao = new ChildDAO();
                    boolean hasChildren = dao.hasChildren(Integer.parseInt(loginUser.getUserID()));
                    
                    if (!hasChildren) {
                        url = CHILD_REGISTRATION;
                        if (vaccineId != null && !vaccineId.isEmpty()) {
                            url += "?vaccineId=" + vaccineId;
                        }
                    } else {
                        List<ChildDTO> childList = dao.getChildrenByCustomerID(Integer.parseInt(loginUser.getUserID()));
                        request.setAttribute("childList", childList);
                        if (vaccineId != null && !vaccineId.isEmpty()) {
                            url = "MainController?action=ShowAppointmentForm&vaccineId=" + vaccineId;
                        } else {
                            url = SUCCESS;
                        }
                    }
                    break;

                case "AddChild":
                    String fullName = request.getParameter("fullName");
                    String dateOfBirth = request.getParameter("dateOfBirth");
                    String gender = request.getParameter("gender");
                    vaccineId = request.getParameter("vaccineId");
                    int customerID = Integer.parseInt(loginUser.getUserID());

                    if (fullName == null || fullName.trim().isEmpty() ||
                        dateOfBirth == null || dateOfBirth.trim().isEmpty() ||
                        gender == null || gender.trim().isEmpty()) {
                        request.setAttribute("ERROR_MESSAGE", "Vui lòng điền đầy đủ thông tin!");
                        url = CHILD_REGISTRATION;
                        return;
                    }

                    ChildDTO child = new ChildDTO();
                    child.setCustomerID(customerID);
                    child.setFullName(fullName);
                    child.setDateOfBirth(dateOfBirth);
                    child.setGender(gender);

                    dao = new ChildDAO();
                    boolean success = dao.addChild(child);

                    if (success) {
                        session.setAttribute("HAS_CHILDREN", true);
                        request.setAttribute("SUCCESS_MESSAGE", "Đăng ký thông tin trẻ em thành công!");
                        if (vaccineId != null && !vaccineId.isEmpty()) {
                            url = "MainController?action=ShowAppointmentForm&vaccineId=" + vaccineId;
                        } else {
                            url = SUCCESS;
                        }
                    } else {
                        request.setAttribute("ERROR_MESSAGE", "Đăng ký thông tin trẻ em thất bại!");
                        url = CHILD_REGISTRATION;
                    }
                    break;

                default:
                    request.setAttribute("ERROR_MESSAGE", "Invalid action!");
                    url = ERROR;
                    break;
            }
            
        } catch (Exception e) {
            log("Error at ChildController: " + e.toString());
            request.setAttribute("ERROR_MESSAGE", "Đã xảy ra lỗi: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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