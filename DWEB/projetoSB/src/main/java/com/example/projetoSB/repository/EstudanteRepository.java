package com.example.projetoSB.repository;

import com.example.projetoSB.model.Estudante;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface EstudanteRepository extends JpaRepository<Estudante, Long> {

}
