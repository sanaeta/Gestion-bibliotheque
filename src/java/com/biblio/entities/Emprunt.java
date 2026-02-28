package com.biblio.entities;

import java.io.Serializable;
import java.time.LocalDate;
import jakarta.persistence.*; // Importe tout d'un coup pour être sûr

@Entity
@Table(name = "emprunts")
public class Emprunt implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_emprunt")
    private LocalDate dateEmprunt;

    @Column(name = "date_retour_prevue")
    private LocalDate dateRetourPrevue;

    @Column(name = "date_retour_reelle")
    private LocalDate dateRetourReelle;

    private String statut; // "EN_COURS" ou "RENDU"

    // Relation avec l'Adhérent
    @ManyToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;

    // Relation avec le Livre
    @ManyToOne
    @JoinColumn(name = "livre_id")
    private Livre livre;

    // --- Constructeur vide OBLIGATOIRE ---
    public Emprunt() {
    }

    // --- Getters et Setters OBLIGATOIRES ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getDateEmprunt() { return dateEmprunt; }
    public void setDateEmprunt(LocalDate dateEmprunt) { this.dateEmprunt = dateEmprunt; }

    public LocalDate getDateRetourPrevue() { return dateRetourPrevue; }
    public void setDateRetourPrevue(LocalDate dateRetourPrevue) { this.dateRetourPrevue = dateRetourPrevue; }

    public LocalDate getDateRetourReelle() { return dateRetourReelle; }
    public void setDateRetourReelle(LocalDate dateRetourReelle) { this.dateRetourReelle = dateRetourReelle; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Utilisateur getUtilisateur() { return utilisateur; }
    public void setUtilisateur(Utilisateur utilisateur) { this.utilisateur = utilisateur; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }
}