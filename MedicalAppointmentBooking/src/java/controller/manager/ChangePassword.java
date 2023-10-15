/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserAccount;

/**
 *
 * @author ngocq
 */
public class ChangePassword extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("frontend/template/view/changepass.jsp").forward(request, response);

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
        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession();
        UserAccount curAcc = ((UserAccount) session.getAttribute("account"));
        String oldpassword = request.getParameter("oldPassword");
        String newpassword = request.getParameter("password");
        String confirmpassword = request.getParameter("rePassword");
        response.getWriter().print(curAcc.getPassword());
        response.getWriter().print(oldpassword);
        response.getWriter().print(curAcc.getPassword() != oldpassword);
        response.getWriter().print(!curAcc.getPassword().equals(oldpassword));

        if (oldpassword.equals("") || newpassword.equals("") || confirmpassword.equals("")) {
            request.setAttribute("error", "Please enter 2 identical passwords!");

            request.getRequestDispatcher("frontend/template/view/changepass.jsp").forward(request, response);
        } else if (!curAcc.getPassword().equals(oldpassword.trim())) {
            request.setAttribute("error", "Old password is not correct!");
            request.getRequestDispatcher("frontend/template/view/changepass.jsp").forward(request, response);

        } else if (!newpassword.equals(confirmpassword)) {
            request.setAttribute("error", "Please enter 2 identical passwords!");
            request.getRequestDispatcher("frontend/template/view/changepass.jsp").forward(request, response);

        } else {
            dao.updatePassword(curAcc, newpassword.trim());
            request.setAttribute("mess", "Change password successfully!");
            request.getRequestDispatcher("frontend/template/view/changepass.jsp").forward(request, response);

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
