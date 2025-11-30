package cl.duoc.agro.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class RecipeController {
    
    @GetMapping("/recipes/search")
    public String searchPage() {
        return "recipe-search";
    }
    
    @GetMapping("/recipes/{id}")
    public String detailPage(@PathVariable Long id) {
        return "recipe-detail";
    }
}
