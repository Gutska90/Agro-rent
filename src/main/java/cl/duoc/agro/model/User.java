package cl.duoc.agro.model;

import jakarta.persistence.*;
import java.util.Set;

@Entity @Table(name="users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable=false)
    private String name;
    @Column(unique = true, length = 50)
    private String username;
    @Column(unique = true, nullable=false)
    private String email;
    @Column(nullable=false)
    private String password;
    @Column(nullable = false)
    private Boolean enabled = true;
    private String address;
    private String phone;
    private String crops;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name="user_roles",
      joinColumns=@JoinColumn(name="user_id"),
      inverseJoinColumns=@JoinColumn(name="role_id"))
    private Set<Role> roles;

    // Constructors
    public User() {}
    
    public User(Long id, String name, String username, String email, String password, Boolean enabled, String address, String phone, String crops, Set<Role> roles) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.email = email;
        this.password = password;
        this.enabled = enabled != null ? enabled : true;
        this.address = address;
        this.phone = phone;
        this.crops = crops;
        this.roles = roles;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public Boolean getEnabled() { return enabled; }
    public void setEnabled(Boolean enabled) { this.enabled = enabled; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getCrops() { return crops; }
    public void setCrops(String crops) { this.crops = crops; }
    
    public Set<Role> getRoles() { return roles; }
    public void setRoles(Set<Role> roles) { this.roles = roles; }
    
    // Builder pattern methods
    public static UserBuilder builder() {
        return new UserBuilder();
    }
    
    public static class UserBuilder {
        private Long id;
        private String name;
        private String username;
        private String email;
        private String password;
        private Boolean enabled = true;
        private String address;
        private String phone;
        private String crops;
        private Set<Role> roles;
        
        public UserBuilder id(Long id) { this.id = id; return this; }
        public UserBuilder name(String name) { this.name = name; return this; }
        public UserBuilder username(String username) { this.username = username; return this; }
        public UserBuilder email(String email) { this.email = email; return this; }
        public UserBuilder password(String password) { this.password = password; return this; }
        public UserBuilder enabled(Boolean enabled) { this.enabled = enabled; return this; }
        public UserBuilder address(String address) { this.address = address; return this; }
        public UserBuilder phone(String phone) { this.phone = phone; return this; }
        public UserBuilder crops(String crops) { this.crops = crops; return this; }
        public UserBuilder roles(Set<Role> roles) { this.roles = roles; return this; }
        public User build() { return new User(id, name, username, email, password, enabled, address, phone, crops, roles); }
    }
}
