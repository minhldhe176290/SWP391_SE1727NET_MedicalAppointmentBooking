/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import dal.DoctorDAO;
import dal.ServicesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Doctor;
import model.Service;
import utils.SessionUtils;

/**
 *
 * @author PC
 */
public class ServiceDetailController extends HttpServlet {

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

            ServicesDAO servicedao = new ServicesDAO();
            DoctorDAO doctordao = new DoctorDAO();
            String action = request.getParameter("action");
            
            if (action != null && action.equals("view-detail")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int cateid = Integer.parseInt(request.getParameter("category_id"));
                Service serviceDetail = new Service();
                List<Service> sList = servicedao.getRelatedService(cateid,id);
                List<Doctor> doctorList = doctordao.getAllDoctor();
                serviceDetail = servicedao.getServiceById(id);
                request.setAttribute("Lists", sList);
                request.setAttribute("doctors", doctorList);
                request.setAttribute("serviceDetail", serviceDetail);
                request.getRequestDispatcher("frontend/view/servicedetail.jsp").forward(request, response);
                return;
            }
            if (action != null && action.equals("book-service")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Service serviceDetail = servicedao.getServiceById(id);
                SessionUtils.getInstance().putValue(request, "chosen_service", serviceDetail);
                request.getRequestDispatcher("booking?action=form-filling").forward(request, response);
                return;
            }

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
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
