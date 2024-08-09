package com.example.academico.controller;

import java.util.List;
import com.example.academico.model.Aluno;
import com.example.academico.service.AlunoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/aluno")
public class AlunoController {
	
	@Autowired
	private AlunoService alunoService;

	@GetMapping
	public String getAllStudents(Model model) {
		List<Aluno> aluno = alunoService.getAllStudents();
		model.addAttribute("aluno", aluno);
		return "alunos/list";
	}

	@GetMapping("/new")
	public String createStudentForm(Model model) {
		model.addAttribute("aluno", new Aluno());
		return "alunos/form";
	}

	@PostMapping
	public String saveStudent(@ModelAttribute Aluno aluno) {
	    alunoService.saveStudent(aluno);
	    return "redirect:/aluno";
	}

	@GetMapping("/edit/{id}")
	public String editStudentForm(@PathVariable Long id, Model model) {
		Aluno aluno = alunoService.getStudentById(id).orElseThrow(() -> new IllegalArgumentException("ID do Aluno Invalido:" + id));
		model.addAttribute("aluno", aluno);
		return "alunos/form";
	}

	@GetMapping("/delete/{id}")
	public String deleteStudent(@PathVariable Long id) {
		alunoService.deleteStudent(id);
		return "redirect:/aluno";
	}
}
