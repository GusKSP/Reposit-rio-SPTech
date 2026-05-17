CREATE DATABASE loja;
USE loja;

CREATE TABLE cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100)
);

CREATE TABLE produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(100),
    preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES cliente(id)
);

CREATE TABLE itens_pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,    
    CONSTRAINT fk_itens_pedido
	FOREIGN KEY (pedido_id)
	REFERENCES pedido(id),
    CONSTRAINT fk_itens_produto
	FOREIGN KEY (produto_id)
	REFERENCES produto(id)
);

-- Inserindo Registros nas tabelas.

INSERT INTO cliente (nome, cidade) VALUES
('Ana', 'São Paulo'),
('Bruno', 'Rio de Janeiro'),
('Carlos', 'São Paulo'),
('Daniela', 'Belo Horizonte'),
('Eduardo', 'Curitiba'),
('Fernanda', 'Rio de Janeiro'),
('Gabriel', 'Salvador'),
('Helena', 'São Paulo'),
('Igor', 'Curitiba'),
('Juliana', 'Recife');

INSERT INTO produto (nome, categoria, preco) VALUES
('Notebook Dell', 'Informática', 4500.00),
('Mouse Gamer', 'Informática', 150.00),
('Teclado Mecânico', 'Informática', 350.00),
('Monitor 27', 'Informática', 1800.00),
('Cadeira Gamer', 'Móveis', 1200.00),
('Mesa Escritório', 'Móveis', 900.00),
('Smartphone Samsung', 'Celulares', 3200.00),
('iPhone', 'Celulares', 7000.00),
('Fone Bluetooth', 'Áudio', 250.00),
('Caixa de Som', 'Áudio', 600.00),
('TV 50 Polegadas', 'Eletrônicos', 3500.00),
('Geladeira', 'Eletrodomésticos', 4200.00),
('Microondas', 'Eletrodomésticos', 800.00),
('Ventilador', 'Eletrodomésticos', 200.00),
('Impressora', 'Informática', 950.00);

INSERT INTO pedido (cliente_id, data, valor_total) VALUES
(1, '2026-01-10', 4650.00),
(1, '2026-02-15', 1200.00),
(2, '2026-01-20', 7000.00),
(3, '2026-03-05', 2150.00),
(4, '2026-03-18', 900.00),
(5, '2026-04-01', 3500.00),
(6, '2026-04-10', 5000.00),
(6, '2026-04-15', 250.00),
(8, '2026-04-20', 1800.00),
(9, '2026-05-01', 4400.00);

INSERT INTO itens_pedido 
(pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 4500.00),
(1, 2, 1, 150.00),
(2, 5, 1, 1200.00),
(3, 8, 1, 7000.00),
(4, 4, 1, 1800.00),
(4, 9, 1, 250.00),
(4, 14, 1, 100.00),
(5, 6, 1, 900.00),
(6, 11, 1, 3500.00),
(7, 12, 1, 4200.00),
(7, 10, 1, 600.00),
(7, 14, 1, 200.00),
(8, 9, 1, 250.00),
(9, 4, 1, 1800.00),
(10, 12, 1, 4200.00),
(10, 14, 1, 200.00);


-- SELECTS
SELECT c.nome, p.valor_total
FROM cliente c
JOIN pedido p
    ON c.id = p.cliente_id
WHERE p.valor_total > (
    SELECT AVG(valor_total)
    FROM pedido
);

SELECT nome, preco FROM produto WHERE preco IN (
SELECT MAX(preco) FROM produto);

SELECT c.nome, p.valor_total FROM cliente c
JOIN pedido p ON c.id = p.cliente_id WHERE valor_total > (
SELECT MIN(valor_total) FROM pedido);

SELECT id, nome as cliente_sem_pedido, cidade
FROM cliente
WHERE id NOT IN (
    SELECT cliente_id
    FROM pedido
);

SELECT * from produto 
WHERE preco > (
SELECT AVG(preco) from produto);

SELECT c.id AS id_cliente, c.nome AS nome_cliente, SUM(p.valor_total) AS total_gasto 
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP by c.id
HAVING SUM(p.valor_total) > (
	SELECT AVG(total_cliente)
    FROM (
		SELECT SUM(valor_total) AS total_cliente
        FROM pedido
        GROUP BY cliente_id
	) AS media_total_gasto
);

DESC pedido;

SELECT c.nome, SUM(p.valor_total) AS maior_valor
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
HAVING MAX(maior_valor) > (
	SELECT SUM(valor_total) FROM pedido
	GROUP BY pedido.cliente_id
	);

    
SELECT c.nome, p.valor_total
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
WHERE p.valor_total = (
    SELECT MAX(valor_total)
    FROM pedido
);

DESC produto;
DESC itens_pedido;

SELECT * FROM produto p
WHERE p.id NOT IN (
SELECT produto_id FROM itens_pedido);

SELECT c.nome, count(p.id) AS quantidade_pedidos 
FROM cliente c
LEFT JOIN pedido p ON c.id = p.cliente_id
GROUP by c.id;

SELECT categoria, COUNT(id) AS quantidade_produtos
FROM produto
GROUP BY categoria
HAVING COUNT(id) > 5;

SELECT AVG(valor_total) 
FROM pedido;

SELECT c.cidade, MAX(p.valor_total) AS maior_pedido
FROM cliente c
JOIN pedido p
    ON c.id = p.cliente_id
GROUP BY c.cidade;

SELECT c.nome, c.cidade, SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON p.cliente_id = c.id
GROUP BY c.id
	HAVING SUM(p.valor_total) > (
	SELECT AVG(total_cliente) 
	FROM (
		SELECT SUM(p2.valor_total) AS total_cliente
		FROM cliente c2
		JOIN pedido p2 ON p2.cliente_id = c2.id
		WHERE c2.cidade = c.cidade
		GROUP BY c2.id
	) AS media_cidade
);

SELECT c.nome, p.valor_total FROM cliente c
JOIN pedido p ON p.cliente_id = c.id
WHERE p.valor_total > (
	SELECT AVG(p2.valor_total) FROM cliente c2
    JOIN pedido p2 ON c2.id = p2.cliente_id
);

SELECT pr.nome, SUM(ip.quantidade) AS total_vendido
FROM produto pr
JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY pr.id
HAVING SUM(ip.quantidade) IN (
	SELECT MAX(total_quantidade) FROM (
		SELECT SUM(quantidade) AS total_quantidade FROM itens_pedido
        GROUP BY produto_id
	) AS maximo_pedido
);
SELECT c.nome, COUNT(p.id) AS quantidade_pedidos
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
HAVING COUNT(p.id) > (
	SELECT AVG(qtd_pedidos) FROM (
		SELECT COUNT(id) AS qtd_pedidos
        FROM pedido
        GROUP BY cliente_id
	) AS media_pedidos
);

SELECT c.nome, COUNT(p.id) AS quantidade_pedidos, SUM(p.valor_total)
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
HAVING COUNT(p.id) > (
	SELECT AVG(qtd_pedidos) FROM (
		SELECT COUNT(id) AS qtd_pedidos
        FROM pedido
        GROUP BY cliente_id
	) AS media_pedidos
)
OR SUM(p.valor_total) > (
	SELECT AVG(total_gasto) FROM (
		SELECT SUM(p2.valor_total) AS total_gasto
        FROM pedido p2
        JOIN cliente c2 ON c2.id = p2.cliente_id
        GROUP BY p2.cliente_id
	) AS media_total_gasto
);