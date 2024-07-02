-- stored procedure
## Aula 28/02/2024
use bd2024;

-- 1) listar bairros
drop procedure if exists sp_lista_bairro;
delimiter ##
create procedure sp_lista_bairro()
begin
	select bainome, clinome
    from bairro
    inner join cliente
		on baicodigo = clibaicodigo;
end ##
delimiter ;

call sp_lista_bairro();

-- 2) listar clientes por bairros
drop procedure if exists sp_cliente_por_bairro;
delimiter ##
create procedure sp_cliente_por_bairro(
										p_bairro varchar(30))
begin
    select bainome, clinome
    from bairro
    inner join cliente
		on baicodigo = clibaicodigo
	where bainome = p_bairro;
end ##
delimiter ;

call sp_cliente_por_bairro('centro');

-- 3) listar clientes por bairro e sexo
drop procedure if exists sp_cliente_por_bairrosexo;
delimiter ##
create procedure sp_cliente_por_bairrosexo(
										p_bairro varchar(30),
                                        p_sexo char(1))
begin
    select bainome, clinome, clisexo
    from bairro
    inner join cliente
		on baicodigo = clibaicodigo
	where bainome = p_bairro
    and clisexo = p_sexo;
end ##
delimiter ;

call sp_cliente_por_bairrosexo('parque 10','f');

-- 4) listar cliente por bairro e sexo, retornando uma mensagem quando o termo de busca(parâmetro de entrada) for inválido
drop procedure if exists sp_cliente_por_bairro_sexo;
delimiter ##

create procedure sp_cliente_por_bairro_sexo(
										p_bairro varchar(30),
                                        p_sexo char(1))
begin
	declare v_achoubairro, v_achousexo boolean default false;
    
    set v_achoubairro = (select count(*)
						from bairro
						where bainome = p_bairro);
                        
	set v_achousexo = p_sexo in ('m', 'f');
    
    if not v_achousexo and not v_achoubairro then
		select 'Sexo inválido e bairro inexistente.' as resposta;
	elseif
		not v_achousexo then
		select 'Sexo inválido' as resposta;
	elseif
		not v_achoubairro then
		select 'Bairro inexistente' as resposta;
	else
		select bainome, clinome, clisexo
		from bairro
		inner join cliente on baicodigo = clibaicodigo
		where bainome = p_bairro
		and clisexo = p_sexo;
	end if;
end ##
delimiter ;

/*
drop procedure sp_cliente_por_bairro_sexo;
*/

call sp_cliente_por_bairro_sexo('centro','m');

/*
Exercícios

Crie uma SP para alterar o salário de determinado funcionário.
Obs.: Caso o funcionario já esteja demitido, retornar erro.
Obs.Harley: O salário não pode diminuir.
*/
-- Area de Testes
/*
select count(funcodigo)
							from funcionario
                            where funsalario < 1759.49
                            and funcodigo = '3';

select v_demitido;
*/
drop procedure if exists sp_alterar_salario;
delimiter ##
create procedure sp_alterar_salario(p_funcodigo int(11), p_novosalario double(6,2))
begin
	declare v_demitido, v_funcionariovalido, v_salariomaior boolean default false;
    set v_demitido = (select count(fundtdem)
						from funcionario
						where funcodigo = p_funcodigo);
	set v_funcionariovalido = (select count(funcodigo)
								from funcionario
								where funcodigo = p_funcodigo);
	set v_salariomaior = (select count(funcodigo)
							from funcionario
                            where funsalario < p_novosalario
                            and funcodigo = p_funcodigo);
	
    if not v_funcionariovalido then
		select 'Não existe funcionário correspondente a este código.' as resposta;
	elseif
		v_demitido then
		select 'Funcionário já foi demitido' as resposta;
	elseif
		not v_salariomaior then
		select 'O novo salário não pode ser menor ou igual ao atual.' as resposta;
	else
        update funcionario
        set funsalario = p_novosalario
        where funcodigo = p_funcodigo;
        
        select funcodigo 'Código', funnome 'Nome', funsalario 'Novo Salário'
		from funcionario
		where funcodigo = p_funcodigo;
	end if;
end ##
delimiter ;

/*
drop procedure alterar_salario;
*/

call sp_alterar_salario('3',3005);