/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import utils.CodeProcessing;
import utils.EmailSending;
import utils.SessionUtils;
import utils.TimestampUtils;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserAccount;

/**
 *
 * @author Admin
 */
public class ForgotPasswordServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    protected UserDAO uDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TimestampUtils timeConfig = new TimestampUtils();
        String action = request.getParameter("action");
        if (action.equals("reset")) {

            UserAccount user = (UserAccount) SessionUtils.getInstance().getValue(request, "user");

            if (timeConfig.isExpired(user.getRecoveryTokenTime())) {
                request.getRequestDispatcher("frontend/view/resetpassword.jsp").forward(request, response);
            } else {
                // Tam thoi dung page404.jsp nay, xu ly sau
                response.sendRedirect("frontend/view/page404.jsp");
            }
        }
        request.getRequestDispatcher("frontend/view/forgotpassword.jsp").forward(request, response);
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

        String email = request.getParameter("email");
        String action = request.getParameter("action");
        if (action.equals("send_link")) {
            UserAccount account = uDAO.getAccountByEmail(email);
            if (account == null) {
                request.setAttribute("error", "Email address is not found in the system! Try again.");
                request.getRequestDispatcher("frontend/view/forgotpassword.jsp").forward(request, response);
            } else {
                String recoveryToken = CodeProcessing.generateToken();
                uDAO.updateRecoveryToken(recoveryToken);
                EmailSending.sendRecoverAccount(request.getContextPath() + "/forgot?action=reset&token=" + recoveryToken, email);
                request.getRequestDispatcher("frontend/view/resetpassword.jsp").forward(request, response);
            }
        } else if (action.equals("reset_password")) {
            String newpassword = request.getParameter("password");
            UserAccount account = (UserAccount) SessionUtils.getInstance().getValue(request, "user");
            uDAO.updatePassword(account, newpassword);
            request.getRequestDispatcher("login").forward(request, response);
        }
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