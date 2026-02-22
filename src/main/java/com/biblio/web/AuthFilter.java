package com.biblio.web;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

//@WebFilter("/*") // On surveille toutes les pages
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // 1. Autoriser le login et les ressources CSS/Images
        if (path.equals("/login.jsp") || path.equals("/login") || path.startsWith("/includes/")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Vérifier si l'utilisateur est connecté
        boolean loggedIn = (session != null && session.getAttribute("userSession") != null);

        if (loggedIn) {
            chain.doFilter(request, response); // OK, on laisse passer
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp"); // Pas de session -> Redirection
        }
    }
}