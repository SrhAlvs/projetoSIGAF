CREATE DATABASE sigaf;

USE sigaf;

-- curso, matérias e afins

CREATE TABLE curso (
    id_curso INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    modalidade ENUM('TÉCNICO', 'BACHAREL', 'LICENCIATURA'),
    duracao INTEGER -- semestres
);

CREATE TABLE disciplina (
    id_disciplina INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_curso INT UNSIGNED,
    nome VARCHAR(100) NOT NULL,
    departamento ENUM('ARTES', 'CIÊNCIAS BIOLÓGICAS', 'CIÊNCIAS EXATAS', 'CIÊNCIAS HUMANAS E SOCIAIS', 'CIÊNCIAS SOCIAS APLICADAS', 'ENGENHARIAS', 'LINGUÍSTICA E LETRAS', 'SAÚDE', 'TECNOLOGIAS'),
    pre_requisito INT UNSIGNED,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE pessoa (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE
);

CREATE TABLE pagamento (
    id_pagamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14),
    tipo ENUM('MENSALIDADE', 'SALÁRIO'),
    valor DECIMAL(10,2),
    situacao ENUM('PAGO', 'PENDENTE'),
    CONSTRAINT FK_pagamento_cpf FOREIGN KEY (cpf) REFERENCES pessoa(cpf)
);

CREATE TABLE professor (
    matricula_professor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14),
    titulacao ENUM('ESPECIALISTA', 'MESTRE', 'DOUTOR', 'LIVRE-DOCENTE'),
    CONSTRAINT FK_professor_cpf FOREIGN KEY (cpf) REFERENCES pessoa(cpf)
);

CREATE TABLE aluno (
    matricula_aluno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_curso INT UNSIGNED,
    cpf VARCHAR(14),
    status_aluno ENUM('CURSANDO', 'TRANCADO', 'EVASÃO', 'FORMADO'),
    bolsa INT UNSIGNED,
    CONSTRAINT FK_aluno_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    CONSTRAINT FK_aluno_cpf FOREIGN KEY (cpf) REFERENCES pessoa(cpf)
);

CREATE TABLE turma (
    id_turma INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_disciplina INT UNSIGNED,
    matricula_professor INT UNSIGNED,
    finalizada BOOLEAN,
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),
    FOREIGN KEY (matricula_professor) REFERENCES professor(matricula_professor)
);

CREATE TABLE diario (
    id_diario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_turma INT UNSIGNED,
    matricula_aluno INT UNSIGNED,
    CONSTRAINT FK_diario_turma FOREIGN KEY (id_turma) REFERENCES turma(id_turma),
    CONSTRAINT FK_diario_aluno FOREIGN KEY (matricula_aluno) REFERENCES aluno(matricula_aluno)
);

CREATE TABLE frequencia (
    id_frequencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_diario INT UNSIGNED,
    aluno_presente BOOLEAN DEFAULT FALSE,
    data_aula DATE,
    CONSTRAINT FK_frequencia_diario FOREIGN KEY (id_diario) REFERENCES diario(id_diario)
);

CREATE TABLE avaliacao ( -- fazer function pra calcular percentual de presença
    id_avaliacao INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_diario INT UNSIGNED,
    descricao VARCHAR(255) NOT NULL,
    nota DECIMAL(4,2),
    CONSTRAINT FK_avaliacao_diario FOREIGN KEY (id_diario) REFERENCES diario(id_diario)
);

CREATE TABLE boletim ( -- fazer function pra calcular percentual de presença
    id_boletim INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_diario INT UNSIGNED,
    nota_final DECIMAL(4,2),
    percentual_frequencia DECIMAL(5,2),
    aprovado ENUM('APROVADO', 'REPROVADO'),
    CONSTRAINT FK_boletim_diario FOREIGN KEY (id_diario) REFERENCES diario(id_diario)
);