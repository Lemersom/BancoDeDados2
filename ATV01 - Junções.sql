--Atividade 1 - Junções

/*1:
Mostre o código e o nome de todos os auxiliares bilíngues que ganham mais que R$ 1.000,00.
*/

SELECT auxiliar.nome, auxiliar.codigo
FROM auxiliar
WHERE bilingue and salario > 1000;


/*2:
Mostre o código, o nome e o departamento dos Projetistas que não são iniciantes.
*/

SELECT projetista.codigo, nome, departamento
FROM projetista, funcionario
WHERE tipo != 'Iniciante' and
	   funcionario.codigo = projetista.codigo;


/*3:
Mostre o nome, o salário e o departamento dos engenheiros com CREA do PR (código CREA começa com 'PR').
*/

SELECT nome, salario, departamento
FROM engenheiro, funcionario
WHERE funcionario.codigo = engenheiro.codigo and
	   engenheiro.crea like 'PR%';


/*4:
Mostre os nomes dos departamentos que têm engenheiros civis.
*/

SELECT DISTINCT funcionario.departamento
FROM engenheiro, funcionario
WHERE engenheiro.codigo = funcionario.codigo and
	   engenheiro.especialidade = 'Civil';
	   
/*5:
Mostre os nomes dos departamentos que têm Projetista Senior e Auxiliar bilíngue.
*/

SELECT funcionario.departamento
FROM projetista, funcionario
WHERE projetista.codigo = funcionario.codigo and
	  projetista.tipo = 'Senior'
AND funcionario.departamento in (SELECT departamento
FROM funcionario, auxiliar
WHERE auxiliar.codigo = funcionario.codigo and
	auxiliar.bilingue);
	   
