package cl.duoc.agro.web;

import cl.duoc.agro.model.User;
import cl.duoc.agro.repo.UserRepository;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
@Controller
public class ProfileController {

    private final UserRepository userRepository;

    public ProfileController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/profile")
    public String profile(@AuthenticationPrincipal UserDetails ud, Model model) {
        User u = userRepository.findByEmail(ud.getUsername()).orElseThrow();
        model.addAttribute("user", u);
        return "profile";
    }

    @PostMapping("/profile")
    public String update(@AuthenticationPrincipal UserDetails ud, @ModelAttribute User form) {
        User u = userRepository.findByEmail(ud.getUsername()).orElseThrow();
        u.setAddress(form.getAddress());
        u.setPhone(form.getPhone());
        u.setCrops(form.getCrops());
        userRepository.save(u);
        return "redirect:/profile?ok";
    }
}
