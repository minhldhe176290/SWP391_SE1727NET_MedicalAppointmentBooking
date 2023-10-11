/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import dal.ServicesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import static java.util.Collections.sort;
import model.Service;
import model.Service_Category;

/**
 *
 * @author PC
 */
public class ServiceController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServicesDAO servicedao = new ServicesDAO();
        String keyword = request.getParameter("keyword");
        List<Service_Category> serviceCateList;
        serviceCateList = servicedao.getAllServiceCategory();
        List<Service> serviceList;
        if (keyword != null && !keyword.isEmpty()) {
            serviceList = servicedao.searchServicesByName(keyword);
        } else {
            serviceList = servicedao.getAllService();
        }
        request.setAttribute("service_category", serviceCateList);
        request.setAttribute("services", serviceList);
        request.getRequestDispatcher("frontend/view/service.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServicesDAO servicedao = new ServicesDAO();
        String selectedCategory = request.getParameter("category");
        String selectedSort = request.getParameter("sort");
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("selectedSort", selectedSort);
        int categoryId = Integer.parseInt(request.getParameter("sc_Id"));
        String sort = request.getParameter("sort");
        List<Service> sList = new ArrayList<>();
        List<Service_Category> serviceCateList;
        serviceCateList = servicedao.getAllServiceCategory();
        if (categoryId == 0) {
            sList = servicedao.sortServiceByCategoryID(categoryId, sort);
        } else {
            sList = servicedao.sortService(categoryId, sort);
        }
        request.setAttribute("Lists", sList);
        request.setAttribute("Listsc", serviceCateList);
        request.getRequestDispatcher("frontend/view/service.jsp").forward(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
