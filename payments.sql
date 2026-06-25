USE sigaf;

START TRANSACTION;

    INSERT INTO pagamento (cpf, tipo, situacao)
    VALUES ('106.000.000-00', 'MENSALIDADE', 'PENDENTE');

    UPDATE pagamento
    SET valor = 375.00,
        situacao = 'PAGO'
    WHERE cpf = '106.000.000-00';

COMMIT;

-- ========================

START TRANSACTION;

INSERT INTO pagamento (cpf, tipo, situacao)
VALUES ('005.000.000-05', 'SALÁRIO', 'PENDENTE');

UPDATE pagamento
SET valor = 6600.00,
    situacao = 'PAGO'
WHERE cpf = '005.000.000-05';

COMMIT;

-- ========================

START TRANSACTION;

INSERT INTO pagamento (cpf, tipo, situacao)
VALUES ('119.000.000-00', 'MENSALIDADE', 'PENDENTE');

UPDATE pagamento
SET valor = 900.00,
    situacao = 'PAGO'
WHERE cpf = '119.000.000-00';

COMMIT;



