package com.recetas.recetas.repository;

import com.recetas.recetas.model.Anuncio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AnuncioRepository extends JpaRepository<Anuncio, Long>{
    List<Anuncio> findByActivoTrue();
}
