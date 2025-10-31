package cl.duoc.agro.web;

import cl.duoc.agro.dto.RecipeDTO;
import cl.duoc.agro.model.Recipe;
import cl.duoc.agro.repo.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/recipes")
@CrossOrigin(origins = "*")
public class RecipeRestController {
    
    @Autowired
    private RecipeRepository recipeRepository;
    
    // API PÚBLICA: Página de inicio - Recetas más recientes y populares
    @GetMapping("/home")
    public ResponseEntity<?> getHomeRecipes() {
        try {
            List<Recipe> recentRecipes = recipeRepository.findTop10ByOrderByCreatedAtDesc();
            List<Recipe> popularRecipes = recipeRepository.findTop10ByOrderByViewCountDesc();
            
            return ResponseEntity.ok(Map.of(
                "recent", convertToDTOList(recentRecipes),
                "popular", convertToDTOList(popularRecipes)
            ));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500)
                .body(Map.of("error", "Error al cargar recetas: " + e.getMessage()));
        }
    }
    
    // API PÚBLICA: Buscar recetas
    @GetMapping("/search")
    public ResponseEntity<?> searchRecipes(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String cuisineType,
            @RequestParam(required = false) String countryOrigin,
            @RequestParam(required = false) String difficulty,
            @RequestParam(required = false) String ingredient) {
        try {
            List<Recipe> recipes = recipeRepository.search(name, cuisineType, countryOrigin, difficulty, ingredient);
            return ResponseEntity.ok(convertToDTOList(recipes));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500)
                .body(Map.of("error", "Error al buscar recetas: " + e.getMessage()));
        }
    }
    
    // API PRIVADA: Ver detalles completos de receta (requiere autenticación JWT)
    @GetMapping("/{id}")
    public ResponseEntity<?> getRecipeDetails(@PathVariable Long id) {
        Recipe recipe = recipeRepository.findById(id)
            .orElse(null);
        
        if (recipe == null) {
            return ResponseEntity.notFound().build();
        }
        
        // Incrementar contador de visitas
        recipe.setViewCount(recipe.getViewCount() + 1);
        recipeRepository.save(recipe);
        
        return ResponseEntity.ok(convertToDTO(recipe));
    }
    
    // Métodos auxiliares
    private List<RecipeDTO> convertToDTOList(List<Recipe> recipes) {
        if (recipes == null || recipes.isEmpty()) {
            return List.of();
        }
        return recipes.stream()
            .map(this::convertToDTO)
            .filter(dto -> dto != null)
            .collect(Collectors.toList());
    }
    
    private RecipeDTO convertToDTO(Recipe recipe) {
        if (recipe == null) {
            return null;
        }
        
        RecipeDTO dto = new RecipeDTO();
        dto.setId(recipe.getId());
        dto.setName(recipe.getName());
        dto.setCuisineType(recipe.getCuisineType());
        dto.setIngredients(recipe.getIngredients());
        dto.setCountryOrigin(recipe.getCountryOrigin());
        dto.setDifficulty(recipe.getDifficulty());
        dto.setCookingTime(recipe.getCookingTime());
        dto.setInstructions(recipe.getInstructions());
        dto.setImageUrl(recipe.getImageUrl());
        dto.setCreatedAt(recipe.getCreatedAt());
        dto.setViewCount(recipe.getViewCount() != null ? recipe.getViewCount() : 0);
        dto.setAuthorName(recipe.getAuthor() != null ? recipe.getAuthor().getName() : "Anónimo");
        
        return dto;
    }
}
