package com.example.academico.service;

import com.example.academico.model.Aluno;
import com.example.academico.model.Professor;
import com.example.academico.model.Turma;
import com.example.academico.repository.AlunoRepository;
import com.example.academico.repository.ProfessorRepository;
import com.example.academico.repository.TurmaRepository;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TurmaService {

    @Autowired
    private TurmaRepository turmaRepository;
    
    @Autowired
    private ProfessorRepository professorRepository;
    
    @Autowired
    private AlunoRepository alunoRepository;

    public List<Turma> getAllTurmas() {
        return turmaRepository.findAll();
    }

    public void saveTurma(Turma turma) {
        // Verifique se o professor é opcional
        if (turma.getProfessor() != null && turma.getProfessor().getId() > 0) {
            Professor professor = professorRepository.findById(turma.getProfessor().getId()).orElse(null);
            turma.setProfessor(professor);
        }
        turmaRepository.save(turma);
    }

    public Optional<Turma> getTurmaById(Long id) {
        return turmaRepository.findById(id);
    }

    @Transactional
    public void deleteTurma(Long turmaId) {
        // Primeiro, obtenha a turma
        Turma turma = turmaRepository.findById(turmaId).orElseThrow(() -> new EntityNotFoundException("Turma não encontrada"));

        // Remova a turma da lista de turmas dos alunos
        for (Aluno aluno : turma.getAlunos()) {
            aluno.getTurmas().remove(turma);
            alunoRepository.save(aluno);
        }

        // Exclua a turma
        turmaRepository.delete(turma);
    }
    
}
