package com.example.academico.service;

import com.example.academico.model.Aluno;
import com.example.academico.model.Turma;
import com.example.academico.repository.AlunoRepository;
import com.example.academico.repository.TurmaRepository;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class AlunoService {

    @Autowired
    private AlunoRepository alunoRepository;
    
    @Autowired
    private TurmaRepository turmaRepository;

    public List<Aluno> getAllStudents() {
        return alunoRepository.findAll();
    }

    public void saveStudent(Aluno aluno) {
        alunoRepository.save(aluno);
    }

    public Optional<Aluno> getStudentById(Long id) {
        return alunoRepository.findById(id);
    }

    @Transactional
    public void deleteStudent(Long alunoId) {
        // Primeiro, remova o aluno de todas as turmas
        Set<Turma> turmas = turmaRepository.findByAlunos_Id(alunoId);
        for (Turma turma : turmas) {
            turma.getAlunos().removeIf(aluno -> alunoId.equals(aluno.getId()));
            turmaRepository.save(turma);
        }

        // Então, exclua o aluno
        alunoRepository.deleteById(alunoId);
    }

    public List<Aluno> getAlunosByTurma(Long turmaId) {
        return alunoRepository.findByTurmas_Id(turmaId);
    }
}
