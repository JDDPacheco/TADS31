package com.example.academico.service;

import com.example.academico.model.Professor;
import com.example.academico.repository.ProfessorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProfessorService {
	
	@Autowired
    private ProfessorRepository professorRepository;

    public List<Professor> getAllProfessores() {
        return professorRepository.findAll();
    }

    public void saveProfessor(Professor professor) {
        professorRepository.save(professor);
    }

    public Optional<Professor> getProfessorById(Long id) {
        return professorRepository.findById(id);
    }

    public void deleteProfessor(Long id) {
        professorRepository.deleteById(id);
    }
}
