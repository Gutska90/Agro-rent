package cl.duoc.agro.repo;

import cl.duoc.agro.model.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RecipeRepository extends JpaRepository<Recipe, Long> {
    
    List<Recipe> findTop10ByOrderByCreatedAtDesc(); // Recetas más recientes
    
    List<Recipe> findTop10ByOrderByViewCountDesc(); // Recetas más populares
    
    @Query("SELECT r FROM Recipe r WHERE " +
           "(:name IS NULL OR LOWER(r.name) LIKE LOWER(CONCAT('%', :name, '%'))) AND " +
           "(:cuisineType IS NULL OR LOWER(r.cuisineType) LIKE LOWER(CONCAT('%', :cuisineType, '%'))) AND " +
           "(:countryOrigin IS NULL OR LOWER(r.countryOrigin) LIKE LOWER(CONCAT('%', :countryOrigin, '%'))) AND " +
           "(:difficulty IS NULL OR LOWER(r.difficulty) = LOWER(:difficulty)) AND " +
           "(:ingredient IS NULL OR LOWER(r.ingredients) LIKE LOWER(CONCAT('%', :ingredient, '%')))")
    List<Recipe> search(
        @Param("name") String name,
        @Param("cuisineType") String cuisineType,
        @Param("countryOrigin") String countryOrigin,
        @Param("difficulty") String difficulty,
        @Param("ingredient") String ingredient
    );
}
