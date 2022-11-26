--ATV2 - Subconsultas

/*Comentários do Professor:
- Nos exercícios 4 e 5, para listar somente uma vez um par pode ser usado somente '<' ou '>' 
ao invés de '<>' ou '!=' na comparação do nome ou código.
*/

/*1:
Mostre os nomes de departamentos que não têm projetista junior.
*/

SELECT DISTINCT funcionario.departamento FROM funcionario
WHERE funcionario.departamento not in
(SELECT DISTINCT funcionario.departamento FROM projetista Natural Join funcionario
WHERE projetista.tipo = 'Junior');


/*2:
Mostre os nomes e os salários dos engenheiros do Departamento de Obras que ganham mais
que os engenheiros do Departamento de Suporte.
*/

SELECT engenheiro.nome, engenheiro.salario 
from engenheiro Natural Join funcionario
WHERE funcionario.departamento = 'Obras'
and engenheiro.salario > ALL(SELECT engenheiro.salario
							from engenheiro Natural Join
							funcionario
							WHERE funcionario.departamento = 'Suporte');
							

/*3:
Mostre os nomes dos auxiliares de departamentos que têm engenheiros civis.
*/

SELECT auxiliar.nome from auxiliar Natural Join funcionario
WHERE departamento in (SELECT funcionario.departamento 
				FROM engenheiro Natural Join funcionario
				Where engenheiro.especialidade = 'Civil');
				
				
/*4:
Mostre os pares de nomes dos projetistas que têm ambos o mesmo nível e tipo. 
Um par deve ser listado somente uma vez; por exemplo, mostre (x,y) mas não (y,x).
*/

SELECT DISTINCT X.nome, Y.nome
FROM projetista as X, projetista as Y
WHERE (X.nivel = Y.nivel and X.tipo = Y.tipo
	 and X.nome <> Y.nome);
	 

/*5:
Mostre os nomes dos departamentos que possuem engenheiros que têm ambos a mesma especialidade e 
crea do mesmo estado. Pesquise e use a função SUBSTRING para resolver esse exercício.
*/

SELECT DISTINCT X.departamento FROM (funcionario Natural Join engenheiro) as X, 
(funcionario Natural Join engenheiro) as Y 
WHERE (substring(X.crea, 1, 2) = substring(Y.crea, 1, 2) and
	   X.especialidade = Y.especialidade and
	   X.departamento = Y.departamento and
	   X.codigo != Y.codigo);
