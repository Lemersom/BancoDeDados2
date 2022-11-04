--Atividade 07


/*1:
Faça uma função para inserir um novo registro na tabela Engenheiro. 
Trate a exceção (verifique o valor do SQLSTATE) para o caso de inserção 
de um código de funcionário que ainda não conste na tabela Funcionario, 
neste caso faça a inserção na tabela Funcionario com departamento 'null', 
e o valor de retorno da função deve ser 0. Em caso de sucesso na inserção 
o valor de retorno deve ser 1.
*/


create or replace function InserirEng(FCod int4, FNome varchar(30), FSal numeric (6,2),
									  FCrea bpchar(11), FEsp varchar(20), FExp int4)
									  returns int as
$$
declare retorno int;
begin 
	
	insert into engenheiro values(FCod, FNome, FSal, FCrea , FEsp, FExp);
 	
	if FCod not in (select codigo from funcionario) then retorno = 0;
 	else retorno = 1;
 	end if;
 
 	exception when sqlstate '23503' then insert into funcionario values(FCod, null);
 	if Fcod not in (select codigo from engenheiro) then 
                insert into engenheiro values(FCod, FNome, FSal, FCrea , FEsp, FExp);
	end if;
               
	return retorno;
end; 
$$ language plpgsql; 


/*2:
Faça uma função que receba a indicação de um tipo de projetista 
(‘S’ para Senior, 'J' para Junior ou ‘I’ para iniciante) e retorne 
os dados (que constam na tabela Projetista) dos projetistas do tipo indicado.
*/


create or replace function ProjTipo(FTipo char) returns setof projetista as 
$$
begin 
	return query (select * from projetista where tipo like FTipo || '%');
	
end;
$$ language plpgsql;


select * from ProjTipo('J');


/*3:
Faça uma função que informe os códigos de um determinado tipo de funcionário 
em um departamento (por exemplo, os códigos dos engenheiros do departamento de obras). 
A função deve receber o tipo de funcionário desejado (‘E’ para engenheiros, ‘P’ para projetistas 
ou ‘A’ para auxiliares) e o nome de um departamento, e retornar os códigos dos funcionários 
do tipo informado no departamento pedido.
*/


create or replace function CodsFuncs(FTipo char, FDep varchar(20)) returns setof int as
$$
begin 
	if FTipo = 'E' then return query (select codigo from funcionario natural join engenheiro
									where departamento = FDep);
	elsif FTipo = 'P' then return query (select codigo from funcionario natural join projetista
									where departamento = FDep);
	elsif FTipo = 'A' then return query (select codigo from funcionario natural join auxiliar
									where departamento = FDep);
	end if;
	
end;
$$ language plpgsql;


select * from CodsFuncs('E', 'Obras');


/*4:
Faça uma função que receba uma especialidade de engenharia e retorne o nome e o salário 
de todos os engenheiros da especialidade informada. Se a especialidade não existir, 
a função deve ser interrompida disparando uma exceção.
*/

create type Nome_Sal as (Nome varchar(30), Salario numeric(6,2));


create or replace function NomeSalEngs(FEsp varchar(20)) returns setof Nome_Sal as 
$$
begin
	if FEsp not in (select especialidade from engenheiro) 
			then raise exception 'Especialidade não existe';
	end if;
	
	return query (select nome, salario from engenheiro where FEsp = especialidade);
	
end;
$$ language plpgsql;


select * from NomeSalEngs('Civil');
