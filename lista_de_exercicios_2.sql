USE bd2024;

-- 1) Surgiu a necessidade de registrar e manter histórico de todas as alterações salariais dos  funcionários.
CREATE TABLE historicosalarios(
histcodigo int(11) not null unique auto_increment,
histfuncodigo int(11) NOT NULL,
histantsalario double(6,2) NOT NULL,
histnovosalario double(6,2) NOT NULL,
histdtaumento date DEFAULT current_timestamp,
PRIMARY KEY (histcodigo),
FOREIGN KEY (histfuncodigo) REFERENCES funcionario(funcodigo)
);

-- 2) Escolha 3 funcionários quaisquer, e gere 3 mudanças de salários (aumento) para cada.
UPDATE funcionario SET funsalario = 3186.00
WHERE funcodigo = 1;
INSERT INTO salariohistorico (histfuncodigo, histantsalario, histnovosalario) VALUES (1, 2868.75, 3186.00);

UPDATE funcionario SET funsalario = 2253.00
WHERE funcodigo = 2;
INSERT INTO salariohistorico (histfuncodigo, histantsalario, histnovosalario) VALUES (2, 1721.25, 2253.00);

UPDATE funcionario SET funsalario = 2283.00
WHERE funcodigo = 3;
INSERT INTO salariohistorico (histfuncodigo, histantsalario, histnovosalario) VALUES (3, 1759.50, 2283.00);

SELECT * FROM historicosalario;

-- 3) Mostre os históricos de salários dos funcionários que tenham tido aumento de salário, com nome  e salário (sem os centavos).
SELECT funnome 'Nome', hisantigosalario 'Salário Anterior', hisnovosalario 'Salário Atual'
FROM funcionario
INNER JOIN historicosalario
ON funcodigo = hisfuncodigo;

-- 4) Mostre o total de vendas por sexo de clientes e forma de pagamento.
SELECT clisexo 'Sexo', fpgdescricao 'Forma de Pagamento', COUNT(*) 'Total'
FROM cliente INNER JOIN (SELECT venclicodigo, vendformapagamento, fpgdescricao FROM venda
	INNER JOIN formapagamento ON fpgcodigo=vendformapagamento) subselecao 
ON clicodigo = subselecao.venclicodigo
GROUP BY clisexo;

-- 5) Mostre o nome e saldo do(s) produto(s) mais vendido para clientes do sexo feminino. 
SELECT clisexo 'Sexo', pronome 'Produto', COUNT(*) 'Total Vendido'
FROM cliente INNER JOIN
	(SELECT venclicodigo, pronome FROM venda INNER JOIN 
		(SELECT itvvencodigo, pronome FROM itemvenda INNER JOIN produto ON itvprocodigo = procodigo ) itvproduto
		ON  itvproduto.itvvencodigo = vencodigo ) 
	venda_item ON clicodigo = venda_item.venclicodigo
WHERE clisexo='F'
GROUP BY pronome
ORDER BY COUNT(*) DESC;

-- 6) Mostre o nome e saldo do(s) produto(s) menos vendido para clientes do sexo masculino, solteiros  ou divorciados. 
SELECT clisexo 'Sexo', estdescricao 'Estado Civil', pronome 'Produto', COUNT(*) 'Total vendidos'
FROM cliente INNER JOIN estadocivil ON cliestcodigo = estcodigo
INNER JOIN (SELECT venclicodigo, pronome FROM venda INNER JOIN
	(SELECT itvvencodigo, pronome FROM itemvenda INNER JOIN produto
		ON itvprocodigo=procodigo) itvproduto
	ON itvproduto.itvvencodigo = vencodigo) venda_item
ON venda_item.venclicodigo = clicodigo
WHERE clisexo = 'M' AND estdescricao in ('solteiro', 'divorciado')
GROUP BY estdescricao
ORDER BY COUNT(*);

-- 7) Mostre a forma de pagamento mais utilizada e o valor total vendido.
SELECT fpgdescricao 'Forma de Pagamento', SUM(propreco) 'Valor Total', COUNT(*) 'Total da Forma de Pagamento'
FROM formapagamento
INNER JOIN (SELECT vendformapagamento, propreco FROM venda
			INNER JOIN (SELECT itvvencodigo, propreco FROM itemvenda
						INNER JOIN produto ON itvprocodigo = procodigo) itvproduto
                        ON itvproduto.itvvencodigo=vencodigo
)venda_item ON fpgcodigo= venda_item.vendformapagamento
GROUP BY fpgdescricao;
		
-- 8) Mostre os nomes dos vendedores que sejam gerentes de mais de 3 funcionários. 
SELECT ger.funnome, COUNT(*) 'Total Subordinados'
FROM funcionario ger, funcionario sub
WHERE ger.funcodigo = sub.funcodgerente
GROUP BY ger.funnome
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

-- 9) Crie um ranking de vendas por funcionário, mostrando nome, idade e quantidade de vendas  realizadas;
alter table funcionario
add fundtnasc date;

SELECT funnome as 'Nome Vendendor', round(datediff(current_date,fundtnasc)/365.25) as 'Idade', COUNT(*) as 'Total de Vendas'
FROM funcionario
INNER JOIN (SELECT vdnfuncodigo
            FROM vendedor
            INNER JOIN venda ON vdnfuncodigo = venfuncodigo) venda_vendedor
ON venda_vendedor.vdnfuncodigo = funcodigo
GROUP BY funnome
ORDER BY COUNT(*) DESC;

-- 10) Mostre os últimos nomes dos funcionários que não realizaram vendas;
SELECT funnome 'Funcionário', 
	REVERSE(LEFT(
		REVERSE(funnome), LOCATE(' ', REVERSE(funnome))-1)) 'Último Nome'
FROM funcionario LEFT OUTER JOIN
	(SELECT vdnfuncodigo FROM vendedor INNER JOIN venda
		ON vdnfuncodigo = venfuncodigo) venda_vendedor
ON funcodigo = venda_vendedor.vdnfuncodigo 
WHERE venda_vendedor.vdnfuncodigo IS NULL;
SELECT distinct * FROM funcionario LEFT OUTER JOIN
	(SELECT vdnfuncodigo FROM vendedor INNER JOIN venda
		ON vdnfuncodigo = venfuncodigo) venda_vendedor
ON funcodigo = venda_vendedor.vdnfuncodigo ;

-- 11) Mostre a maior renda de cliente por zona;
SELECT zonnome 'Zona', SUM(clirendamensal) 'Renda Total'
FROM zona INNER JOIN
(SELECT baizoncodigo, clirendamensal FROM
	cliente INNER JOIN bairro ON clibaicodigo = baicodigo) clibairro
ON clibairro.baizoncodigo = zoncodigo
GROUP BY zonnome
ORDER BY SUM(clirendamensal);

-- 12) Para cada cliente, mostre seu nome e a data da primeira venda realizada.
SELECT clinome 'Cliente', MIN(vendata) 'Primeira Compra'
FROM cliente INNER JOIN venda ON clicodigo = venclicodigo
GROUP BY clinome
ORDER BY clinome;

-- 13) Mostre os clientes com os 3 menores saldos;
SELECT clinome 'Cliente', clirendamensal 'Renda Mensal'
FROM cliente
ORDER BY clirendamensal LIMIT 3;

-- Esta é a forma correta
select clinome, clirendamensal
from cliente
where clirendamensal <= (select max(clirendamensal)
from (select distinct clirendamensal
from cliente
order by clirendamensal
limit 3) as rendas)
order by clirendamensal
;
#Exemplo de subconsulta
select max(clirendamensal)
from (select distinct clirendamensal
from cliente
order by clirendamensal
limit 3) as rendas;

update cliente set clirendamensal = '7520' where clicodigo = '528';

-- 14) Mostre os nomes dos clientes que tenham as 5 maiores rendas.
SELECT clinome 'Cliente', clirendamensal 'Renda Mensal'
FROM cliente
ORDER BY clirendamensal DESC LIMIT 5;