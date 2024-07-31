package com.example.projetoSB.service;

import com.example.projetoSB.model.Estudante;
import com.example.projetoSB.repository.EstudanteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EstudanteService {

    @Autowired
    private EstudanteRepository studentRepository;

    public List<Estudante> getAllStudents() {
        return studentRepository.findAll();
    }

    public void saveStudent(Estudante student) {
        studentRepository.save(student);
    }

    public Optional<Estudante> getStudentById(Long id) {
        return studentRepository.findById(id);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }
}
