-- pra usar depois é:
-- SELECT calcular_mensalidade('TÉCNICO', 50);

CREATE FUNCTION calcular_mensalidade (
    modalidade ENUM('TÉCNICO', 'BACHAREL', 'LICENCIATURA'),
    bolsa INT UNSIGNED
)
RETURNS DECIMAL (5,2)
DETERMINISTIC
BEGIN
    DECLARE valor_mensalidade DECIMAL (5,2);
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
RETURNS DECIMAL (5,2)
DETERMINISTIC
BEGIN
    DECLARE valor_salario DECIMAL (5,2);
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