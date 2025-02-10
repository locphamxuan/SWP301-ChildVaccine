/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vaccine.VaccineDAO;
import vaccine.VaccineDTO;

/**
 *
 * @author Windows
 */
@WebServlet(name = "VaccinationController", urlPatterns = {"/VaccinationController"})
public class VaccinationController extends HttpServlet {
    private static final String VACCINE_LIST_PAGE = "vaccinationSchedule.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Xử lý tiếng Việt

        try {
            String searchKeyword = request.getParameter("search");
            System.out.println("Search keyword: " + searchKeyword); // Log để debug
            
            VaccineDAO vaccineDAO = new VaccineDAO();
            List<VaccineDTO> vaccineList;

            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                vaccineList = vaccineDAO.search(searchKeyword.trim());
                System.out.println("Found " + vaccineList.size() + " vaccines"); // Log để debug
            } else {
                vaccineList = vaccineDAO.getAllVaccines();
            }

            request.setAttribute("vaccines", vaccineList);
            request.getRequestDispatcher(VACCINE_LIST_PAGE).forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in VaccinationController: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(VACCINE_LIST_PAGE);
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
