create database clinica_medica;

use clinica_medica;

create table clinica_medica.funcionarios(
	Codigo_Funcionario INT NOT NULL AUTO_INCREMENT,
    Nome_Completo VARCHAR(255) NULL,
    Numero_RG VARCHAR(12) NULL,
    Orgao_Emissor VARCHAR(6) NULL,
    Numero_CPF VARCHAR(14) NULL,
    Endereco VARCHAR(50) NULL,
    Numero VARCHAR(15) NULL,
    Complemento VARCHAR(30) NULL,
    Bairro VARCHAR(40) NULL,
    Cidade VARCHAR(40) NULL,
    Estado VARCHAR(2) NULL,
    Telefone VARCHAR(20) NULL,
    Celular VARCHAR(20) NULL,
    Numero_CTPS VARCHAR(20) NULL,
    Numero_PIS VARCHAR(20) NULL,
    Data_Nascimento DATE NULL,
    PRIMARY KEY (Codigo_Funcionario),
    INDEX Idx_Nome (Nome_Completo ASC),
    INDEX Idx_RG (Numero_RG ASC),
    INDEX Idx_CPF (Numero_CPF ASC)
) ENGINE = InnoDB;

CREATE TABLE clinica_medica.usuarios (
	Registro_Usuario INT NOT NULL AUTO_INCREMENT,
    Identificacao_Usuario VARCHAR(20) NULL,
    Senha_Acesso VARCHAR(10) NULL,
    Cadastro_Funcionario VARCHAR(1) NULL DEFAULT 'N',
    Cadastro_Usuario VARCHAR(1) NULL DEFAULT 'N',
    Cadastro_Paciente VARCHAR(1) NULL DEFAULT 'N',
    Cadastro_Especialidade VARCHAR(1) NULL DEFAULT 'N',
    Cadastro_Medico VARCHAR(1) NULL DEFAULT 'N',
    Cadastro_Convenio VARCHAR(1) NULL DEFAULT 'N',
    Agendamento_Consulta VARCHAR(1) NULL DEFAULT 'N',
    Cancelamento_Consulta VARCHAR(1) NULL DEFAULT 'N',
    Modulo_Administrativo VARCHAR(1) NULL DEFAULT 'N',
    Modulo_Agendamento VARCHAR(1) NULL DEFAULT 'N',
    Modulo_Atendimento VARCHAR(1) NULL DEFAULT 'N',
    PRIMARY KEY (Registro_Usuario)
)ENGINE = InnoDB;

CREATE TABLE clinica_medica.especialidades (
	Codigo_Especialidade INT NOT NULL AUTO_INCREMENT,
    Descricao_Especialidade VARCHAR(45) NULL,
    PRIMARY KEY (Codigo_Especialidade)
)ENGINE = InnoDB;

CREATE TABLE clinica_medica.medicos(
	Codigo_Medico INT NOT NULL AUTO_INCREMENT,
    Nome_Medico VARCHAR(50) NULL,
    Codigo_Especialidade INT NOT NULL,
    CRM VARCHAR(20) NULL,
    PRIMARY KEY (Codigo_Medico, Codigo_Especialidade),
    INDEX fk_medicos_especialidades_idx (Codigo_Especialidade),
    CONSTRAINT fk_medicos_especialidades
		FOREIGN KEY (Codigo_Especialidade)
		REFERENCES clinica_medica.especialidades (Codigo_Especialidade)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)ENGINE = InnoDB;

CREATE TABLE clinica_medica.convenios (
	Codigo_Convenio INT NOT NULL AUTO_INCREMENT,
    Empresa_Convenio VARCHAR(45) NULL,
    CNPJ VARCHAR(18) NULL,
    Telefone VARCHAR(20) NULL,
    PRIMARY KEY (Codigo_Convenio)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS clinica_medica.pacientes ( Codigo_Paciente INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR (50) NULL,
	Numero_RG VARCHAR (12) NULL,
	Orgao_Emissor VARCHAR (6) NULL, Numero_CPF VARCHAR (14) NULL, Endereco VARCHAR (50) NULL, Numero VARCHAR (15) NULL,
	Complemento VARCHAR (30) NULL,
	Bairro VARCHAR (40) NULL, Cidade VARCHAR (40) NULL,
	Estado VARCHAR (2) NULL, Telefone VARCHAR (20) NULL, Celular VARCHAR (20) NULL, Data_Nascimento DATE NULL, Sexo VARCHAR (1) NULL,
	Tem_Convenio VARCHAR(1) NULL, Codigo_Convenio INT NOT NULL,
	Senha_Acesso VARCHAR (10),
	PRIMARY KEY (Codigo_Paciente, Codigo_Convenio),
	INDEX fk_pacientes_conveniosl_idx (Codigo_Convenio ASC), 
    CONSTRAINT fk_pacientes_convenios1
		FOREIGN KEY (Codigo_Convenio)
		REFERENCES clinica_medica.convenios (Codigo_Convenio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS clinica_medica. agenda_consulta (
Registro_Agenda INT NOT NULL AUTO_INCREMENT,
Codigo_Usuario INT NOT NULL,
Codigo_Paciente INT NOT NULL, Codigo_Medico INT NOT NULL, Data DATE NULL,
Hora VARCHAR (5) NULL,
Retorno VARCHAR (1) NULL DEFAULT 'N',
Cancelado VARCHAR (1) NULL DEFAULT 'N',
Motivo_Cancelamento TEXT NULL,
PRIMARY KEY (Registro_Agenda, Codigo_Usuario, Codigo_Medico, Codigo_Paciente), 
INDEX fk_agenda_consulta_pacientesl_idx (Codigo_Paciente ASC),
INDEX fk_agenda_consulta_medicosl_idx (Codigo_Medico ASC),
INDEX fk_agenda_consulta_usuariosl_idx (Codigo_Usuario ASC), 
CONSTRAINT fk_agenda_consulta_pacientes
	FOREIGN KEY (Codigo_Paciente)
	REFERENCES clinica_medica.pacientes (Codigo_Paciente)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
CONSTRAINT fk_agenda_consulta_medicosl
	FOREIGN KEY (Codigo_Medico)
	REFERENCES clinica_medica.medicos (Codigo_Medico)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
CONSTRAINT fk_agenda_consulta_usuariosl
	FOREIGN KEY (Codigo_Usuario)
	REFERENCES clinica_medica.usuarios (Registro_Usuario)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS clinica_medica.prontuario_paciente (
	Registro INT NOT NULL AUTO_INCREMENT,
	Registro_Agenda INT NOT NULL,
	Historico TEXT NULL,
	Receituario TEXT NULL,
	Exames TEXT NULL,
	PRIMARY KEY (Registro, Registro_Agenda),
	INDEX fk_prontuario_paciente_agenda_consultal_idx (Registro_Agenda ASC), 
    CONSTRAINT fk_prontuario_paciente_agenda_consultal
	FOREIGN KEY (Registro_Agenda)
	REFERENCES clinica_medica. agenda_consulta (Registro_Agenda)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
)ENGINE = InnoDB;