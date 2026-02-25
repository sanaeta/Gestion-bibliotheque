package com.biblio.web;

import com.biblio.entities.Utilisateur;
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
        if ("add".equals(action)) {
            // 1. Si on veut ajouter, on ouvre le formulaire vide
            request.getRequestDispatcher("/admin/form_membre.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // 2. Si on veut éditer, on cherche le membre et on l'envoie au formulaire
            Long id = Long.parseLong(request.getParameter("id"));
            Utilisateur m = userService.trouver(id); // Utilise ton EJB pour trouver le membre
            request.setAttribute("membre", m);
            request.getRequestDispatcher("/admin/form_membre.jsp").forward(request, response);
        } 
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