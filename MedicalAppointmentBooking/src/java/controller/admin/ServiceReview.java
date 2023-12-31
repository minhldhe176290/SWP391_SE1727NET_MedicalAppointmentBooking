/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.ServicesDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
public class ServiceReview extends HttpServlet {

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
        String action = request.getParameter("action");      
        ServicesDAO sv = new ServicesDAO();
        request.setAttribute("serviceList", sv.getAllService());
        if (action != null && action.equals("view-all")) {
            request.setAttribute("review", sv.getServiceReview());
            request.getRequestDispatcher("frontend/view/servicereview.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("filter")) {
            int serId = Integer.parseInt(request.getParameter("service_id"));
            request.setAttribute("review", sv.getServiceReviewById(serId));
            request.getRequestDispatcher("frontend/view/servicereview.jsp").forward(request, response);
            return;
        } 
         if (action != null && action.equals("sort")) {
            String sortby = request.getParameter("sortby");
            if(sortby.equalsIgnoreCase("Newest"))
            {
                request.setAttribute("review", sv.getServiceReviewDESC());
                request.getRequestDispatcher("frontend/view/servicereview.jsp").forward(request, response);
            }else{
                request.setAttribute("review", sv.getServiceReviewASC());
                request.getRequestDispatcher("frontend/view/servicereview.jsp").forward(request, response);
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
