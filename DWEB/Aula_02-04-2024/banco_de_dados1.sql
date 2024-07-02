use clinica_medica:

create table if not exists clinica_medica.funcionarios(
	Codigo_Funcionario int not null auto_increment,
    Nome_Completo varchar(50) null,
    Numero_RG varchar(12) null,
    Orgao_Emissor varchar(6) null,
    Numero_CPF varchar(14) null,
    Endereco varchar(50) null,
    Numero varchar(15) null,
    Complemento varchar(30) null,
    Bairro varchar(40) null,
    Cidade varchar(40) null,
    Estado varchar(2) null,
    Telefone varchar(20) null,
    Celular varchar(20) null,
    Numero_CTPS varchar(20) null,
    Numero_PIS varchar(20) null,
    Data_Nascimento date null,
    primary key (Codigo_Funcionario),
    index idx_Nome (Nome_Completo asc),
    index idx_RG (Numero_RG asc),
    index idx_CPF (Numero_CPF asc)
    )
ENGINE = InnoDB;

create table if not exists clinica_medica.usuarios(
	Registro_Usuario int not null auto_increment,
	Identificacao_Usuario varchar(20) null,
	Senha_Acesso varchar(10) null,
	Cadastro_Funcionario varchar(1) null default 'N',
	Cadastro_Usuario varchar(1) null default 'N',
	Cadastro_Paciente varchar(1) null default 'N',
	Cadastro_Especialidade varchar(1) null default 'N',
	Cadastro_Medico varchar(1) null default 'N',
	Cadastro_Convenio varchar(1) null default 'N',
	Agendamento_Consulta varchar(1) null default 'N',
	Cancelamento_Consulta varchar(1) null default 'N',
	Modulo_Adiministrativo varchar(1) null default 'N',
	Modulo_Agendamento varchar(1) null default 'N',
	Modulo_Atendimento varchar(1) null default 'N',
  primary key (Registro_Usuario))
ENGINE = InnoDB;