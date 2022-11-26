--ATV10 - Revisão

create table empregado(
	ENro char(5),
	ENome char(30),
	ESalario numeric(6, 2),
	ESexo char(1),
	EIdade int,
	PNro char(5),
	primary key(ENro),
	foreign key(PNro) references projeto(PNro)
);

insert into empregado
values('E0001', 'Roberto Andrade', 2400.00, 'M', 25, 'P3');
insert into empregado
values('E0002', 'Ana Maria Pires', 2800.00, 'F', 32, 'P3');
insert into empregado
values('E0003', 'Francisco Alves', 3000.00, 'M', 41, 'P3');
insert into empregado
values('E0004', 'Adriana Pereira', 1750.00, 'F', 20, 'P1');
insert into empregado
values('E0005', 'Beatriz Almeida', 2000.00, 'F', 37, 'P3');


/*1:
Dado o nome de um projeto, faça uma função que retorne 
o nome e o salário dos empregados desse projeto.
*/

create type NomeSalario as(
	nome_func char(30),
	salario_func numeric(6, 2)
);

create or replace function NomeSalarioEmpregados(nome_projeto bpchar(30)) 
returns SETOF NomeSalario as
$$
begin 
	return query (select ENome, ESalario from empregado natural join projeto
						where projeto.pnome = nome_projeto);
	
end; 
$$ language plpgsql;


/*2:
Faça uma função que receba o nome de um projeto e retorne a quantidade 
de funcionários do projeto informado. Use essa função em uma consulta 
que mostre para cada empregado seu nome, seguido do nome do projeto em que 
ele trabalha e a quantidade de funcionários desse projeto.
*/

create or replace function qtdFunc(nome_projeto bpchar(30)) returns int as
$$
begin
	return (select count(*) from empregado natural join projeto
							where projeto.pnome = nome_projeto);
end;
$$ language plpgsql;


select ENome, PNome, qtdFunc(PNome) from empregado natural join projeto;


/*3:
Por lei, salários não podem ser reduzidos. Faça uma trigger que, na atualização 
dos dados de um empregado verifique se o salário está sendo reduzido 
(demais dados podem ser alterados normalmente). Se o salário estiver sendo reduzido 
mantenha o salário sem atualização e emita uma mensagem informando a situação. 
*/

create or replace function ManterSalario() returns trigger as
$$
begin
	if(new.ESalario < old.ESalario) then new.ESalario := old.ESalario;
		raise notice 'Salario não pode ser reduzido';
	end if;
	return new;
end;
$$ language plpgsql;


create trigger NaoReduzirSalario before update on empregado
for each row execute procedure ManterSalario();


/*4:
Crie uma view chamada InfoEmpregados que mostre para todos os empregados 
seu Nome, seu Salário, e o Nome do Projeto em que ele trabalha. Em seguida, 
faça uma trigger que permita atualizar o projeto em que um empregado trabalha 
usando a view criada. Exemplo: Francisco Alves trabalha no projeto Alfa (P3), mas 
agora vai para o Pegasus (P2). O seguinte comando na view deve funcionar e fazer a 
alteração pretendida: UPDATE InfoEmpregados SET PNome='Pegasus' WHERE ENome='Francisco Alves';
Veja que a view usa o NOME do projeto (e não PNro), e que a resolução do exercício 
deve funcionar para qualquer mudança possível (e não só para a do exemplo!). 
*/

create view InfoEmpregados as
	select enome, esalario, pnome from empregado natural join projeto;


create or replace function AttEmpregadoProjeto() returns trigger as
$$declare pnro_novo bpchar(5);
begin 
	pnro_novo := (select pnro from projeto where pnome = new.pnome);
	update empregado set pnro = pnro_novo where enome = new.enome;
	return new;
end;
$$ language plpgsql;


create trigger AttInfoEmpregados instead of update on InfoEmpregados
for each row execute procedure AttEmpregadoProjeto();




