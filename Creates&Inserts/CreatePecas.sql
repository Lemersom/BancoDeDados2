-- NO POSTGRESQL, crie um BD chamado 'startrek'

-- cria a tabela Peca
CREATE TABLE Peca (
     PeNro      CHAR(5)      NOT NULL,
     PeNome     CHAR(30)     NOT NULL,
     PePreco    FLOAT        NOT NULL,
     PeCor      CHAR(20)
);
-- cria a tabela Fornecedor
CREATE TABLE Fornecedor (
     FNro       CHAR(5)      NOT NULL,
     FNome      CHAR(30)     NOT NULL,
     FCidade    CHAR(20)     NOT NULL,
     FCateg     CHAR(1)
);
-- cria a tabela Projeto
CREATE TABLE Projeto (
     PNro       CHAR(5)      NOT NULL,
     PNome      CHAR(30)     NOT NULL,
     PDuracao   INTEGER      NOT NULL,
     PCusto     FLOAT
);
-- cria a tabela Fornece_Para
CREATE TABLE Fornece_Para (
     PeNro      CHAR(5)      NOT NULL,
     FNro       CHAR(5)      NOT NULL,
     PNro       CHAR(5)      NOT NULL,
     Quant      INTEGER
);
-- cria as constraints
ALTER TABLE Peca ADD CONSTRAINT peca_pk PRIMARY KEY (PeNro);
ALTER TABLE Fornecedor ADD CONSTRAINT fornecedor_pk PRIMARY KEY (FNro);
ALTER TABLE Projeto ADD CONSTRAINT projeto_pk PRIMARY KEY (PNro);
ALTER TABLE Fornece_Para ADD CONSTRAINT fornece_para_pk PRIMARY KEY (PeNro,FNro,PNro);
ALTER TABLE Fornece_Para ADD CONSTRAINT fornece_para_peca_fk FOREIGN KEY (PeNro) REFERENCES Peca(PeNro);
ALTER TABLE Fornece_Para ADD CONSTRAINT fornece_para_fornecedor_fk FOREIGN KEY (FNro) REFERENCES Fornecedor(FNro);
ALTER TABLE Fornece_Para ADD CONSTRAINT fornece_para_projeto_fk FOREIGN KEY (PNro) REFERENCES Projeto(PNro);