package com.biblio.services;

import com.biblio.entities.Livre;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class LivreService {

    @PersistenceContext
    private EntityManager em;

    // --- GESTION CRUD ---
    public List<Livre> findAll() {
        return em.createQuery("SELECT l FROM Livre l", Livre.class).getResultList();
    }

    public Livre find(Long id) {
        return em.find(Livre.class, id);
    }

    public void save(Livre l) {
        if (l.getId() == null) em.persist(l);
        else em.merge(l);
    }

    public void delete(Long id) {
        Livre l = find(id);
        if (l != null) em.remove(l);
    }

    // --- RECHERCHE (Pour le catalogue étudiant) ---
    public List<Livre> rechercher(String kw) {
        // On utilise LOWER pour que la recherche marche même si on écrit en minuscules
        return em.createQuery("SELECT l FROM Livre l WHERE LOWER(l.titre) LIKE LOWER(:kw) OR LOWER(l.auteur) LIKE LOWER(:kw)", Livre.class)
                 .setParameter("kw", "%" + kw + "%") // Le % permet de trouver le mot n'importe où dans le titre
                 .getResultList();
    }
    public List<Livre> findDisponibles() {
        return em.createQuery("SELECT l FROM Livre l WHERE l.quantiteDispo > 0", Livre.class).getResultList();
    }

    // --- STATISTIQUES (Pour ton Dashboard) ---
    public long countLivres() {
        return em.createQuery("SELECT COUNT(l) FROM Livre l", Long.class).getSingleResult();
    }

    public long countMembres() {
        return em.createQuery("SELECT COUNT(u) FROM Utilisateur u WHERE u.role = 'ADHERENT'", Long.class).getSingleResult();
    }

    public long countEmpruntsEnCours() {
        return em.createQuery("SELECT COUNT(e) FROM Emprunt e WHERE e.dateRetourReelle IS NULL", Long.class).getSingleResult();
    }
}