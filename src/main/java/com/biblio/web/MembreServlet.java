package com.biblio.web;

import com.biblio.services.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/membres")
public class MembreServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB private UserService userService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");

        if ("delete".equals(action)) {
            userService.supprimer(Long.parseLong(request.getParameter("id")));
        }

        if (search != null && !search.isEmpty()) {
            request.setAttribute("membres", userService.rechercherParNom(search));
        } else {
            request.setAttribute("membres", userService.listerTousLesMembres());
        }
        request.getRequestDispatcher("/admin/gestion_membres.jsp").forward(request, response);
    }
}