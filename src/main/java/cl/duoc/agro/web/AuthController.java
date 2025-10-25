package cl.duoc.agro.web;

import cl.duoc.agro.dto.RegisterDto;
import cl.duoc.agro.model.Role;
import cl.duoc.agro.model.User;
import cl.duoc.agro.repo.RoleRepository;
import cl.duoc.agro.repo.UserRepository;
import jakarta.validation.Valid;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Set;

@Controller
public class AuthController {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder encoder;

    public AuthController(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder encoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.encoder = encoder;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("registerDto", new RegisterDto());
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(@Valid @ModelAttribute RegisterDto dto, BindingResult result, Model model) {
        if (result.hasErrors()) return "register";
        if (userRepository.existsByEmail(dto.getEmail())) {
            model.addAttribute("error", "El correo ya está registrado.");
            return "register";
        }
        Role userRole = roleRepository.findByName("ROLE_USER").orElseGet(() -> roleRepository.save(Role.builder().name("ROLE_USER").build()));
        User u = User.builder().name(dto.getName()).email(dto.getEmail()).password(encoder.encode(dto.getPassword())).roles(Set.of(userRole)).build();
        userRepository.save(u);
        return "redirect:/login?registered";
    }
}
