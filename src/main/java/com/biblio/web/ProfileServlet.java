package com.biblio.web;

import com.biblio.entities.Utilisateur;
import com.biblio.services.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profil")
public class ProfileServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB private UserService userService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("userSession");

        if (user != null) {
            user.setNom(request.getParameter("nom"));
            user.setEmail(request.getParameter("email"));
            
            String newPass = request.getParameter("password");
            if (newPass != null && !newPass.isEmpty()) {
                user.setPassword(newPass);
            }

            userService.modifier(user);
            session.setAttribute("userSession", user); // Mise à jour de la session
            response.sendRedirect("profil.jsp?success=1");
        }
    }
}