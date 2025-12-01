-- Criação das tabelas
CREATE TABLE Recepcionista (
    CPF VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Salario DECIMAL(10, 2)
);

CREATE TABLE Medico (
    CRM VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Salario DECIMAL(10, 2)
);

CREATE TABLE Paciente (
    CPF VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Data_de_nascimento DATE
);

CREATE TABLE Consulta (
    id_consulta INT PRIMARY KEY,
    Data_e_hora TIMESTAMP NOT NULL,
    Valor DECIMAL(8, 2),
    CPF_paciente VARCHAR(14) NOT NULL,
    CRM_medico VARCHAR(20) NOT NULL,
    FOREIGN KEY (CPF_paciente) REFERENCES Paciente(CPF),
    FOREIGN KEY (CRM_medico) REFERENCES Medico(CRM)
);

CREATE TABLE Prontuario (
    id_prontuario INT PRIMARY KEY,
    CRM_medico_responsavel VARCHAR(20) NOT NULL,
    Diagnostico TEXT,
    Prescricao TEXT,
    id_consulta INT UNIQUE,
    FOREIGN KEY (CRM_medico_responsavel) REFERENCES Medico(CRM),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);

-- Inserção dos dados
INSERT INTO Paciente (CPF, Nome, Telefone, Data_de_nascimento) VALUES
('11111111111', 'Ana Silva', '999999999', '1985-05-15'),
('11111111112', 'Bruno Martins', '999999999', '1990-11-20'),
('11111111113', 'Carla Souza', '999999999', '1976-02-28'),
('11111111114', 'David Lima', '999999999', '2001-08-10');

INSERT INTO Medico (CRM, Nome, Telefone, Salario) VALUES
('111111', 'Dr. Eduardo Costa', '999999999', 15000.00),
('111112', 'Dra. Fernanda Alves', '999999999', 18000.00);

INSERT INTO Recepcionista (CPF, Nome, Telefone, Salario) VALUES
('11111111115', 'Mariana Gomes', '999999999', 2500.00),
('11111111116', 'Lucas Pereira', '999999999', 2600.00);

INSERT INTO Consulta (id_consulta, Data_e_hora, Valor, CPF_paciente, CRM_medico) VALUES
(1, '2025-11-20 10:00:00', 150.00, '11111111111', '111111'),
(2, '2025-11-20 14:30:00', 200.00, '11111111112', '111112'),
(3, '2025-12-01 09:00:00', 180.00, '11111111113', '111111');

INSERT INTO Prontuario (id_prontuario, CRM_medico_responsavel, Diagnostico, Prescricao, id_consulta) VALUES
(1001, '111111', 'Gripe comum', 'Repouso e Paracetamol', 1),
(1002, '111112', 'Exame de rotina OK', 'Manter hábitos saudáveis', 2),
(1003, '111111', 'Dor nas costas', 'Sessões de fisioterapia', 3);

-- Consultas
SELECT Nome, Data_de_nascimento, Telefone
FROM Paciente
WHERE Data_de_nascimento > '1980-01-01'
ORDER BY Data_de_nascimento DESC;

SELECT
  P.Nome AS Paciente,
  M.Nome AS Medico,
  Pr.Diagnostico
FROM Consulta C
JOIN Paciente P ON C.CPF_paciente = P.CPF
JOIN Medico M ON C.CRM_medico = M.CRM
JOIN Prontuario Pr ON C.id_consulta = Pr.id_consulta
ORDER BY C.Data_e_hora;

SELECT Nome, Salario
FROM Recepcionista
ORDER BY Salario ASC
LIMIT 1;

SELECT M.Nome AS Nome_do_Medico,
COUNT(C.id_consulta) AS Numero_de_Consultas
FROM Medico M
LEFT JOIN Consulta C ON M.CRM = C.CRM_medico
GROUP BY M.Nome
ORDER BY Numero_de_Consultas DESC;

--Alterações
UPDATE Medico
SET Salario = Salario * 1.10
WHERE Salario IS NOT NULL;

UPDATE Consulta
SET Valor = 200.00, Data_e_hora = '2025-12-01 09:30:00'
WHERE id_consulta = 3;

UPDATE Prontuario
SET Diagnostico = 'Resfriado Comum Forte'
WHERE Prescricao = 'Repouso e Paracetamol';

DELETE FROM Prontuario
WHERE id_prontuario = 1002;

DELETE FROM Consulta
WHERE id_consulta = 2;

DELETE FROM Paciente
WHERE CPF = '11111111114';

DELETE FROM Recepcionista
WHERE Salario < 2550.00;
