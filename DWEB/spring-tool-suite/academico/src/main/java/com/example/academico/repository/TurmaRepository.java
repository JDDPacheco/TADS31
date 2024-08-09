package com.example.academico.repository;

import com.example.academico.model.Turma;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TurmaRepository extends JpaRepository<Turma, Long> {
	Set<Turma> findByAlunos_Id(Long alunoId);
	Set<Turma> findByProfessor_Id(Long professorId);
}
