package com.biblio.web;

import com.biblio.entities.Livre;
import com.biblio.entities.Utilisateur;
import com.biblio.services.LivreService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/livres")
public class LivreServlet extends HttpServlet {
    
    @EJB private LivreService livreService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("userSession");

       
        if ("dashboard".equals(action) || action == null) {
            if (user != null && "ADMIN".equals(user.getRole())) {
                request.setAttribute("nbLivres", livreService.countLivres());
                request.setAttribute("nbMembres", livreService.countMembres());
                request.setAttribute("nbEmprunts", livreService.countEmpruntsEnCours());
            } else {
                String kw = request.getParameter("search");
                List<Livre> liste = (kw != null && !kw.trim().isEmpty()) ? livreService.rechercher(kw) : livreService.findAll();
                request.setAttribute("nbLivres", livreService.countLivres());
                request.setAttribute("livres", liste);
            }
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } 

        
        else if ("catalogue".equals(action)) {
            String kw = request.getParameter("search");
            List<Livre> liste = (kw != null && !kw.trim().isEmpty()) ? livreService.rechercher(kw) : livreService.findDisponibles();
            request.setAttribute("livres", liste);
            request.getRequestDispatcher("/client/catalogue.jsp").forward(request, response);
        }

        
        else if ("gestion".equals(action)) {
            request.setAttribute("livres", livreService.findAll());
            request.getRequestDispatcher("/admin/gestion_livres.jsp").forward(request, response);
        }

       
        else if ("add".equals(action)) {
            request.getRequestDispatcher("/admin/form_livre.jsp").forward(request, response);
        }

        else if ("edit".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Livre l = livreService.find(id);
            request.setAttribute("livre", l); // On envoie l'objet 'livre' à la JSP
            request.getRequestDispatcher("/admin/form_livre.jsp").forward(request, response);
        }

        else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            livreService.delete(id);
            response.sendRedirect("livres?action=gestion");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // RÉCUPÉRATION DES DONNÉES DU FORMULAIRE
        String idStr = request.getParameter("id");
        String titre = request.getParameter("titre");
        String auteur = request.getParameter("auteur");
        String isbn = request.getParameter("isbn");
        int qte = Integer.parseInt(request.getParameter("quantite"));

        Livre l = new Livre();
        l.setTitre(titre);
        l.setAuteur(auteur);
        l.setIsbn(isbn);
        l.setQuantiteStock(qte);

        if (idStr != null && !idStr.isEmpty()) {
            // MODE MODIFICATION
            l.setId(Long.parseLong(idStr));
            // On récupère l'ancienne dispo pour ne pas la perdre
            Livre ancien = livreService.find(l.getId());
            l.setQuantiteDispo(ancien.getQuantiteDispo());
            livreService.save(l); // Update
        } else {
            // MODE AJOUT
            l.setQuantiteDispo(qte); // Au début, dispo = stock
            livreService.save(l); // Persist
        }

        // Une fois fini, on retourne à la liste
        response.sendRedirect("livres?action=gestion");
    }
}