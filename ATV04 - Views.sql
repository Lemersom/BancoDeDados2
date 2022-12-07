--Atividade 4 - Views


/*1a:
A visão EngenheirosDepto deve mostrar o código, o nome, o salário, 
a especialidade e o departamento de todos os engenheiros. 
*/

CREATE VIEW EngenheirosDepto AS
SELECT codigo, nome, salario, especialidade, departamento
FROM engenheiro NATURAL JOIN funcionario;


/*1b:
A visão AuxiliaresBilingues deve mostrar o código, o nome 
e o departamento dos auxiliares bilíngues. 
*/

CREATE VIEW AuxiliaresBilingues AS
SELECT codigo, nome, departamento 
FROM auxiliar NATURAL JOIN funcionario
WHERE auxiliar.bilingue = 'true';

/*1c:
A visão ProjetistasSenior deve mostrar o código, o nome, o nível 
e o departamento dos Projetistas Senior. 
*/

CREATE VIEW ProjetistasSenior AS
SELECT codigo, nome, nivel, departamento FROM projetista NATURAL JOIN funcionario
WHERE tipo = 'Senior'

/*1d:
A visão Salarios deve mostrar o nome, o departamento 
e o salário de todos os funcionários.
*/

CREATE VIEW Salarios AS
SELECT nome,departamento, salario from engenheiro NATURAL JOIN funcionario
UNION
SELECT nome, departamento, salario from projetista NATURAL JOIN funcionario
UNION
SELECT nome, departamento, salario from auxiliar NATURAL JOIN funcionario


/*2a:
Mostre os nomes dos Projetistas Senior de nível A do Departamento de Obras. 
*/

SELECT nome, nivel FROM ProjetistasSenior
WHERE departamento = 'Obras' and nivel = 'A';

/*2b:
Mostre o nome do departamento e a média de salário dos engenheiros 
em cada departamento. 
*/

SELECT departamento, ROUND(AVG(salario), 2)
FROM EngenheirosDepto GROUP BY (departamento)

/*2c:
Mostre os departamentos que têm tanto projetistas senior 
quanto auxiliares bilíngues.
*/

SELECT DISTINCT departamento FROM ProjetistasSenior JOIN AuxiliaresBilingues USING(departamento)

/*2d:
Mostre o nome de cada departamento seguido do 
custo total (soma dos salários) com funcionários do departamento. 
Para as colunas use os nomes “departamento” e “custo”. 
*/

SELECT departamento, ROUND(SUM(salario), 2) AS Custo FROM Salarios
GROUP BY (departamento)

