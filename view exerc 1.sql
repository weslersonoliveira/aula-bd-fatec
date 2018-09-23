CREATE DATABASE produto_ex_view_1
GO
USE produto_ex_view_1


CREATE TABLE fabricante(
	idFab INT CONSTRAINT PK_idFab PRIMARY KEY IDENTITY(1,1),
	razaoSocial VARCHAR(50) NOT NULL,
	cidade VARCHAR(20) CONSTRAINT df_cidade DEFAULT('Franca'),
	UF CHAR(2) CONSTRAINT ch_UF CHECK(UF IN ('SP','MG','RJ'))
)

CREATE TABLE categoria(
	idCat INT CONSTRAINT PK_idCat PRIMARY KEY IDENTITY(100,1),
	descricao VARCHAR(50),
	ativo Char(1) CONSTRAINT ck_ativo CHECK(ativo IN('A','I'))
)


CREATE TABLE marca(
	idMarca INT CONSTRAINT PK_idMarca PRIMARY KEY IDENTITY(5000,1),
	nomeMarca VARCHAR(50) NOT NULL,
)

CREATE TABLE produto(
	idProd INT CONSTRAINT PK_idProd PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(50) NOT NULL,
	preco DECIMAL(10,2) CONSTRAINT ck_preco CHECK(preco > 0),
	idCat INT CONSTRAINT FK_idCat_categoria FOREIGN KEY REFERENCES categoria(idCat),
	idFab INT CONSTRAINT FK_idFab_fabricante FOREIGN KEY REFERENCES fabricante(idFab),
	estoque INT CONSTRAINT ck_estoque CHECK(estoque > 0),
	idMarca INT CONSTRAINT FK_idMarca FOREIGN KEY REFERENCES marca(idMarca)
)


--Cadastre 5 marcas,fabricantes e categorias
INSERT INTO marca
VALUES ('Nestlé'),
	   ('Garoto'),   
	   ('Arcor'),
	   ('Mabel'),
	   ('Fini')


INSERT INTO fabricante(razaoSocial,cidade,UF)
VALUES ('Amaranto LTDA','Franca','SP'),
	   ('Juazeiro do Norte','Rio de Janeiro','RJ'),
	   ('Marcelo & Souza','Belo Horizonte','MG'),
	   ('Alabrama´s','Cassia','MG'),
	   ('Juvivi','São Caetano do Sul','SP')


INSERT INTO categoria(descricao,ativo)	
VALUES ('doce','A'),     
	   ('bebida','I'),
	   ('salgado','A')	    


INSERT INTO produto(descricao,preco,idCat,idFab,estoque,idMarca)   
VALUES ('Manjar dos Deuses 500g',			12.50, 1,5,19,5001),										
	   ('Quindinzinho 10g',					1.00,  1,2,12,5002),										
	   ('Brigadeiro Eduardo Gomes 50g',		2.00,  1,2,14,5003),					
	   ('Maça do amor 150g',				3.00,  3,3,14,5002),							
	   ('Pé de mulecote 20g',				4.00,  3,1,13,5004),																			
	   ('Aguardente c/ Pimenta 500ml',		3.50,  2,3,12,5001),							
	   ('Vodquila 500ml',					15,    2,5,13,5002)
	   

--2.	Crie as seguintes views para:
--a.	Listar o código do produto, sua descrição e preço, a categoria, o nome a cidade do fabricante.
CREATE VIEW vListarProduto
AS
	SELECT 
		P.idProd,
		P.descricao,
		P.preco,
		C.descricao AS Categoria,
		F.cidade AS 'Cidade do fabricante'
	FROM
		produto AS P INNER JOIN categoria AS C ON
			P.idCat = C.idCat
		INNER JOIN fabricante AS F ON
			P.idFab = F.idFab

--b.	Listar a quantidade de produtos que existem por categoria.
CREATE VIEW vQtdPorCategoria
AS
	SELECT
		C.descricao AS Categoria,
		SUM(P.estoque) as 'Total de Produtos'
	FROM
		produto as P INNER JOIN categoria AS C ON
			P.idCat = C.idCat
		GROUP BY C.descricao		
--c.	Selecionar de forma exclusiva as categorias que possuem produtos fornecidos para o estado de SP e que estão em categorias inativas.
CREATE VIEW vParaSp
AS
	SELECT DISTINCT
		C.descricao AS CATEGORIA

	FROM
		categoria AS C INNER JOIN produto AS P ON
			C.idCat = P.idCat
		INNER JOIN fabricante AS F ON
			P.idFab = F.idFab
		WHERE C.ativo = 'I' AND F.UF = 'SP'		
--d.	Listar os nomes dos produtos, o preço total dos seus estoques (considerando o preço de venda) e o nome das categorias que eles pertencem. Somente de produtos fabricados em SP.

CREATE VIEW vTotalPrecoSp
AS
	SELECT
		P.descricao,
		C.descricao AS Categoria,
		SUM(p.estoque * p.preco) AS 'Preço do estoque'
	FROM
		categoria AS C INNER JOIN produto AS P ON
			C.idCat = P.idCat
		INNER JOIN fabricante AS F ON
			P.idFab = F.idFab
		WHERE F.UF = 'SP'
		GROUP BY P.descricao, C.descricao
	
--6.	Crie uma view que liste a quantidade de produtos que existe por marca. Depois exiba o conteúdo desta view colocando no início da lista, a marca que tem mais produtos.
CREATE VIEW vSomMarca
AS
	SELECT
		M.idMarca AS ID,
		M.nomeMarca,
		SUM(P.estoque) 'Total de produtos da marca'
	FROM
		produto AS P INNER JOIN MARCA AS M ON
			P.idMarca = M.idMarca
		GROUP BY M.idMarca,M.nomeMarca

SELECT ID,nomeMarca,[Total de produtos da marca]
FROM vSomMarca
ORDER BY [Total de produtos da marca] DESC
		
--7.	Crie uma view que informe quais são os fabricantes e as marcas dos produtos que estão nas categorias Inativas.
CREATE VIEW vInativas
AS
	SELECT 
		P.idProd,
		P.descricao,
		M.nomeMarca,
		F.razaoSocial
	FROM
		produto AS P INNER JOIN fabricante AS F ON
			P.idFab = F.idFab 
		INNER JOIN MARCA AS M ON 
			P.idMarca = M.idMarca
		INNER JOIN categoria AS C ON
			P.idCat = C.idCat
		WHERE C.ativo = 'I'


--8.	Crie uma nova view para mostrar a descrição e os preços dos produtos e suas respectivas marcas, ordenado por produto.

CREATE VIEW vProdutoPrecoMarca
AS
	SELECT
		P.descricao,
		P.preco,
		M.nomeMarca
	FROM
		produto AS P INNER JOIN MARCA AS M ON
			P.idMarca = M.idMarca

SELECT * FROM vProdutoPrecoMarca
	ORDER BY descricao
--(Uma view por ser uma tabela nova, não permite cadastro do ORDER BY, já que ele
-- é exclusivo de uma consulta! Entao deve-se fazer a consulta da view, aplicando
-- o order by



