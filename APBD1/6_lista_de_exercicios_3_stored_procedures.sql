# Aluno: José Diogo Dutra Pacheco
# Turma: TADS31


-- 1) Mostre os históricos de alterações de salários de um determinado funcionário (nome do funcionário, data de alteração e valor do salário). Utilize o código do funcionário como parâmetro da SP.

delimiter ##
drop procedure if exists sp_atualizacoes_salarios;
create procedure sp_atualizacoes_salarios(p_funcodigo int)
begin

    declare v_achou_funcionario boolean default false;
    set v_achou_funcionario = (select count(*) 
                                from funcionario
                                where funcodigo = p_funcodigo);
    
    if not v_achou_funcionario then
        select 'Não existe funcionário cadastrado com este código' as resposta;
    else
        select funnome as 'Nome do funcionário', 
               histdtaumento as 'Data de alteração', 
               histnovosalario as 'Valor do salário'
        from funcionario 
        inner join historicosalarios on histfuncodigo = funcodigo
        where funcodigo = p_funcodigo;
    end if;

end ##

delimiter ;


-- 2) Crie (em uma única stored procedures) opções para inserção, atualização e deleção de clientes. Defina os parâmetros de forma adequada para cada operação, e valide os campos que são chaves estrangeiras, fazendo os devidos tratamentos e envio de mensagens de erros.
drop procedure if exists sp_crud_cliente;
delimiter ##
create procedure sp_crud_cliente(p_opcao INT(1), -- 1: Inserir, 2: Atualizar, 3: Deletar
				p_clicodigo INT(11),
				p_clisexo CHAR(1),
				p_clirendamensal DOUBLE(6,2),
				p_clinome VARCHAR(60),
				p_clibaicodigo INT(11),
				p_clifone VARCHAR(10),
				p_cliestcodigo INT(11),
				p_clidtdesativacao DATE)

begin
	declare v_cliente_valido, v_sexo_valido, v_renda_valida, v_bairro_valido, v_estcivil_valido boolean default false;

	set v_cliente_valido = (select count(clicodigo)
				from cliente
				where clicodigo = p_clicodigo);

	set v_sexo_valido = p_clisexo in ('F', 'M');

	set v_renda_valida = p_clirendamensal > 0;

	set v_bairro_valido = (select count(baicodigo)
				from bairro
				where baicodigo = p_clibaicodigo);

	set v_estcivil_valido = (select count(estcodigo)
				from estadocivil
				where estcodigo = p_cliestcodigo);

	case p_opcao	-- Seleção da operação
	when 1 then	-- Inserir

		-- Tratativa de erros
		if not v_sexo_valido then
			select 'Sexo inválido. Deve ser "F" ou "M"' as resposta;
		elseif not v_renda_valida then
			select 'A renda deve ser maior que 0' as resposta;
		elseif not v_bairro_valido then
			select 'O código do bairro não é válido' as resposta;
		elseif not v_estado_valido then
			select 'O código do estado não é válido' as resposta;
		elseif v_cliente_valido then
			select 'Cliente já cadastrado' as resposta;
		else
			-- Implementação do Inserir
			insert into cliente(clisexo, clirendamensal, clinome, clibaicodigo, clifone, cliestcodigo, clidtcadastro, clidtdesativacao) 
			values (p_clisexo, p_clirendamensal, p_clinome, p_clibaicodigo, p_clifone, p_cliestcodigo, curdate(), p_clidtdesativacao);
		end if;

	when 2 then	-- Atualizar

		-- Tratativa de erros
		if not v_sexo_valido then
			select 'Sexo inválido. Deve ser "F" ou "M"' as resposta;
		elseif not v_renda_valida then
			select 'A renda deve ser maior que 0' as resposta;
		elseif not v_bairro_valido then
			select 'O código do bairro não é válido' as resposta;
		elseif not v_estado_valido then
			select 'O código do estado não é válido' as resposta;
		elseif not v_cliente_valido then
			select 'Cliente não encontrado' as resposta;
		else

			-- Implementação do Atualizar
			update cliente
			set clisexo =	p_clisexo,
					clirendamensal = p_clirendamensal,
					clinome = p_clinome,
					clibaicodigo = p_clibaicodigo,
					clifone = p_clifone,
					cliestcodigo = p_cliestcodigo,
					clidtdesativacao = p_clidtdesativacao
					where clicodigo = p_clicodigo;
		end if;

        when 3 then	-- Deletar

		-- Tratativa de erros
		if not v_cliente_valido then
			select 'Erro: Cliente não existe' as resposta;

		else

                	-- Implementação do Deletar
			delete from clientestatus
			where csclicodigo = p_clicodigo;
		end if;
	else
		select 'Erro: Operação solicitada não existe' as resposta;
    end case;
end ##

delimiter ;


-- 3) Mostre o total de vendas por sexo de clientes e forma de pagamento.
drop procedure if exists sp_vendas_p_sexo_fpagamento;
delimiter ##

create procedure sp_vendas_p_sexo_fpagamento()

begin
	declare  v_vendas boolean default false;

	set v_vendas = (select count(vencodigo)
				from venda);

	if not v_vendas then
		select 'Nenhuma venda realizada' as resposta;
	else
		select clisexo 'Sexo', fpgdescricao 'Forma de pagamento', count(*)
		from cliente
		join venda on clicodigo = venclicodigo
		join formapagamento on vendformapagamento = fpgcodigo
		group by clisexo, fpgdescricao;
	end if;

end ##

delimiter ;


-- 4) Mostre o nome e saldo do(s) produto(s) mais vendido de um determinado grupo de produtos (parâmetro).

drop procedure if exists sp_produtos_saldo;

delimiter ##

create procedure sp_produtos_saldo(p_grpcodigo int(11))

begin

	declare v_grupo_produto boolean default false;

	set v_grupo_produto = (select count(grpcodigo)
				from grupoproduto
				where grpcodigo = p_grpcodigo);

	if not v_grupo_produto then
		select 'Não existem registros para este grupo' as resposta;
	else
		select pronome 'Nome do produto', prosaldo 'Saldo do produto'
		from venda
		join itemvenda on vencodigo=itvvencodigo
		join produto on itvprocodigo=procodigo
		join grupoproduto on progrpcodigo=grpcodigo
		where grpcodigo=p_grpcodigo and pronome in (select pronome
													from venda
													join itemvenda on vencodigo=itvvencodigo
													join produto on itvprocodigo=procodigo
													join grupoproduto on progrpcodigo=grpcodigo
													where grpcodigo=p_grpcodigo
													group by itvqtde, pronome
													order by sum(itvqtde) desc)
		group by pronome, prosaldo
		having sum(itvqtde)=(select sum(itvqtde)
					from venda
					join itemvenda on vencodigo=itvvencodigo
					join produto on itvprocodigo=procodigo
					join grupoproduto on progrpcodigo=grpcodigo
					where grpcodigo=p_grpcodigo
					group by pronome
					order by sum(itvqtde)
					limit 1);
	end if;

end ##

delimiter ;

call sp_produtos_saldo(5);

-- 5) Mostre o nome e saldo do(s) produto(s) menos vendido para clientes de um determinado sexo (parâmetro 1) e de um estado civil (parâmetro 2).

delimiter ##

drop procedure if exists sp_produtos_saldo_sexo_estado;

create procedure sp_produtos_saldo_sexo_estado(p_clisexo char(1), p_cliestcodigo int(11))

begin

	declare v_sexo_valido, v_estcivil_valido boolean default false;

	set v_sexo_valido = p_clisexo in ('F', 'M');
	
	set v_estcivil_valido = (select count(estcodigo)
				from estadocivil
				where estcodigo = p_cliestcodigo);

    if not v_sexo_valido then
		select 'O sexo informado não é válido' as resposta;
    elseif not v_estcivil_valido then
			select 'O estado civil não é válido' as resposta;
	else
		select pronome 'Nome do produto', prosaldo 'Saldo do produto'
		from cliente
		join venda on clicodigo = venclicodigo
		join itemvenda on vencodigo = itvvencodigo
		join produto on itvprocodigo=procodigo
		where clisexo = p_clisexo 
		and cliestcodigo = p_cliestcodigo
		and pronome in (select pronome
						from cliente
						join venda on clicodigo=venclicodigo
						join itemvenda on vencodigo=itvvencodigo
						join produto on itvprocodigo=procodigo
						where clisexo=p_clisexo 
						and cliestcodigo=p_cliestcodigo
						group by pronome, prosaldo
						having sum(itvqtde) = ( select sum(itvqtde)
												from cliente
												join venda on clicodigo=venclicodigo
												join itemvenda on vencodigo=itvvencodigo
												join produto on itvprocodigo=procodigo
												where clisexo=p_clisexo 
												and cliestcodigo=p_cliestcodigo
												group by pronome
												order by sum(itvqtde)
												limit 1))
		group by pronome, prosaldo;
	end if;
end ##
delimiter ;

call sp_produtos_saldo_sexo_estado('m', 1);

-- 6) Mostre os nomes dos clientes que tenham gerado mais de uma venda e que tenham os nomes iniciando com determinada letra (parâmetro).

drop procedure if exists sp_compra_cliente;

delimiter ##
create procedure sp_compra_cliente(p_inicial char(1))
begin
    declare v_inicial boolean default false;

	set v_inicial = p_inicial not in ('1','2','3','4','5','6','7','8','9','0','!','?','.',' ','´');

	if not v_inicial then
		select 'A inicial precisa ser uma letra do alfabeto' as resposta;
	else
		select clinome 'Nome do Cliente', count(*) 'Qtd de Compras'
		from cliente 
		join venda on venclicodigo = clicodigo
		where left(clinome,1) = p_inicial
		group by clinome
        having count(*) > 1
		order by count(*) desc;
    end if;
end ##
delimiter ;

CALL sp_compra_cliente('r');

-- 7) Mostre a maior renda de cliente para uma zona (parâmetro);

delimiter ##

drop procedure if exists sp_maior_renda_zona;

create procedure sp_maior_renda_zona(p_zoncodigo int(11))

begin
    declare v_zona_existe, v_cliente_existe boolean default false;
    
    set v_zona_existe = (select count(*) 
						from zona 
						where zoncodigo=p_zoncodigo);
	if (select count(*) 
		from zona 
        join bairro on baizoncodigo=zoncodigo 
        join cliente on clibaicodigo=baicodigo 
        where zoncodigo = p_zoncodigo) > 0 then
        set v_zona_existe = TRUE;
	end if;
    
    if v_zona_existe is not true then
		select 'Zona não cadastrada' as resposta;
    else 
        if v_cliente_existe is not true then
			select 'Não existem clientes cadastrados para esta zona' as resposta;
		else
			select zonnome 'Nome da Zona', max(clirendamensal) 'Maior Renda' 
            from cliente 
            join bairro on clibaicodigo=baicodigo 
            join zona on baizoncodigo=zoncodigo 
            where zoncodigo=p_zoncodigo
            group by zonnome;
        end if;
	end if;
end ##
delimiter ;

call sp_maior_renda_zona(2);

-- 8) Para cada cliente, mostre seu nome e a data da primeira venda realizada.

drop procedure if exists sp_primeira_compra;

delimiter ##
create procedure sp_primeira_compra()
begin
    declare v_cliente, v_venda boolean default false;
    
    if (select count(*) 
		from cliente) > 0 then
        set v_cliente = TRUE;
	end if;
    
    if (select count(*) 
		from venda) > 0 then
        set v_venda = TRUE;
	end if;
    
	if v_cliente is not true then
		select 'Sem clientes na lista' as resposta;
    else
		if	v_venda is not true then
			select 'Não Há vendas registradas' as resposta;
        else
			select clinome 'Nome do Cliente', min(vendata) 'Primeira compra' 
			from cliente 
			join venda on venclicodigo=clicodigo
			group by clinome
			order by clinome;
		end if;
    end if;
end ##
delimiter ;

call sp_primeira_compra;