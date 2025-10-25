package cl.duoc.agro.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Set;

@Service
public class OptimizedUserDetailsService implements UserDetailsService {

    @Value("${spring.datasource.url}")
    private String databaseUrl;
    
    @Value("${spring.datasource.username}")
    private String databaseUsername;
    
    @Value("${spring.datasource.password}")
    private String databasePassword;

    private static final String USER_QUERY = """
        SELECT u.id, u.username, u.email, u.password, u.enabled, r.name as role 
        FROM users u 
        LEFT JOIN user_roles ur ON u.id = ur.user_id 
        LEFT JOIN roles r ON ur.role_id = r.id 
        WHERE (u.username = ? OR u.email = ?) AND u.enabled = TRUE
        """;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try (Connection conn = DriverManager.getConnection(databaseUrl, databaseUsername, databasePassword);
             PreparedStatement stmt = conn.prepareStatement(USER_QUERY)) {
            
            stmt.setString(1, username);
            stmt.setString(2, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (!rs.next()) {
                    throw new UsernameNotFoundException("Usuario no encontrado: " + username);
                }

                // Obtener datos del usuario
                String dbUsername = rs.getString("username");
                String dbPassword = rs.getString("password");
                boolean enabled = rs.getBoolean("enabled");
                
                // Recopilar todos los roles
                Set<SimpleGrantedAuthority> authorities = new HashSet<>();
                do {
                    String role = rs.getString("role");
                    if (role != null) {
                        authorities.add(new SimpleGrantedAuthority(role));
                    }
                } while (rs.next());
                
                return new User(dbUsername, dbPassword, enabled, true, true, true, authorities);
            }
            
        } catch (Exception e) {
            throw new UsernameNotFoundException("Error al cargar usuario: " + e.getMessage(), e);
        }
    }
}
