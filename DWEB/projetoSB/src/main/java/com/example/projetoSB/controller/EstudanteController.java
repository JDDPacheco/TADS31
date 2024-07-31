package com.example.projetoSB.controller;

import com.example.projetoSB.model.Estudante;
import com.example.projetoSB.service.EstudanteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/students")
public class EstudanteController {

    @Autowired
    private EstudanteService studentService;

    @GetMapping
    public String getAllStudents(Model model) {
        List<Estudante> students = studentService.getAllStudents();
        model.addAttribute("students", students);
        return "students/list";
    }

    @GetMapping("/new")
    public String createStudentForm(Model model) {
        model.addAttribute("student", new Estudante());
        return "students/form";
    }

    @PostMapping
    public String saveStudent(@ModelAttribute Estudante student) {
        studentService.saveStudent(student);
        return "redirect:/students";
    }

    @GetMapping("/edit/{id}")
    public String editStudentForm(@PathVariable Long id, Model model) {
        Estudante student = studentService.getStudentById(id).orElseThrow(() -> new IllegalArgumentException("Invalid student Id:" + id));
        model.addAttribute("student", student);
        return "students/form";
    }

    @GetMapping("/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return "redirect:/students";
    }
}
