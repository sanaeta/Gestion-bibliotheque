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

import com.biblio.services.EmpruntService;
import com.biblio.entities.Utilisateur;

@WebServlet("/emprunter") // L'URL que le bouton du formulaire va appeler
public class EmpruntServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 🚨 L'INJECTION : On demande au serveur de nous connecter au "Cerveau"
    @EJB
    private EmpruntService empruntService;
   	
	  @PersistenceContext(unitName = "LibraryPU")
	    private EntityManager em;
  

    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
   
 
        // 1. RÉCUPÉRATION DES DONNÉES
        // On récupère l'ID du livre depuis le formulaire JSP
        String livreIdStr = request.getParameter("livreId");
        
        // On récupère l'utilisateur connecté depuis la SESSION (Géré par Étudiant A)
        HttpSession session = request.getSession();
        Utilisateur userConnecte = (Utilisateur) session.getAttribute("userSession");
        
        // 2. SÉCURITÉ : Vérifier si l'utilisateur est bien connecté
       /* if (userConnecte == null) {
            response.sendRedirect("login.jsp");
            return;
        } */

        try {
            Long idLivre = Long.parseLong(livreIdStr);
            Long idUser = userConnecte.getId();

            // 3. APPEL AU CERVEAU (EJB)
            // On demande au service d'exécuter la transaction atomique
            empruntService.effectuerEmprunt(idUser, idLivre);

            // 4. RÉUSSITE
            // On renvoie vers la page des emprunts avec un message de succès
            request.setAttribute("message", "Livre emprunté avec succès !");
            request.getRequestDispatcher("/client/mes_emprunts.jsp").forward(request, response);

        } catch (Exception e) {
            // 5. GESTION DES ERREURS (Ex: Stock vide)
            // On renvoie l'erreur à la page pour l'afficher à l'utilisateur
            request.setAttribute("erreur", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("/client/catalogue_test.jsp").forward(request, response);
        }
    }
}