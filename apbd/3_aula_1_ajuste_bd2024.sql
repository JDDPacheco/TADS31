#Adiconando formas de pagamento na tabela venda
update venda set vendformapagamento = '1' where vendformapagamento ='0';
#Criando relacionamento de forma de pagamento com venda
alter table venda
add constraint foreign key(vendformapagamento)
references formapagamento(fpgcodigo);

alter table venda 
add constraint foreign key (venfuncodigo)
references vendedor(vdnfuncodigo);

alter table vendedor
add constraint foreign key(vdnfuncodigo) 
references funcionario(funcodigo);

select funcodigo from funcionario order by funcodigo;
desc formapagamento;