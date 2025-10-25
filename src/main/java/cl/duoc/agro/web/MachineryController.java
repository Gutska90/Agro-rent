package cl.duoc.agro.web;

import cl.duoc.agro.model.Machinery;
import cl.duoc.agro.model.User;
import cl.duoc.agro.repo.MachineryRepository;
import cl.duoc.agro.repo.UserRepository;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/machinery")
public class MachineryController {

    private final MachineryRepository machineryRepository;
    private final UserRepository userRepository;

    public MachineryController(MachineryRepository machineryRepository, UserRepository userRepository) {
        this.machineryRepository = machineryRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("")
    public String listPublic(Model model) {
        model.addAttribute("machineryList", machineryRepository.findAll());
        return "machinery-search";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String type,
                         @RequestParam(required = false) String location,
                         @RequestParam(required = false) Double minPrice,
                         @RequestParam(required = false) Double maxPrice,
                         @RequestParam(required = false) String from,
                         @RequestParam(required = false) String to,
                         Model model) {
        LocalDate f = (from == null || from.isBlank()) ? null : LocalDate.parse(from);
        LocalDate t = (to == null || to.isBlank()) ? null : LocalDate.parse(to);
        List<Machinery> res = machineryRepository.search(type, location, minPrice, maxPrice, f, t);
        model.addAttribute("machineryList", res);
        return "machinery-search";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Machinery m = machineryRepository.findById(id).orElse(null);
        model.addAttribute("machinery", m);
        return "machinery-detail";
    }

    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("machinery", new Machinery());
        return "machinery-form";
    }

    @PostMapping("/new")
    public String create(@ModelAttribute Machinery machinery, @AuthenticationPrincipal UserDetails ud, Model model) {
        try {
            User owner = userRepository.findByEmail(ud.getUsername()).orElseThrow();
            machinery.setOwner(owner);
            
            // Validaciones básicas
            if (machinery.getType() == null || machinery.getType().trim().isEmpty()) {
                model.addAttribute("error", "El tipo de maquinaria es requerido");
                return "machinery-form";
            }
            
            if (machinery.getBrand() == null || machinery.getBrand().trim().isEmpty()) {
                model.addAttribute("error", "La marca es requerida");
                return "machinery-form";
            }
            
            if (machinery.getPricePerDay() == null || machinery.getPricePerDay() <= 0) {
                model.addAttribute("error", "El precio por día debe ser mayor a 0");
                return "machinery-form";
            }
            
            machineryRepository.save(machinery);
            return "redirect:/machinery?success";
        } catch (Exception e) {
            model.addAttribute("error", "Error al guardar la maquinaria: " + e.getMessage());
            return "machinery-form";
        }
    }
}
