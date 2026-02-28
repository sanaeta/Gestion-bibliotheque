package com.biblio.services;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import com.biblio.entities.Emprunt;
import com.biblio.entities.Livre;
import com.biblio.entities.Utilisateur;
import java.time.LocalDate;
import java.util.List;

@Stateless // Dit au serveur : "Ceci est un composant métier géré par toi"
public class EmpruntService {

    // On demande au serveur de nous donner l'outil pour parler à la DB
    @PersistenceContext(unitName = "LibraryPU")
    private EntityManager em;

    /**
     * Méthode ATOMIQUE pour enregistrer un emprunt.
     * Grâce au @Stateless, si une erreur survient ici, la transaction s'annule.
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void effectuerEmprunt(Long idUser, Long idLivre) throws Exception {
        
        // 1. On récupère l'Adhérent et le Livre en base
        Utilisateur user = em.find(Utilisateur.class, idUser);
        Livre livre = em.find(Livre.class, idLivre);

        // 2. Vérification de sécurité (Règle métier)
        if (livre == null || user == null) {
            throw new Exception("Utilisateur ou Livre introuvable !");
        }

        if (livre.getQuantiteDispo() <= 0) {
            // Ici, on arrête tout si le livre n'est pas disponible
            throw new Exception("Désolé, ce livre n'est plus en stock.");
        }

        // 3. LOGIQUE MÉTIER : Création de l'emprunt
        Emprunt nouvelEmprunt = new Emprunt();
        nouvelEmprunt.setUtilisateur(user);
        nouvelEmprunt.setLivre(livre);
        nouvelEmprunt.setDateEmprunt(LocalDate.now()); // Date d'aujourd'hui
        nouvelEmprunt.setDateRetourPrevue(LocalDate.now().plusDays(14)); // Prêt pour 14 jours
        nouvelEmprunt.setStatut("EN_COURS");

        // 4. ACTION CRITIQUE : Mise à jour du stock
        // On décrémente la quantité disponible du livre
        livre.setQuantiteDispo(livre.getQuantiteDispo() - 1);

        
        // 5. ENREGISTREMENT
        em.persist(nouvelEmprunt); // On crée l'emprunt
        em.merge(livre); // On met à jour le livre en base
        
        // MAGIE DE L'ATOMICITÉ :
        // Si l'étape 5 échoue, l'étape 4 (le stock) est automatiquement annulée par Payara.
    }
    
    
    public List<Emprunt> listerMesEmprunts(Long idUser) {
        // On utilise du JPQL (Java Persistence Query Language)
        // C'est comme du SQL, mais on parle aux Objets, pas aux tables.
        return em.createQuery("SELECT e FROM Emprunt e WHERE e.utilisateur.id = :uid AND e.dateRetourReelle IS NULL", Emprunt.class)
                 .setParameter("uid", idUser)
                 .getResultList();
    }
    
 // Dans le fichier com.biblio.services.EmpruntService.java

    /**
     * Récupère la liste des emprunts effectués par un utilisateur spécifique
     */
    public List<Emprunt> getEmpruntsByUser(Long userId) {
        try {
            // On cherche tous les emprunts (e) où l'ID de l'utilisateur correspond
            // Note : Vérifie si dans l'entité Emprunt le champ s'appelle "utilisateur" ou "user"
            return em.createQuery("SELECT e FROM Emprunt e WHERE e.utilisateur.id = :uid", Emprunt.class)
                     .setParameter("uid", userId)
                     .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public void retournerLivre(Long idEmprunt) throws Exception {
        // 1. On cherche l'emprunt en base
        Emprunt e = em.find(Emprunt.class, idEmprunt);
        if (e == null) {
            throw new Exception("Emprunt introuvable.");
        }

        // 2. On met à jour l'emprunt
        e.setDateRetourReelle(LocalDate.now()); // On enregistre la date du jour
        e.setStatut("RENDU");

        // 3. On récupère le livre associé et on augmente le stock
        Livre livre = e.getLivre();
        livre.setQuantiteDispo(livre.getQuantiteDispo() + 1);

        // 4. On synchronise
        em.merge(e);
        em.merge(livre);
        
        // TRANSACTION ATOMIQUE : 
        // Si l'augmentation du stock échoue, la date de retour n'est pas enregistrée.
    }
}