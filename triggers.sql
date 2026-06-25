USE sigaf;

CREATE TRIGGER insere_boletim_inicial
AFTER INSERT
ON diario
FOR EACH ROW
BEGIN
    -- sempre que um aluno entrar no diário, cria o boletim dele zerado
    INSERT INTO boletim (id_diario, nota_final, percentual_frequencia, aprovado)
    VALUES (NEW.id_diario, 0.00, 0.00, 'REPROVADO');
END;

-- =============================================

CREATE TRIGGER atualiza_boletim_avaliacao
AFTER INSERT
ON avaliacao
FOR EACH ROW
BEGIN
    DECLARE nota_final DECIMAL (4,2);
    DECLARE percentual_frequencia DECIMAL (5,2);
    DECLARE aprovado ENUM('APROVADO', 'REPROVADO');

    SELECT AVG(ava.nota)
    INTO nota_final
    FROM avaliacao ava
    WHERE ava.id_diario = NEW.id_diario;

    SET percentual_frequencia = calcular_percentual_frequencia(NEW.id_diario);

    IF (nota_final >= 6.0 AND percentual_frequencia >= 75.00) THEN
        SET aprovado = 'APROVADO';
    ELSE
        SET aprovado = 'REPROVADO';
    END IF;

    UPDATE boletim bol
    SET bol.nota_final = nota_final,
        bol.percentual_frequencia = percentual_frequencia,
        bol.aprovado = aprovado
    WHERE bol.id_diario = NEW.id_diario;
END;

-- =============================================

CREATE TRIGGER calcula_valor_pagamento
BEFORE INSERT
ON pagamento
FOR EACH ROW
BEGIN
    DECLARE valor DECIMAL (10,2);

    IF NEW.tipo = 'MENSALIDADE' THEN
        SET valor = calcular_mensalidade(
                    (SELECT cur.modalidade FROM curso cur JOIN aluno alu ON alu.cpf = NEW.cpf WHERE cur.id_curso = alu.id_curso),
                    (SELECT COALESCE(alu.bolsa, 0) FROM aluno alu WHERE alu.cpf = NEW.cpf)
                    );
    ELSEIF NEW.tipo = 'SALÁRIO' THEN
        SET valor = calcular_salario(
                    (SELECT pro.titulacao FROM professor pro WHERE pro.cpf = NEW.cpf),
                    total_turmas(NEW.cpf)
                    );
    END IF;

    SET NEW.valor = valor;
END;

-- =============================================

CREATE TRIGGER analiza_pre_requisitos
BEFORE INSERT
ON diario
FOR EACH ROW
BEGIN
    DECLARE pre_requisito INT UNSIGNED;
    DECLARE aprovado BOOLEAN;

    SELECT dis.pre_requisito
    INTO pre_requisito
    FROM disciplina dis
    JOIN turma tur ON tur.id_turma = NEW.id_turma
    WHERE tur.id_disciplina = dis.id_disciplina;

    IF pre_requisito IS NOT NULL AND pre_requisito <> 0 THEN
        SET aprovado = verificar_aprovacao(
                       NEW.matricula_aluno,
                       pre_requisito
                       );

        IF NOT aprovado THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'O aluno não pode ser matriculado, pois não possui os requisitos necessários.';
        END IF;

    END IF;
END;