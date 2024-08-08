package com.example.academico.service;

import com.example.academico.model.Aluno;
import com.example.academico.repository.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AlunoService {
	
	@Autowired
    private AlunoRepository studentRepository;

    public List<Aluno> getAllStudents() {
        return studentRepository.findAll();
    }

    public void saveStudent(Aluno student) {
        studentRepository.save(student);
    }

    public Optional<Aluno> getStudentById(Long id) {
        return studentRepository.findById(id);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }
}
