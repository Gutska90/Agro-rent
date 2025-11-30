package cl.duoc.agro.repo;

import cl.duoc.agro.model.Machinery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.util.List;

public interface MachineryRepository extends JpaRepository<Machinery, Long> {
    @Query("SELECT m FROM Machinery m WHERE " +
           "(:type IS NULL OR LOWER(m.type) LIKE LOWER(CONCAT('%', :type, '%'))) AND " +
           "(:location IS NULL OR LOWER(m.location) LIKE LOWER(CONCAT('%', :location, '%'))) AND " +
           "(:minPrice IS NULL OR m.pricePerDay >= :minPrice) AND " +
           "(:maxPrice IS NULL OR m.pricePerDay <= :maxPrice) AND " +
           "(:fromDate IS NULL OR m.availableFrom <= :fromDate) AND " +
           "(:toDate IS NULL OR m.availableTo >= :toDate)")
    List<Machinery> search(@Param("type") String type,
                           @Param("location") String location,
                           @Param("minPrice") Double minPrice,
                           @Param("maxPrice") Double maxPrice,
                           @Param("fromDate") LocalDate fromDate,
                           @Param("toDate") LocalDate toDate);
}
