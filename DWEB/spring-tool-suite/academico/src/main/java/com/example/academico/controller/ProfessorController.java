package com.example.academico.controller;

import java.util.List;
import com.example.academico.model.Professor;
import com.example.academico.service.ProfessorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/professor")
public class ProfessorController {
	
	@Autowired
	private ProfessorService professorService;

	@GetMapping
	public String getAllProfessors(Model model) {
		List<Professor> professores = professorService.getAllProfessors();
		model.addAttribute("professores", professores);
		return "professores/list";
	}

	@GetMapping("/new")
	public String createProfessorForm(Model model) {
		model.addAttribute("professor", new Professor());
		return "professores/form";
	}

	@PostMapping
	public String saveProfessor(@ModelAttribute Professor professor) {
	    professorService.saveProfessor(professor);
	    return "redirect:/professor";
	}

	@GetMapping("/edit/{id}")
	public String editProfessorForm(@PathVariable Long id, Model model) {
		Professor professor = professorService.getProfessorById(id)
			.orElseThrow(() -> new IllegalArgumentException("ID do Professor Inválido:" + id));
		model.addAttribute("professor", professor);
		return "professores/form";
	}

	@GetMapping("/delete/{id}")
	public String deleteProfessor(@PathVariable Long id) {
		professorService.deleteProfessor(id);
		return "redirect:/professor";
	}

	@GetMapping("/detalhe/{id}")
	public String detalheProfessor(@PathVariable Long id, Model model) {
		Professor professor = professorService.getProfessorById(id)
			.orElseThrow(() -> new IllegalArgumentException("ID do Professor Inválido:" + id));
		model.addAttribute("professor", professor);
		return "professores/detalhe";
	}
}
