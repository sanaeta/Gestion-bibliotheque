package com.biblio.entities;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "livres")
public class Livre implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;
    private String auteur;
    
    @Column(unique = true)
    private String isbn;

    @Column(name = "quantite_dispo")
    private int quantiteStock;

    @Column(name = "quantite_stock")
    private int quantiteDispo;

    // --- Constructeur vide OBLIGATOIRE ---
    public Livre() {}

    // --- Getters et Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public int getQuantiteStock() { return quantiteStock; }
    public void setQuantiteStock(int quantiteStock) { this.quantiteStock = quantiteStock; }

    public int getQuantiteDispo() { return quantiteDispo; }
    public void setQuantiteDispo(int quantiteDispo) { this.quantiteDispo = quantiteDispo; }
}