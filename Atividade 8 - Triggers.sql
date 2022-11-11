--Atividade 8 - Triggers


/*1:
Crie uma tabela de LOG de inserções na tabela Funcionario (chamada
LogFuncionario), da forma mostrada no material disponível no Moodle. Como se tratam
de resultados históricos, essa tabela não deve permitir exclusões na tabela ou alterações
no campo 'Data', ou seja, as linhas só podem ser inseridas, e só o ID pode ser alterado.
Faça uma trigger que implemente essa restrição disparando uma exceção com a
mensagem 'Essa alteração no LOG não é permitida!'.
*/


CREATE TABLE LogFuncionario(ID SERIAL PRIMARY KEY, DATA TIMESTAMP);
CREATE OR REPLACE FUNCTION LogFuncionario() RETURNS TRIGGER AS $$
	BEGIN
		INSERT INTO LogFuncionario (DATA) VALUES (CURRENT_TIMESTAMP);
	RETURN NULL;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DeleteORUpdate() RETURNS TRIGGER AS $$
	BEGIN
		RAISE EXCEPTION 'Não é possível alterar o campo Data';
	RETURN NULL;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER LogFuncionario AFTER INSERT ON Funcionario FOR EACH
STATEMENT EXECUTE PROCEDURE LogFuncionario(); 

CREATE TRIGGER LogFuncionario AFTER UPDATE OF Data OR DELETE ON LogFuncionario FOR EACH
STATEMENT EXECUTE PROCEDURE DeleteORUpdate();



/*2:
Quando houver uma inserção na tabela Funcionario, ou uma atualização do
campo Departamento na tabela Funcionario, informe com uma mensagem se há algum
departamento que passou a ter mais que 10 funcionários.
*/


create or replace function func2() returns trigger as $$
begin
	if exists(select count(codigo)from funcionario 
					 group by(departamento)
					 having(count(codigo) >= 10))
	then raise notice 'Há departamento(s) com mais de 10 funcionários';
	end if;

	return null;
end;
$$ language plpgsql;

create trigger DepMais10Func after update of departamento or insert on funcionario 
for each statement execute procedure func2();

update funcionario
set departamento = 'Suporte'
where codigo = 5040;

insert into funcionario
values(123, 'Suporte');



/*3:
Quando ocorrer qualquer modificação na tabela Engenheiro, dispare uma
exceção para interromper a operação e não permitir que o salário médio dos engenheiros
para cada departamento seja maior que R$ 5.000,00.
*/


CREATE OR REPLACE FUNCTION SalMedioEng() RETURNS TRIGGER AS $$
	BEGIN
	IF EXISTS (SELECT AVG(Salario) FROM engenheiro NATURAL JOIN Funcionario
			  GROUP BY (Departamento) HAVING (AVG(Salario) > 5000))
	THEN RAISE EXCEPTION 'Salário médio não pode ultrapassar R$5.000,00';
	END IF;
RETURN NULL;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER SalMedio AFTER INSERT OR UPDATE OR DELETE ON Engenheiro FOR EACH
STATEMENT EXECUTE PROCEDURE SalMedioEng();

