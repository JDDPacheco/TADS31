-- aula dia 03/07/2024

/*
Trabalho em grupo, 4 membros.
Conhecer os outros SGBDs:
	1. SQL Server
    2. Oracle
    3. PostgreSQL
    4. BD2
    5. SyBase
    6. Informix
    
    1ª parte: Fazer uma tabela comparativa entre os SGBDs contemplando sintaxe SQL, requisitos de hardware, suporte a programação (SP, Functions, Triggers, Events, outros), Sistemas Operacionais, funcionalidades avançadas (SQL) e tecnologias adicionais (SQL).
    
    Link do trabalho: https://docs.google.com/spreadsheets/d/1Rzo8wbJM9VhgOWFN7id0kirkiQ-FGpXuWczMBFygtSY/
*/

use bd2024;

drop procedure if exists sp_lista_cliente_sexo_bairro;

delimiter ##
create procedure sp_lista_cliente_sexo_bairro(psexo char(1),
												pbairro varchar(40))
begin
    select clicodigo Codigo, clinome CLiente,
			clisexo Sexo, clirendamensal Renda,
            estdescricao Estado_Civil, bainome Bairro
	from cliente
    inner join bairro on baicodigo = clibaicodigo
    inner join estadocivil on estcodigo = cliestcodigo
    where bainome = pbairro and clisexo = psexo
    order by clinome;
end ##
delimiter ;

call sp_lista_cliente_sexo_bairro('f', 'cachoeirinha');