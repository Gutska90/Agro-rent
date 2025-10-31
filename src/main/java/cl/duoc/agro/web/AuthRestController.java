package cl.duoc.agro.web;

import cl.duoc.agro.dto.LoginRequest;
import cl.duoc.agro.dto.LoginResponse;
import cl.duoc.agro.model.User;
import cl.duoc.agro.repo.UserRepository;
import cl.duoc.agro.service.JwtService;
import cl.duoc.agro.service.OptimizedUserDetailsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthRestController {
    
    @Autowired
    private AuthenticationManager authenticationManager;
    
    @Autowired
    private JwtService jwtService;
    
    @Autowired
    private OptimizedUserDetailsService userDetailsService;
    
    @Autowired
    private UserRepository userRepository;
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest request) {
        try {
            // Autenticar usuario
            Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                    request.getUsername(), 
                    request.getPassword()
                )
            );
            
            // Cargar detalles del usuario
            UserDetails userDetails = userDetailsService.loadUserByUsername(request.getUsername());
            
            // Generar token JWT
            String role = userDetails.getAuthorities().stream()
                .map(auth -> auth.getAuthority())
                .collect(Collectors.toList())
                .get(0);
            
            String token = jwtService.generateToken(userDetails, role);
            
            // Obtener usuario de la BD para obtener email
            Optional<User> userOpt = userRepository.findByUsernameOrEmail(request.getUsername(), request.getUsername());
            
            // Crear respuesta
            LoginResponse response = new LoginResponse();
            response.setToken(token);
            response.setUsername(userDetails.getUsername());
            response.setRole(role);
            response.setEmail(userOpt.map(User::getEmail).orElse(request.getUsername()));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                .body("Error de autenticación: " + e.getMessage());
        }
    }
}
