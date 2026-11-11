CREATE DATABASE Academia_Movimento_Mais;

USE Academia_Movimento_Mais;

SELECT name AS NomeDoBanco
FROM sys.databases
ORDER BY name;

SELECT DB_NAME() AS BancoAtual;

CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefone VARCHAR(20) NOT NULL,
    DataNascimento DATE NULL,
    Ativo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Instrutor (
    IdInstrutor INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CREF VARCHAR(20) NOT NULL UNIQUE,
    Especialidade VARCHAR(80) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Ativo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Modalidade (
    IdModalidade INT IDENTITY(1,1) PRIMARY KEY,
    NomeModalidade VARCHAR(80) NOT NULL UNIQUE,
    Nivel VARCHAR(20) NOT NULL,
    DuracaoMinutos INT NOT NULL CHECK (DuracaoMinutos > 0),
    Descricao VARCHAR(200) NULL
);

CREATE TABLE Plano (
    IdPlano INT IDENTITY(1,1) PRIMARY KEY,
    NomePlano VARCHAR(80) NOT NULL UNIQUE,
    ValorMensal DECIMAL(10,2) NOT NULL CHECK (ValorMensal > 0),
    DuracaoMeses INT NOT NULL CHECK (DuracaoMeses BETWEEN 1 AND 24),
    AcessoLivre BIT NOT NULL DEFAULT 0
);

CREATE TABLE Matricula (
    IdMatricula INT IDENTITY(1,1) PRIMARY KEY,
    IdCliente INT NOT NULL,
    IdPlano INT NOT NULL,
    DataInicio DATE NOT NULL,
    StatusMatricula VARCHAR(15) NOT NULL DEFAULT 'Ativa',
    Desconto DECIMAL(5,2) NOT NULL DEFAULT 0
        CHECK (Desconto BETWEEN 0 AND 100),

    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (IdPlano) REFERENCES Plano(IdPlano)
);

CREATE TABLE Aula (
    IdAula INT IDENTITY(1,1) PRIMARY KEY,
    IdModalidade INT NOT NULL,
    IdInstrutor INT NOT NULL,
    DataAula DATE NOT NULL,
    Horario TIME NOT NULL,
    Vagas INT NOT NULL CHECK (Vagas BETWEEN 1 AND 50),
    Sala VARCHAR(30) NOT NULL,

    FOREIGN KEY (IdModalidade) REFERENCES Modalidade(IdModalidade),
    FOREIGN KEY (IdInstrutor) REFERENCES Instrutor(IdInstrutor)
);


SELECT * FROM Cliente; 
SELECT * FROM Instrutor;
SELECT * FROM Modalidade;
SELECT * FROM Plano;
SELECT * FROM Matricula;
SELECT * FROM Aula;

INSERT INTO Cliente (
    Nome,
    CPF,
    Email,
    Telefone,
    DataNascimento
)
VALUES
('Alice Fernandes', '11122233344', 'alice.fernandes@email.com', '11990001111', '2004-04-16'),
('Bruno Carvalho', '22233344455', 'bruno.carvalho@email.com', '11990002222', '2001-09-20'),
('Camila Santos', '33344455566', 'camila.santos@email.com', '11990003333', '1999-01-10'),
('Diego Oliveira', '44455566677', 'diego.oliveira@email.com', '11990004444', '2003-07-05'),
('Elisa Martins', '55566677788', 'elisa.martins@email.com', '11990005555', '1998-11-23'),
('Felipe Rocha', '66677788899', 'felipe.rocha@email.com', '11990006666', '2002-03-18'),
('Gabriela Lima', '77788899900', 'gabriela.lima@email.com', '11990007777', '2000-12-09'),
('Henrique Alves', '88899900011', 'henrique.alves@email.com', '11990008888', '1997-06-27'),
('Isabela Costa', '99900011122', 'isabela.costa@email.com', '11990009999', '2005-02-14'),
('João Ribeiro', '00011122233', 'joao.ribeiro@email.com', '11991112222', '2001-08-30');

INSERT INTO Instrutor (
    Nome,
    CREF,
    Especialidade,
    Email
)
VALUES
('André Silva', 'CREF-SP-1001', 'Musculação', 'andre.silva@movimentomais.com'),
('Beatriz Costa', 'CREF-SP-1002', 'Pilates', 'beatriz.costa@movimentomais.com'),
('Caio Mendes', 'CREF-SP-1003', 'Cross Training', 'caio.mendes@movimentomais.com'),
('Daniela Reis', 'CREF-SP-1004', 'Dança', 'daniela.reis@movimentomais.com'),
('Eduardo Lima', 'CREF-SP-1005', 'Natação', 'eduardo.lima@movimentomais.com'),
('Fernanda Alves', 'CREF-SP-1006', 'Yoga', 'fernanda.alves@movimentomais.com'),
('Gabriel Rocha', 'CREF-SP-1007', 'Funcional', 'gabriel.rocha@movimentomais.com'),
('Helena Souza', 'CREF-SP-1008', 'Corrida', 'helena.souza@movimentomais.com'),
('Igor Martins', 'CREF-SP-1009', 'Lutas', 'igor.martins@movimentomais.com'),
('Juliana Nunes', 'CREF-SP-1010', 'Alongamento', 'juliana.nunes@movimentomais.com');

INSERT INTO Modalidade (
    NomeModalidade,
    Nivel,
    DuracaoMinutos,
    Descricao
)
VALUES
('Musculação', 'Todos', 60, 'Treino com pesos e equipamentos.'),
('Pilates', 'Iniciante', 50, 'Exercícios de equilíbrio e fortalecimento.'),
('Cross Training', 'Intermediário', 45, 'Circuito de alta intensidade.'),
('Zumba', 'Todos', 50, 'Aula de dança com ritmos variados.'),
('Natação', 'Iniciante', 45, 'Fundamentos de natação.'),
('Yoga', 'Todos', 60, 'Posturas, respiração e concentração.'),
('Treino Funcional', 'Intermediário', 45, 'Movimentos para condicionamento físico.'),
('Corrida Orientada', 'Intermediário', 40, 'Técnica e resistência para corrida.'),
('Muay Thai', 'Iniciante', 60, 'Fundamentos da luta e condicionamento.'),
('Alongamento', 'Todos', 30, 'Mobilidade e flexibilidade.');

INSERT INTO Plano (
    NomePlano,
    ValorMensal,
    DuracaoMeses,
    AcessoLivre
)
VALUES
('Básico Mensal', 89.90, 1, 0),
('Básico Trimestral', 79.90, 3, 0),
('Básico Semestral', 74.90, 6, 0),
('Premium Mensal', 129.90, 1, 1),
('Premium Trimestral', 119.90, 3, 1),
('Premium Semestral', 109.90, 6, 1),
('Estudante Mensal', 69.90, 1, 0),
('Estudante Anual', 59.90, 12, 0),
('Família Mensal', 199.90, 1, 1),
('Corporativo Anual', 99.90, 12, 1);

INSERT INTO Matricula (
    IdCliente,
    IdPlano,
    DataInicio,
    StatusMatricula,
    Desconto
)
VALUES
(1, 7, '2026-02-01', 'Ativa', 0),
(2, 4, '2026-02-01', 'Ativa', 10),
(3, 6, '2026-02-02', 'Ativa', 0),
(4, 1, '2026-02-02', 'Suspensa', 0),
(5, 5, '2026-02-03', 'Ativa', 5),
(6, 2, '2026-02-03', 'Encerrada', 0),
(7, 8, '2026-02-04', 'Ativa', 15),
(8, 9, '2026-02-04', 'Ativa', 0),
(9, 7, '2026-02-05', 'Ativa', 20),
(10, 10, '2026-02-05', 'Ativa', 0);

INSERT INTO Aula (
    IdModalidade,
    IdInstrutor,
    DataAula,
    Horario,
    Vagas,
    Sala
)
VALUES
(1, 1, '2026-03-02', '07:00:00', 20, 'Sala de Musculação'),
(2, 2, '2026-03-02', '08:00:00', 12, 'Estúdio 1'),
(3, 3, '2026-03-02', '18:00:00', 18, 'Box Funcional'),
(4, 4, '2026-03-03', '19:00:00', 25, 'Sala de Dança'),
(5, 5, '2026-03-03', '09:00:00', 10, 'Piscina'),
(6, 6, '2026-03-04', '07:30:00', 15, 'Estúdio 2'),
(7, 7, '2026-03-04', '18:30:00', 20, 'Box Funcional'),
(8, 8, '2026-03-05', '06:30:00', 30, 'Pista Externa'),
(9, 9, '2026-03-05', '20:00:00', 16, 'Sala de Lutas'),
(10, 10, '2026-03-06', '17:00:00', 20, 'Estúdio 1');
