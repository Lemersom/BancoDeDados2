--Atividade 09 - Triggers

/*1:
Quando um novo auxiliar bilingue for inserido com salário menor que
1.300,00, permita a inserção, mas mude o salário para 1.300,00 e avise que o valor foi
alterado.
*/

CREATE OR REPLACE FUNCTION SalarioMinimo() RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.Salario < 1300 AND NEW.Bilingue = True) THEN NEW.Salario := 1300;
		RAISE NOTICE 'Sálario definido como R$1300,00';
	END IF;
RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER SalarioAuxiliar BEFORE INSERT ON Auxiliar
FOR EACH ROW EXECUTE PROCEDURE SalarioMinimo();


/*2:
Quando um novo engenheiro for inserido na tabela Engenheiro, insira
também um funcionário com mesmo código na tabela Funcionário com departamento
'Obras'.
*/

create or replace function InsirirFunc() returns trigger as
$$
begin
	insert into funcionario values(new.codigo, 'Obras');
	return new;
end;
$$ language plpgsql;


create trigger NovoEng before insert on engenheiro
for each row execute procedure InsirirFunc();


/*3:
A especialidade e o número CREA dos engenheiros são baseados em
documentos fornecidos pelos funcionários, portanto só são inseridos no BD após
conferência. Como se tratam de informações certificadas, a tabela Engenheiro não deve
permitir alterações nos campos 'crea' ou 'especialidade'. Faça uma trigger que
implemente essa restrição sem gerar exceção, mas avisando o usuário.
*/

create or replace function NaoAltCreaEsp() returns trigger as
$$
begin
	if(new.crea != old.crea or new.especialidade != old.especialidade) then
		new.crea := old.crea;
		new.especialidade := old.especialidade;
		raise notice 'Crea e especialidade não podem ser alterados';
	end if;
	return new;
end;
$$ language plpgsql;


create trigger CreaEsp before update on engenheiro
for each row execute procedure NaoAltCreaEsp();


