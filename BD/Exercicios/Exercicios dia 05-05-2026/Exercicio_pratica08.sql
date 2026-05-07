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