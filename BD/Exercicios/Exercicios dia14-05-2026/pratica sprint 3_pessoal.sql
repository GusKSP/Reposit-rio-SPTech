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

SELECT COUNT(a.idAluno) AS Qtd_aluno, 
c.nomeCurso 
FROM aluno a 
JOIN curso c ON a.fkCurso = c.idCurso GROUP BY a.fkCurso;

-- 2) Mostre os cursos que possuem mais de 1 aluno.

SELECT COUNT(a.idAluno) AS Qtd_aluno, 
c.nomeCurso 
FROM aluno a 
JOIN curso c ON a.fkCurso = c.idCurso 
GROUP BY a.fkCurso
Having Qtd_aluno > 1;

-- 3) Mostre a média das notas por disciplina.

SELECT ROUND(AVG(m.nota),2) AS Media_Notas, d.nomeDisciplina
FROM matricula m
JOIN disciplina d ON d.idDisciplina = m.fkDisciplina
GROUP BY d.nomeDisciplina;

-- 4) Mostre a maior nota de cada disciplina.

SELECT MAX(m.nota) AS Nota_max, d.nomeDisciplina
FROM matricula m
JOIN disciplina d ON d.idDisciplina = m.fkDisciplina
GROUP BY d.nomeDisciplina;

-- 5) Mostre as disciplinas cuja média das notas seja maior que 7.

SELECT ROUND(AVG(m.nota),2) AS Media_Notas, d.nomeDisciplina
FROM matricula m
JOIN disciplina d ON d.idDisciplina = m.fkDisciplina
GROUP BY d.nomeDisciplina
HAVING Media_Notas > 7;

-- 6) Mostre os alunos que possuem nota acima da média geral.

SELECT nome FROM aluno WHERE idAluno IN (
	SELECT fkAluno FROM matricula WHERE nota > (
		SELECT AVG(nota) FROM matricula)
	)
;

-- 7) Mostre o aluno que possui a maior nota.

SELECT nome FROM aluno WHERE idAluno = (
	SELECT fkAluno FROM matricula ORDER BY nota DESC LIMIT 1);


-- 8) Mostre a disciplina com maior carga horária.

SELECT nomeDisciplina FROM disciplina ORDER BY cargaHoraria DESC LIMIT 1;

-- 9) Mostre a quantidade de matrículas por disciplina.

SELECT COUNT(idMatricula) AS qtd_Matriculas, nomeDisciplina 
FROM matricula 
JOIN disciplina ON fkDisciplina = idDisciplina
GROUP BY idDisciplina;


-- 10) Mostre os alunos cuja média das notas seja maior que 7.
DESC aluno;

SELECT a.nome, AVG(m.nota) AS media_notas FROM matricula m
Join aluno a ON m.fkAluno = a.idAluno
GROUP BY m.fkAluno
HAVING media_notas > 7;

-- 11) Mostre a média das médias das notas dos alunos.

SELECT ROUND(AVG(media_alunos),2) AS media_das_medias FROM (
SELECT AVG(nota) AS media_alunos FROM matricula group by fkAluno) AS tabela_media;

-- 12) Mostre a maior média entre os alunos.

SELECT ROUND(MAX(media_alunos),2) AS media_max FROM (
SELECT AVG(nota) AS media_alunos FROM matricula group by fkAluno) AS tabela_media;

-- 13) Mostre quantos alunos possuem média maior que 7.


SELECT COUNT(media_alunos) AS Qtd_notas_maior_7 FROM (
SELECT AVG(nota) AS media_alunos FROM matricula group by fkAluno) AS tabela_media
WHERE media_alunos > 7;

-- 14) Mostre os cursos cuja quantidade de alunos seja maior ou igual a 2.

SELECT nomeCurso FROM curso
WHERE idCurso IN (
	SELECT fkCurso FROM aluno GROUP BY fkCurso HAVING Count(idAluno) >= 2
	)
;
-- 15) Mostre os alunos cuja média seja maior que a média das médias.

SELECT nome FROM aluno WHERE idAluno IN (
	SELECT fkAluno FROM matricula GROUP BY fkAluno HAVING AVG(nota) > (
		SELECT ROUND(AVG(media_alunos),2) AS media_das_medias FROM (
		SELECT AVG(nota) AS media_alunos FROM matricula group by fkAluno) AS tabela_media)
	)
;
		