/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.GeneralDAO;
import entity.Account;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MSI
 */
@WebServlet(name = "SignUpController", urlPatterns = {"/signup"})
public class SignUpController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("onlineUser")!= null) {
            response.sendRedirect("chatroom");
            return;
        }else {
            response.sendRedirect("signin");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("onlineUser")!= null) {
            response.sendRedirect("chatroom");
            return;
        }
        try {
            String email = request.getParameter("email");
            if (email == null) response.sendRedirect("signin");
            String password = request.getParameter("password");
            String username = request.getParameter("username");
            String lname = request.getParameter("lname");
            String fname = request.getParameter("fname");
            String remail = request.getParameter("remail");
            String genderStr = request.getParameter("gender");
            
            String emailLabel = null;
            String usernameLabel = null;
            
            GeneralDAO dao = new GeneralDAO();
            
            if (dao.getAccountByEmail(email)!=null) {
                emailLabel = "This email has been registered";
            }else if(dao.getAccountByUsername(username)!=null){
                usernameLabel = "This username has been registered";
            }
            
            if (emailLabel != null || usernameLabel != null) {
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.setAttribute("lname", lname);
                request.setAttribute("fname", fname);
                request.setAttribute("remail", remail);
                request.setAttribute("genderStr", genderStr);
                request.setAttribute("emailLabel", emailLabel);
                request.setAttribute("usernameLabel", usernameLabel);
                request.getRequestDispatcher("/WEB-INF/signin.jsp").forward(request, response);
            }else {
                dao.addAccount(new Account(email, password, username, fname, lname, 
                        genderStr.equals("male"), new java.sql.Date(new Date().getTime())));
                response.sendRedirect("signin");
            }
            
        } catch (Exception e) {
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
