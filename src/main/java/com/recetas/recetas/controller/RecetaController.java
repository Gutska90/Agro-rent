package com.recetas.recetas.controller;


import com.recetas.recetas.model.Receta;
import com.recetas.recetas.service.RecetaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/recetas")

public class RecetaController {
    
    @Autowired
    private RecetaService recetaService;

    @GetMapping("/{id}")
    public String verDetalleReceta(@PathVariable Long id, Model model) {
        Receta receta = recetaService.obtenerRecetaPorId(id)
                .orElseThrow(() -> new RuntimeException("Receta no encontrada"));
        
        model.addAttribute("receta", receta);
        return "detalle-receta";
    }
}
