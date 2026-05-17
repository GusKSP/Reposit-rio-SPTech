CREATE DATABASE loja;
USE loja;

CREATE TABLE categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nomeCategoria VARCHAR(100)
);

CREATE TABLE produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    nomeProduto VARCHAR(100),
    preco DECIMAL(10,2),
    fkCategoria INT,
    FOREIGN KEY (fkCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE venda (
    idVenda INT PRIMARY KEY AUTO_INCREMENT,
    fkCliente INT,
    dataVenda DATE,
    FOREIGN KEY (fkCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE itemVenda (
    idItemVenda INT PRIMARY KEY AUTO_INCREMENT,
    fkVenda INT,
    fkProduto INT,
    quantidade INT,
    FOREIGN KEY (fkVenda) REFERENCES venda(idVenda),
    FOREIGN KEY (fkProduto) REFERENCES produto(idProduto)
);

INSERT INTO categoria (nomeCategoria) VALUES
('Periféricos'),
('Hardware'),
('Monitores');

INSERT INTO produto (nomeProduto, preco, fkCategoria) VALUES
('Mouse', 120, 1),
('Teclado', 250, 1),
('SSD', 400, 2),
('Monitor Gamer', 1500, 3),
('Memória RAM', 350, 2);

INSERT INTO cliente (nome, email) VALUES
('Ana', 'ana@email.com'),
('Bruno', 'bruno@email.com'),
('Carlos', 'carlos@email.com');

INSERT INTO venda (fkCliente, dataVenda) VALUES
(1, '2026-05-01'),
(2, '2026-05-02'),
(1, '2026-05-03'),
(3, '2026-05-04');

INSERT INTO itemVenda (fkVenda, fkProduto, quantidade) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 4, 1),
(3, 3, 2),
(3, 5, 1),
(4, 1, 1),
(4, 4, 1);

-- =====================================================
-- EXERCÍCIOS
-- =====================================================

-- 1) Mostre a quantidade de produtos por categoria.

DESC produto;
DESC categoria;

SELECT c.nomeCategoria, COUNT(p.idProduto) AS qtd_produtos
FROM produto p
JOIN categoria c on p.fkCategoria = c.idCategoria
GROUP BY p.fkCategoria;

-- 2) Mostre as categorias que possuem mais de 1 produto.

SELECT nomeCategoria FROM categoria WHERE idCategoria IN (
	SELECT fkCategoria FROM produto GROUP BY fkCategoria HAVING COUNT(idProduto) > 1)
;

-- 3) Mostre o produto mais caro.

SELECT nomeProduto, MAX(preco) AS preco FROM produto GROUP BY idProduto ORDER BY preco DESC LIMIT 1;

-- 4) Mostre o preço médio dos produtos por categoria.

SELECT c.nomeCategoria, tpm.media_preco_por_categoria FROM categoria c
JOIN (
	SELECT fkCategoria, AVG(preco) AS media_preco_por_categoria 
	FROM produto 
	GROUP BY fkCategoria) AS tpm ON tpm.fkCategoria = c.idCategoria
;

-- 5) Mostre os produtos com preço acima da média.

SELECT p.nomeProduto, p.preco FROM produto p WHERE p.preco > (
	SELECT AVG(preco) FROM produto);

-- 6) Mostre a quantidade de itens vendidos por produto.

SELECT p.nomeProduto, COUNT(iv.fkProduto) AS qtd_Vendas 
FROM itemVenda iv 
JOIN produto p ON p.idProduto = iv.fkProduto 
GROUP BY p.idProduto;

-- 7) Mostre os produtos cuja quantidade vendida seja maior que 1.

SELECT p.nomeProduto, COUNT(iv.fkProduto) AS qtd_Vendas 
FROM itemVenda iv 
JOIN produto p ON p.idProduto = iv.fkProduto 
GROUP BY p.idProduto
HAVING qtd_Vendas > 1;

-- 8) Mostre a média dos preços médios das categorias.

SELECT ROUND(AVG(media_preco_produtos_categoria),2) AS media_da_media_de_precos FROM (
	SELECT avg(preco) AS media_preco_produtos_categoria FROM produto 
    GROUP BY fkCategoria) AS tabela_preco_medio_produtos_por_categoria;


-- 9) Mostre o cliente que realizou mais vendas.

SELECT c.nome FROM cliente c
WHERE c.idCliente IN (
	SELECT fkCliente FROM (
		SELECT fkCliente, COUNT(fkCliente) AS numero_vendas FROM venda GROUP BY fkCliente 
        ORDER BY numero_vendas DESC LIMIT 1)
	AS clientes)
;

-- 10) Mostre a maior quantidade vendida de cada produto.

SELECT 
p.nomeProduto,
qtd.qtd_vendido AS quantidade_maior_venda
FROM produto p
JOIN (
	SELECT 
	fkProduto,
	MAX(quantidade) AS qtd_vendido
	FROM itemVenda
	JOIN venda ON fkVenda = idVenda
    GROUP BY fkProduto
) AS qtd ON qtd.fkProduto = p.idProduto
;

-- 11) Mostre os produtos com preço acima da média da categoria.

SELECT nomeProduto, preco, nomeCategoria FROM produto JOIN (
	SELECT AVG(preco) AS media_preco_categoria,
    fkCategoria AS Categoria_produto
    FROM produto p
    JOIN categoria ON idCategoria = fkCategoria 
    GROUP BY fkCategoria) AS tabela_preco_medio_categoria
JOIN categoria ON idCategoria = fkCategoria
WHERE preco > media_preco_categoria AND Categoria_produto = fkCategoria
;
SELECT * FROM produto;

SELECT AVG(preco) AS media_preco_categoria FROM produto JOIN categoria ON idCategoria = fkCategoria GROUP BY fkCategoria;

-- 12) Mostre a média das quantidades vendidas por produto.

SELECT SUM(iv.quantidade) AS Soma_Vendas, 
p.nomeProduto, 
iv.fkProduto AS id_produto_vendido,
v.dataVenda AS data_venda,
v.idVenda AS id_venda
FROM produto p
JOIN itemVenda iv ON iv.fkProduto = p.idProduto
JOIN venda v ON iv.fkVenda = v.idVenda
GROUP BY p.idProduto AND data_venda;

SELECT p.nomeProduto, ROUND(AVG(Soma_Vendas),2) AS media_vendas FROM produto p
JOIN(
	SELECT SUM(iv.quantidade) AS Soma_Vendas, 
    p.nomeProduto, 
    iv.fkProduto AS produto_vendido
	FROM produto p
	JOIN itemVenda iv ON iv.FkProduto = p.idProduto
    JOIN Venda v ON iv.fkVenda = v.idVenda
	GROUP BY p.idProduto AND dataVenda
) AS psv ON psv.produto_vendido = p.idProduto
GROUP BY psv.produto_vendido;
-- 13) Mostre quantos produtos possuem preço acima de 300.

-- 14) Mostre a categoria com maior quantidade de produtos.

-- 15) Mostre os produtos cujo preço seja maior que a média dos preços médios.