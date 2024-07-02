use bd2024;

set global log_bin_trust_function_creators = 1; -- Necessário para implementar functions em MySQL

drop procedure if exists sp_contador;

delimiter ##

create procedure sp_contador(p_numero tinyint)

begin
	declare v_cont tinyint unsigned default 0;
    while(v_cont <= p_numero) do
		select v_cont;
        set v_cont = v_cont + 1;
	end while;
end ##

delimiter ;

call sp_contador(20);

/* Exercícios(SP):

Crie um SP para:

 1) Receber uma string e retorne o conteúdo da cada posição:
 
 2) Receber uma string e retornar somente as vogais contidas:
 Exemplo: 'LKJH2KJH6;LKA;LK3LKJU;LO' retorna 'AOU'
 
 3) Receber um conjunto de caracteres separados por '-' e retornar somente os números contidos nesta string:
Exemplo: 'a-T-3-k-P-2-S-X-0-5-H-Z' retorna '3-2-0-5'

4) Receber um conjunto de números e retornar somente os números pares:

*/

-- Resolução:

-- 1) Receber uma string e retorne o conteúdo da cada posição:
delimiter ##
create procedure sp_cada_posicao(p_string varchar(100))
begin
	declare v_contador int default 1;
    declare v_tam_string int default 0;
    
    set v_tam_string = length(p_string);
    
    while(v_contador <= v_tam_string) do
		select substring(p_string,v_contador,1) as 'Caractere', v_contador as 'Posição';
        set v_contador = v_contador + 1;
    end while;

end ##
delimiter ;

drop procedure sp_cada_posicao;

-- 2) Receber uma string e retornar somente as vogais contidas:
-- Exemplo: 'LKJH2KJH6;LKA;LK3LKJU;LO' retorna 'AUO'

delimiter ##
create function f_is_vogal(p_char char) returns boolean
begin
	if p_char in ('A','E','I','O','U') then
		return true;
    else
		return false;
    end if;
end ##
delimiter ;

drop function f_is_vogal;

delimiter ##
create procedure sp_somente_vogais(p_string varchar(100))
begin
	declare v_contador int default 1;
    declare v_tam_string int default 0;
    declare v_vogais varchar(100) default '';
    declare v_caractere_atual char default null;
    
    set v_tam_string = length(p_string);
    
    while(v_contador <= v_tam_string) do
		set v_caractere_atual = substring(p_string,v_contador,1);
        if (select f_is_vogal(v_caractere_atual)) then
			set v_vogais = concat(v_vogais,v_caractere_atual);
        end if;
        set v_contador = v_contador + 1;
    end while;
	
    select v_vogais as 'Vogais';
	
end ##
delimiter ;

call sp_somente_vogais('LKJH2KJH6;LKA;LK3LKJU;LO');

drop procedure sp_somente_vogais;

-- 3) Receber um conjunto de caracteres separados por '-' e retornar somente os números contidos nesta string:
-- Exemplo: 'a-T-3-k-P-2-S-X-0-5-H-Z' retorna '3-2-0-5'

delimiter ##
create function f_is_number(p_char char) returns boolean
begin
	if ascii(p_char) >= 48 and ascii(p_char) <= 57 then
		return true;
    else
		return false;
    end if;
end ##
delimiter ;

delimiter ##
create procedure sp_somente_numeros(p_string varchar(100))
begin
    declare v_contador int default 1;
    declare v_tam_string int default 0;
    declare v_numeros varchar(100) default '';
    declare v_caractere_atual char default null;
    
    while(v_contador <= v_tam_string) do
		set v_caractere_atual = substring(p_string,v_contador,1);
        if (select f_is_number(v_caractere_atual)) then
			set v_numeros = concat(v_numeros,v_caractere_atual,'-');
        end if;
        set v_contador = v_contador + 1;
    end while;
	
end ##
delimiter ;

select ascii(9);