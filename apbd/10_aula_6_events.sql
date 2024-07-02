use bd2024;

-- Criar tabela 'tempoespera'
create table if not exists tempoespera(
	teclicodigo int(11),
    tetempo int unsigned,
    primary key(teclicodigo, tetempo),
    foreign key (teclicodigo) references cliente(clicodigo)
);

-- adicionar campo 'clisituacao' na tabela 'cliente'
alter table cliente
add clisituacao tinyint default 0;

-- Trigger para adicionar novo registro na tabela 'tempoespera' sempre que o 'clisituacao' for modificado
drop trigger if exists adicionar_tempo_espera;
delimiter //
create trigger adicionar_tempo_espera
after update on cliente
for each row
begin
    if (new.clisituacao = 1 and old.clisituacao != 1) then
        insert into tempoespera values (new.clicodigo, 0);
	elseif(old.clisituacao <> new.clisituacao and new.clisituacao = 0) then
    	delete from tempoespera where teclicodigo = old.clicodigo;
    end if;
end;
//
delimiter ;

-- Criando event para adicionar 1 segundo a cada segundo
drop event if exists ev_monitor_espera;
create event ev_monitor_espera
on schedule
-- starts
-- ends 
every 1 second do
update tempoespera
set tetempo = tetempo + 1;


/** Área de Testes

-- alterar a situação de um cliente
update cliente set clisituacao = 1 where clicodigo = 5;

-- ver
select * from tempoespera;

select current_timestamp();

alter table tempoespera
add column tetempominuto int unsigned;
*/