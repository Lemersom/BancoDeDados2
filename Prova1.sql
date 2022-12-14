--Prova 1

/*Coment?rios do Professor:
Quest?o 1 (1,5/2,5): H? erro de l?gica. O fato de um departamento ter um auxiliar
que n?o ? bil?ngue n?o quer dizer que n?o h? no mesmo departamento um outro auxiliar
que seja bil?ngue. Para selecionar os departamentos sem auxiliares bil?ngues 
era necess?rio identificar os departamentos que t?m esses funcion?rios e exclui-los 
dos demais departamentos usando EXCEPT ou NOT IN.
*/


/*1:
Para redistribuir os auxiliares que falam ingl?s, mostre quais departamentos 
est?o sem auxiliares bil?ngues mas t?m, no mesmo departamento, 
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
Fa?a uma consulta que mostre o nome, o sal?rio e o departamento dos 
projetistas senior que ganham menos que a m?dia salarial dos auxiliares bil?ngues.
*/

select nome, salario, departamento from projetista natural join funcionario
where tipo = 'Senior' and salario < (
			select round(avg(salario)) from auxiliar
						   where bilingue = 'true'
);
	
	
/*3:
Crie a vis?o MediaEngenheiros que mostre o nome de cada departamento com a m?dia salarial 
de seus engenheiros. Ordene da m?dia mais alta para a mais baixa. Use essa vis?o em uma consulta 
que mostre o nome do departamento que tem a m?dia salarial dos engenheiros maior que R$ 4.000,00.
*/

Create view MediaEngenheiros as(
select departamento, round(avg(salario)) from funcionario natural join engenheiro
group by(departamento)
order by round(avg(salario)) desc
);

select departamento from MediaEngenheiros
where round > 4000.00;
	
	
/*4:
S?o considerados engenheiros "experientes" aqueles com mais de 10 anos de experi?ncia. 
Fa?a uma fun??o que receba o nome de um departamento e retorne a quantidade de 
engenheiros experientes no departamento informado. Use essa fun??o em uma consulta que mostre os 
nomes dos departamentos que t?m engenheiros experientes.
*/

Create function EngExperientes(dep char(20)) returns bigint as
$$
select count(engenheiro.codigo) from engenheiro natural join funcionario
where experiencia >= 10 and departamento = dep
$$ language sql;

select distinct departamento from funcionario
where EngExperientes(departamento) >= 1;
										