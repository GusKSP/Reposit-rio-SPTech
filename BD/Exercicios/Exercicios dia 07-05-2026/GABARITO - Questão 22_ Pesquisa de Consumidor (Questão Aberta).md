# GABARITO - Questão 22: Pesquisa de Consumidor (Questão Aberta)

Este gabarito contém os comandos DDL, DML de exemplo e as 20 soluções SQL para a Questão 22.

## PARTE 1: Modelagem de Dados (DDL)

### Tarefa 1.1: Diagrama Lógico

O cenário exige modelar o relacionamento N:N entre PESQUISA e PERGUNTA, e o registro das RESPOSTAS em um contexto de SESSÃO.

*   **PESQUISA** (1) -- N:1 --> (N) **PESQUISA_PERGUNTA** (Tabela Associativa N:N)
*   **PERGUNTA** (1) -- N:1 --> (N) **PESQUISA_PERGUNTA**
*   **CONSUMIDOR** (1) -- N:1 --> (N) **SESSAO_RESPOSTA**
*   **PESQUISA** (1) -- N:1 --> (N) **SESSAO_RESPOSTA**
*   **SESSAO_RESPOSTA** (1) -- N:1 --> (N) **RESPOSTAS**
*   **PERGUNTA** (1) -- N:1 --> (N) **RESPOSTAS**

### Tarefa 1.2: Comandos DDL

```sql
-- 1. Tabela CONSUMIDORES
CREATE TABLE CONSUMIDORES (
    id_consumidor INT PRIMARY KEY AUTO_INCREMENT,
    nome_consumidor VARCHAR(150) NOT NULL,
    idade INT,
    cidade VARCHAR(100)
);

-- 2. Tabela PESQUISAS
CREATE TABLE PESQUISAS (
    id_pesquisa INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    data_criacao DATE
);

-- 3. Tabela PERGUNTAS
CREATE TABLE PERGUNTAS (
    id_pergunta INT PRIMARY KEY AUTO_INCREMENT,
    texto_pergunta TEXT NOT NULL,
    tipo_resposta VARCHAR(50) -- Ex: 'Nota', 'Multipla Escolha', 'Texto'
);

-- 4. Tabela SESSAO_RESPOSTA (Quando o consumidor respondeu a qual pesquisa)
CREATE TABLE SESSAO_RESPOSTA (
    id_sessao INT PRIMARY KEY AUTO_INCREMENT,
    id_consumidor INT NOT NULL,
    id_pesquisa INT NOT NULL,
    data_resposta DATETIME NOT NULL,
    FOREIGN KEY (id_consumidor) REFERENCES CONSUMIDORES(id_consumidor),
    FOREIGN KEY (id_pesquisa) REFERENCES PESQUISAS(id_pesquisa)
);

-- 5. Tabela RESPOSTAS (A resposta de uma pergunta específica dentro de uma sessão)
CREATE TABLE RESPOSTAS (
    id_resposta INT PRIMARY KEY AUTO_INCREMENT,
    id_sessao INT NOT NULL,
    id_pergunta INT NOT NULL,
    valor_resposta VARCHAR(255), -- Para texto ou múltipla escolha
    nota_resposta INT,           -- Para notas (1 a 5)
    FOREIGN KEY (id_sessao) REFERENCES SESSAO_RESPOSTA(id_sessao),
    FOREIGN KEY (id_pergunta) REFERENCES PERGUNTAS(id_pergunta)
);

-- 6. Tabela PESQUISA_PERGUNTA (Tabela N:N para quais perguntas estão em quais pesquisas)
CREATE TABLE PESQUISA_PERGUNTA (
    id_pesquisa INT NOT NULL,
    id_pergunta INT NOT NULL,
    PRIMARY KEY (id_pesquisa, id_pergunta),
    FOREIGN KEY (id_pesquisa) REFERENCES PESQUISAS(id_pesquisa),
    FOREIGN KEY (id_pergunta) REFERENCES PERGUNTAS(id_pergunta)
);
```

## PARTE 2: Inserção de Dados (DML)

```sql
-- Inserção de Consumidores
INSERT INTO CONSUMIDORES (nome_consumidor, idade, cidade) VALUES
('Alice Silva', 35, 'São Paulo'),    -- Consumidor 1
('Bruno Costa', 22, 'Rio de Janeiro'), -- Consumidor 2
('Carla Souza', 45, 'São Paulo'),    -- Consumidor 3
('David Lima', 28, 'Belo Horizonte'), -- Consumidor 4
('Eva Santos', 50, 'Rio de Janeiro'); -- Consumidor 5

-- Inserção de Pesquisas
INSERT INTO PESQUISAS (titulo, data_criacao) VALUES
('Satisfação do Produto X', '2024-01-10'), -- Pesquisa 1
('Pesquisa de Atendimento', '2024-05-20'); -- Pesquisa 2

-- Inserção de Perguntas
INSERT INTO PERGUNTAS (texto_pergunta, tipo_resposta) VALUES
('Qual sua nota de 1 a 5 para o produto?', 'Nota'), -- Pergunta 1
('Qual sua cidade de origem?', 'Texto'),           -- Pergunta 2
('O atendimento foi satisfatório (1 a 5)?', 'Nota'), -- Pergunta 3
('Recomendaria o produto a um amigo (Sim/Não)?', 'Multipla Escolha'), -- Pergunta 4
('Qual sua principal crítica?', 'Texto');          -- Pergunta 5

-- Relacionamento Pesquisa x Pergunta (N:N)
INSERT INTO PESQUISA_PERGUNTA (id_pesquisa, id_pergunta) VALUES
(1, 1), (1, 2), (1, 4), -- Pesquisa 1 usa P1, P2, P4
(2, 3), (2, 5), (2, 2); -- Pesquisa 2 usa P3, P5, P2

-- Inserção de Sessões de Resposta
INSERT INTO SESSAO_RESPOSTA (id_consumidor, id_pesquisa, data_resposta) VALUES
(1, 1, '2024-01-15 10:00:00'), -- Alice responde P1
(2, 1, '2024-01-15 11:00:00'), -- Bruno responde P1
(3, 2, '2024-05-25 14:30:00'), -- Carla responde P2
(4, 1, '2024-01-16 09:00:00'), -- David responde P1
(5, 2, '2024-05-26 16:00:00'); -- Eva responde P2

-- Inserção de Respostas (20 Respostas)
-- Sessão 1 (Alice - P1)
INSERT INTO RESPOSTAS (id_sessao, id_pergunta, valor_resposta, nota_resposta) VALUES
(1, 1, NULL, 5), (1, 2, 'São Paulo', NULL), (1, 4, 'Sim', NULL);
-- Sessão 2 (Bruno - P1)
INSERT INTO RESPOSTAS (id_sessao, id_pergunta, valor_resposta, nota_resposta) VALUES
(2, 1, NULL, 3), (2, 2, 'Rio de Janeiro', NULL), (2, 4, 'Não', NULL);
-- Sessão 3 (Carla - P2)
INSERT INTO RESPOSTAS (id_sessao, id_pergunta, valor_resposta, nota_resposta) VALUES
(3, 3, NULL, 4), (3, 5, 'Demora na entrega', NULL), (3, 2, 'São Paulo', NULL);
-- Sessão 4 (David - P1)
INSERT INTO RESPOSTAS (id_sessao, id_pergunta, valor_resposta, nota_resposta) VALUES
(4, 1, NULL, 4), (4, 2, 'Belo Horizonte', NULL), (4, 4, 'Sim', NULL);
-- Sessão 5 (Eva - P2)
INSERT INTO RESPOSTAS (id_sessao, id_pergunta, valor_resposta, nota_resposta) VALUES
(5, 3, NULL, 5), (5, 5, 'Produto excelente', NULL), (5, 2, 'Rio de Janeiro', NULL);
-- Respostas extras para totalizar 20
INSERT INTO RESPOSTAS (id_sessao, id_pergunta, valor_resposta, nota_resposta) VALUES
(1, 3, NULL, 5), (2, 3, NULL, 4), (3, 1, NULL, 3), (4, 3, NULL, 5), (5, 1, NULL, 4);
```

## PARTE 3: Consultas e Manipulação de Dados

#### **Consultas (SELECT) - JOINs e Filtros**

1.  **Liste o nome de todos os consumidores e o título da pesquisa que eles responderam.**
    ```sql
    SELECT
        C.nome_consumidor,
        P.titulo
    FROM
        CONSUMIDORES C
    JOIN
        SESSAO_RESPOSTA SR ON C.id_consumidor = SR.id_consumidor
    JOIN
        PESQUISAS P ON SR.id_pesquisa = P.id_pesquisa;
    ```

2.  **Liste o título das pesquisas que contêm a palavra "Satisfação" no título.**
    ```sql
    SELECT
        titulo
    FROM
        PESQUISAS
    WHERE
        titulo LIKE '%Satisfação%';
    ```

3.  **Liste o nome dos consumidores que responderam a pesquisas criadas antes de 2024.**
    ```sql
    SELECT DISTINCT
        C.nome_consumidor
    FROM
        CONSUMIDORES C
    JOIN
        SESSAO_RESPOSTA SR ON C.id_consumidor = SR.id_consumidor
    JOIN
        PESQUISAS P ON SR.id_pesquisa = P.id_pesquisa
    WHERE
        YEAR(P.data_criacao) < 2024;
    ```

4.  **Liste o texto de todas as perguntas e o título da pesquisa em que elas foram utilizadas.**
    ```sql
    SELECT
        Q.texto_pergunta,
        P.titulo
    FROM
        PERGUNTAS Q
    JOIN
        PESQUISA_PERGUNTA PP ON Q.id_pergunta = PP.id_pergunta
    JOIN
        PESQUISAS P ON PP.id_pesquisa = P.id_pesquisa;
    ```

5.  **Liste o nome dos consumidores que não responderam a nenhuma pesquisa (use `LEFT JOIN` e `WHERE IS NULL`).**
    ```sql
    SELECT
        C.nome_consumidor
    FROM
        CONSUMIDORES C
    LEFT JOIN
        SESSAO_RESPOSTA SR ON C.id_consumidor = SR.id_consumidor
    WHERE
        SR.id_sessao IS NULL;
    ```

#### **Consultas (SELECT) - Agregação e Funções**

6.  **Calcule a idade média dos consumidores, arredondada para zero casas decimais.**
    ```sql
    SELECT
        ROUND(AVG(idade), 0) AS idade_media
    FROM
        CONSUMIDORES;
    ```

7.  **Calcule a nota média de todas as respostas (assuma que as respostas são notas de 1 a 5).**
    ```sql
    SELECT
        AVG(nota_resposta) AS nota_media_geral
    FROM
        RESPOSTAS
    WHERE
        nota_resposta IS NOT NULL;
    ```

8.  **Liste a cidade e a quantidade de consumidores que responderam a pesquisas em cada cidade.**
    ```sql
    SELECT
        C.cidade,
        COUNT(DISTINCT C.id_consumidor) AS total_consumidores
    FROM
        CONSUMIDORES C
    JOIN
        SESSAO_RESPOSTA SR ON C.id_consumidor = SR.id_consumidor
    GROUP BY
        C.cidade;
    ```

9.  **Liste o título da pesquisa e a quantidade total de respostas que ela recebeu.**
    ```sql
    SELECT
        P.titulo,
        COUNT(R.id_resposta) AS total_respostas
    FROM
        PESQUISAS P
    JOIN
        SESSAO_RESPOSTA SR ON P.id_pesquisa = SR.id_pesquisa
    JOIN
        RESPOSTAS R ON SR.id_sessao = R.id_sessao
    GROUP BY
        P.titulo;
    ```

10. **Calcule a nota máxima e a nota mínima dadas para a pergunta de ID = 1.**
    ```sql
    SELECT
        MAX(nota_resposta) AS nota_maxima,
        MIN(nota_resposta) AS nota_minima
    FROM
        RESPOSTAS
    WHERE
        id_pergunta = 1;
    ```

#### **Consultas (SELECT) - GROUP BY e HAVING**

11. **Liste o título da pesquisa que teve uma nota média de resposta inferior a 3.0.**
    ```sql
    SELECT
        P.titulo
    FROM
        PESQUISAS P
    JOIN
        SESSAO_RESPOSTA SR ON P.id_pesquisa = SR.id_pesquisa
    JOIN
        RESPOSTAS R ON SR.id_sessao = R.id_sessao
    WHERE
        R.nota_resposta IS NOT NULL
    GROUP BY
        P.titulo
    HAVING
        AVG(R.nota_resposta) < 3.0;
    ```

12. **Liste o nome do consumidor que respondeu a mais de uma pesquisa.**
    ```sql
    SELECT
        C.nome_consumidor
    FROM
        CONSUMIDORES C
    JOIN
        SESSAO_RESPOSTA SR ON C.id_consumidor = SR.id_consumidor
    GROUP BY
        C.nome_consumidor
    HAVING
        COUNT(SR.id_pesquisa) > 1;
    ```

13. **Liste as cidades que têm mais de 2 consumidores registrados.**
    ```sql
    SELECT
        cidade
    FROM
        CONSUMIDORES
    GROUP BY
        cidade
    HAVING
        COUNT(id_consumidor) > 2;
    ```

#### **Manipulação de Dados (UPDATE e DELETE)**

14. **UPDATE: Altere a cidade de todos os consumidores com idade superior a 40 anos para 'São Paulo'.**
    ```sql
    UPDATE CONSUMIDORES
    SET cidade = 'São Paulo'
    WHERE idade > 40;
    ```

15. **UPDATE: Altere o texto da pergunta de ID = 2 para 'Qual sua opinião sobre o atendimento?'.**
    ```sql
    UPDATE PERGUNTAS
    SET texto_pergunta = 'Qual sua opinião sobre o atendimento?'
    WHERE id_pergunta = 2;
    ```

16. **DELETE: Exclua todas as respostas dadas por consumidores da cidade de 'Rio de Janeiro'.**
    ```sql
    DELETE FROM RESPOSTAS
    WHERE id_sessao IN (
        SELECT SR.id_sessao
        FROM SESSAO_RESPOSTA SR
        JOIN CONSUMIDORES C ON SR.id_consumidor = C.id_consumidor
        WHERE C.cidade = 'Rio de Janeiro'
    );
    ```

17. **DELETE: Exclua a pesquisa que teve o menor número de respostas (use subquery).**
    ```sql
    DELETE FROM PESQUISAS
    WHERE id_pesquisa = (
        SELECT id_pesquisa FROM (
            SELECT
                P.id_pesquisa
            FROM
                PESQUISAS P
            JOIN
                SESSAO_RESPOSTA SR ON P.id_pesquisa = SR.id_pesquisa
            JOIN
                RESPOSTAS R ON SR.id_sessao = R.id_sessao
            GROUP BY
                P.id_pesquisa
            ORDER BY
                COUNT(R.id_resposta) ASC
            LIMIT 1
        ) AS PesquisaMenosRespondida
    );
    ```

#### **Consultas Avançadas (Subquery e VIEW)**

18. **Subquery no WHERE: Liste o nome dos consumidores cuja idade é superior à idade média de todos os consumidores.**
    ```sql
    SELECT
        nome_consumidor
    FROM
        CONSUMIDORES
    WHERE
        idade > (SELECT AVG(idade) FROM CONSUMIDORES);
    ```

19. **Tabela Derivada (Subquery no FROM): Liste o título da pesquisa e a diferença entre a nota média da pesquisa e a nota média geral de todas as pesquisas.**
    ```sql
    SELECT
        P.titulo,
        AVG(R.nota_resposta) - MediaGeral.media_total AS diferenca_media
    FROM
        PESQUISAS P
    JOIN
        SESSAO_RESPOSTA SR ON P.id_pesquisa = SR.id_pesquisa
    JOIN
        RESPOSTAS R ON SR.id_sessao = R.id_sessao
    JOIN
        (SELECT AVG(nota_resposta) AS media_total FROM RESPOSTAS WHERE nota_resposta IS NOT NULL) AS MediaGeral
    WHERE
        R.nota_resposta IS NOT NULL
    GROUP BY
        P.titulo, MediaGeral.media_total;
    ```

20. **VIEW: Crie uma `VIEW` chamada `V_ANALISE_RESPOSTAS` que liste o título da pesquisa, o texto da pergunta e a nota média obtida para aquela pergunta naquela pesquisa.**
    ```sql
    CREATE VIEW V_ANALISE_RESPOSTAS AS
    SELECT
        P.titulo AS titulo_pesquisa,
        Q.texto_pergunta,
        AVG(R.nota_resposta) AS nota_media
    FROM
        PESQUISAS P
    JOIN
        SESSAO_RESPOSTA SR ON P.id_pesquisa = SR.id_pesquisa
    JOIN
        RESPOSTAS R ON SR.id_sessao = R.id_sessao
    JOIN
        PERGUNTAS Q ON R.id_pergunta = Q.id_pergunta
    WHERE
        R.nota_resposta IS NOT NULL
    GROUP BY
        P.titulo, Q.texto_pergunta;
    ```
