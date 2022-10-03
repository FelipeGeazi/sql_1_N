-- 1 : N Criação das Tabelas
CREATE TABLE IF NOT EXISTS usuario (
 id BIGSERIAL PRIMARY KEY,
 nome VARCHAR(128) NOT NULL,
 idade INTEGER NOT NULL,
);

CREATE TABLE IF NOT EXISTS smartphone (
 id BIGSERIAL PRIMARY KEY,
 modelo VARCHAR(64) NOT NULL,
 numero VARCHAR(64) NULL,
 usuario_id INTEGER,
 FOREIGN KEY (usuario_id) REFERENCES usuario (id)
);

-- 1 : N Inserção dos Dados
INSERT INTO
 ususario (nome, idade)
VALUES
 ('Pedro', 26),
 ('João', 23),
 ('Gabriela', 22),
 ('Márcia', 30);

INSERT INTO
 smartphone (modelo, numero, usuario_id)
VALUES
 ('Iphone 13', '', 3),
 ('Galaxy S21', '81234567', 3),
 ('Iphone 6', '81234578', 3),
 ('Edge 20', null, 1),
 ('Pixel 4', '91234567', 2),
 ('Galaxy S22 Ultra', '91238929', 4),
 ('Motorola V3', '95623482', null);

-- 1 : N Selects
SELECT
 *
FROM
 smartphone s
WHERE
 s.usuario_id = 3;

SELECT
 *
FROM
 smartphone s
WHERE
 s.usuario_id IS NULL;

SELECT
 s.modelo
FROM
 smartphone s
WHERE
 s.numero LIKE '%9';

-- JOINS: Criação das Tabelas
CREATE TABLE IF NOT EXISTS endereco(
 id BIGSERIAL PRIMARY KEY,
 pais VARCHAR(100) NOT NULL,
 estado VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS pessoa(
 id BIGSERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 idade INTEGER NOT NULL,
 endereco_id INTEGER UNIQUE,
 CONSTRAINT fk_enderecos FOREIGN KEY (endereco_id) REFERENCES endereco(id)
);

-- JOINS: Inserção de Dados
INSERT INTO
 endereco (pais, estado)
VALUES
 ('Brasil', 'SP'),
 ('Brasil', 'PR'),
 ('Brasil', 'RJ'),
 ('Brasil', 'MG');

INSERT INTO
 pessoa (nome, idade, endereco_id)
VALUES
 ('Mario', 27, 1),
 ('Joana', 22, 2),
 ('Zé', 29, 3),
 ('Ana', 28, null);

-- JOIN: Sintaxe Geral
SELECT
 tabela_N.nome_da_coluna,
...
FROM
 tabela_1 TIPO_DE_JOIN
 JOIN tabela_2 ON condição_do_join;

-- JOIN: Sintaxe Geral (Parte 1)
SELECT
 nome_da_tabelaN.nome_da_coluna,
...-- JOIN: Sintaxe Geral (Parte1: Exemplo)
...
FROM
 tabela_1 TIPO_DE_JOIN
 JOIN tabela_2 ON condição_do_join -- JOIN: Sintaxe Geral (Parte 2)
...
FROM
 tabela_1 TIPO_DE_JOIN
 JOIN tabela_2 ON condição_do_join -- JOIN: Sintaxe Geral (Parte 2: Exemplo)
FROM
 pessoa
 JOIN endereco ON pessoa.endereco_id = endereco.id;

-- TIPOS DE JOIN
-- INNER JOIN (JOIN PADRÃO)
SELECT
 pessoa.nome,
 pessoa.idade,
 endereco.pais,
 endereco.estado
FROM
 pessoa
 JOIN endereco ON endereco.id = pessoa.endereco_id;

-- LEFT JOIN (COM ALIASING)
SELECT
 p.nome,
 p.idade,
 e.pais,
 e.estado
FROM
 pessoa AS p
 LEFT JOIN endereco AS e ON e.id = p.endereco_id;

-- RIGHT JOIN (COM ALIASING SHORT)
SELECT
 p.nome,
 p.idade,
 e.pais,
 e.estado
FROM
 pessoa p
 RIGHT JOIN endereco e ON p.endereco_id = e.id;

-- FULL OUTER JOIN
SELECT
 p.nome,
 p.idade,
 e.pais,
 e.estado
FROM
 pessoa p FULL
 OUTER JOIN endereco e ON p.endereco_id = e.id;

-- MULTIPLE JOIN
-- MULTIPLE JOIN: Criação da tabela PET
CREATE TABLE IF NOT EXISTS pet (
 id BIGSERIAL PRIMARY KEY,
 nome VARCHAR(128) NOT NULL,
 especie VARCHAR(64) NOT NULL,
 raca VARCHAR(128) NOT NULL,
 dono_id INTEGER,
 FOREIGN KEY (dono_id) REFERENCES pessoa (id)
);

-- MULTIPLE JOIN: Inserção de dados
INSERT INTO
 pet (nome, especie, raca, dono_id)
VALUES
 ('Bob', 'Cachorro', 'Poodle', 1),
 ('Nyx', 'Gato', 'Persa', 2),
 ('Luna', 'Gato', 'Siamês', 3),
 ('Luigi', 'Cachorro', 'Desconhecida', 1),
 ('Mel', 'Gato', 'Sphynx', 4),
 ('Kiara', 'Gato', 'Angorá', 2);

-- MULTIPLE JOIN: Select
SELECT
 pessoa.nome,
 endereco.estado,
 endereco.pais,
 pet.nome,
 pet.raca
FROM
 pessoa
 INNER JOIN endereco ON pessoa.endereco_id = endereco.id
 INNER JOIN pet ON pet.dono_id = pessoa.id;