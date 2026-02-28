package com.biblio.web;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.biblio.services.EmpruntService;

@WebServlet("/retourner")
public class RetourServlet extends HttpServlet {

    @EJB
    private EmpruntService empruntService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("empruntId");

        try {
            Long idEmprunt = Long.parseLong(idStr);
            
            // On appelle le cerveau
            empruntService.retournerLivre(idEmprunt);

            // On redirige vers la liste des emprunts avec un message
            request.getSession().setAttribute("message", "Livre rendu !");
            response.sendRedirect("mes-emprunts"); // On recharge la liste

        } catch (Exception e) {
            request.getSession().setAttribute("erreur", "Erreur lors du retour : " + e.getMessage());
            response.sendRedirect("mes-emprunts");
        }
    }
}
