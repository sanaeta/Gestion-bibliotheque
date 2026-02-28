package com.biblio.web;

import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import com.biblio.services.EmpruntService;
import com.biblio.entities.Utilisateur;
import com.biblio.entities.Emprunt;

// ✅ MODIFICATION 1 : Support des deux URLs pour éviter le 404
@WebServlet(urlPatterns = {"/emprunter", "/emprunts"}) 
public class EmpruntServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private EmpruntService empruntService;
   	
    @PersistenceContext(unitName = "LibraryPU")
    private EntityManager em;

    // ✅ MODIFICATION 2 : Ajout du doGet pour régler l'erreur 405
    // Cette méthode s'exécute quand on clique sur le lien "Mes Livres"
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Utilisateur userConnecte = (Utilisateur) session.getAttribute("userSession");

        if (userConnecte != null && "mes_livres".equals(action)) {
            // On charge les livres empruntés par l'étudiant
            List<Emprunt> liste = empruntService.getEmpruntsByUser(userConnecte.getId());
            request.setAttribute("mesEmprunts", liste);
            
            // On affiche la page
            request.getRequestDispatcher("/client/mes_emprunts.jsp").forward(request, response);
        } else {
            // Si pas connecté, retour au login
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    // Cette méthode s'exécute quand on clique sur le bouton "EMPRUNTER" du catalogue
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
   
        String livreIdStr = request.getParameter("livreId");
        HttpSession session = request.getSession();
        Utilisateur userConnecte = (Utilisateur) session.getAttribute("userSession");
        
        if (userConnecte == null) {
            response.sendRedirect("login.jsp");
            return;
        } 

        try {
            Long idLivre = Long.parseLong(livreIdStr);
            Long idUser = userConnecte.getId();

            // Exécution de l'emprunt (Logique de Sanae)
            empruntService.effectuerEmprunt(idUser, idLivre);

            // ✅ MODIFICATION 3 : Redirection vers l'URL correcte après succès
            response.sendRedirect(request.getContextPath() + "/emprunts?action=mes_livres");

        } catch (Exception e) {
            // En cas d'erreur (ex: stock vide), retour au catalogue avec le message
            response.sendRedirect(request.getContextPath() + "/livres?action=catalogue&erreur=" + e.getMessage());
        }
    }
}