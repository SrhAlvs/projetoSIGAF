USE sigaf;

-- pra usar é:
-- SELECT * FROM historico WHERE nome = "";
-- ou
-- SELECT * FROM historico WHERE matricula_aluno = 0;

CREATE OR REPLACE VIEW historico AS
SELECT alu.matricula_aluno AS matricula_aluno,
       pes.nome AS nome,
       dis.nome AS disciplina,
       dia.nota AS nota,
       dia.aprovado AS situacao,
       tur.id_turma AS codigo_turma
FROM pessoa pes
JOIN aluno alu ON alu.cpf = pes.cpf
JOIN disciplina dis ON dis.id_curso = alu.id_curso
JOIN turma tur ON tur.id_disciplina = dis.id_disciplina
JOIN diario dia ON dia.id_turma = dia.id_turma;

-- =============================================

-- pra usar é:
-- SELECT * FROM quantidade_turmas WHERE nome = "";
-- ou
-- SELECT * FROM quantidade_turmas WHERE matricula_professor = 0;

CREATE OR REPLACE VIEW quantidade_turmas AS
SELECT COUNT(tur.id_turma) AS codigo_turmas,
       pro.matricula_professor AS matricula_professor,
       pes.nome AS nome
FROM turma tur
JOIN professor pro ON pro.matricula_professor = tur.matricula_professor
JOIN pessoa pes ON pes.cpf = pro.cpf
WHERE tur.finalizada = false;