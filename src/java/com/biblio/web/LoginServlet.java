package com.biblio.web;

import com.biblio.entities.Utilisateur;
import com.biblio.services.AuthService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB private AuthService authService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String roleForm = request.getParameter("role");

        Utilisateur user = authService.login(email, pass);

        if (user != null && user.getRole().equals(roleForm)) {
            request.getSession().setAttribute("userSession", user);
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/livres?action=dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/livres?action=dashboard");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}