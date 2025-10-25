package cl.duoc.agro.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Reservation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(optional=false)
    private Machinery machinery;
    @ManyToOne(optional=false)
    private User renter;
    private LocalDate startDate;
    private LocalDate endDate;
    private Double totalPrice;

    // Constructors
    public Reservation() {}
    
    public Reservation(Long id, Machinery machinery, User renter, LocalDate startDate, LocalDate endDate, Double totalPrice) {
        this.id = id;
        this.machinery = machinery;
        this.renter = renter;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Machinery getMachinery() { return machinery; }
    public void setMachinery(Machinery machinery) { this.machinery = machinery; }
    
    public User getRenter() { return renter; }
    public void setRenter(User renter) { this.renter = renter; }
    
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    
    public Double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(Double totalPrice) { this.totalPrice = totalPrice; }
}
