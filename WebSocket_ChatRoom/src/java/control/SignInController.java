/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.GeneralDAO;
import entity.Account;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MSI
 */
@WebServlet(name = "SignInController", urlPatterns = {"/signin"})
public class SignInController extends HttpServlet {

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
        if (request.getSession().getAttribute("onlineUser")!= null) {
            response.sendRedirect("chatroom");
        }else {
            request.getRequestDispatcher("/WEB-INF/signin.jsp").forward(request, response);
        }
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
        //if there is online uesr
        if (request.getSession().getAttribute("onlineUser")!= null) {
            response.sendRedirect("chatroom");
            return;
        }
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            String errorLb=null;
            
            GeneralDAO dao = new GeneralDAO();
            
            Account logInAccount = dao.getAccountByEmail(email);
            if (logInAccount==null) {
                logInAccount = dao.getAccountByUsername(email);
            }
            if (logInAccount==null) {
                errorLb = "Username not registered";
            }else {
                if (!password.equals(logInAccount.getPassword())) {
                    errorLb = "Wrong password";
                }
            }
            
            //if there is error
            if (errorLb != null) {
                request.setAttribute("errorLb", errorLb);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.getRequestDispatcher("/WEB-INF/signin.jsp").forward(request, response);
            }else {
                request.getSession().setAttribute("onlineUser", logInAccount);
                response.sendRedirect("chatroom");
            }
            
        }catch(Exception e) {
            e.printStackTrace();
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
