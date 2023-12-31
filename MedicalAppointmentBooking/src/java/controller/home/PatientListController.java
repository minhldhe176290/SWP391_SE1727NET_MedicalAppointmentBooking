/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import dal.DoctorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.PatientDAO;
import java.util.List;
import model.Doctor;
import model.Patient;
import utils.SessionUtils;

/**
 *
 * @author nguye
 */
public class PatientListController extends HttpServlet {

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
        PatientDAO patientDAO = new PatientDAO();
        Doctor doctor = (Doctor) SessionUtils.getInstance().getValue(request, "user");
        request.setAttribute("doctor", doctor);
        if (action != null && action.equals("view-all")) {
            PatientDAO pdao = new PatientDAO();
            List<Patient> listP = pdao.getPatientByDoctorId(doctor.getDoctorId());
            request.setAttribute("listPatient", listP);
            request.getRequestDispatcher("frontend/view/admin/doctor_patientlist.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("search")) {
            String search = request.getParameter("search").trim();
            PatientDAO pdao = new PatientDAO();
            List<Patient> listP = pdao.getPatientByDoctorIdAndName(doctor.getDoctorId(), search);
            request.setAttribute("listPatient", listP);
            request.getRequestDispatcher("frontend/view/admin/doctor_patientlist.jsp").forward(request, response);
            return;
        }
        if (action != null && action.equals("view-detail")) {
            int patientID = Integer.parseInt(request.getParameter("pid"));
            Patient p = patientDAO.getPatientById(patientID);
            request.setAttribute("patient", p);
            request.getRequestDispatcher("frontend/view/admin/doctor_patientdetail.jsp").forward(request, response);

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
