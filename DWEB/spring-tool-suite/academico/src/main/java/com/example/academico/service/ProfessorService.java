package com.example.academico.service;

import com.example.academico.model.Professor;
import com.example.academico.model.Turma;
import com.example.academico.repository.ProfessorRepository;
import com.example.academico.repository.TurmaRepository;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class ProfessorService {

    @Autowired
    private ProfessorRepository professorRepository;
    
    @Autowired
    private TurmaRepository turmaRepository;

    public List<Professor> getAllProfessors() {
        return professorRepository.findAll();
    }

    public void saveProfessor(Professor professor) {
        professorRepository.save(professor);
    }

    public Optional<Professor> getProfessorById(Long id) {
        return professorRepository.findById(id);
    }

    @Transactional
    public void deleteProfessor(Long professorId) {
        // Primeiro, remova o professor de todas as turmas
        Set<Turma> turmas = turmaRepository.findByProfessor_Id(professorId);
        for (Turma turma : turmas) {
            turma.setProfessor(null); // Remove a referência ao professor
            turmaRepository.save(turma); // Salva a turma sem o professor
        }

        // Então, exclua o professor
        professorRepository.deleteById(professorId);
    }

}
