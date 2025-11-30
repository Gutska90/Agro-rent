package cl.duoc.agro.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecipeDTO {
    private Long id;
    private String name;
    private String cuisineType;
    private String ingredients;
    private String countryOrigin;
    private String difficulty;
    private String cookingTime;
    private String instructions;
    private String imageUrl;
    private LocalDateTime createdAt;
    private Integer viewCount;
    private String authorName;
    
    // Getters y Setters
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
    
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
    
    // Builder methods estáticos
    public static RecipeDTOBuilder builder() {
        return new RecipeDTOBuilder();
    }
    
    public static class RecipeDTOBuilder {
        private Long id;
        private String name;
        private String cuisineType;
        private String ingredients;
        private String countryOrigin;
        private String difficulty;
        private String cookingTime;
        private String instructions;
        private String imageUrl;
        private LocalDateTime createdAt;
        private Integer viewCount;
        private String authorName;
        
        public RecipeDTOBuilder id(Long id) { this.id = id; return this; }
        public RecipeDTOBuilder name(String name) { this.name = name; return this; }
        public RecipeDTOBuilder cuisineType(String cuisineType) { this.cuisineType = cuisineType; return this; }
        public RecipeDTOBuilder ingredients(String ingredients) { this.ingredients = ingredients; return this; }
        public RecipeDTOBuilder countryOrigin(String countryOrigin) { this.countryOrigin = countryOrigin; return this; }
        public RecipeDTOBuilder difficulty(String difficulty) { this.difficulty = difficulty; return this; }
        public RecipeDTOBuilder cookingTime(String cookingTime) { this.cookingTime = cookingTime; return this; }
        public RecipeDTOBuilder instructions(String instructions) { this.instructions = instructions; return this; }
        public RecipeDTOBuilder imageUrl(String imageUrl) { this.imageUrl = imageUrl; return this; }
        public RecipeDTOBuilder createdAt(LocalDateTime createdAt) { this.createdAt = createdAt; return this; }
        public RecipeDTOBuilder viewCount(Integer viewCount) { this.viewCount = viewCount; return this; }
        public RecipeDTOBuilder authorName(String authorName) { this.authorName = authorName; return this; }
        
        public RecipeDTO build() {
            RecipeDTO dto = new RecipeDTO();
            dto.setId(this.id);
            dto.setName(this.name);
            dto.setCuisineType(this.cuisineType);
            dto.setIngredients(this.ingredients);
            dto.setCountryOrigin(this.countryOrigin);
            dto.setDifficulty(this.difficulty);
            dto.setCookingTime(this.cookingTime);
            dto.setInstructions(this.instructions);
            dto.setImageUrl(this.imageUrl);
            dto.setCreatedAt(this.createdAt);
            dto.setViewCount(this.viewCount);
            dto.setAuthorName(this.authorName);
            return dto;
        }
    }
}
