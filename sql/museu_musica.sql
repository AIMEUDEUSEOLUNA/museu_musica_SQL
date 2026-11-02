
-- PROJETO INTEGRADOR II - FATEC ITU
-- MUSEU DE MUSICA
-- Preservacao e digitalizacao do acervo musical
-- Script de criacao do banco de dados

CREATE DATABASE IF NOT EXISTS museu_musica
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE museu_musica;

-- 1. REMOCAO DAS TABELAS (para recriacao do zero)
--  apaga os dados existentes!

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS COLECAO_ITEM;
DROP TABLE IF EXISTS MIDIA;
DROP TABLE IF EXISTS PARTITURA;
DROP TABLE IF EXISTS INSTRUMENTO;
DROP TABLE IF EXISTS DOCUMENTO;
DROP TABLE IF EXISTS ITEM_ACERVO;
DROP TABLE IF EXISTS COLECAO;
DROP TABLE IF EXISTS MUSICA;
DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS CATEGORIA;

SET FOREIGN_KEY_CHECKS = 1;

-- 2. TABELA CATEGORIA

CREATE TABLE CATEGORIA (
    id_categoria INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),

    PRIMARY KEY (id_categoria),
    UNIQUE (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. TABELA USUARIO

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    senha VARCHAR(255) NOT NULL,

    PRIMARY KEY (id_usuario),
    UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. TABELA MUSICA

CREATE TABLE MUSICA (
    id_musica INT AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    compositor VARCHAR(150),
    ano_composicao INT,
    descricao TEXT,

    PRIMARY KEY (id_musica)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. TABELA ITEM_ACERVO

CREATE TABLE ITEM_ACERVO (
    id_item INT AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    origem VARCHAR(150),
    data_aquisicao DATE,
    estado_conservacao VARCHAR(50),
    `status` VARCHAR(30) NOT NULL DEFAULT 'Cadastrado',
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario_cadastro INT NOT NULL,

    PRIMARY KEY (id_item),

    CONSTRAINT fk_item_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES CATEGORIA(id_categoria),

    CONSTRAINT fk_item_usuario
        FOREIGN KEY (id_usuario_cadastro)
        REFERENCES USUARIO(id_usuario),

    CONSTRAINT chk_item_status
        CHECK (`status` IN (
            'Cadastrado',
            'Em conservacao',
            'Em digitalizacao',
            'Digitalizado',
            'Indisponivel'
        ))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. TABELA DOCUMENTO

CREATE TABLE DOCUMENTO (
    id_item INT,
    tipo_documento VARCHAR(100) NOT NULL,
    autor VARCHAR(150),
    data_documento DATE,

    PRIMARY KEY (id_item),

    CONSTRAINT fk_documento_item
        FOREIGN KEY (id_item)
        REFERENCES ITEM_ACERVO(id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. TABELA INSTRUMENTO

CREATE TABLE INSTRUMENTO (
    id_item INT,
    tipo_instrumento VARCHAR(100) NOT NULL,
    fabricante VARCHAR(150),
    ano_fabricacao INT,
    antigo_dono VARCHAR(150),

    PRIMARY KEY (id_item),

    CONSTRAINT fk_instrumento_item
        FOREIGN KEY (id_item)
        REFERENCES ITEM_ACERVO(id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. TABELA PARTITURA

CREATE TABLE PARTITURA (
    id_item INT,
    id_musica INT NOT NULL,
    autor VARCHAR(150),
    ano_criacao INT,
    arquivo_url VARCHAR(500),

    PRIMARY KEY (id_item),

    CONSTRAINT fk_partitura_item
        FOREIGN KEY (id_item)
        REFERENCES ITEM_ACERVO(id_item),

    CONSTRAINT fk_partitura_musica
        FOREIGN KEY (id_musica)
        REFERENCES MUSICA(id_musica)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. TABELA MIDIA

CREATE TABLE MIDIA (
    id_midia INT AUTO_INCREMENT,
    id_item INT NOT NULL,
    tipo_midia VARCHAR(50) NOT NULL,
    arquivo_url VARCHAR(500) NOT NULL,
    descricao VARCHAR(255),

    PRIMARY KEY (id_midia),

    CONSTRAINT fk_midia_item
        FOREIGN KEY (id_item)
        REFERENCES ITEM_ACERVO(id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 10. TABELA COLECAO


CREATE TABLE COLECAO (
    id_colecao INT AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,

    PRIMARY KEY (id_colecao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 11. TABELA COLECAO_ITEM


CREATE TABLE COLECAO_ITEM (
    id_colecao INT,
    id_item INT,

    PRIMARY KEY (id_colecao, id_item),

    CONSTRAINT fk_colecao_item_colecao
        FOREIGN KEY (id_colecao)
        REFERENCES COLECAO(id_colecao),

    CONSTRAINT fk_colecao_item_acervo
        FOREIGN KEY (id_item)
        REFERENCES ITEM_ACERVO(id_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 12. INSERCAO DE DADOS DE TESTE


-- Categorias

INSERT INTO CATEGORIA (nome, descricao) VALUES
('Instrumentos', 'Instrumentos musicais historicos'),
('Documentos', 'Documentos historicos do museu'),
('Partituras', 'Partituras e composicoes musicais'),
('Fotografias', 'Fotografias relacionadas a musica');

-- Usuario ficticio para testes.
-- Em producao, a senha deve ser armazenada com hash.

INSERT INTO USUARIO (nome, email, senha) VALUES
('Administrador do Museu',
 'admin@museudemusica.com',
 'HASH_DE_TESTE_NAO_UTILIZAR');

-- Musicas

INSERT INTO MUSICA
(titulo, compositor, ano_composicao, descricao)
VALUES
('Sonata Historica', 'Compositor Ficticio', 1920,
 'Composicao utilizada para teste do acervo'),
('Melodia Brasileira', 'Compositora Ficticia', 1945,
 'Composicao brasileira utilizada para teste');

-- Itens do acervo

INSERT INTO ITEM_ACERVO
(id_categoria, titulo, descricao, origem, data_aquisicao,
 estado_conservacao, `status`, id_usuario_cadastro)
VALUES
(1, 'Violao Antigo',
 'Violao historico pertencente ao acervo do museu',
 'Doacao particular', '2020-05-10',
 'Bom', 'Digitalizado', 1),

(3, 'Partitura Historica',
 'Partitura de uma composicao musical antiga',
 'Arquivo musical', '2021-08-15',
 'Bom', 'Em digitalizacao', 1),

(2, 'Carta de Compositor',
 'Carta historica relacionada a musica brasileira',
 'Doacao familiar', '2019-03-20',
 'Regular', 'Cadastrado', 1);

-- Instrumento

INSERT INTO INSTRUMENTO
(id_item, tipo_instrumento, fabricante, ano_fabricacao, antigo_dono)
VALUES
(1, 'Violao de cordas',
 'Fabricante Ficticio', 1950, 'Colecionador particular');

-- Partitura

INSERT INTO PARTITURA
(id_item, id_musica, autor, ano_criacao, arquivo_url)
VALUES
(2, 1, 'Compositor Ficticio', 1920,
 'https://exemplo.com/partitura-sonata.pdf');

-- Documento

INSERT INTO DOCUMENTO
(id_item, tipo_documento, autor, data_documento)
VALUES
(3, 'Carta historica',
 'Compositor Brasileiro Ficticio', '1940-06-15');

-- Midias digitais

INSERT INTO MIDIA
(id_item, tipo_midia, arquivo_url, descricao)
VALUES
(1, 'Imagem', 'https://exemplo.com/violao.jpg',
 'Fotografia digitalizada do violao'),

(2, 'PDF', 'https://exemplo.com/partitura.pdf',
 'Arquivo digital da partitura'),

(3, 'Imagem', 'https://exemplo.com/carta.jpg',
 'Imagem digitalizada da carta historica');

-- Colecoes

INSERT INTO COLECAO (titulo, descricao)
VALUES
('Instrumentos Historicos',
 'Colecao de instrumentos musicais antigos'),

('Memoria Musical Brasileira',
 'Colecao de documentos e partituras historicas');

-- Relacionamento entre colecoes e itens

INSERT INTO COLECAO_ITEM (id_colecao, id_item)
VALUES
(1, 1),
(2, 2),
(2, 3);


-- 13 CONSULTAS PARA CONFERENCIA


SELECT * FROM CATEGORIA;
SELECT * FROM USUARIO;
SELECT * FROM MUSICA;
SELECT * FROM ITEM_ACERVO;
SELECT * FROM DOCUMENTO;
SELECT * FROM INSTRUMENTO;
SELECT * FROM PARTITURA;
SELECT * FROM MIDIA;
SELECT * FROM COLECAO;
SELECT * FROM COLECAO_ITEM;
