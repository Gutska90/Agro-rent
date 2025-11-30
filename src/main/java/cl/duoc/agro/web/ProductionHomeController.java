package cl.duoc.agro.web;

import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Profile("prod")
public class ProductionHomeController {
    
    @GetMapping("/recetas")
    public String homeProd() {
        return "home";
    }
}
