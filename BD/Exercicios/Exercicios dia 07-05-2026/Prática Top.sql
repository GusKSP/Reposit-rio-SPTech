CREATE DATABASE PraticaTOP;
USE PraticaTOP;

-- 1. Tabela PLANOS
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

SHOW TABLES;

DESC ALUNOS;