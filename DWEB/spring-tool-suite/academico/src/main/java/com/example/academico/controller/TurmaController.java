package com.example.academico.controller;

import java.util.List;
import com.example.academico.model.Turma;
import com.example.academico.model.Professor;
import com.example.academico.model.Aluno;
import com.example.academico.service.TurmaService;
import com.example.academico.service.ProfessorService;
import com.example.academico.service.AlunoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/turma")
public class TurmaController {
	
	@Autowired
	private TurmaService turmaService;

	@Autowired
	private ProfessorService professorService;

	@Autowired
	private AlunoService alunoService;

	@GetMapping
	public String getAllTurmas(Model model) {
		List<Turma> turmas = turmaService.getAllTurmas();
		model.addAttribute("turmas", turmas);
		return "turmas/list";
	}

	@GetMapping("/new")
	public String createTurmaForm(Model model) {
		model.addAttribute("turma", new Turma());
		model.addAttribute("professores", professorService.getAllProfessors());
		model.addAttribute("alunos", alunoService.getAllStudents());
		return "turmas/form";
	}
	

	@PostMapping
	public String saveTurma(@ModelAttribute Turma turma) {
	    turmaService.saveTurma(turma);
	    return "redirect:/turma";
	}

	@GetMapping("/edit/{id}")
	public String editTurmaForm(@PathVariable Long id, Model model) {
		Turma turma = turmaService.getTurmaById(id).orElseThrow(() -> new IllegalArgumentException("ID da Turma Inválido:" + id));
		model.addAttribute("turma", turma);
		model.addAttribute("professores", professorService.getAllProfessors());
		model.addAttribute("alunos", alunoService.getAllStudents());
		return "turmas/form";
	}

	@GetMapping("/delete/{id}")
	public String deleteTurma(@PathVariable Long id) {
		turmaService.deleteTurma(id);
		return "redirect:/turma";
	}

	@GetMapping("/detalhe/{id}")
	public String detalheTurma(@PathVariable Long id, Model model) {
		Turma turma = turmaService.getTurmaById(id)
			.orElseThrow(() -> new IllegalArgumentException("ID da Turma Inválido:" + id));
		model.addAttribute("turma", turma);
		return "turmas/detalhe";
	}
}
