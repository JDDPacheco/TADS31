/*
Instituto Federal de Educação, Ciência e Tecnologia do Amazonas -IFAM
Tecnologia em Análise e Desenvolvimento de Sistemas
Prof. Marcelo Chamy Machado
Aluno: José Diogo Dutra Pacheco

ABD – 4a Lista de Exercícios – Funções e estruturas de repetição.

Março de 2024

Crie as funções / stored procedures para resolver o que está sendo solicitado nos enunciados abaixo:
1. Considerando que cada vogal possui os seguintes valores numéricos:
A = 1; E = 2; I = 3; O = 4; U = 5

Retorne o valor equivalente à soma de todas as vogais de um parâmetro string de n posições.
a. Exemplo:
Select f_total_vogais(“BANCO DE DADOS - BANCO”);

Resultado: 12
*/
-- Inicialização: incluindo o scriptSQL para o bd2024 e ativando a criação de funções
use bd2024;
set global log_bin_trust_function_creators = 1;

-- Início da resolução da questão 1

-- Criada função para retornar o valor exato de uma vogal fornecida como parâmetro
drop function if exists f_valor_vogal;
delimiter ##
create function f_valor_vogal(p_vogal char(1)) returns int
begin
    if p_vogal = 'a' then
		return 1;
	elseif p_vogal = 'e' then
		return 2;
	elseif p_vogal = 'i' then
		return 3;
	elseif p_vogal = 'o' then
		return 4;
	elseif p_vogal = 'u' then
		return 5;
	else
		return 0;
    end if;
end ##
delimiter ;

-- Criada função para retornar o valor total das vogais encontradas em uma string de entrada
drop function if exists f_valor_total_vogais;
delimiter ##
create function f_valor_total_vogais(p_string varchar(100)) returns int
begin
    declare v_contador int default 1;
    declare v_tam_string int default 0;
    declare v_valor_vogais int default 0;
    
    set v_tam_string = length(p_string);
    
    while(v_contador <= v_tam_string) do
        if (select f_is_vogal(substring(p_string,v_contador,1))) then
			set v_valor_vogais = v_valor_vogais + f_valor_vogal(substring(p_string,v_contador,1));
        end if;
        set v_contador = v_contador + 1;
    end while;
    return v_valor_vogais;
end ##
delimiter ;

-- Chamada da função
select f_valor_total_vogais('BANCO DE DADOS') as 'f_valor_total_vogais';

/*
2. Implemente a função f_meu_left(). As únicas funções permitidas no código são substring(),
length() e concat().
*/

-- Criada função que tem o mesmo comportamento da função nativa left(), mas apenas usando funções específicas
drop function if exists f_meu_left;
delimiter ##
create function f_meu_left(p_string varchar(100), p_limitador smallint unsigned) returns varchar(100)
begin
	declare v_contador int default 1;
    declare v_left varchar(100) default '';
    declare v_limitador smallint unsigned default 0;

    if p_limitador > length(p_string) then
		set v_limitador = length(p_string);
	else
		set v_limitador = p_limitador;
    end if;
    
    while (v_contador <= v_limitador) do
		set v_left = concat(v_left,substring(p_string,v_contador,1));
		set v_contador = v_contador + 1;
    end while;
    return v_left;
    
end ##
delimiter ;

-- Chamada da função
select f_meu_left('BANCO DE DADOS',5) as 'f_meu_left';

/*
3. Implemente a função f_meu_right(), com as mesmas regras de questão 2.
*/

-- Criada função que tem o mesmo comportamento da função nativa rigtht(), mas apenas usando funções específicas
drop function if exists f_meu_right;
delimiter ##
create function f_meu_right(p_string varchar(100), p_inicializador smallint unsigned) returns varchar(100)
begin
    declare v_right varchar(100) default '';
    declare v_inicializador smallint unsigned default 0;
    declare v_tam_string int default 0;
    
    set v_tam_string = length(p_string);
    set v_inicializador = v_tam_string - p_inicializador + 1;
    
    -- set v_right = substring(p_string,v_inicializador); -- Daria pra fazer assim, sem laço de repetição, mas acredito que não era este o intuito do exercício
    
    while (v_inicializador <= v_tam_string) do
		set v_right = concat(v_right,substring(p_string,v_inicializador,1));
		set v_inicializador = v_inicializador + 1;
    end while;
    
    return v_right;
    
end ##
delimiter ;

-- Chamada da função
select f_meu_right('BANCO DE DADOS',5) as 'f_meu_right';

/*
4. Implemente a função f_meu_locate(), sendo que a nossa vai retornar todas as posições que
ocorrem em determinada STRING. Lembre que “string” pode ter 1 ou n posições... 😊
*/

-- Criada função que tem o mesmo comportamento da função nativa locate(), mas apenas usando funções específicas e a função criada anteriormente 'f_meu_right'
drop function if exists f_meu_locate;
delimiter ##
create function f_meu_locate(p_caractere char(1), p_string varchar(10000)) returns varchar(10000)
begin
	declare v_tam_string int default 0;
    declare v_indice int default 1;
    declare v_string_resposta varchar(10000) default '';
    declare v_caractere_atual char (1) default '';
    set v_tam_string = length(p_string);
    while (v_indice <= v_tam_string) do
		set v_caractere_atual = substring(p_string,v_indice,1);
		if v_caractere_atual = p_caractere then
			set v_string_resposta = concat(v_string_resposta,' - ',v_indice);
        end if;
		set v_indice = v_indice + 1;
    end while;
    return f_meu_right(v_string_resposta,(length(v_string_resposta) - 3));
end ##
delimiter ;

select f_meu_locate('D', 'BANCO DE DADOS') as 'f_meu_locate';

/*
5. Implemente uma função que procura pelos seguintes caracteres: ( ) / \ + $ % - ‘ “ e caso
encontre, simplesmente retire do texto.
Exemplo: Select f_limpa_str(“Pro%gra”mação em ban/co-d$e’da)do(s]=\)
Resultado: Programação em banco de dados
*/

-- Função criada para determinar se determinado caractere que entra como parametro deve ser eliminado ou não,
-- para isto ela usa intervalos da tabela ASCII onde os caracteres comuns da língua portuguesa são encontrados nas suas formas maiúsculas e minúsculas
-- retornando 'true' caso o caractere não seja um caractere comum e 'false' cada seja um caractere comum
drop function if exists f_caracter_remover;
delimiter ##
create function f_caracter_remover(p_caractere char(1)) returns boolean
begin
	if ascii(p_caractere) = 32 then
		return false;
	elseif ascii(p_caractere) between 65 and 90 then
		return false;
	elseif ascii(p_caractere) between 97 and 122 then
		return false;
	elseif ascii(p_caractere) between 224 and 250 then
		return false;
	elseif ascii(p_caractere) between 170 and 186 then
		return false;
    else
		return true;
    end if;
end ##
delimiter ;

-- Criada função para receber um string "suja" e retornar "limpa"
drop function if exists f_limpa_str;
delimiter ##
create function f_limpa_str(p_string varchar(10000)) returns varchar(10000)
begin
	declare v_string_resposta varchar(10000) default '';
    declare v_contador int default 1;
    declare v_tam_string int default 0;
    declare v_caractere_atual char(1) default ''; 
    set v_tam_string = length(p_string);
    while (v_contador <= v_tam_string) do
		set v_caractere_atual = substring(p_string,v_contador,1);
        if v_caractere_atual = ' ' then								-- O caso do espaço teve que ser tratado exclusivamente por motivo de o SQL não reconhecer o códido ASCII dele como 32,
			set v_string_resposta = concat(v_string_resposta,' ');	-- mas sim como 0 que seria um caractere vazio na ASCII, e isso faria os espaços serem excluídos junto com os caracteres "estranhos"
		elseif not f_caracter_remover(v_caractere_atual) then
			set v_string_resposta = concat(v_string_resposta,v_caractere_atual);
        end if;
        set v_contador = v_contador + 1;
    end while;
    return v_string_resposta;
end ##
delimiter ;

-- Chamada da função
select f_limpa_str('Pro%gra”mação em ban/co -d$e ’da)do(s]=\'') as 'f_limpar_str';

/*
-- Área de testes para obter melhor os valores da tabela ASCII
-- Esta áres foi utilizada para entender melhor como a função ascii() retorna o valor para determinados caracteres
-- Isso foi importante para determinar a melhor forma de lidar com espaços no texto e com caracteres especiais da língua portuguesa, como letras acentuadas e cedilha

call sp_teste('Pro%gra”mação em ban/co-d$e’da)do(s]=\'');

drop procedure if exists sp_teste;
delimiter ##
create procedure sp_teste(p_string varchar(10000))
begin
	declare v_contador tinyint unsigned default 0;
    declare v_caractere_atual char(1) default '';
    while(v_contador <= length(p_string)) do
		set v_caractere_atual = substring(p_string,v_contador,1);
		select v_caractere_atual as 'Caractere', ascii(v_caractere_atual) as 'ASCII';
        set v_contador = v_contador + 1;
	end while;
end ##
delimiter ;
*/

/*
6. Implemente a função f_capital(), que deve fazer o seguinte:
a. Caso encontre uma letra minúscula no início de uma string ou após um espaço, deve
trocar pela mesma letra maiúscula; (UPPER)
b. Caso encontre uma letra maiúscula no meio de uma palavra, deve trocar por
minúscula. (LOWER)
*/

-- Criação da função UPPER incluindo letras acentudas da língua portuguesa
drop function if exists f_upper;
delimiter ##
create function f_upper(p_caractere char(1)) returns char(1)
begin
	declare v_retorno char(1) default '';
    if ascii(p_caractere) between 97 and 122 then
		set v_retorno = char(ascii(p_caractere) - 32);
	elseif ascii(p_caractere) between 224 and 250 then
		set v_retorno = char(ascii(p_caractere) - 32);
	else
		set v_retorno = p_caractere;
	end if;
    return v_retorno;
end ##
delimiter ;

-- Criação da função LOWER incluindo letras acentudas da língua portuguesa
drop function if exists f_lower;
delimiter ##
create function f_lower(p_caractere char(1)) returns char(1)
begin
	declare v_retorno char(1) default '';
    if ascii(p_caractere) between 65 and 90 then
		set v_retorno = char(ascii(p_caractere) + 32);
	elseif ascii(p_caractere) between 192 and 218 then
		set v_retorno = char(ascii(p_caractere) + 32);
	else
		set v_retorno = p_caractere;
	end if;
    return v_retorno;
end ##
delimiter ;

-- Implementação da função f_capital() conforme critérios exigidos
drop function if exists f_capital;
delimiter ##
create function f_capital(p_string varchar(10000)) returns varchar(10000)
begin
	declare v_caract_ant, v_caract_atual char(1) default '';
    declare v_cont int default 1;
    declare v_tam_string int default 0;
    declare v_string_retorno varchar(10000) default '';
    set v_tam_string = length(p_string);
    while (v_cont <= v_tam_string) do
		set v_caract_atual = substring(p_string,v_cont,1);
        if ascii(v_caract_ant) = 0 then
			set v_string_retorno = concat(v_string_retorno,f_upper(v_caract_atual)); -- Se o anterior for vazio (ou espaço) é chamada a função UPPER
		elseif ascii(v_caract_atual) between 65 and 90 then
			set v_string_retorno = concat(v_string_retorno,f_lower(v_caract_atual)); -- Caso seja uma letra maiúscula não antecedida por vazio, ou seja, está no meio de uma palavra, chamada LOWER
		elseif ascii(v_caract_atual) between 192 and 218 then
			set v_string_retorno = concat(v_string_retorno,f_lower(v_caract_atual)); -- Mesmo caso anterios mas para letras acentuadas e cedilha
		elseif v_caract_atual = ' ' then
			set v_string_retorno = concat(v_string_retorno,' ');	-- Novamente precisamos tratar o espaço de forma especial
		else
			set v_string_retorno = concat(v_string_retorno,v_caract_atual); -- Caso não seja espaço, vazio ou maiúscula, a letra ou caractere é adicionada da forma que está
		end if;
        set v_caract_ant = v_caract_atual;
        set v_cont = v_cont + 1;
    end while;
    return v_string_retorno;
end ##
delimiter ;

select f_capital('ALUNO: joSÉ dIOGO Dutra PACHecO | tads31') as 'f_capital';