/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.AppointmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Appointment;

/**
 *
 * @author Admin
 */
public class AdminAppointmentList extends HttpServlet {

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
        AppointmentDAO apptDAO = new AppointmentDAO();
        if (action != null && action.equals("view")) {
            List<Appointment> apptList = apptDAO.getAllAppointment();
            request.setAttribute("apptList", apptList);
            request.getRequestDispatcher("frontend/view/admin/admin_appointment.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("view-detail")) {
            int apptId = Integer.parseInt(request.getParameter("apptId"));
            Appointment appt = apptDAO.getAppointmentById(apptId);
            request.setAttribute("appt", appt);
            request.getRequestDispatcher("frontend/view/admin/admin_appointmentdetail.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("search")) {
            String search = request.getParameter("search");
            List<Appointment> apptList = apptDAO.searchAppointmentByPatientName(search);

            request.setAttribute("apptList", apptList);
            request.getRequestDispatcher("frontend/view/admin/admin_appointment.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("filter")) {
            String filter = request.getParameter("status_filter");
            List<Appointment> apptList = null;
            if (filter.equals("all")) {
                apptList = apptDAO.getAllAppointment();
            } else {
                apptList = apptDAO.getFilteredAppointmentList(filter);
            }
            request.setAttribute("apptList", apptList);
            request.getRequestDispatcher("frontend/view/admin/admin_appointment.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("view-detail")) {
            int apptId = Integer.parseInt(request.getParameter("apptId"));
            Appointment appt = apptDAO.getAppointmentById(apptId);
            request.setAttribute("appt", appt);
            request.getRequestDispatcher("frontend/view/admin/admin_appointmentdetail.jsp").forward(request, response);
            return;
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
