package cl.duoc.agro.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "recipes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Recipe {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, length = 200)
    private String name;
    
    @Column(name = "cuisine_type", length = 100)
    private String cuisineType; // Tipo de cocina
    
    @Column(length = 1000)
    private String ingredients; // Ingredientes separados por comas
    
    @Column(name = "country_origin", length = 100)
    private String countryOrigin; // País de origen
    
    @Column(length = 50)
    private String difficulty; // Fácil, Media, Difícil
    
    @Column(name = "cooking_time", length = 50)
    private String cookingTime; // Tiempo de cocción
    
    @Column(columnDefinition = "TEXT")
    private String instructions; // Instrucciones de preparación
    
    @Column(name = "image_url", length = 500)
    private String imageUrl; // URL de la imagen
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "view_count", nullable = false)
    @Builder.Default
    private Integer viewCount = 0; // Para determinar popularidad
    
    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author; // Usuario que creó la receta
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (viewCount == null) {
            viewCount = 0;
        }
    }
    
    // Getters y Setters (en caso de que Lombok no funcione correctamente)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
    
    public String getIngredients() { return ingredients; }
    public void setIngredients(String ingredients) { this.ingredients = ingredients; }
    
    public String getCountryOrigin() { return countryOrigin; }
    public void setCountryOrigin(String countryOrigin) { this.countryOrigin = countryOrigin; }
    
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
    
    public String getCookingTime() { return cookingTime; }
    public void setCookingTime(String cookingTime) { this.cookingTime = cookingTime; }
    
    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }
    
    public User getAuthor() { return author; }
    public void setAuthor(User author) { this.author = author; }
}
