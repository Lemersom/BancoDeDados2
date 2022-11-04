--ATV6 - Funções


/*Comentários do Professor:
- No exercício 1 a consulta que usa a função não corresponde ao que foi pedido, 
podia ser feita uma subconsulta com o SELECT usando o MAX para ser usada no WHERE.
*/


/*1:
Faça uma função que receba o nome de um departamento e retorne a quantidade de 
engenheiros daquele departamento que têm mais de 10 anos de experiência 
(se não houver nenhum deve retornar 0). Use essa função em uma consulta que mostre 
o nome do departamento que tem mais engenheiros com pelo menos 10 anos de experiência.
*/

create or replace function QtdEngenheiro(Dep varchar(20)) returns bigint as 
$$
declare qtd int;
begin
	qtd := (select count(nome) from funcionario natural join engenheiro
			where departamento = Dep and experiencia >= 10);
	if qtd = null then return(0);
	else return(qtd);
	end if;
end;
$$LANGUAGE plpgsql;


select distinct departamento from funcionario
	where QtdEngenheiro(departamento) != 0;
	

/*2:
Faça uma função que informe o departamento de um funcionário. A função recebe o nome do 
funcionário e seu tipo (‘E’ para engenheiros, ‘P’ para projetistas ou ‘A’ para auxiliares) 
e retorna seu departamento. Se for informado um nome ou tipo inexistente, retorne a mensagem 'ERRO'.
*/

create view FuncNomes as
	select nome from engenheiro
	union
	select nome from projetista
	union
	select nome from auxiliar;

select * from FuncNomes;

create or replace function DepFunc(NomeFunc varchar(30), TipoFunc char(1)) returns varchar(30) as 
$$
declare existe int;
begin
	existe := (select count(nome) from FuncNomes
				where nome = NomeFunc);
	if existe = 0 then return 'ERRO';
	elsif TipoFunc = 'P' then 
		return(select departamento from projetista natural join funcionario
				where NomeFunc = projetista.nome);
	elsif TipoFunc = 'E' then
		return(select departamento from engenheiro natural join funcionario
				where NomeFunc = engenheiro.nome);
	elsif TipoFunc = 'A' then
		return(select departamento from auxiliar natural join funcinario
				where NomeFunc = auxiliar.nome);
	else return 'ERRO';
	end if;
end;
$$LANGUAGE plpgsql;


select DepFunc('Paula Moreira', 'P');


/*3:
Faça uma função que receba todos os dados referentes a um projetista (departamento, código, nome, salário, nível e tipo)
e faça a sua inserção (nas tabelas Funcionario e Projetista). Antes de inserir, verifique se o código informado
corresponde realmente a um projetista (deve começar com 7). Se não corresponder, dispare uma exceção para interromper 
a função e mostrar uma mensagem de erro, sem realizar a inserção.
*/

CREATE OR REPLACE FUNCTION InsProjetista(dep VARCHAR(20), cod integer, nome VARCHAR(20), salario NUMERIC(6,2), nivel CHAR(1), tipo VARCHAR(10))
RETURNS VARCHAR(20) AS $$
DECLARE retorno char(10);
BEGIN
	IF cod < 7000 OR cod > 8000 THEN
		RAISE EXCEPTION 'Código incorreto';
		retorno := 'Erro';
		RETURN retorno;
	ELSIF cod > 6999 OR cod < 8000 THEN
		INSERT INTO funcionario VALUES (cod,dep);
		INSERT INTO projetista VALUES(cod,nome,salario,nivel,tipo);
		retorno := 'Inserido';
	END IF;
	
	RETURN retorno;
END;
$$ LANGUAGE PLPGSQL;

SELECT InsProjetista('Obras', 7540,'Guilherme', 3000.00, 'A', 'Senior');

SELECT InsProjetista('Obras', 6540,'Guilherme', 3000.00, 'A', 'Senior');

SELECT * FROM projetista



