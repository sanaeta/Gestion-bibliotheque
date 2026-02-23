package com.biblio.web;

import com.biblio.services.UtilisateurService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/membres")
public class MembreServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB private UtilisateurService service;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, jakarta.servlet.ServletException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            service.supprimer(Long.parseLong(request.getParameter("id")));
        }
        request.setAttribute("membres", service.listerAdherents());
        request.getRequestDispatcher("/admin/gestion_membres.jsp").forward(request, response);
    }
}