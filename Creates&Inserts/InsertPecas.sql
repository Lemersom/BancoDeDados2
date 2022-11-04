-- popula a tabela Peca
insert into Peca(PeNro,PeNome,PePreco,PeCor) values ('PE1','Cinto',22,'Azul');
insert into Peca(PeNro,PeNome,PePreco,PeCor) values ('PE2','Volante',18,'Vermelho');
insert into Peca(PeNro,PeNome,PePreco,PeCor) values ('PE3','Lanterna',14,'Preto');
insert into Peca(PeNro,PeNome,PePreco,PeCor) values ('PE4','Limpador',09,'Amarelo');
insert into Peca(PeNro,PeNome,PePreco,PeCor) values ('PE5','Painel',43,'Vermelho');

-- popula a tabela Fornecedor
insert into Fornecedor(FNro,FNome,FCidade,FCateg) values ('F1','Plastec','Campinas','B');
insert into Fornecedor(FNro,FNome,FCidade,FCateg) values ('F2','C&M','São Paulo','D');
insert into Fornecedor(FNro,FNome,FCidade,FCateg) values ('F3','Kirurgic','Campinas','A');
insert into Fornecedor(FNro,FNome,FCidade,FCateg) values ('F4','Piloto''s','Piracicaba','A');
insert into Fornecedor(FNro,FNome,FCidade,FCateg) values ('F5','Equipament','São Carlos','C');

-- popula a tabela Projeto
insert into Projeto(PNro,PNome,PDuracao,PCusto) values ('P1','Detroit',5,43000);
insert into Projeto(PNro,PNome,PDuracao,PCusto) values ('P2','Pegasus',3,37000);
insert into Projeto(PNro,PNome,PDuracao,PCusto) values ('P3','Alfa',2,26700);
insert into Projeto(PNro,PNome,PDuracao,PCusto) values ('P4','Sea',3,21200);
insert into Projeto(PNro,PNome,PDuracao,PCusto) values ('P5','Paraíso',1,17000);

-- popula a tabela Fornece_Para
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE1','F5','P4',5);
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE2','F2','P2',1);
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE3','F3','P4',2);
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE4','F4','P5',3);
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE5','F1','P1',1);
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE2','F2','P3',1);
insert into Fornece_Para(PeNro,FNro,PNro,Quant) values ('PE4','F3','P5',2);