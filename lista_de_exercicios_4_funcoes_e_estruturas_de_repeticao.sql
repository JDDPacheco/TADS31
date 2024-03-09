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

2. Implemente a função f_meu_left(). As únicas funções permitidas no código são substring(),
length() e concat().
3. Implemente a função f_meu_right(), com as mesmas regras de questão 2.
4. Implemente a função f_meu_locate(), sendo que a nossa vai retornar todas as posições que
ocorrem em determinada STRING. Lembre que “string” pode ter 1 ou n posições... 😊
5. Implemente uma função que procura pelos seguintes caracteres: ( ) / \ + $ % - ‘ “ e caso
encontre, simplesmente retire do texto.
Exemplo: Select f_limpa_str(“Pro%gra”mação em ban/co-d$e’da)do(s]=\)
Resultado: Programação em banco de dados
6. Implemente a função f_capital(), que deve fazer o seguinte:
a. Caso encontre uma letra minúscula no início de uma string ou após um espaço, deve
trocar pela mesma letra maiúscula; (UPPER)
b. Caso encontre uma letra maiúscula no meio de uma palavra, deve trocar por
minúscula. (LOWER)
*/

-- Resolução das questões

-- 1.
