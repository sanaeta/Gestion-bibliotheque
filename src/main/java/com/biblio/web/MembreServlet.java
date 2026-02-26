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
    private static final long serialVersionUID = 1L;
    @EJB private UserService userService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");

        // 1. Ouvrir le formulaire d'ajout
        if ("add".equals(action)) {
            request.getRequestDispatcher("/admin/form_membre.jsp").forward(request, response);
            return; // STOPPE L'EXÉCUTION ICI
        } 

        // 2. Ouvrir le formulaire d'édition avec les données
        if ("edit".equals(action)) {
            String idParam = request.getParameter("id");
            if(idParam != null) {
                Long id = Long.parseLong(idParam);
                Utilisateur m = userService.trouver(id);
                request.setAttribute("membre", m);
                request.getRequestDispatcher("/admin/form_membre.jsp").forward(request, response);
                return; // STOPPE L'EXÉCUTION ICI
            }
        } 

        // 3. Action de suppression
        if ("delete".equals(action)) {
            userService.supprimer(Long.parseLong(request.getParameter("id")));
            response.sendRedirect("membres");
            return;
        }

        // 4. Par défaut : Affichage de la liste (avec ou sans recherche)
        if (search != null && !search.isEmpty()) {
            request.setAttribute("membres", userService.rechercherParNom(search));
        } else {
            request.setAttribute("membres", userService.listerTousLesMembres());
        }
        request.getRequestDispatcher("/admin/gestion_membres.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        Utilisateur u = new Utilisateur();
        u.setNom(request.getParameter("nom"));
        u.setEmail(request.getParameter("email"));
        u.setRole("ADHERENT");

        if (idStr != null && !idStr.isEmpty()) {
            // MODE MODIFICATION
            u.setId(Long.parseLong(idStr));
            Utilisateur ancien = userService.trouver(u.getId());
            u.setPassword(ancien.getPassword()); // On garde l'ancien mot de passe
            userService.modifier(u);
        } else {
            // MODE AJOUT
            u.setPassword(request.getParameter("password"));
            userService.creer(u);
        }
        response.sendRedirect("membres");
    }
}