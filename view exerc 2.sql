CREATE DATABASE Seguradora
GO
USE Seguradora




CREATE TABLE Carro(
	idCarro INT CONSTRAINT PK_idCarro PRIMARY KEY IDENTITY(1,1),
	Modelo VARCHAR(20) NOT NULL,
	Placa VARCHAR(20),
	cor VARCHAR(20),
	ANO INT CONSTRAINT chk_ano CHECK (ANO > 0)   
)

CREATE TABLE SEGURO(
	codSeguro INT CONSTRAINT PK_idSeguro PRIMARY KEY IDENTITY(1,1),
	NroApolice INT NOT NULL CHECK(NroApolice > 1000),
	DtValidade DATETIME,
	IdCarro INT NOT NULL CONSTRAINT FK_IdCodCarro FOREIGN KEY REFERENCES Carro(idCarro)	
)

CREATE TABLE ROUBO(
	idRoubo INT CONSTRAINT PK_idRoubo PRIMARY KEY IDENTITY(1,1),
	dtOcorrencia DATETIME CONSTRAINT df_dataRoubo DEFAULT(GETDATE()),
	Local varchar(50),
	Cidade varchar(50),
	IdCarro INT NOT NULL CONSTRAINT FK_IdcodCarroRoubo FOREIGN KEY REFERENCES Carro(idCarro)
)

CREATE TABLE RECUPERACAO(
	idRec INT CONSTRAINT PK_idRecuperacao PRIMARY KEY IDENTITY(1,1),
	DtRec DATETIME,
	Responsavel varchar(50),
	Obs VARCHAR(500),
	idRoubo INT CONSTRAINT FK_idRoubo FOREIGN KEY REFERENCES ROUBO(idRoubo)
)


INSERT INTO Carro(Modelo, Placa, cor, ANO)
VALUES    ('Mustang V8', 'EJJ-2525','Vermelha',2018),
		  ('Lamborguini A','AHA-1980','Preta',2015),
		  ('Lamborguini G','JBS-0171','Azul',2011),
		  ('Ferrari F-50','KKK-0990','Vermelha',2013),
		  ('Crossfox','KJN-9090','Azul',2011),
		  ('Lamborguini SV','ASV-1424','Rosa',2014),
		  ('Audi A8','SMN-1243','Bordo',2017),
		  ('Range Rover Evoque','JUH-2050','Amarela',2018)

INSERT INTO SEGURO(NroApolice,IdCarro)
VALUES		(1001,10),
			(1002,11),
			(1003,12),     
			(1004,09)


INSERT INTO ROUBO (Local,Cidade,IdCarro)
VALUES      ('Rua Amora','Franca',5),
			('Rua 15','Boa Vista',6),
			('Rua 54','Ribeirão Preto',11),
			('Rua nove hora','Batatais',12),
			('Rua joazin','São José Of Good View',8)


INSERT INTO RECUPERACAO(DtRec,Responsavel,Obs)
VALUES (terminar)










--exe 5
create view c.modelo, c.ano, c.cor, s.numApolice, s.datavalidade
from carro c
	left join Roubo R on c.codC = R.CodC
	left join Seguro S on C.CodC = S.CodC
where R.CodC is null
