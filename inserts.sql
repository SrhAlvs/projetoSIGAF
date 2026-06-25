USE sigaf;

-- =============================================================================
-- 1. INSERTS (POPULANDO O BANCO)
-- =============================================================================

-- 1.1 CURSOS (3 Cursos, um de cada modalidade)
INSERT INTO curso (nome, modalidade, duracao)
VALUES ('Técnico em Informática', 'TÉCNICO', 4),
       ('Bacharelado em Engenharia de Software', 'BACHAREL', 8),
       ('Licenciatura em Matemática', 'LICENCIATURA', 6);

-- 1.2 DISCIPLINAS (12 disciplinas - Mínimo pedido: 10)
INSERT INTO disciplina (id_curso, nome, departamento, pre_requisito)
VALUES (1, 'Algoritmos e Lógica', 'TECNOLOGIAS', NULL),                  -- ID 1
       (1, 'Banco de Dados I', 'TECNOLOGIAS', 1),                        -- ID 2
       (1, 'Desenvolvimento Web', 'TECNOLOGIAS', 1),                     -- ID 3
       (2, 'Cálculo Diferencial e Integral I', 'CIÊNCIAS EXATAS', NULL),  -- ID 4
       (2, 'Cálculo Diferencial e Integral II', 'CIÊNCIAS EXATAS', 4),   -- ID 5
       (2, 'Estrutura de Dados', 'ENGENHARIAS', 1),                      -- ID 6
       (2, 'Programação Orientada a Objetos', 'ENGENHARIAS', 1),         -- ID 7
       (2, 'Engenharia de Requisitos', 'ENGENHARIAS', NULL),             -- ID 8
       (3, 'Álgebra Linear', 'CIÊNCIAS EXATAS', NULL),                   -- ID 9
       (3, 'Geometria Analítica', 'CIÊNCIAS EXATAS', NULL),               -- ID 10
       (3, 'Didática Geral', 'CIÊNCIAS HUMANAS E SOCIAIS', NULL),        -- ID 11
       (3, 'História da Matemática', 'CIÊNCIAS HUMANAS E SOCIAIS', 9);   -- ID 12

-- 1.3 PESSOAS (38 Pessoas: 8 Professores + 30 Alunos)
-- Professores (CPFs de 001 a 008)
INSERT INTO pessoa (cpf, nome, data_nascimento)
VALUES ('001.000.000-01', 'Alan Turing', '1982-06-23'),
       ('002.000.000-02', 'Grace Hopper', '1985-12-09'),
       ('003.000.000-03', 'Ada Lovelace', '1988-12-10'),
       ('004.000.000-04', 'Isaac Newton', '1975-01-04'),
       ('005.000.000-05', 'Gottfried Leibniz', '1979-07-01'),
       ('006.000.000-06', 'Euclides de Alexandria', '1970-03-15'),
       ('007.000.000-07', 'Paulo Freire', '1965-09-19'),
       ('008.000.000-08', 'Maria Montessori', '1980-08-31'),
       ('101.000.000-00', 'Linus Torvalds', '2000-01-01'),
       ('102.000.000-00', 'Bill Gates', '2001-02-02'),
       ('103.000.000-00', 'Steve Jobs', '2002-03-03'),
       ('104.000.000-00', 'Mark Zuckerberg', '2003-04-04'),
       ('105.000.000-00', 'Elon Musk', '1999-05-05'),
       ('106.000.000-00', 'Jeff Bezos', '2000-06-06'),
       ('107.000.000-00', 'Tim Berners-Lee', '2001-07-07'),
       ('108.000.000-00', 'Richard Stallman', '2002-08-08'),
       ('109.000.000-00', 'Dennis Ritchie', '2003-09-09'),
       ('110.000.000-00', 'Ken Thompson', '1998-10-10'),
       ('111.000.000-00', 'Carl Friedrich Gauss', '2001-11-11'),
       ('112.000.000-00', 'Leonhard Euler', '2002-12-12'),
       ('113.000.000-00', 'Blaise Pascal', '2000-05-15'),
       ('114.000.000-00', 'René Descartes', '2003-07-20'),
       ('115.000.000-00', 'Pierre de Fermat', '2001-03-11'),
       ('116.000.000-00', 'Albert Einstein', '1999-09-09'),
       ('117.000.000-00', 'Marie Curie', '2002-04-18'),
       ('118.000.000-00', 'Nikola Tesla', '2000-02-28'),
       ('119.000.000-00', 'Ada Yonath', '2003-11-05'),
       ('120.000.000-00', 'Rosalind Franklin', '2001-08-12'),
       ('121.000.000-00', 'Margaret Hamilton', '2002-01-30'),
       ('122.000.000-00', 'Katherine Johnson', '2000-10-26'),
       ('123.000.000-00', 'Dorothy Vaughan', '2003-06-14'),
       ('124.000.000-00', 'Mary Jackson', '2001-04-09'),
       ('125.000.000-00', 'Alan Kay', '2002-05-25'),
       ('126.000.000-00', 'Barbara Liskov', '2000-09-15'),
       ('127.000.000-00', 'Donald Knuth', '2003-02-19'),
       ('128.000.000-00', 'James Gosling', '2001-12-05'),
       ('129.000.000-00', 'Guido van Rossum', '2002-07-07'),
       ('130.000.000-00', 'Bjarne Stroustrup', '2000-08-23');

-- 1.4 PROFESSORES (8 Professores - Mínimo pedido: 8)
INSERT INTO professor (cpf, titulacao)
VALUES ('001.000.000-01', 'DOUTOR'),
       ('002.000.000-02', 'MESTRE'),
       ('003.000.000-03', 'ESPECIALISTA'),
       ('004.000.000-04', 'LIVRE-DOCENTE'),
       ('005.000.000-05', 'DOUTOR'),
       ('006.000.000-06', 'MESTRE'),
       ('007.000.000-07', 'DOUTOR'),
       ('008.000.000-08', 'ESPECIALISTA');

-- 1.5 ALUNOS (30 Alunos divididos nos 3 cursos - Mínimo pedido: 30)
-- 1 a 10 no Curso 1 | 11 a 20 no Curso 2 | 21 a 30 no Curso 3
INSERT INTO aluno (id_curso, cpf, status_aluno, bolsa)
VALUES (1, '101.000.000-00', 'CURSANDO', 0),
       (1, '102.000.000-00', 'CURSANDO', 50),
       (1, '103.000.000-00', 'CURSANDO', 100),
       (1, '104.000.000-00', 'TRANCADO', 0),
       (1, '105.000.000-00', 'CURSANDO', 0),
       (1, '106.000.000-00', 'CURSANDO', 25),
       (1, '107.000.000-00', 'CURSANDO', 0),
       (1, '108.000.000-00', 'EVASÃO', 0),
       (1, '109.000.000-00', 'CURSANDO', 50),
       (1, '110.000.000-00', 'FORMADO', 0),
       (2, '111.000.000-00', 'CURSANDO', 0),
       (2, '112.000.000-00', 'CURSANDO', 100),
       (2, '113.000.000-00', 'CURSANDO', 0),
       (2, '114.000.000-00', 'CURSANDO', 0),
       (2, '115.000.000-00', 'TRANCADO', 0),
       (2, '116.000.000-00', 'CURSANDO', 50),
       (2, '117.000.000-00', 'CURSANDO', 0),
       (2, '118.000.000-00', 'CURSANDO', 0),
       (2, '119.000.000-00', 'CURSANDO', 25),
       (2, '120.000.000-00', 'CURSANDO', 0),
       (3, '121.000.000-00', 'CURSANDO', 100),
       (3, '122.000.000-00', 'CURSANDO', 0),
       (3, '123.000.000-00', 'CURSANDO', 0),
       (3, '124.000.000-00', 'CURSANDO', 50),
       (3, '125.000.000-00', 'TRANCADO', 0),
       (3, '126.000.000-00', 'CURSANDO', 0),
       (3, '127.000.000-00', 'CURSANDO', 0),
       (3, '128.000.000-00', 'CURSANDO', 0),
       (3, '129.000.000-00', 'EVASÃO', 0),
       (3, '130.000.000-00', 'CURSANDO', 75);

-- 1.6 TURMAS (15 Turmas distribuídas - Mínimo pedido: 15)
-- id_turma gerados automaticamente de 1 a 15
INSERT INTO turma (id_disciplina, matricula_professor, finalizada)
VALUES (1, 1, false),
       (2, 2, false),
       (3, 3, false), -- Técnico Inf
       (4, 4, false),
       (5, 5, false),
       (6, 1, false),
       (7, 2, false),
       (8, 3, false), -- Eng Soft
       (9, 6, false),
       (10, 5, false),
       (11, 7, false),
       (12, 8, false), -- Mat
       (1, 2, false),
       (4, 5, false),
       (9, 4, false); -- Turmas extras/paralelas para somar 15

-- 1.7 DIÁRIO / MATRÍCULAS (52 Matrículas vinculando Alunos às Turmas - Mínimo pedido: 50)
-- IMPORTANTE: Alunos do curso 1 entram nas turmas do curso 1, e assim por diante.
-- *Aqui o gatilho 'insere_boletim_inicial' vai criar o boletim de cada um automaticamente!*
INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 1);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 2);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 3);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 5);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 6);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 7);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (1, 9);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (2, 1);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (2, 2);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (2, 3);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (2, 5);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (2, 6);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (3, 5);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (3, 6);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (3, 7);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (4, 11);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (4, 12);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (4, 13);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (4, 14);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (5, 16);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (5, 17);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (5, 18);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (5, 19);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (5, 20);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (6, 11);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (6, 12);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (6, 13);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (6, 14);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (7, 16);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (7, 17);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (7, 18);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (7, 19);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (8, 11);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (8, 12);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (8, 20);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (9, 21);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (9, 22);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (9, 23);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (9, 24);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (10, 26);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (10, 27);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (10, 28);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (11, 21);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (11, 22);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (11, 30);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (12, 26);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (12, 27);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (12, 30);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (13, 1);

INSERT INTO diario (id_turma, matricula_aluno) VALUES (13, 2);

-- =============================================================================
-- 2. COMANDOS DE ATUALIZAÇÃO (UPDATE)
-- =============================================================================

-- Caso 2.1: O aluno 'Elon Musk' (Matrícula 5) conseguiu uma bolsa de 50% no seu curso.
UPDATE aluno
SET bolsa = 50
WHERE matricula_aluno = 5;

-- Caso 2.2: O professor 'Paulo Freire' (Matrícula 7) defendeu sua tese e virou Doutor.
UPDATE professor
SET titulacao = 'DOUTOR'
WHERE matricula_professor = 7;

-- =============================================================================
-- 3. COMANDOS DE DELEÇÃO (DELETE)
-- =============================================================================

-- Caso 3.1: Um aluno desistiu da matrícula na turma ANTES do início das aulas.
-- Vamos remover o aluno 2 da turma 13.
-- Nota: O banco vai apagar em cascata ou você precisa limpar os registros dependentes.
-- Como o boletim foi criado via trigger, precisamos remover o boletim dele primeiro (ou ter ON DELETE CASCADE).
DELETE FROM boletim
WHERE id_diario = (SELECT id_diario FROM diario WHERE id_turma = 13 AND matricula_aluno = 2);

DELETE FROM diario
WHERE id_turma = 13 AND matricula_aluno = 2;