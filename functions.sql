USE sigaf;

CREATE FUNCTION total_turmas (
    professor_cpf VARCHAR(14)
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE quantidade_turmas INT UNSIGNED DEFAULT 0;

    SELECT COUNT(tur.id_turma)
    INTO quantidade_turmas
    FROM turma tur
    JOIN professor pro ON pro.matricula_professor = tur.matricula_professor
    WHERE pro.cpf = professor_cpf
    AND tur.finalizada = false;

    RETURN quantidade_turmas;
END;

-- =============================================

-- pra usar depois é:
-- SELECT calcular_mensalidade('TÉCNICO', 50);

CREATE FUNCTION calcular_mensalidade (
    modalidade ENUM('TÉCNICO', 'BACHAREL', 'LICENCIATURA'),
    bolsa INT UNSIGNED
)
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
    DECLARE valor_mensalidade DECIMAL (10,2);
    IF modalidade = 'TÉCNICO' THEN
        SET valor_mensalidade = 500 - ((500 * bolsa)/100);
    ELSEIF modalidade =  'BACHAREL' THEN
        SET valor_mensalidade = 1200 - ((1200 * bolsa)/100);
    ELSEIF modalidade = 'LICENCIATURA' THEN
        SET valor_mensalidade = 1000 - ((1000 * bolsa)/100);
    END IF;
    RETURN valor_mensalidade;
END;

-- =============================================

-- pra usar depois é:
-- SELECT calcular_salario('ESPECIALISTA', x);
-- x = (SELECT * FROM quantidade_turmas WHERE matricula_professor = y);

CREATE FUNCTION calcular_salario (
    titulacao ENUM('ESPECIALISTA', 'MESTRE', 'DOUTOR', 'LIVRE-DOCENTE'),
    quantidade_turmas INT UNSIGNED
)
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
    DECLARE valor_salario DECIMAL (10,2);
    IF titulacao = 'ESPECIALISTA' THEN
        SET valor_salario = 2000 + (quantidade_turmas * 200);
    ELSEIF titulacao = 'MESTRE' THEN
        SET valor_salario = 4000 + (quantidade_turmas * 200);
    ELSEIF titulacao = 'DOUTOR' THEN
        SET valor_salario = 6000 + (quantidade_turmas * 200);
    ELSEIF titulacao = 'LIVRE-DOCENTE' THEN
        SET valor_salario = 8000 + (quantidade_turmas * 200);
    END IF;
    RETURN valor_salario;
END;

-- =============================================

CREATE FUNCTION verificar_aprovacao (
    matricula_aluno INT UNSIGNED,
    pre_requisito INT UNSIGNED
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE aprovado VARCHAR(50) DEFAULT 'REPROVADO';

    SELECT bol.aprovado
    INTO aprovado
    FROM boletim bol
    JOIN diario dia ON bol.id_diario = dia.id_diario
    JOIN turma tur ON dia.id_turma = tur.id_turma
    WHERE dia.matricula_aluno = matricula_aluno
    AND tur.id_disciplina = pre_requisito
    LIMIT 1; -- evita dar erro caso ele tenha cursado mais de uma vez

    IF aprovado = 'APROVADO' THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;

-- =============================================

CREATE FUNCTION calcular_percentual_frequencia (
    id_diario INT UNSIGNED
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_aulas INT UNSIGNED;
    DECLARE total_presencas INT UNSIGNED;

    SELECT COUNT(fre.id_frequencia) AS quantidade_aulas
    INTO total_aulas
    FROM frequencia fre
    WHERE fre.id_diario = id_diario;

    SELECT COUNT(fre.id_frequencia) AS quantidade_aulas
    INTO total_presencas
    FROM frequencia fre
    WHERE fre.id_diario = id_diario
    AND fre.aluno_presente = TRUE;

    IF total_aulas = 0 THEN
        RETURN 0.00;
    ELSE
        RETURN (total_presencas * 100) / total_aulas;
    END IF;
END;