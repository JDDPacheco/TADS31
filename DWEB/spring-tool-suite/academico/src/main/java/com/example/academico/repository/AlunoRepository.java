package com.example.academico.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.academico.model.Aluno;
import java.util.List;

public interface AlunoRepository extends JpaRepository<Aluno, Long> {
    // Método para buscar alunos por ID de turma
    List<Aluno> findByTurmas_Id(Long turmaId);
}
