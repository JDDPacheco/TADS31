/*
	Utilizando o information_schema, crie stored procedure para:
    
    1) Mostrar a(s) tabela(s) com a {maior/menor} quantidade de relacionamentos;
    2) Mostrar o total de caracteres a partir dos campos de uma {tabela};
    3) Mostrar os campos que são chaves estrangeiras de {uma tabela} e ajuda as tabelas relacionadas e campos referenciados

*/

/*
Documentação de information_schema MySQL: https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.7/en/information-schema-character-sets-table.html
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
	select table_name, sum(CHARACTER_MAXIMUM_LENGTH) 'QTD de Caracteres'
	from information_schema.COLUMNS
	where table_schema = 'bd2024'
	and table_name = v_tabela
    and DATA_TYPE in ('varchar','char')
    GROUP BY table_name;

end //
DELIMITER ;
call sp_total_caracteres_by_tabela('cliente');

-- 3)
drop procedure if exists sp_chaves_estrangeiras_by_tabela;
DELIMITER //
create procedure sp_chaves_estrangeiras_by_tabela(v_tabela VARCHAR(255))
begin
	select COLUMN_NAME, REFERENCED_TABLE_NAME , REFERENCED_COLUMN_NAME
    from information_schema.KEY_COLUMN_USAGE
    where table_schema = 'bd2024'
    and table_name = v_tabela
    and REFERENCED_TABLE_NAME is not null
    and REFERENCED_COLUMN_NAME is not null;
end //
DELIMITER ;
call sp_chaves_estrangeiras_by_tabela('cliente');
