package com.recetas.recetas.controller;

import com.recetas.recetas.model.Receta;
import com.recetas.recetas.service.RecetaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BuscarController {

    @Autowired
    private RecetaService recetaService;

    @GetMapping("/buscar")
    public String buscar(
            @RequestParam(required = false) String nombre,
            @RequestParam(required = false) String tipoCocina,
            @RequestParam(required = false) String ingrediente,
            @RequestParam(required = false) String paisOrigen,
            @RequestParam(required = false) String dificultad,
            Model model) {

        List<Receta> resultados = new ArrayList<>();

        if (nombre != null && !nombre.isEmpty()) {
            resultados = recetaService.buscarPorNombre(nombre);
        } else if (tipoCocina != null && !tipoCocina.isEmpty()) {
            resultados = recetaService.buscarPorTipoCocina(tipoCocina);
        } else if (ingrediente != null && !ingrediente.isEmpty()) {
            resultados = recetaService.buscarPorIngrediente(ingrediente);
        } else if (paisOrigen != null && !paisOrigen.isEmpty()) {
            resultados = recetaService.buscarPorPaisOrigen(paisOrigen);
        } else if (dificultad != null && !dificultad.isEmpty()) {
            resultados = recetaService.buscarPorDificultad(dificultad);
        } else {
            resultados = recetaService.obtenerTodasLasRecetas();
        }

        model.addAttribute("resultados", resultados);
        model.addAttribute("nombre", nombre);
        model.addAttribute("tipoCocina", tipoCocina);
        model.addAttribute("ingrediente", ingrediente);
        model.addAttribute("paisOrigen", paisOrigen);
        model.addAttribute("dificultad", dificultad);

        return "buscar";
    }
    
}
