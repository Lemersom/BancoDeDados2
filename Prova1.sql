--Prova 1

/*Comentários do Professor:
Questão 1 (1,5/2,5): Há erro de lógica. O fato de um departamento ter um auxiliar
que não é bilíngue não quer dizer que não há no mesmo departamento um outro auxiliar
que seja bilíngue. Para selecionar os departamentos sem auxiliares bilíngues 
era necessário identificar os departamentos que têm esses funcionários e exclui-los 
dos demais departamentos usando EXCEPT ou NOT IN.
*/


/*1:
Para redistribuir os auxiliares que falam inglês, mostre quais departamentos 
estão sem auxiliares bilíngues mas têm, no mesmo departamento, 
tanto engenheiros eletricistas quanto projetistas senior.
*/

select departamento from funcionario natural join auxiliar
where bilingue = 'false'
INTERSECT
select departamento from funcionario natural join engenheiro
where especialidade = 'Eletricista'
INTERSECT
select departamento from funcionario natural join projetista
where tipo = 'Senior';


/*2:
Faça uma consulta que mostre o nome, o salário e o departamento dos 
projetistas senior que ganham menos que a média salarial dos auxiliares bilíngues.
*/

select nome, salario, departamento from projetista natural join funcionario
where tipo = 'Senior' and salario < (
			select round(avg(salario)) from auxiliar
						   where bilingue = 'true'
);
	
	
/*3:
Crie a visão MediaEngenheiros que mostre o nome de cada departamento com a média salarial 
de seus engenheiros. Ordene da média mais alta para a mais baixa. Use essa visão em uma consulta 
que mostre o nome do departamento que tem a média salarial dos engenheiros maior que R$ 4.000,00.
*/

Create view MediaEngenheiros as(
select departamento, round(avg(salario)) from funcionario natural join engenheiro
group by(departamento)
order by round(avg(salario)) desc
);

select departamento from MediaEngenheiros
where round > 4000.00;
	
	
/*4:
São considerados engenheiros "experientes" aqueles com mais de 10 anos de experiência. 
Faça uma função que receba o nome de um departamento e retorne a quantidade de 
engenheiros experientes no departamento informado. Use essa função em uma consulta que mostre os 
nomes dos departamentos que têm engenheiros experientes.
*/

Create function EngExperientes(dep char(20)) returns bigint as
$$
select count(engenheiro.codigo) from engenheiro natural join funcionario
where experiencia >= 10 and departamento = dep
$$ language sql;

select distinct departamento from funcionario
where EngExperientes(departamento) >= 1;
										