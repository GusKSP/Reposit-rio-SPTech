CREATE DATABASE 1CCOA_BD_20260507;
USE 1CCOA_BD_20260507;

CREATE TABLE departamento(
idDepartamento INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50)
);

CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80),
salario DECIMAL (10,2),
fkDepartamento INT, 
FOREIGN KEY (fkDepartamento) REFERENCES departamento(idDepartamento)
);

INSERT INTO departamento (nome) VALUES
('TI'),
('RH'),
('DP'),
('Vendas');

INSERT INTO funcionario (nome, salario, fkDepartamento) VALUES
('Clara', 5000, 1),
('Vivian',5500,1),
('Pedro', 6200,2),
('Walter', 9999, 4);

-- Subquery - Consulta dentro de uma consulta
-- Separado por ()

-- Trazendo nome e salário de todos que são de TI

-- SELECT no WHERE
SELECT
nome,
salario
FROM funcionario
WHERE fkDepartamento IN (
	SELECT idDepartamento
    FROM departamento
    WHERE nome = 'TI'
);

-- Trazendo o nome dos funcionários onde o salário é maior que a média

SELECT f.nome
FROM funcionario f 
WHERE salario > (
	SELECT AVG(salario) 
    FROM funcionario
);

-- Exemplo de Subquery utilizada no FROM, trazendo uma tabela virtual
-- como resultado da subquery
-- Como o resultado e uma tabela , preciso de um ALIAS.
CREATE VIEW dp_salario AS (
SELECT *
FROM (
	SELECT dp.nome AS departamento,
	AVG(salario) AS media_salario
    FROM funcionario
    JOIN departamento dp ON funcionario.fkDepartamento = dp.idDepartamento
    GROUP BY fkDepartamento
) AS medias
);

SELECT * FROM dp_salario;

SELECT
ROUND(AVG(media_salario),2) AS media_total
FROM dp_salario;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(45),
cnpj CHAR(14)
);

ALTER TABLE departamento ADD COLUMN fkEmpresa INT, ADD CONSTRAINT cfkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa);

INSERT INTO empresa (nomeEmpresa, cnpj) VALUES
('Empresa da clara','11111111111111');

UPDATE departamento SET fkEmpresa=1 WHERE idDepartamento IN (1,2,3,4);

INSERT INTO empresa (nomeEmpresa, cnpj) VALUES
('Empresa do Matheus','11111111111112');

SELECT * FROM
empresa LEFT JOIN 
departamento 
ON fkEmpresa = idEmpresa
LEFT JOIN funcionario
ON fkDepartamento = idDepartamento