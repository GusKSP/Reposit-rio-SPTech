CREATE DATABASE academia;

USE academia;

CREATE TABLE PLANOS (
    id_plano INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL UNIQUE,
    preco DECIMAL(10, 2) NOT NULL,
    duracao_dias INT NOT NULL
);

-- 2. Tabela FORMAS_PAGAMENTO
CREATE TABLE FORMAS_PAGAMENTO (
    id_forma INT PRIMARY KEY AUTO_INCREMENT,
    nome_forma VARCHAR(50) NOT NULL UNIQUE
);

-- 3. Tabela ALUNOS
CREATE TABLE ALUNOS (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    data_matricula DATE NOT NULL
);

-- 4. Tabela MATRICULAS (Relaciona Aluno e Plano)
CREATE TABLE MATRICULAS (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES ALUNOS(id_aluno),
    FOREIGN KEY (id_plano) REFERENCES PLANOS(id_plano)
);

-- 5. Tabela PAGAMENTOS (Relaciona Matrícula e Forma de Pagamento)
CREATE TABLE PAGAMENTOS (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_matricula INT NOT NULL,
    id_forma INT NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL,
    status_pagamento VARCHAR(50) NOT NULL, -- Ex: 'Pago', 'Atrasado', 'Cancelado'
    FOREIGN KEY (id_matricula) REFERENCES MATRICULAS(id_matricula),
    FOREIGN KEY (id_forma) REFERENCES FORMAS_PAGAMENTO(id_forma)
);

## PARTE 2: Inserção de Dados (DML)

-- Inserção de Planos
INSERT INTO PLANOS (titulo, preco, duracao_dias) VALUES
('Mensal', 100.00, 30),
('Trimestral', 270.00, 90),
('Anual', 960.00, 365);

-- Inserção de Formas de Pagamento
INSERT INTO FORMAS_PAGAMENTO (nome_forma) VALUES
('Cartão'),
('Pix'),
('Dinheiro');

-- Inserção de Alunos (com datas de nascimento fictícias)
INSERT INTO ALUNOS (nome_aluno, data_nascimento, data_matricula) VALUES
('João Silva', '1995-05-10', '2024-01-15'), -- Aluno 1
('Maria Oliveira', '2000-11-20', '2024-02-01'), -- Aluno 2
('Pedro Souza', '1988-03-03', '2024-03-10'), -- Aluno 3
('Ana Costa', '1999-07-25', '2024-04-05'), -- Aluno 4
('Carlos Lima', '1990-01-01', '2024-05-20'); -- Aluno 5

-- Inserção de Matrículas
INSERT INTO MATRICULAS (id_aluno, id_plano, data_inicio, data_vencimento) VALUES
(1, 3, '2024-01-15', '2025-01-15'), -- João: Anual
(2, 1, '2024-02-01', '2024-03-01'), -- Maria: Mensal (1ª)
(2, 1, '2024-03-01', '2024-04-01'), -- Maria: Mensal (2ª)
(3, 2, '2024-03-10', '2024-06-10'), -- Pedro: Trimestral
(4, 1, '2024-04-05', '2024-05-05'), -- Ana: Mensal
(5, 3, '2024-05-20', '2025-05-20'); -- Carlos: Anual

-- Inserção de Pagamentos (10 Pagamentos)
INSERT INTO PAGAMENTOS (id_matricula, id_forma, valor_pago, data_pagamento, status_pagamento) VALUES
(1, 2, 960.00, '2024-01-15', 'Pago'),    -- João (Anual - Pix)
(2, 1, 100.00, '2024-02-01', 'Pago'),    -- Maria (Mensal - Cartão)
(3, 1, 100.00, '2024-03-01', 'Pago'),    -- Maria (Mensal - Cartão)
(4, 3, 270.00, '2024-03-10', 'Pago'),    -- Pedro (Trimestral - Dinheiro)
(4, 3, 50.00, '2024-04-10', 'Atrasado'), -- Pedro (Pagamento parcial/atrasado - Dinheiro)
(5, 2, 100.00, '2024-04-05', 'Pago'),    -- Ana (Mensal - Pix)
(6, 1, 480.00, '2024-05-20', 'Pago'),    -- Carlos (Anual - 1ª Parcela - Cartão)
(6, 1, 480.00, '2024-06-20', 'Pago'),    -- Carlos (Anual - 2ª Parcela - Cartão)
(1, 3, 10.00, '2024-06-01', 'Pago'),     -- João (Compra de água - Dinheiro)
(3, 2, 10.00, '2024-06-05', 'Pago');     -- Maria (Compra de água - Pix)

-- Consultas (irei fazer apenas as consultas das tabelas, pois é a parte que mais tenho dificuldade)

SELECT a.*, p.* FROM MATRICULAS m JOIN ALUNOS a ON a.id_aluno = m.id_aluno JOIN PLANOS p ON p.id_plano = m.id_plano;

-- para a seguinte consulta irei fazer um update para aparecer ao menos um resultado

UPDATE MATRICULAS SET data_vencimento = CURDATE() + INTERVAL 1 YEAR WHERE id_aluno=1;
UPDATE MATRICULAS SET data_inicio = CURDATE() - INTERVAL 1 YEAR WHERE id_aluno=1;
UPDATE ALUNOS SET data_matricula = CURDATE() - INTERVAL 1 YEAR WHERE id_aluno = 1;

SELECT a.*, p.* FROM MATRICULAS m JOIN ALUNOS a ON a.id_aluno = m.id_aluno JOIN PLANOS p ON p.id_plano = m.id_plano WHERE p.titulo = 'anual' AND m.data_vencimento > CURDATE();

SELECT a.nome_aluno, SUM(p.valor_pago) AS valor_total_pago 
FROM PAGAMENTOS p 
RIGHT JOIN MATRICULAS m ON p.id_matricula = m.id_matricula 
RIGHT JOIN ALUNOS a ON m.id_aluno = a.id_aluno 
GROUP BY a.id_aluno;

SELECT DISTINCT a.* 
FROM PAGAMENTOS p 
RIGHT JOIN MATRICULAS m ON p.id_matricula = m.id_matricula 
RIGHT JOIN FORMAS_PAGAMENTO f ON f.id_forma = p.id_forma 
RIGHT JOIN ALUNOS a ON m.id_aluno = a.id_aluno 
WHERE f.nome_forma = 'cartão';

SELECT a.* FROM ALUNOS a
LEFT JOIN MATRICULAS m ON m.id_aluno = a.id_aluno
LEFT JOIN PAGAMENTOS p ON p.id_matricula = m.id_matricula WHERE p.id_pagamento IS NULL;

SELECT ROUND(AVG(p.preco),2) FROM PLANOS p;

SELECT f.nome_forma, SUM(p.valor_pago) AS valor_total FROM PAGAMENTOS p JOIN FORMAS_PAGAMENTO f ON f.id_forma = p.id_forma GROUP BY f.id_forma;

SELECT DATE_FORMAT(data_pagamento, '%Y/%m') AS ano_mes, SUM(valor_pago) AS total FROM PAGAMENTOS p GROUP BY ano_mes ORDER BY total DESC LIMIT 1;

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, data_nascimento,CURDATE())),2) AS media_idade FROM ALUNOS;

-- Indo para questões mais complexas
UPDATE PLANOS p SET p.preco = p.preco * 1.10 WHERE p.titulo = 'Mensal';
SELECT * FROM PLANOS;


-- Ex 14. Adicionando um valor para pagamentos para entrar na condição específica
INSERT INTO PAGAMENTOS (id_matricula, id_forma, valor_pago, data_pagamento, status_pagamento) VALUES
(4,3,300.00,CURDATE() - INTERVAL 10 DAY, 'pago');

UPDATE PAGAMENTOS SET id_forma = (SELECT id_forma FROM FORMAS_PAGAMENTO where nome_forma = 'Pix') 
WHERE id_pagamento IN (SELECT id_pagamento FROM 
(SELECT p.id_pagamento FROM PAGAMENTOS p WHERE p.data_pagamento >= CURDATE() - INTERVAL 1 MONTH) AS mes_passado);
-- Consulta para ver se alterou
SELECT * FROM PAGAMENTOS;

-- Testando se funciona se um aluno nunca pagou:
INSERT INTO ALUNOS (nome_aluno, data_nascimento, data_matricula) VALUES
('gus kenzo', '2007-09-14', CURDATE());

	-- Ex 16
DELETE FROM ALUNOS WHERE id_aluno IN (
	SELECT AlunoMenosPago.id_aluno FROM (
		SELECT a.id_aluno, SUM(valor_pago) AS TotalPago FROM PAGAMENTOS p JOIN MATRICULAS m ON m.id_matricula = p.id_matricula 
		JOIN ALUNOS a ON a.id_aluno = m.id_aluno GROUP BY a.id_aluno ORDER BY TotalPago LIMIT 1)
	AS AlunoMenosPago
);

-- Não irá funcionar pois não existe está com RIGHT JOIN, e está com o Safemode ativado.