CREATE DATABASE escola;
USE escola;

CREATE TABLE curso (
    idCurso INT PRIMARY KEY AUTO_INCREMENT,
    nomeCurso VARCHAR(100)
);

CREATE TABLE aluno (
    idAluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    fkCurso INT,
    FOREIGN KEY (fkCurso) REFERENCES curso(idCurso)
);

CREATE TABLE disciplina (
    idDisciplina INT PRIMARY KEY AUTO_INCREMENT,
    nomeDisciplina VARCHAR(100),
    cargaHoraria INT
);

CREATE TABLE matricula (
    idMatricula INT PRIMARY KEY AUTO_INCREMENT,
    fkAluno INT,
    fkDisciplina INT,
    nota DECIMAL(4,2),
    FOREIGN KEY (fkAluno) REFERENCES aluno(idAluno),
    FOREIGN KEY (fkDisciplina) REFERENCES disciplina(idDisciplina)
);

INSERT INTO curso (nomeCurso) VALUES
('ADS'),
('SI'),
('CCO');

INSERT INTO aluno (nome, email, fkCurso) VALUES
('Ana', 'ana@sptech.school', 1),
('Bruno', 'bruno@sptech.school', 1),
('Carlos', 'carlos@sptech.school', 2),
('Daniela', 'daniela@sptech.school', 3),
('Eduardo', 'eduardo@sptech.school', 1);

INSERT INTO disciplina (nomeDisciplina, cargaHoraria) VALUES
('Banco de Dados', 80),
('Algoritmos', 60),
('Redes', 40);

INSERT INTO matricula (fkAluno, fkDisciplina, nota) VALUES
(1, 1, 8.5),
(1, 2, 7.0),
(2, 1, 9.0),
(2, 2, 6.5),
(3, 1, 5.0),
(3, 3, 7.5),
(4, 1, 8.0),
(4, 2, 9.5),
(5, 3, 6.0);

-- =====================================================
-- EXERCÍCIOS
-- =====================================================

-- 1) Mostre a quantidade de alunos por curso.

-- 2) Mostre os cursos que possuem mais de 1 aluno.

-- 3) Mostre a média das notas por disciplina.

-- 4) Mostre a maior nota de cada disciplina.

-- 5) Mostre as disciplinas cuja média das notas seja maior que 7.

-- 6) Mostre os alunos que possuem nota acima da média geral.

-- 7) Mostre o aluno que possui a maior nota.

-- 8) Mostre a disciplina com maior carga horária.

-- 9) Mostre a quantidade de matrículas por disciplina.

-- 10) Mostre os alunos cuja média das notas seja maior que 7.

-- 11) Mostre a média das médias das notas dos alunos.

-- 12) Mostre a maior média entre os alunos.

-- 13) Mostre quantos alunos possuem média maior que 7.

-- 14) Mostre os cursos cuja quantidade de alunos seja maior ou igual a 2.

-- 15) Mostre os alunos cuja média seja maior que a média das médias.