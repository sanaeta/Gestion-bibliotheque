package com.biblio.services;

import com.biblio.entities.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class AuthService {
    @PersistenceContext
    private EntityManager em;

    public Utilisateur login(String email, String password) {
        try {
            return em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :e AND u.password = :p", Utilisateur.class)
                     .setParameter("e", email)
                     .setParameter("p", password)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isEmailExists(String email) {
        Long count = em.createQuery("SELECT COUNT(u) FROM Utilisateur u WHERE u.email = :e", Long.class)
                       .setParameter("e", email)
                       .getSingleResult();
        return count > 0;
    }
}