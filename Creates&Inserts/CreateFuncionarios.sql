-- BD Funcionarios - Criação de Tabelas

-- cria a tabela Funcionario
CREATE TABLE Funcionario (
     codigo     	INTEGER,
     departamento       VARCHAR(20)
);

-- cria a tabela Engenheiro
CREATE TABLE Engenheiro (
     codigo     	INTEGER NOT NULL,
     nome		VARCHAR(30),
     salario    	NUMERIC(6,2),
     crea       	CHAR(11),
     especialidade      VARCHAR(20),
     experiencia        INTEGER
);

-- cria a tabela Projetista
CREATE TABLE Projetista (
     codigo     	INTEGER NOT NULL,
     nome		VARCHAR(30),
     salario    	NUMERIC(6,2),
     nivel         	CHAR(1),
     tipo       	VARCHAR(20)
);

-- cria a tabela Auxiliar
CREATE TABLE Auxiliar
(
     codigo     	INTEGER NOT NULL,
     nome		VARCHAR(30),
     salario    	NUMERIC(6,2),
     bilingue  		BOOLEAN
);

ALTER TABLE Funcionario ADD PRIMARY KEY (codigo);

ALTER TABLE Engenheiro ADD FOREIGN KEY (codigo) REFERENCES Funcionario(codigo) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Engenheiro ADD PRIMARY KEY (codigo);

ALTER TABLE Projetista ADD FOREIGN KEY (codigo) REFERENCES Funcionario(codigo) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Projetista ADD PRIMARY KEY (codigo);

ALTER TABLE Auxiliar ADD FOREIGN KEY (codigo) REFERENCES Funcionario(codigo) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Auxiliar ADD PRIMARY KEY (codigo);