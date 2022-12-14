--Prova P2


/*1:
Fa?a uma fun??o que retorne os dados dos auxiliares bil?ngues que recebam 
um sal?rio maior do que um valor informado. Use essa fun??o em uma 
consulta para mostrar, do maior para o menor sal?rio, o nome e o sal?rio 
dos auxiliares bil?ngues que recebem mais que R$ 1.000,00. 
(Considere como dados dos auxiliares os dados da tabela ?Auxiliar?)
*/

create or replace function AuxBilSalMaior(val int) returns setof auxiliar as
$$
begin
	return query (select * from auxiliar
					where bilingue = true and
					salario > val);
end;
$$ language plpgsql;


select nome, salario from AuxBilSalMaior(1000)
order by(salario) desc;


/*2:
Fa?a uma fun??o que retorne o nome e o sal?rio de determinados 
funcion?rios de um departamento. A fun??o recebe o tipo de 
funcion?rio (?E? para engenheiros, ?P? para projetistas ou ?A? para 
auxiliares) e o nome do departamento, e retorna os dados. 
N?o precisa fazer controle de erro.
*/

create type NomeSal as (nome varchar(30), salario numeric(6,2));

create or replace function NomeSalFunc(tipo char, dep varchar(20)) returns setof NomeSal as
$$
begin
	if tipo = 'E' then return query (select nome, salario from engenheiro natural join funcionario
									where departamento = dep);
	elsif tipo = 'P' then return query (select nome, salario from projetista natural join funcionario
										where departamento = dep);
	elsif tipo = 'A' then return query (select nome, salario from auxiliar natural join funcionario
										where departamento = dep);
	end if;							
end;
$$language plpgsql;

select * from NomeSalFunc('A', 'Obras');


/*3:
No Paran? o piso salarial para engenheiros civis ? de R$ 4.200,00. 
Portanto, fa?a uma trigger para controlar a inser??o de engenheiros civis. 
Quando for inserido um engenheiro civil com CREA do Paran? (in?cio com ?PR?),
verifique se o sal?rio atende o piso. Se n?o atender, mude o sal?rio 
para o valor do piso e avise que o valor foi alterado.
*/

create or replace function PisoSalarialEng() returns trigger as
$$
begin
	if (new.especialidade = 'Civil' and new.crea like 'PR%' and new.salario > 4200) then
		new.salario := 4200;
		raise notice 'Salario alterado para o piso salarial de 4200';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger PisoSal before insert on engenheiro for each 
row execute procedure PisoSalarialEng();


insert into funcionario values(12343, 'Obras');

insert into engenheiro 
values(12343, 'TestNome', 4500, 'PR23435', 'Civil', 1);


/*4:
Crie a vis?o InfoProjetistas que mostre todos os dados dos projetistas 
incluindo o departamento em que ele trabalha. Em seguida, fa?a 
uma trigger que permita atualizar o departamento em que um 
projetista trabalha usando a view criada.
*/

create view InfoProjetistas as
select codigo, nome, salario, nivel, tipo, departamento 
from projetista natural join funcionario;

create or replace function UpdateProjetista() returns trigger as
$$
begin
	update funcionario set departamento = new.departamento
			where codigo = new.codigo;
	return new;
end;
$$ language plpgsql;

create trigger AttDepProjetista instead of update on infoprojetistas
for each row execute procedure UpdateProjetista();


update InfoProjetistas set departamento = 'TesteDep'
where codigo = 7020;



