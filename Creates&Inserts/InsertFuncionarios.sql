-- BD Funcionarios - Inserção de Dados

-- popula a tabela Funcionario
insert into Funcionario (codigo, departamento) values (5010, 'Obras');
insert into Funcionario (codigo, departamento) values (5020, 'Obras');
insert into Funcionario (codigo, departamento) values (5030, 'Obras');
insert into Funcionario (codigo, departamento) values (5040, 'Suporte');
insert into Funcionario (codigo, departamento) values (5060, 'Suporte');
insert into Funcionario (codigo, departamento) values (7020, 'Obras');
insert into Funcionario (codigo, departamento) values (7040, 'Obras');
insert into Funcionario (codigo, departamento) values (5050, 'Suporte');
insert into Funcionario (codigo, departamento) values (5070, 'Planejamento');
insert into Funcionario (codigo, departamento) values (5080, 'Planejamento');
insert into Funcionario (codigo, departamento) values (5090, 'Obras');
insert into Funcionario (codigo, departamento) values (5100, 'Planejamento');
insert into Funcionario (codigo, departamento) values (7070, 'Planejamento');
insert into Funcionario (codigo, departamento) values (7080, 'Obras');
insert into Funcionario (codigo, departamento) values (9010, 'Obras');
insert into Funcionario (codigo, departamento) values (9020, 'Obras');
insert into Funcionario (codigo, departamento) values (9030, 'Estoque');
insert into Funcionario (codigo, departamento) values (7010, 'Suporte');
insert into Funcionario (codigo, departamento) values (7030, 'Suporte');
insert into Funcionario (codigo, departamento) values (9040, 'Suporte');
insert into Funcionario (codigo, departamento) values (9050, 'Planejamento');
insert into Funcionario (codigo, departamento) values (9060, 'Estoque');
insert into Funcionario (codigo, departamento) values (7050, 'Planejamento');
insert into Funcionario (codigo, departamento) values (7060, 'Obras');

-- popula a tabela Engenheiro
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5010, 'Eduardo Almeida', 5520.00, 'SP1A4355612', 'Civil', 15);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5020, 'Ana Gouveia', 5500.00, 'MG1A7685345', 'Civil', 13);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5030, 'Marcelo Oliveira', 5000.00, 'PR2B3746589', 'Civil', 8);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5040, 'Fabio Prado', 4320.90, 'PR2C4762892', 'Eletricista', 9);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5050, 'Pedro Ramos', 4300.00, 'SP2A3676189', 'Eletricista', 5);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5060, 'Vitor Teixeira', 5400.50, 'PR1A6475893', 'Controle', 20);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5070, 'Heloisa Maia', 3890.90, 'RJ2B347859', 'Controle', 2);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5080, 'Denise Rocha', 3900, 'SP2B2348098', 'Controle', 3);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5090, 'Marcos Ferreira', 3750.00, 'PR2A1289075', 'Civil', 25);
insert into Engenheiro (codigo,nome,salario,crea,especialidade,experiencia) values (5100, 'Beatriz Barbosa', 3290.90, 'PR1C7846196', 'Eletricista', 14);

-- popula a tabela Projetista
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7010, 'Paula Moreira', 2490.00, 'A', 'Senior');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7020, 'Artur Paiva', 1238.80, 'A', 'Junior');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7030, 'Francisco Costa', 3120.50, 'C', 'Iniciante');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7040, 'Talita Morais', 1650.00, 'B', 'Iniciante');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7050, 'Jeferson Santos', 1230.80, 'C', 'Senior');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7060, 'Gabriel Mota', 2300.00, 'A', 'Senior');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7070, 'Ricardo Lemes', 1800.50, 'B', 'Junior');
insert into Projetista (codigo,nome,salario,nivel,tipo) values (7080, 'Luciana Carvalho', 1750.00, 'B', 'Junior');

-- popula a tabela Auxiliar
insert into Auxiliar (codigo,nome,salario,bilingue) values (9010, 'Vicente Borges', 1480.90, true);
insert into Auxiliar (codigo,nome,salario,bilingue) values (9020, 'Roberto Silva', 1200.00, true);
insert into Auxiliar (codigo,nome,salario,bilingue) values (9030, 'Maria Siqueira', 990.80, false);
insert into Auxiliar (codigo,nome,salario,bilingue) values (9040, 'Alexandre Dias', 890.00, false);
insert into Auxiliar (codigo,nome,salario,bilingue) values (9050, 'Daniel Figueiredo', 900.00, false);
insert into Auxiliar (codigo,nome,salario,bilingue) values (9060, 'Bruno Viana', 1350.00, true);