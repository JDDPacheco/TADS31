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
create table if not exists funcionariocomissao(
fcfuncodigo int(11) not null,
fcanomes char(6) not null,
fcvalor decimal(6,2) unsigned default 0,
primary key (fcfuncodigo),
foreign key (fcfuncodigo) references funcionario(funcodigo)
);

-- stored procedure para calcular a comissão
drop procedure if exists sp_calcular_comissao;
delimiter ##
create procedure sp_calcular_comissao(p_vencodigo int)
begin
-- (somatório (preco * qtd * grupocomissao))/100
declare v_contador int default 0;
declare v_anomes char(6) default '';
declare v_valorcomissao decimal(6,2) default 0;
set v_anomes = concat(	left((select vendata from venda where vencodigo = p_vencodigo),4),
						right(left((select vendata from venda where vencodigo = p_vencodigo),7),2)
					);

end ##
delimiter ;

call sp_calcular_comissao(1);

/*
Área de testes

concat(left(current_date(),4),right(left(current_date(),7),2)) -- obter anomes no formato correto com current_date

*/

select *
from venda;
