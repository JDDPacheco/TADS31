package com.example.academico.service;

import com.example.academico.model.Turma;
import com.example.academico.repository.TurmaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TurmaService {
	
	@Autowired
    private TurmaRepository turmaRepository;

    public List<Turma> getAllTurmas() {
        return turmaRepository.findAll();
    }

    public void saveTurma(Turma turma) {
        turmaRepository.save(turma);
    }

    public Optional<Turma> getTurmaById(Long id) {
        return turmaRepository.findById(id);
    }

    public void deleteTurma(Long id) {
        turmaRepository.deleteById(id);
    }
}
