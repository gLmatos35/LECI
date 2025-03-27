CREATE TABLE [Medicamentos_Especialidade](
	[Id] [varchar](16) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	PRIMARY KEY([Id])
)
GO

CREATE TABLE [Medicamentos_Medico](
	[Name] [varchar](128) NOT NULL,
	[Especialidade_Id] [varchar](16) REFERENCES [Medicamentos_Especialidade] ([Id]) NOT NULL,
	[NumSNS] [varchar](64) NOT NULL,
	PRIMARY KEY([NumSNS])
)
GO

CREATE TABLE [Medicamentos_Paciente](
	[Name] [varchar](128) NOT NULL,
	[DataNascimento] [date] NOT NULL,
	[Endereco] [varchar](256) NOT NULL,
	[NumUtente] [varchar](16) NOT NULL,
	PRIMARY KEY([NumUtente])
)
GO

CREATE TABLE [Medicamentos_Farmacia](
	[NumTel] [varchar](9) NOT NULL,
	[Endereco] [varchar](256) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[NIF] [varchar](16) NOT NULL,
	PRIMARY KEY([NIF])
)
GO

CREATE TABLE [Medicamentos_Farmaceutica](
	[NumRegistoNacional] [varchar](64) NOT NULL,
	[NumTel] [varchar](9) NOT NULL,
	[Endereco] [varchar](256) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	PRIMARY KEY([NumRegistoNacional])
)
GO

CREATE TABLE [Medicamentos_Farmaco](
	[ComercialName] [varchar](256) NOT NULL,
	[Formula] [varchar](256) NOT NULL,
	[Farmaceutica_NumRegistoNacional] [varchar](64) REFERENCES [Medicamentos_Farmaceutica]([NumRegistoNacional]) NOT NULL,
	PRIMARY KEY([ComercialName])
)
GO

CREATE TABLE [Medicamentos_Prescricao](
	[Id] [varchar](16) NOT NULL,
	[Date] [date] NOT NULL,
	[Medico_NumSNS] [varchar](64) REFERENCES [Medicamentos_Medico] ([NumSNS]) NOT NULL,
	[Paciente_NumUtente] [varchar](16) REFERENCES [Medicamentos_Paciente](NumUtente) NOT NULL,
	[Farmacia_NIF] [varchar](16) REFERENCES [Medicamentos_Farmacia](NIF) NOT NULL,
	[Farmaco_ComercialName] [varchar](256) REFERENCES [Medicamentos_Farmaco](ComercialName) NOT NULL, 
	PRIMARY KEY([Id])
)
GO