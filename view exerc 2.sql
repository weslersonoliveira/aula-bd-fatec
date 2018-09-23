--a)	Crie um nome para as constraints de todas as chaves primárias e chaves estrangeiras.
--b)	Ano de fabricação do carro deverá ser maior que zero.
--c)	Modelo do carro é de preenchimento obrigatório.
--d)	Número da apólice é um inteiro maior que 1000 e não pode ser deixado em branco.
--e)	Data do roubo tem valor padrão como sendo a data atual do servidor.


CREATE DATABASE Seguradora_ex_view_2
GO
USE Seguradora_ex_view_2



CREATE TABLE carro(
	idCarro INT CONSTRAINT PK_idCarro PRIMARY KEY IDENTITY(1,1),
	modelo VARCHAR(50) NOT NULL,
	placa VARCHAR(20),
	cor VARCHAR(20),
	ano INT CONSTRAINT chk_ano CHECK (Ano > 0)   
)

CREATE TABLE seguro(
	idSeguro   INT CONSTRAINT PK_idSeguro PRIMARY KEY IDENTITY(1,1),
	nroApolice INT NOT NULL CHECK(NroApolice > 1000),
	dtValidade DATETIME,
	idCarro    INT CONSTRAINT FK_IdCodCarroSeguro FOREIGN KEY REFERENCES carro(idCarro)	
)

CREATE TABLE roubo(
	idRoubo INT CONSTRAINT PK_idRoubo PRIMARY KEY IDENTITY(1,1),
	dtOcorrencia DATETIME CONSTRAINT df_dtOcorrencia DEFAULT(GETDATE()),
	lugar VARCHAR(50),
	cidade VARCHAR(50),
	idCarro INT NOT NULL CONSTRAINT FK_IdCodCarroRoubo FOREIGN KEY REFERENCES carro(idCarro)
)

CREATE TABLE recuperacao(
	idRec INT CONSTRAINT PK_idRec PRIMARY KEY IDENTITY(1,1),
	DtRec DATETIME,
	Responsavel varchar(50),
	Obs VARCHAR(500),
	idRoubo INT CONSTRAINT FK_idRoubo FOREIGN KEY REFERENCES ROUBO(idRoubo)
)

--Cadastre 8 Carros
INSERT INTO Carro(modelo, placa, cor, ano)
VALUES    ('Mustang V8', 'EJJ-2525','Vermelha',2018),
		  ('Lamborguini Aventador','AHA-1980','Preta',2015),
		  ('Lamborguini Gallardo','JBS-0171','Azul',2011),
		  ('Ferrari F-50','KKK-0990','Vermelha',2013),
		  ('Crossfox','KJN-9090','Azul',2011),
		  ('Lamborguini Diablo SV','ASV-1424','Rosa',2014),
		  ('Audi A8','SMN-1243','Bordo',2017),
		  ('Range Rover Evoque','JUH-2050','Amarela',2018)

--Cadastre 4 Seguros
INSERT INTO seguro(nroApolice,dtValidade,idCarro)
VALUES		(1001,'22/09/2019',1),
			(1002,'22/09/2019',3),
			(1003,'22/09/2019',6),     
			(1004,'22/09/2019',8)

--Cadastre 5 Roubos
INSERT INTO roubo(lugar,cidade,idCarro)
VALUES      ('Rua Amora','Franca',5),
			('Rua 15','Boa Vista',6),
			('Rua 54','Ribeirão Preto',8),
			('Rua nove hora','Batatais',1),
			('Rua joazin','São José Of Good View',2)


--Cadastre 3 Recuperações
INSERT INTO recuperacao(DtRec,Responsavel,Obs,idRoubo)
VALUES		('22/10/2018','Rogério','Sem as rodas',2),
			('23/11/2018','Marcos','No desmanche',1),
			('26/02/2018','Matheus','Sem parabrisa',5)

--3.	Crie uma view que liste os modelos dos carros que foram roubados e não tinham seguro.

CREATE VIEW vRouboSemSeguro
AS
	Select
		modelo as 'Carros roubados sem seguro'
	FROM	
	carro AS C INNER JOIN roubo AS R ON
		C.idCarro = R.idCarro
	LEFT JOIN Seguro AS S ON
		C.idCarro = S.idCarro
	WHERE S.idCarro IS NULL	
										
select * from vRouboSemSeguro

--4.	Crie uma view que liste os carros que foram roubados em Franca e foram recuperados. Liste também as observações da recuperação.
CREATE VIEW vRecuperados
AS
	SELECT
		C.idCarro,  
		C.modelo as Recuperados,
		REC.obs as 'Observações das recuperações'

	FROM
		carro AS C INNER JOIN roubo AS R ON
			C.idCarro = R.idCarro
		INNER JOIN recuperacao as REC ON
			R.idRoubo = REC.idRoubo
		WHERE R.cidade = 'Franca'

--5.	Crie uma view que liste os carros que nunca foram roubados com as informações de seguro para aqueles que tem seguro.
CREATE VIEW vNeverRoubado
AS
	SELECT 
		C.idCarro,
		C.modelo,
		c.cor,
		S.nroApolice,
		S.dtValidade
	FROM	
		carro AS C LEFT JOIN seguro AS S ON
			C.idCarro = S.idCarro	
		LEFT JOIN roubo AS R ON
			C.idCarro = R.idCarro
		WHERE R.idCarro IS NULL	
		

