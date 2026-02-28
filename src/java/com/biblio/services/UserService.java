package com.biblio.services;

import com.biblio.entities.Utilisateur;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UserService {
    @PersistenceContext
    private EntityManager em;

    public void creer(Utilisateur u) { em.persist(u); }
    public void modifier(Utilisateur u) { em.merge(u); }
    public void supprimer(Long id) {
        Utilisateur u = em.find(Utilisateur.class, id);
        if (u != null) em.remove(u);
    }
    public Utilisateur trouver(Long id) {
        return em.find(Utilisateur.class, id);
    }
    public List<Utilisateur> listerTousLesMembres() {
        return em.createQuery("SELECT u FROM Utilisateur u WHERE u.role = 'ADHERENT'", Utilisateur.class).getResultList();
    }

    public List<Utilisateur> rechercherParNom(String nom) {
        return em.createQuery("SELECT u FROM Utilisateur u WHERE u.nom LIKE :n AND u.role = 'ADHERENT'", Utilisateur.class)
                 .setParameter("n", "%" + nom + "%")
                 .getResultList();
    }
	
}