/*
	Utilizando o information_schema, crie stored procedure para:
    
    1) Mostrar a(s) tabela(s) com a {maior/menor} quantidade de relacionamentos;
    2) Mostrar o total de caracteres a partir dos campos de uma {tabela};
    3) Mostrar os campos que são chaves estrangeiras de {uma tabela} e ajuda as tabelas relacionadas e campos referenciados

*/

-- 1)
drop procedure if exists sp_tabela_maior_menor_relacionamentos;
DELIMITER //
create procedure sp_tabela_maior_menor_relacionamentos()
begin
    select table_name 'Nome da Tabela', COUNT(*) 'QTD de Relacionamentos'
    from information_schema.KEY_COLUMN_USAGE
    where constraint_schema = 'bd2024'
    group by table_name
    order by count(*) desc;
end //
DELIMITER ;
call sp_tabela_maior_menor_relacionamentos();

-- 2)
drop procedure if exists sp_total_caracteres_by_tabela;
DELIMITER //
CREATE PROCEDURE sp_total_caracteres_by_tabela(v_tabela VARCHAR(255))
begin
	select t.table_name, sum(CHARACTER_MAXIMUM_LENGTH) 'QTD de Caracteres'
	FROM information_schema.TABLES t
	JOIN information_schema.COLUMNS c ON t.table_schema = c.table_schema AND t.table_name = c.table_name
	WHERE t.table_schema = 'bd2024'
	AND t.table_name = v_tabela and c.table_name = v_tabela
    and c.DATA_TYPE in ('varchar','char')
    GROUP BY t.table_name;

END //
DELIMITER ;
call sp_total_caracteres_by_tabela('cliente');

-- 3)
