package com.example.academico.controller;

import com.example.academico.model.Turma;
import com.example.academico.service.TurmaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/turma")
public class TurmaController {
	
	@Autowired
	private TurmaService turmaService;

	
}