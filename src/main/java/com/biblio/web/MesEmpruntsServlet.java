package com.biblio.web;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import com.biblio.services.EmpruntService;
import com.biblio.entities.Emprunt;
import com.biblio.entities.Utilisateur;

@WebServlet("/mes-emprunts")
public class MesEmpruntsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	@EJB
    private EmpruntService empruntService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur userConnecte = (Utilisateur) session.getAttribute("userSession");

    
        // 1. On demande la liste au cerveau (EJB)
        List<Emprunt> liste = empruntService.listerMesEmprunts(userConnecte.getId());

        // 2. On met la liste dans un "carton" (Attribute) pour la donner à la JSP
        request.setAttribute("emprunts", liste);

        // 3. On affiche la page JSP
        request.getRequestDispatcher("/client/mes_emprunts.jsp").forward(request, response);
    }
}
