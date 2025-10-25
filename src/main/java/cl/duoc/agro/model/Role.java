package cl.duoc.agro.model;

import jakarta.persistence.*;

@Entity
public class Role {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true, nullable = false)
    private String name; // ROLE_USER, ROLE_ADMIN

    // Constructors
    public Role() {}
    
    public Role(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    // Builder pattern methods
    public static RoleBuilder builder() {
        return new RoleBuilder();
    }
    
    public static class RoleBuilder {
        private Long id;
        private String name;
        
        public RoleBuilder id(Long id) { this.id = id; return this; }
        public RoleBuilder name(String name) { this.name = name; return this; }
        public Role build() { return new Role(id, name); }
    }
}
