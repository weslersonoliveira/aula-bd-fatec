--CREATE DATABASE locadora_ex_view_3
--GO
--USE locadora_ex_view_3

CREATE TABLE cliente(
	idCliente INT CONSTRAINT PK_idCliente PRIMARY KEY IDENTITY(1,1),
	prenome VARCHAR(20),
	sobrenome VARCHAR(20),
	telefone BIGINT,
	endereco VARCHAR(100),
)
GO

CREATE TABLE filme(
	idFilme INT CONSTRAINT PK_idFilme PRIMARY KEY IDENTITY(1,1),
	titulo VARCHAR(50) NOT NULL,
)
GO

CREATE TABLE ator(
	idAtor INT CONSTRAINT PK_idAtor PRIMARY KEY IDENTITY(1,1),
	nomeArtistico VARCHAR(50) NOT NULL,
	nomePopular VARCHAR(50),
	dataNascimento DATETIME
)
GO

CREATE TABLE elenco(
	idElenco INT CONSTRAINT PK_idElenco PRIMARY KEY IDENTITY(1,1),
	idAtor INT CONSTRAINT FK_idElencoAtor FOREIGN KEY REFERENCES ator(idAtor),
	idFilme INT CONSTRAINT FK_idElencoFilme FOREIGN KEY REFERENCES filme(idFilme)
)
GO

CREATE TABLE fita(
	idFita INT CONSTRAINT PK_idFita PRIMARY KEY IDENTITY(1,1),
	rolo varchar(20) CONSTRAINT chk_rolo CHECK(rolo IN('Lançamento','Promocional','Edição Especial')),
	idFilme INT CONSTRAINT PK_idFitaFilme FOREIGN KEY REFERENCES filme(idFilme)
)
GO

CREATE TABLE aluguel(
	idAluguel INT CONSTRAINT PK_idAluguel PRIMARY KEY IDENTITY(1,1),   
	dtRetirada DATETIME,
	dtDevolucao DATETIME,
	valor_pago DECIMAL(10,2),
	CONSTRAINT chk_datas CHECK(dtDevolucao > dtRetirada),
	idCliente INT CONSTRAINT FK_idAluguelCliente FOREIGN KEY REFERENCES cliente(idCliente),
	idFita INT CONSTRAINT FK_idAluguelFita FOREIGN KEY REFERENCES fita(idFita)
)

--Cadastros

INSERT INTO cliente(prenome,sobrenome,endereco,telefone)
VALUES		('Fulano','de Tal','Rua das amoreiras 17',1699996767),
			('Marcilio','o Pintor','Rua das Acássias 18',1698765-7876),
			('João','Sebozo','Rua da ortinha 17',1698767-1718),
			('Marta','dos Prazeres','Rua do Bordel 69',1696969-1313),
			('Claudisnei','o Virgem','Rua dos Fap Fap 23',1799951-1414),
			('Virginia','do Restaurante','Rua dos Processos 14',19978781616)




INSERT INTO filme(titulo)
VALUES		('To cansado'),
			('De estudar muito'),
			('Hoje é domingo'),
			('E to sem dinheiro'),
			('Afinal meu seguro chega dia 1'),
			('(triste)')


INSERT INTO ator(nomeArtistico,nomePopular,dataNascimento)
VALUES		('Dr Rey','Reinaldo',							'01-04-1993'),
			('Kid Bengala','Clovis Ribeiro',				'04-09-1950'),
			('Mulher Melão','(não sei)',					'23-12-1978'),                          
			('Grande Joe','Joaquim Silveira',				'31-12-1991'),
			('Mulher Melancia','(não importa)',				'12-04-2000'),
			('Macaco','Paulo Silveira',						'19-08-2001'),
			('Will Smith','William Cardoso',				'09-12-1967'),
			('Mister M','Cid Moreira',						'01-07-1950'),
			('Wayke the Dark','Fernando de Paula',			'06-01-1992'),      
			('Dexter','Michael C. Hall',					'08-03-1987'),
			('Michael Jackson','Michael Donald Jackson',	'09-03-1967')



INSERT INTO elenco(idFilme,idAtor)                           
VALUES		(1,1),  
			(1,2),
			(1,3),
			(1,4),
			(1,5),

			(2,6),
			(2,7),
			(2,10),
			(2,9),
			(2,1),

			(3,2),
			(3,3),
			(3,4),
			(3,11),
			(3,8),

			(4,10),
			(4,3),
			(4,4),
			(4,5),
			(4,7),

			(5,5),
			(5,7),
			(5,9),
			(5,3),
			(5,11),

			(6,1),
			(6,2),
			(6,3),
			(6,11),
			(6,5)
			


INSERT INTO fita(rolo,idFilme)              
VALUES    ('lançamento',1),
		  ('Promocional',2),
		  ('Edição Especial',3),
		  ('Edição Especial',4),
		  ('lançamento',5),
		  ('Promocional',6)

INSERT INTO aluguel(dtRetirada,dtDevolucao,valor_pago,idCliente,IdFita)    
VALUES       ('01-01-2015','02-01-2015',3.00,1,1),
			 ('01-02-2015','02-02-2015',3.00,1,2),
			 ('01-03-2015','02-03-2015',3.00,1,3),
											
			 ('01-01-2016','02-01-2016',3.00,1,2),
			 ('01-02-2016','02-02-2016',3.00,2,1),
			 ('01-03-2016','02-03-2016',3.00,2,3),
			 ('01-04-2016','02-04-2016',3.00,2,4),
			 ('01-05-2016','02-05-2016',3.00,2,6),
			 ('01-06-2016','02-06-2016',3.00,1,3),
			 ('01-07-2016','02-07-2016',3.00,1,2),
			 ('01-08-2016','02-08-2016',3.00,3,1),
											
			 ('01-01-2017','02-01-2017',3.00,3,1),
			 ('01-02-2017','02-02-2017',3.00,3,3),
			 ('01-03-2017','02-03-2017',3.00,1,4),
			 ('01-04-2017','02-04-2017',2.00,4,2),
			 ('01-05-2017','02-05-2017',2.00,4,6),
			 ('01-06-2017','02-06-2017',2.00,4,6),
			 ('01-07-2017','02-07-2017',2.00,6,4),
			 ('01-08-2017','02-08-2017',2.00,6,3),
			 ('01-09-2017','02-09-2017',2.00,1,2),
			 ('01-10-2017','02-10-2017',2.00,6,1),
			 ('01-11-2017','02-11-2017',2.00,5,2),
			 ('01-12-2017','02-12-2017',2.00,1,1),
											
			 ('01-01-2018','02-01-2018',2.00,1,3),
			 ('01-02-2018','02-02-2018',2.00,5,5),
			 ('01-03-2018','02-03-2018',2.00,1,6),
			 ('01-04-2018','02-04-2018',2.00,1,3),
			 ('01-05-2018','02-05-2018',2.00,5,2),
			 ('01-06-2018','02-06-2018',2.00,1,6)
		

--EXERCÍCIOS (CRIE VIEWS)

--a.	Listar os títulos dos filmes estrelados pelos atores nascidos no mês de março de qualquer ano.
CREATE VIEW vFilmeAtorMarco
AS
	SELECT
		F.titulo,                               
		A.nomeArtistico AS 'Ator nascido em março'               
		--F.titulo
	FROM
		filme AS F INNER JOIN ELENCO AS E ON
			F.idFilme = E.idFilme
		INNER JOIN ator AS A ON
			E.idAtor = A.idAtor
		WHERE MONTH(A.dataNascimento) = '3'   


--b.	Listar os títulos dos filmes alugados pelo cliente Fulano de Tal durante o ano de 2015.
CREATE VIEW vFulano2015
AS
	SELECT 
		C.idCliente,
		CONCAT(C.prenome, ' ' , C.sobrenome) As 'Nome do Cliente',
		FIL.titulo,
		A.dtRetirada AS 'Data de Locação'
	FROM
		cliente AS C INNER JOIN aluguel AS A ON
			C.idCliente = A.idCliente
		INNER JOIN FITA AS F ON
			A.idFita = F.idFita
		INNER JOIN FILME AS FIL ON
			F.idFilme = FIL.idFilme
		WHERE YEAR(A.dtRetirada) = '2015'


--c.	Listar os nomes dos clientes e a quantidade de filmes que alugaram.
CREATE VIEW vNomeQuant
AS                                                                          
	SELECT
		C.idCliente,
		C.prenome as Nome,
		COUNT(A.IdAluguel) as 'Total de filmes alugados'

	FROM
		cliente AS C INNER JOIN aluguel AS A ON
			C.idCliente = A.idCliente
		INNER JOIN FITA AS F ON
			A.idFita = F.idFita
		INNER JOIN FILME AS FIL ON
			F.idFilme = FIL.idFilme
		GROUP BY C.idCliente, C.prenome

--d.	Listar os títulos dos filmes e os nomes dos atores que estrelaram tais filmes.
CREATE VIEW vFilmeAtor
AS
	SELECT
		F.titulo as 'Titulo do filme',
		A.nomeArtistico AS Ator

	FROM
		filme AS F INNER JOIN elenco as E ON
			F.idFilme = E.idFilme
		INNER JOIN ator as A on
			E.idAtor = A.idAtor

--e.	Listar os nomes dos filmes juntamente com o preço médio pago nas locações.

CREATE VIEW vFilmePrecoMedio
AS
	SELECT 
		FIL.idFilme,
		FIL.titulo,
		AVG(A.valor_pago) AS 'Média Paga'
	FROM
		aluguel as A INNER JOIN fita AS F ON
			A.idFita = F.idFita
		INNER JOIN FILME AS FIL ON
			F.idFilme = FIL.idFilme
		GROUP BY FIL.idFilme,FIL.titulo


