package com.biblio.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    public Livre() {
	}
    // autres attributs
	public int getQuantiteDispo() {
		// TODO Auto-generated method stub
		return 0;
	}
	public void setQuantiteDispo(int i) {
		// TODO Auto-generated method stub
		
	}
}
