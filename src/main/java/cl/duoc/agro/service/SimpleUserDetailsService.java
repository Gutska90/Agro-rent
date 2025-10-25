package cl.duoc.agro.service;

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
import java.util.ArrayList;
import java.util.List;

@Service
public class SimpleUserDetailsService implements UserDetailsService {

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            // Conexión directa a MySQL
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/agrorent?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "agrouser", 
                "agropass"
            );

            // Buscar usuario por username o email
            String sql = "SELECT u.id, u.username, u.email, u.password, u.enabled, r.name as role " +
                        "FROM users u " +
                        "LEFT JOIN user_roles ur ON u.id = ur.user_id " +
                        "LEFT JOIN roles r ON ur.role_id = r.id " +
                        "WHERE (u.username = ? OR u.email = ?) AND u.enabled = TRUE";
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, username);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
                conn.close();
                throw new UsernameNotFoundException("Usuario no encontrado: " + username);
            }

            String dbUsername = rs.getString("username");
            String dbEmail = rs.getString("email");
            String dbPassword = rs.getString("password");
            boolean enabled = rs.getBoolean("enabled");
            
            List<SimpleGrantedAuthority> authorities = new ArrayList<>();
            
            // Agregar el primer rol encontrado
            String role = rs.getString("role");
            if (role != null) {
                authorities.add(new SimpleGrantedAuthority(role));
            }
            
            // Buscar roles adicionales si los hay
            while (rs.next()) {
                String additionalRole = rs.getString("role");
                if (additionalRole != null && !authorities.contains(new SimpleGrantedAuthority(additionalRole))) {
                    authorities.add(new SimpleGrantedAuthority(additionalRole));
                }
            }
            
            conn.close();
            
            return new User(dbUsername, dbPassword, enabled, true, true, true, authorities);
            
        } catch (Exception e) {
            throw new UsernameNotFoundException("Error al cargar usuario: " + e.getMessage());
        }
    }
}
