package cl.duoc.agro.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Machinery {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String type; // Tractor, Cosechadora, etc.
    private String brand;
    private String model;
    private Integer year;
    private String location;
    private Integer capacity; // genérico
    private String maintenance; // texto corto
    private String conditions; // condiciones de arriendo
    private String paymentMethods;
    private Double pricePerDay;
    private LocalDate availableFrom;
    private LocalDate availableTo;
    @ManyToOne
    private User owner;

    // Constructors
    public Machinery() {}
    
    public Machinery(Long id, String type, String brand, String model, Integer year, String location, 
                     Integer capacity, String maintenance, String conditions, String paymentMethods, 
                     Double pricePerDay, LocalDate availableFrom, LocalDate availableTo, User owner) {
        this.id = id;
        this.type = type;
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.location = location;
        this.capacity = capacity;
        this.maintenance = maintenance;
        this.conditions = conditions;
        this.paymentMethods = paymentMethods;
        this.pricePerDay = pricePerDay;
        this.availableFrom = availableFrom;
        this.availableTo = availableTo;
        this.owner = owner;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    
    public Integer getYear() { return year; }
    public void setYear(Integer year) { this.year = year; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }
    
    public String getMaintenance() { return maintenance; }
    public void setMaintenance(String maintenance) { this.maintenance = maintenance; }
    
    public String getConditions() { return conditions; }
    public void setConditions(String conditions) { this.conditions = conditions; }
    
    public String getPaymentMethods() { return paymentMethods; }
    public void setPaymentMethods(String paymentMethods) { this.paymentMethods = paymentMethods; }
    
    public Double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(Double pricePerDay) { this.pricePerDay = pricePerDay; }
    
    public LocalDate getAvailableFrom() { return availableFrom; }
    public void setAvailableFrom(LocalDate availableFrom) { this.availableFrom = availableFrom; }
    
    public LocalDate getAvailableTo() { return availableTo; }
    public void setAvailableTo(LocalDate availableTo) { this.availableTo = availableTo; }
    
    public User getOwner() { return owner; }
    public void setOwner(User owner) { this.owner = owner; }
}
