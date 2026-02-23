package com.biblio.services;

import com.biblio.entities.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UtilisateurService {
    @PersistenceContext(unitName = "LibraryPU")
    private EntityManager em;

    public Utilisateur verifierLogin(String email, String pwd) {
        try {
            return em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :e AND u.password = :p", Utilisateur.class)
                     .setParameter("e", email).setParameter("p", pwd).getSingleResult();
        } catch (Exception e) { return null; }
    }

    public List<Utilisateur> listerAdherents() {
        return em.createQuery("SELECT u FROM Utilisateur u WHERE u.role = 'ADHERENT'", Utilisateur.class).getResultList();
    }

    public void creer(Utilisateur u) { em.persist(u); }
    public void modifier(Utilisateur u) { em.merge(u); }
    public void supprimer(Long id) { em.remove(em.find(Utilisateur.class, id)); }
    public Utilisateur trouver(Long id) { return em.find(Utilisateur.class, id); }
}