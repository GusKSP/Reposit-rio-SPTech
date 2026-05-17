# GABARITO - Questão 21: Sistema de Academia (Questão Aberta)

Este gabarito contém os comandos DDL, DML de exemplo e as 20 soluções SQL para a Questão 21.

## PARTE 1: Modelagem de Dados (DDL)

### Tarefa 1.1: Diagrama Lógico

O diagrama lógico envolve as seguintes tabelas e relacionamentos:

*   **PLANOS** (1) -- N:1 --> (N) **MATRICULAS**
*   **FORMAS_PAGAMENTO** (1) -- N:1 --> (N) **PAGAMENTOS**
*   **ALUNOS** (1) -- N:1 --> (N) **MATRICULAS**
*   **MATRICULAS** (1) -- N:1 --> (N) **PAGAMENTOS**

### Tarefa 1.2: Comandos DDL

```sql
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
```

## PARTE 2: Inserção de Dados (DML)

```sql
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
(1, 2, 960.00, '2024-01-15', 'Pago'),    -- João    (Anual - Pix)
(2, 1, 100.00, '2024-02-01', 'Pago'),    -- Maria (Mensal - Cartão)
(3, 1, 100.00, '2024-03-01', 'Pago'),    -- Maria (Mensal - Cartão)
(4, 3, 270.00, '2024-03-10', 'Pago'),    -- Pedro (Trimestral - Dinheiro)
(4, 3, 50.00, '2024-04-10', 'Atrasado'), -- Pedro (Pagamento parcial/atrasado - Dinheiro)
(5, 2, 100.00, '2024-04-05', 'Pago'),    -- Ana (Mensal - Pix)
(6, 1, 480.00, '2024-05-20', 'Pago'),    -- Carlos (Anual - 1ª Parcela - Cartão)
(6, 1, 480.00, '2024-06-20', 'Pago'),    -- Carlos (Anual - 2ª Parcela - Cartão)
(1, 3, 10.00, '2024-06-01', 'Pago'),     -- João (Compra de água - Dinheiro)
(3, 2, 10.00, '2024-06-05', 'Pago');     -- Maria (Compra de água - Pix)
```

## PARTE 3: Consultas e Manipulação de Dados

#### **Consultas (SELECT) - JOINs e Filtros**

1.  **Liste o nome de todos os alunos e o título do plano que eles possuem.**
    ```sql
    SELECT
        A.nome_aluno,
        P.titulo
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PLANOS P ON M.id_plano = P.id_plano;
    ```

2.  **Liste o nome dos alunos que se matricularam no plano 'Anual' e que ainda estão ativos (assuma que a data de vencimento do plano é 365 dias após a data de matrícula).**
    ```sql
    SELECT
        A.nome_aluno
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PLANOS P ON M.id_plano = P.id_plano
    WHERE
        P.titulo = 'Anual' AND M.data_vencimento >= CURDATE();
    ```

3.  **Liste o nome de todos os alunos e o valor total que cada um já pagou à academia.**
    ```sql
    SELECT
        A.nome_aluno,
        SUM(PG.valor_pago) AS valor_total_pago
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        A.nome_aluno;
    ```

4.  **Liste o nome dos alunos que utilizaram a forma de pagamento 'Cartão' em pelo menos um pagamento.**
    ```sql
    SELECT DISTINCT
        A.nome_aluno
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    JOIN
        FORMAS_PAGAMENTO FP ON PG.id_forma = FP.id_forma
    WHERE
        FP.nome_forma = 'Cartão';
    ```

5.  **Liste o nome dos alunos que nunca fizeram um pagamento (use `LEFT JOIN` e `WHERE IS NULL`).**
    ```sql
    SELECT
        A.nome_aluno
    FROM
        ALUNOS A
    LEFT JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    LEFT JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    WHERE
        PG.id_pagamento IS NULL;
    ```

#### **Consultas (SELECT) - Agregação e Funções**

6.  **Calcule o valor médio dos planos da academia, arredondado para duas casas decimais.**
    ```sql
    SELECT
        ROUND(AVG(preco), 2) AS valor_medio_planos
    FROM
        PLANOS;
    ```

7.  **Calcule o valor total arrecadado por cada Forma de Pagamento.**
    ```sql
    SELECT
        FP.nome_forma,
        SUM(PG.valor_pago) AS total_arrecadado
    FROM
        FORMAS_PAGAMENTO FP
    JOIN
        PAGAMENTOS PG ON FP.id_forma = PG.id_forma
    GROUP BY
        FP.nome_forma;
    ```

8.  **Liste o título do plano e a quantidade de alunos que o possuem.**
    ```sql
    SELECT
        P.titulo,
        COUNT(M.id_aluno) AS quantidade_alunos
    FROM
        PLANOS P
    JOIN
        MATRICULAS M ON P.id_plano = M.id_plano
    GROUP BY
        P.titulo;
    ```

9.  **Liste o mês e o ano (Ex: '2024-05') em que a academia teve a maior arrecadação total.**
    ```sql
    SELECT
        DATE_FORMAT(data_pagamento, '%Y-%m') AS mes_ano,
        SUM(valor_pago) AS arrecadacao_mensal
    FROM
        PAGAMENTOS
    GROUP BY
        mes_ano
    ORDER BY
        arrecadacao_mensal DESC
    LIMIT 1;
    ```

10. **Calcule a idade média dos alunos da academia (use `AVG` e uma função de data/tempo).**
    ```sql
    SELECT
        AVG(TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())) AS idade_media
    FROM
        ALUNOS;
    ```

#### **Consultas (SELECT) - GROUP BY e HAVING**

11. **Liste os títulos dos planos que geraram uma arrecadação total superior a R$ 5.000,00.**
    ```sql
    SELECT
        P.titulo
    FROM
        PLANOS P
    JOIN
        MATRICULAS M ON P.id_plano = M.id_plano
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        P.titulo
    HAVING
        SUM(PG.valor_pago) > 5000.00;
    ```

12. **Liste os nomes dos alunos que possuem mais de uma matrícula registrada (assuma que o aluno pode ter renovado o plano).**
    ```sql
    SELECT
        A.nome_aluno
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    GROUP BY
        A.nome_aluno
    HAVING
        COUNT(M.id_matricula) > 1;
    ```

13. **Liste as Formas de Pagamento que foram utilizadas em menos de 3 pagamentos.**
    ```sql
    SELECT
        FP.nome_forma
    FROM
        FORMAS_PAGAMENTO FP
    JOIN
        PAGAMENTOS PG ON FP.id_forma = PG.id_forma
    GROUP BY
        FP.nome_forma
    HAVING
        COUNT(PG.id_pagamento) < 3;
    ```

#### **Manipulação de Dados (UPDATE e DELETE)**

14. **UPDATE: Atualize o preço do plano 'Mensal' em 10% (use função matemática).**
        ```sql
        UPDATE PLANOS
        SET preco = preco * 1.10
        WHERE titulo = 'Mensal';
    ```

15. **UPDATE: Altere a forma de pagamento de todos os pagamentos feitos no mês passado para 'Pix' (use função de data).**
    ```sql
    UPDATE PAGAMENTOS
    SET id_forma = (SELECT id_forma FROM FORMAS_PAGAMENTO WHERE nome_forma = 'Pix')
    WHERE data_pagamento >= DATE_SUB(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 2 MONTH)), INTERVAL DAY(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 2 MONTH))) - 1 DAY)
      AND data_pagamento <= LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));
    ```

16. **DELETE: Exclua todos os pagamentos que foram feitos com a forma de pagamento 'Dinheiro'.**
    ```sql
    DELETE FROM PAGAMENTOS
    WHERE id_forma = (SELECT id_forma FROM FORMAS_PAGAMENTO WHERE nome_forma = 'Dinheiro');
    ```

17. **DELETE: Exclua o aluno com o menor valor total pago à academia (use subquery).**
    ```sql
    DELETE FROM ALUNOS
    WHERE id_aluno = (
        SELECT id_aluno FROM (
            SELECT
                A.id_aluno
            FROM
                ALUNOS A
            JOIN
                MATRICULAS M ON A.id_aluno = M.id_aluno
            JOIN
                PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
            GROUP BY
                A.id_aluno
            ORDER BY
                SUM(PG.valor_pago) ASC
            LIMIT 1
        ) AS AlunoMenosPago
    );  
    ```

#### **Consultas Avançadas (Subquery e VIEW)**

18. **Subquery no WHERE: Liste o nome dos alunos cujo valor total pago é superior ao valor médio total pago por todos os alunos.**
    ```sql
    SELECT
        A.nome_aluno
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        A.nome_aluno
    HAVING
        SUM(PG.valor_pago) > (
            SELECT AVG(TotalPago)
            FROM (
                SELECT SUM(valor_pago) AS   
                FROM PAGAMENTOS
                GROUP BY id_matricula
            ) AS MediaGeral
        );
    ```

19. **Tabela Derivada (Subquery no FROM): Liste o nome do aluno e a diferença entre o valor do seu plano e o valor médio de todos os planos.**
    ```sql
    SELECT
        A.nome_aluno,
        P.preco - MediaPlanos.media_geral AS diferenca_plano_media
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PLANOS P ON M.id_plano = P.id_plano
    JOIN
        (SELECT AVG(preco) AS media_geral FROM PLANOS) AS MediaPlanos;
    ```

20. **VIEW: Crie uma `VIEW` chamada `V_RELATORIO_FINANCEIRO` que liste o nome do aluno, o título do plano, o valor do plano e o valor total pago pelo aluno até o momento.**
    ```sql
    CREATE VIEW V_RELATORIO_FINANCEIRO AS
    SELECT
        A.nome_aluno,
        P.titulo AS titulo_plano,
        P.preco AS valor_plano,
        COALESCE(SUM(PG.valor_pago), 0) AS total_pago
    FROM
        ALUNOS A
    JOIN
        MATRICULAS M ON A.id_aluno = M.id_aluno
    JOIN
        PLANOS P ON M.id_plano = P.id_plano
    LEFT JOIN
        PAGAMENTOS PG ON M.id_matricula = PG.id_matricula
    GROUP BY
        A.nome_aluno, P.titulo, P.preco;
    ```
