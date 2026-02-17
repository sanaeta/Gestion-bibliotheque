package com.biblio.entities;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    
    private String role; // Valeurs : "ADMIN" ou "ADHERENT"

    // --- Constructeur vide OBLIGATOIRE pour JPA ---
    public Utilisateur() {}

    // --- Getters et Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}