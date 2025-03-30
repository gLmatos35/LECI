-- DROP TABLE presc_farmaco;
-- GO
-- DROP TABLE Prescricao_prescricao;
-- GO
-- DROP TABLE Prescricao_farmaco;
-- GO
-- DROP TABLE Prescricao_farmaceutica;
-- GO
-- DROP TABLE Prescricao_farmacia;
-- GO
-- DROP TABLE Prescricao_paciente;
-- GO
-- DROP TABLE Prescricao_medico;
-- GO

CREATE TABLE Prescricao_medico(
	numSNS int NOT NULL,
	nome varchar(128) NOT NULL,
	especialidade varchar(64) NOT NULL,
	PRIMARY KEY(numSNS)
)
GO

CREATE TABLE Prescricao_paciente(
	numUtente int NOT NULL,
	nome varchar(128) NOT NULL,
	dataNasc date NOT NULL,
	endereco varchar(256) NOT NULL,
	PRIMARY KEY(numUtente)
)
GO

CREATE TABLE Prescricao_farmacia(
	nome varchar(128) NOT NULL,
	telefone varchar(9) NOT NULL,
	endereco varchar(256) NOT NULL,
	PRIMARY KEY(nome)
)
GO

CREATE TABLE Prescricao_farmaceutica(
	numReg int NOT NULL,
	nome varchar(128) NOT NULL,
	endereco varchar(256) NOT NULL,
	PRIMARY KEY(numReg)
)
GO

CREATE TABLE Prescricao_farmaco(
	numRegFarm int REFERENCES Prescricao_farmaceutica(numReg) NOT NULL,
	nome varchar(256) NOT NULL,
	formula varchar(128) NOT NULL,
	PRIMARY KEY(numRegFarm,nome)
)
GO

CREATE TABLE Prescricao_prescricao(
	numPresc int NOT NULL,
	numUtente int REFERENCES Prescricao_paciente(numUtente) NOT NULL,
	numMedico int REFERENCES Prescricao_medico (numSNS) NOT NULL,
	farmacia varchar(128) REFERENCES Prescricao_farmacia(nome), 
	dataProc date,
	PRIMARY KEY(numPresc)
)

CREATE TABLE presc_farmaco(
	numPresc int REFERENCES Prescricao_prescricao(numPresc) NOT NULL,
	numRegFarm int NOT NULL,
	nomeFarmaco varchar(256) NOT NULL,
	PRIMARY KEY(numPresc,numRegFarm,nomeFarmaco),
	FOREIGN KEY (numRegFarm,nomeFarmaco) REFERENCES Prescricao_farmaco(numRegFarm,nome)
)
GO