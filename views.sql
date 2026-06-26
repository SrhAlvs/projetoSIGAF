USE sigaf;

-- pra usar é:
-- SELECT * FROM historico WHERE nome = "";
-- ou
-- SELECT * FROM historico WHERE matricula_aluno = 1;


CREATE OR REPLACE VIEW historico AS
SELECT alu.matricula_aluno AS matricula_aluno,
       pes.nome AS nome,
       dis.nome AS disciplina,
       bol.nota_final AS nota,
       bol.aprovado AS situacao,
       tur.id_turma AS codigo_turma
FROM pessoa pes
JOIN aluno alu ON alu.cpf = pes.cpf
JOIN disciplina dis ON dis.id_curso = alu.id_curso
JOIN turma tur ON tur.id_disciplina = dis.id_disciplina
JOIN diario dia ON dia.id_turma = tur.id_turma
JOIN boletim bol ON bol.id_diario = dia.id_diario;

-- ===============================

-- =============================================================================
-- PARTE 1: CONSULTAS SIMPLES (10)
-- =============================================================================

-- 1. Listar todas as pessoas cadastradas
SELECT * FROM pessoa;

-- 2. Listar todos os alunos cadastrados
SELECT * FROM aluno;

-- 3. Listar todos os professores
SELECT * FROM professor;

-- 4. Mostrar os cursos oferecidos pela instituição
SELECT * FROM curso;

-- 5. Listar todas as disciplinas salvas
SELECT * FROM disciplina;

-- 6. Listar todas as turmas cadastradas
SELECT * FROM turma;

-- 7. Mostrar todos os registros de pagamentos efetuados ou pendentes
SELECT * FROM pagamento;

-- 8. Visualizar o conteúdo completo da tabela diário
SELECT * FROM diario;

-- 9. Listar todas as notas e avaliações lançadas
SELECT * FROM avaliacao;

-- 10. Listar todos os boletins gerados no sistema
SELECT * FROM boletim;


-- =============================================================================
-- PARTE 2: CONSULTAS COM FILTROS (10) - Uso de WHERE, LIKE, BETWEEN, IN
-- =============================================================================

-- 11. Filtrar pessoas que nasceram a partir dos anos 2000 (WHERE)
SELECT nome, data_nascimento FROM pessoa
WHERE data_nascimento >= '2000-01-01';

-- 12. Filtrar apenas os pagamentos cuja situação está como 'PAGO' (WHERE)
SELECT id_pagamento, cpf, valor FROM pagamento
WHERE situacao = 'PAGO';

-- 13. Buscar pessoas cujo nome começa com a letra 'A' (LIKE)
SELECT cpf, nome FROM pessoa
WHERE nome LIKE 'A%';

-- 14. Buscar pessoas que possuem o sobrenome 'Matemática' ou similar em disciplinas (LIKE)
SELECT id_disciplina, nome FROM disciplina
WHERE nome LIKE '%Matemática%';

-- 15. Filtrar pagamentos com valores entre R$ 300,00 e R$ 3.000,00 (BETWEEN)
SELECT id_pagamento, cpf, tipo, valor FROM pagamento
WHERE valor BETWEEN 300.00 AND 3000.00;

-- 16. Filtrar pessoas que nasceram entre as décadas de 80 e 90 (BETWEEN)
SELECT nome, data_nascimento FROM pessoa
WHERE data_nascimento BETWEEN '1980-01-01' AND '1999-12-31';

-- 17. Filtrar alunos que possuem os status específicos de 'TRANCADO' ou 'EVASÃO' (IN)
SELECT matricula_aluno, status_aluno FROM aluno
WHERE status_aluno IN ('TRANCADO', 'EVASÃO');

-- 18. Filtrar professores com titulação de alta patente: MESTRE ou DOUTOR (IN)
SELECT matricula_professor, titulacao FROM professor
WHERE titulacao IN ('MESTRE', 'DOUTOR');

-- 19. Filtrar disciplinas pertencentes aos departamentos de Ciências Exatas ou Tecnologias (IN e WHERE)
SELECT nome, departamento FROM disciplina
WHERE departamento IN ('CIÊNCIAS EXATAS', 'TECNOLOGIAS');

-- 20. Filtrar pagamentos do tipo MENSALIDADE que custaram exatamente R$ 0,00 ou R$ 250,00 (IN)
SELECT id_pagamento, valor FROM pagamento
WHERE tipo = 'MENSALIDADE' AND valor IN (0.00, 250.00);


-- =============================================================================
-- PARTE 3: CONSULTAS COM JUNÇÃO (10) - INNER, LEFT, RIGHT e FULL OUTER JOIN
-- =============================================================================

-- 21. Mostrar dados básicos do aluno, seu curso correspondente e sua situação financeira (INNER JOIN)
SELECT p.nome AS aluno, c.nome AS curso, pag.valor, pag.situacao AS situacao_financeira
FROM aluno alu
         INNER JOIN pessoa p ON alu.cpf = p.cpf
         INNER JOIN curso c ON alu.id_curso = c.id_curso
         INNER JOIN pagamento pag ON pag.cpf = p.cpf;

-- 22. Listar todas as disciplinas e os nomes dos seus respectivos cursos associados (INNER JOIN)
SELECT d.nome AS disciplina, c.nome AS curso, d.departamento
FROM disciplina d
         INNER JOIN curso c ON d.id_curso = c.id_curso;

-- 23. Listar as turmas exibindo o nome da disciplina e o nome do professor responsável (INNER JOIN)
SELECT t.id_turma, d.nome AS disciplina, p.nome AS professor
FROM turma t
         INNER JOIN disciplina d ON t.id_disciplina = d.id_disciplina
         INNER JOIN professor prof ON t.matricula_professor = prof.matricula_professor
         INNER JOIN pessoa p ON prof.cpf = p.cpf;

-- 24. Listar todas as pessoas e, caso sejam alunos, mostrar sua matrícula e status (LEFT JOIN)
-- (Traz todas as pessoas, mesmo as que não são alunas)
SELECT p.nome, alu.matricula_aluno, alu.status_aluno
FROM pessoa p
         LEFT JOIN aluno alu ON p.cpf = alu.cpf;

-- 25. Listar todos os diários de classe com as notas finais contidas no boletim (LEFT JOIN)
-- (Garante a exibição do diário mesmo se o boletim ainda não tiver sido gerado/atualizado)
SELECT d.id_diario, d.id_turma, b.nota_final, b.aprovado
FROM diario d
         LEFT JOIN boletim b ON d.id_diario = b.id_diario;

-- 26. Listar todas as disciplinas e seus pré-requisitos, se houver (LEFT JOIN autorreferencial)
SELECT d.nome AS disciplina, pre.nome AS pre_requisito
FROM disciplina d
         LEFT JOIN disciplina pre ON d.pre_requisito = pre.id_disciplina;

-- 27. Listar todos os professores existentes a partir da tabela de pagamentos (RIGHT JOIN)
-- (Garante a exibição de dados do professor mesmo se ele não possuir lançamentos de pagamentos)
SELECT pag.id_pagamento, pag.valor, p.nome AS professor, prof.titulacao
FROM pagamento pag
         RIGHT JOIN professor prof ON pag.cpf = prof.cpf
         INNER JOIN pessoa p ON prof.cpf = p.cpf;

-- 28. Listar boletins estruturados garantindo a visualização dos dados dos alunos associados (RIGHT JOIN)
SELECT b.id_boletim, b.nota_final, p.nome AS aluno, alu.matricula_aluno
FROM boletim b
         INNER JOIN diario d ON b.id_diario = d.id_diario
         RIGHT JOIN aluno alu ON d.matricula_aluno = alu.matricula_aluno
         INNER JOIN pessoa p ON alu.cpf = p.cpf;

-- 29. FULL OUTER JOIN Simulado: União de todas as pessoas com todos os registros de pagamentos possíveis
-- (Traz pessoas sem pagamentos e pagamentos que por ventura estejam sem vínculo direto na tabela aluno/prof)
SELECT p.nome, p.cpf, pag.tipo, pag.valor, pag.situacao
FROM pessoa p
         LEFT JOIN pagamento pag ON p.cpf = pag.cpf
UNION
SELECT p.nome, pag.cpf, pag.tipo, pag.valor, pag.situacao
FROM pessoa p
         RIGHT JOIN pagamento pag ON p.cpf = pag.cpf;

-- 30. FULL OUTER JOIN Simulado: Mapeamento completo entre Cursos e Alunos
-- (Traz cursos sem alunos matriculados e alunos que possam estar temporariamente sem curso mapeado)
SELECT c.nome AS curso, alu.matricula_aluno, alu.status_aluno
FROM curso c
         LEFT JOIN aluno alu ON c.id_curso = alu.id_curso
UNION
SELECT c.nome AS curso, alu.matricula_aluno, alu.status_aluno
FROM curso c
         RIGHT JOIN aluno alu ON c.id_curso = alu.id_curso;