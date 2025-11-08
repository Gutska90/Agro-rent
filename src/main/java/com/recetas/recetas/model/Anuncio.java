package com.recetas.recetas.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "anuncios")
@Data
public class Anuncio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String empresa;
    
    @Column(nullable = false)
    private String titulo;
    
    @Column(columnDefinition = "TEXT")
    private String descripcion;
    
    private String imagenUrl;
    
    private String urlDestino;
    
    private Boolean activo = true;
}
