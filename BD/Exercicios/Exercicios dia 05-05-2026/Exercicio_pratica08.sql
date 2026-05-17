CREATE DATABASE Venda;
USE Venda;

CREATE TABLE endereco (
idendereco INT PRIMARY KEY AUTO_INCREMENT,
estado VARCHAR(45),
cidade VARCHAR(45),
bairro VARCHAR (45),
numero INT,
complemento VARCHAR(45),
cep CHAR(8)
);



CREATE TABLE cliente (
idcliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cpf CHAR(11),
email VARCHAR(45),
fk_endereco INT NOT NULL,
cliente_indicacao INT,
CONSTRAINT cfk_endereco FOREIGN KEY (fk_endereco) REFERENCES endereco(idendereco),
CONSTRAINT ccliente_indicacao FOREIGN KEY (cliente_indicacao) REFERENCES cliente(idcliente)
);

CREATE TABLE venda (
idvenda INT PRIMARY KEY AUTO_INCREMENT,
dt_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
desconto DECIMAL(20,2),
total DECIMAL(20,2),
fk_cliente INT NOT NULL,
CONSTRAINT cfk_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente(idcliente)
);

CREATE TABLE produto (
idproduto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao VARCHAR(255),
preco DECIMAL(10,2)
);

CREATE TABLE venda_produtos (
fk_idproduto INT,
fk_idvenda INT,
PRIMARY KEY (fk_idproduto, fk_idvenda),
CONSTRAINT cfk_produto FOREIGN KEY (fk_idproduto) REFERENCES produto(idproduto),
CONSTRAINT cfk_venda FOREIGN KEY (fk_idvenda) REFERENCES venda(idvenda)
);

INSERT INTO endereco (estado, cidade, bairro, numero, complemento, cep) VALUES
('SP', 'São Paulo', 'Centro', 100, 'Apto 101', '01001001'),
('SP', 'Santo André', 'Vila Assunção', 200, NULL, '01010102'),
('RJ', 'Rio de Janeiro', 'Copacabana', 300, 'Casa', '01001003');

INSERT INTO cliente (nome, cpf, email, fk_endereco, cliente_indicacao) VALUES
('João Silva', '12345678901', 'joao@email.com', 1, NULL),
('Maria Souza', '98765432100', 'maria@email.com', 2, NULL);

INSERT INTO cliente (nome, cpf, email, fk_endereco, cliente_indicacao) VALUES
('Carlos Lima', '11122233344', 'carlos@email.com', 3, 1);

INSERT INTO produto (nome, descricao, preco) VALUES
('Notebook', 'Notebook i5 8GB RAM', 3500.00),
('Mouse', 'Mouse sem fio', 80.00),
('Teclado', 'Teclado mecânico', 250.00);

INSERT INTO venda (desconto, total, fk_cliente) VALUES
(100.00, 3480.00, 1),
(0.00, 80.00, 2),
(50.00, 3700.00, 3);

INSERT INTO venda_produtos (fk_idproduto, fk_idvenda) VALUES
(1, 1),
(2, 2),
(1, 3),
(3, 3);

INSERT INTO venda (desconto, total, fk_cliente) VALUES
(50.00, 3300.00, 1),
(10.00, 70.00, 2),
(100.00, 3600.00, 3);

INSERT INTO venda_produtos (fk_idproduto, fk_idvenda) VALUES
(1, 4),
(2, 4),
(3, 5),
(2, 6);

SELECT * FROM endereco;
SELECT * FROM cliente;
SELECT * FROM venda;
SELECT * FROM produto;
SELECT * FROM venda_produtos;

SELECT 
    c.idcliente,
    c.nome,
    c.email,
    v.idvenda,
    v.dt_venda,
    v.desconto,
    v.total
FROM cliente c
JOIN venda v ON c.idcliente = v.fk_cliente;

SELECT c.nome AS cliente, c.email AS email, v.dt_venda AS 'data', v.desconto AS desconto, v.total AS total, p.nome AS produto, p.preco AS 'preco do produto'
FROM cliente c
JOIN venda v ON c.idcliente = v.fk_cliente
JOIN venda_produtos vp ON v.idvenda = vp.fk_idvenda
JOIN produto p ON vp.fk_idproduto = p.idproduto
WHERE c.nome = 'João Silva';

SELECT 
    c.nome AS cliente,
    c.email,
    v.idvenda,
    v.dt_venda,
    v.desconto,
    v.total,
    p.idproduto,
    p.nome AS produto,
    p.preco
FROM cliente c
JOIN venda v ON c.idcliente = v.fk_cliente
JOIN venda_produtos vp ON v.idvenda = vp.fk_idvenda
JOIN produto p ON vp.fk_idproduto = p.idproduto
WHERE c.nome = 'João Silva'
ORDER BY v.idvenda;

SELECT c.* , ci.nome  AS 'cliente indicado'
FROM cliente c
LEFT JOIN cliente ci ON c.idcliente = ci.cliente_indicacao;

SELECT 
    ci.idcliente AS id_indicador,
    ci.nome AS indicador,
    ci.email AS email_indicador,
    
    c.idcliente AS id_indicado,
    c.nome AS cliente_indicado,
    c.email AS email_indicado

FROM cliente ci
LEFT JOIN cliente c 
    ON ci.idcliente = c.cliente_indicacao
WHERE ci.nome = 'João Silva';

SELECT 
    c.idcliente,
    c.nome AS cliente,
    c.email,
    ci.idcliente AS id_indicador,
    ci.nome AS indicador,
    ci.email AS email_indicador,
    v.idvenda,
    v.dt_venda,
    v.desconto,
    v.total,
    p.idproduto,
    p.nome AS produto,
    p.preco
FROM cliente c
LEFT JOIN cliente ci 
    ON c.cliente_indicacao = ci.idcliente
LEFT JOIN venda v 
    ON c.idcliente = v.fk_cliente
LEFT JOIN venda_produtos vp 
    ON v.idvenda = vp.fk_idvenda
LEFT JOIN produto p 
    ON vp.fk_idproduto = p.idproduto
ORDER BY c.idcliente, v.idvenda;

SELECT 
    DATE(v.dt_venda) AS data_venda,
    p.nome AS produto,
    COUNT(p.idproduto) AS quantidade
FROM venda v
JOIN venda_produtos vp ON v.idvenda = vp.fk_idvenda
JOIN produto p ON vp.fk_idproduto = p.idproduto
WHERE v.idvenda = 1
GROUP BY DATE(v.dt_venda), p.idproduto;

SELECT 
    p.nome AS produto,
    p.preco,
    COUNT(vp.fk_idproduto) AS quantidade_vendida
FROM produto p
JOIN venda_produtos vp 
    ON p.idproduto = vp.fk_idproduto
GROUP BY p.idproduto, p.nome, p.preco;

SELECT 
    c.idcliente,
    c.nome,
    c.email,
    v.idvenda,
    v.dt_venda,
    v.total
FROM cliente c
LEFT JOIN venda v 
    ON c.idcliente = v.fk_cliente
ORDER BY c.idcliente;

SELECT 
    MIN(preco) AS produto_menor_preco,
    MAX(preco) AS produto_maior_preco
FROM produto;

SELECT 
    SUM(preco) AS soma_precos,
    ROUND(AVG(preco),2) AS media_precos
FROM produto;

SELECT 
    p.nome,
    COUNT(p.idproduto) AS quantidade_produto_acima_media_preco
FROM produto p
WHERE p.preco > (SELECT AVG(preco) FROM produto)
GROUP BY p.idproduto;

SELECT 
    SUM(DISTINCT preco) AS soma_precos_distintos
FROM produto;

SELECT 
    v.idvenda,
    SUM(p.preco) AS total_produtos
FROM venda v
JOIN venda_produtos vp ON v.idvenda = vp.fk_idvenda
JOIN produto p ON vp.fk_idproduto = p.idproduto
WHERE v.idvenda = 1
GROUP BY v.idvenda;