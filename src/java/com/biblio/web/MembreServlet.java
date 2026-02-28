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
        String idParam = request.getParameter("id");

        // --- CAS 1 : AJOUT ---
        if ("add".equals(action)) {
            request.getRequestDispatcher("/admin/form_membre.jsp").forward(request, response);
            return; // ARRÊTE TOUT ET AFFICHE LE FORMULAIRE
        } 

        // --- CAS 2 : ÉDITION (MODIFICATION) ---
        if ("edit".equals(action)) {
            if (idParam != null && !idParam.isEmpty()) {
                Long id = Long.parseLong(idParam);
                Utilisateur m = userService.trouver(id);
                
                if (m != null) {
                    request.setAttribute("membre", m); // On envoie l'objet à la JSP
                    request.getRequestDispatcher("/admin/form_membre.jsp").forward(request, response);
                    return; // ARRÊTE TOUT ET AFFICHE LE FORMULAIRE
                }
            }
        } 

        // --- CAS 3 : SUPPRESSION ---
        if ("delete".equals(action)) {
            if (idParam != null) {
                userService.supprimer(Long.parseLong(idParam));
            }
            response.sendRedirect("membres"); // On recharge la liste
            return; 
        }

        // --- PAR DÉFAUT : LA LISTE ---
        // Si on arrive ici, c'est qu'aucune action (add, edit, delete) n'a été trouvée
        String search = request.getParameter("search");
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