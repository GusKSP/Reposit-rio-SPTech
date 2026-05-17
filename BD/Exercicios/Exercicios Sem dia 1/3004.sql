SHOW DATABASES;


CREATE DATABASE 1ccoa;
USE 1ccoa;

CREATE TABLE Aluno (
id_aluno INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cpf CHAR(11),
dt_nasc DATE
);

CREATE TABLE Curso (
id_curso INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
dt_criacao DATE
);

CREATE TABLE Matricula(
fk_aluno INT,
fk_curso INT,
PRIMARY KEY (fk_aluno, fk_curso),
FOREIGN KEY (fk_aluno) REFERENCES Aluno(id_aluno),
FOREIGN KEY (fk_curso) REFERENCES Curso(id_curso)
);
ALTER TABLE Matricula ADD COLUMN dt_inicio DATETIME;

INSERT INTO Aluno (nome,cpf,dt_nasc) VALUES
('Clara','11111111111','2004-05-10'),
('Joao','11111111112','2004-05-11');

INSERT INTO Curso (nome,dt_criacao) VALUES
('Python', '2007-02-06'),
('SQL', '2007-02-05'),
('CSS', '2007-02-04'),
('HTML', '2007-02-03'),
('JS', '2007-02-02');

-- CRIAÇÃO DE TABELA PARA RELAÇÃO N:M
INSERT INTO Matricula (fk_aluno, fk_curso, dt_inicio) VALUES
(1,1,NOW()),
(1,2,NOW()),
(2,1,NOW()),
(2,2,NOW()),
(2,3,NOW()),
(2,4,NOW());

SELECT * FROM Aluno
JOIN Matricula
ON Matricula.fk_aluno = Aluno.id_aluno
JOIN Curso
ON Matricula.fk_curso = Curso.id_curso;

-- Introdução ao "TIMESTAMPDIFF().
SELECT a.nome AS Aluno, c.nome AS Curso, m.dt_inicio AS Matricula, TIMESTAMPDIFF(YEAR,a.dt_nasc, CURDATE()) AS Idade
FROM Aluno a
RIGHT JOIN Matricula m
ON m.fk_aluno = a.id_aluno
RIGHT JOIN Curso c
ON m.fk_curso = c.id_curso;

-- CRIAÇÃO DE TABELA VIRTUAL (VIEW)
CREATE VIEW info_aluno_curso AS
SELECT a.nome AS Aluno, c.nome AS Curso, m.dt_inicio AS Matricula, TIMESTAMPDIFF(YEAR,a.dt_nasc, CURDATE()) AS Idade
FROM Aluno a
RIGHT JOIN Matricula m
ON m.fk_aluno = a.id_aluno
RIGHT JOIN Curso c
ON m.fk_curso = c.id_curso;

-- Como utilizar a tabela Virtual
SELECT * FROM info_aluno_curso