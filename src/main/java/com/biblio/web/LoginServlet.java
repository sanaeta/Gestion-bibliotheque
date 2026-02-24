package com.biblio.web;

import com.biblio.entities.Utilisateur;
import com.biblio.services.UtilisateurService;
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
	@EJB private UtilisateurService service;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Utilisateur user = service.verifierLogin(request.getParameter("email"), request.getParameter("password"));
        if (user != null) {
            request.getSession().setAttribute("userSession", user);
            if ("ADMIN".equals(user.getRole())) response.sendRedirect("admin/gestion_membres.jsp");
            else response.sendRedirect("catalogue.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}