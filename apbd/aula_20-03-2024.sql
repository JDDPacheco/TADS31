use bd2024;

/*
Aula do dia 20/03/2024
*/

/*
1) Criar a tabela funcionariocomissao(fcfuncodigo,fcanomes,fcvalor) relacionada a tabela funcionario.
fcanomes: char(6) - ex.: "202403"											----- grupo produto
fcvalor: decimal (6,2) - ex.: 9999,99										|
																			v
fórmula do valor da comissão: valcomissao = (somatório (preco * qtd * grupocomissao))/100 -> stored procedure

2) Procedures para:
	2.1 -> inserir venda
    2.2 -> inserir item venda (controlar saldo)
    2.3 -> atualizar saldo do produto
    2.4 -> atualizar comissão vendedor
*/

-- 1)
-- Criar tabela
drop table funcionariocomissao;
create table if not exists funcionariocomissao(
fcfuncodigo int(11) not null,
fcanomes char(6) not null,
fcvalor decimal(7,2) unsigned default 0,
primary key (fcfuncodigo),
foreign key (fcfuncodigo) references funcionario(funcodigo)
);

-- stored procedure para popular a tabela de funcionariocomissao
insert into funcionariocomissao (fcfuncodigo, fcanomes, fcvalor)
select 	funcodigo,
	   	DATE_FORMAT(v.vendata, '%Y%m') AS fcanomes,
	  	-- sum((i.itvqtde * p.propreco)) as valorVenda,
	  	sum(ROUND(i.itvqtde * p.propreco * g.grpcomissao)/100) as valorComissao
from 		bd2024.itemvenda i 
left join 	bd2024.venda v on v.vencodigo = i.itvvencodigo 
inner join 	bd2024.funcionario f on f.funcodigo = v.venfuncodigo 
left JOIN	bd2024.produto p on p.procodigo = i.itvprocodigo
left join	bd2024.grupoproduto g on g.grpcodigo = p.progrpcodigo
group by 1,2;

drop procedure if exists sp_calcular_comissao;
delimiter ##
create procedure sp_calcular_comissao(p_vencodigo int)
begin
	-- (somatório (preco * qtd * grupocomissao))/100
	declare v_contador int default 0;
	declare v_anomes char(6) default '';
	declare v_valorcomissao decimal(6,2) default 0;
    declare v_funcodigo int(11) default (select venfuncodigo from venda where vencodigo = p_vencodigo); -- pega o código do vendedor
	set v_anomes = concat(	left((select vendata from venda where vencodigo = p_vencodigo),4),
							right(left((select vendata from venda where vencodigo = p_vencodigo),7),2) -- pega a data no formato 'AAAAMM'
						);
	if (select count(*) from funcionariocomissao where fcfuncodigo = v_funcodigo) then
		set v_valor_comissao = (select fcvalor from funcionariocomissao where fcfuncodigo = v_funcodigo);
	else
		set v_valor_comissao = v_valor_comissao;
    end if;
    
end ##
delimiter ;

call sp_calcular_comissao(1);

/*
Área de testes

concat(left(current_date(),4),right(left(current_date(),7),2)) -- obter anomes no formato correto com current_date

*/

select *
from venda;

-- qtd
select itvqtde
from itemvenda inner join venda
on itvvencodigo = vencodigo
where vencodigo = 1;

-- preco
select propreco
from produto
where procodigo in (select itvprocodigo
from itemvenda inner join venda
on itvvencodigo = vencodigo
where vencodigo = 1)
;

-- grpcomissao
select grpcomissao
from grupoproduto inner join produto
where ;

select *
from itemvenda;


select venfuncodigo
		from venda;


/*

ACID:
- Atomicidade
- Consistencia
- Isolamento
- Durabilidade

START TRANSACTION

COMMIT;

Caso apresente erro: ROLLBACK;

begin...
logo após o último declare...
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
	ROLLBACK;
    SELECT "ERRO DETECTADO...OPERAÇÕES CANCELADAS";
END;
	antes de começar alterações...
	START TRANSACTION;
		[aqui vem lógica que faz alterações no banco]
		após o fim da alteração...
    COMMIT;
end##

*/