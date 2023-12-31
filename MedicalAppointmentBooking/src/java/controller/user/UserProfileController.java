/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.DoctorDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Doctor;
import model.UserAccount;
import resource.RoleProp;
import utils.SessionUtils;

/**
 *
 * @author Admin
 */
@MultipartConfig(maxFileSize = 16177215)
public class UserProfileController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DoctorDAO doctorDAO = new DoctorDAO();
        UserDAO uDAO = new UserDAO();
        UserAccount user = (UserAccount) SessionUtils.getInstance().getValue(request, "user");
        String action = request.getParameter("action");
        if (action != null && action.equals("view")) {
            if (user.getRole().getRole_name().equals("PATIENT")) {
                request.getRequestDispatcher("frontend/view/userprofile.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("frontend/view/admin/profile.jsp").forward(request, response);
            }
            return;
        }
        if (action != null && action.equals("edit-info")) {
            Part image = request.getPart("image");
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            int gender = Integer.parseInt(request.getParameter("gender"));
            uDAO.updateAccountProfile(user.getUserId(), name, gender, email, phone, dob, address, image);
            request.setAttribute("success", "UPDATE SUCCESSFULLY");
            UserAccount newUser = uDAO.getAccountById(user.getUserId());
            if (newUser.getRole().getRole_name().equals(RoleProp.DOCTOR)) {
                Doctor doctor = doctorDAO.getDoctorByUserId(user.getUserId());
                System.out.println(doctor.getDoctorId());
                SessionUtils.getInstance().putValue(request, "user", doctor);
            } else {
                SessionUtils.getInstance().putValue(request, "user", newUser);
            }
            request.getRequestDispatcher("/user-profile?action=view").forward(request, response);
            return;
        }
        if (action != null && action.equals("change-password")) {
            String oldPassword = request.getParameter("oldpassword");
            String newPassword = request.getParameter("newpassword");
            UserAccount checkAccount = uDAO.getUserAccount(user.getUserName(), oldPassword);
            if (checkAccount == null) {
                request.setAttribute("error", "Your password is not correct!");
                request.getRequestDispatcher("/user-profile?action=view").forward(request, response);
            } else {
                uDAO.updatePassword(user, newPassword);
                SessionUtils.getInstance().removeValue(request, "user");
                request.setAttribute("success", "Change password successfully. Login again!");
                request.getRequestDispatcher("frontend/view/login.jsp").forward(request, response);
            }
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
