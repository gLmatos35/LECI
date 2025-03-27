CREATE TABLE [ATL_Professor](
	[dataNascimento] [date] NOT NULL,
	[CC] [varchar](10) UNIQUE NOT NULL,
	[nome] [varchar](64) NOT NULL,
	[email] [varchar](64) UNIQUE NOT NULL ,
	[numTelemovel] [varchar](9) NOT NULL,
	[morada] [varchar](128) NOT NULL,
	[numFuncionario] [varchar](10) NOT NULL,
	PRIMARY KEY([numFuncionario])
)
GO

CREATE TABLE [ATL_Turma](
	[Identificador] [varchar](16) NOT NULL,
	[Designacao] [varchar](16) NOT NULL,
	[AnoLetivo] [varchar](16) NOT NULL,
	[MaxAlunos] [int] NOT NULL,
	[Professor] [varchar](10) NOT NULL,
	FOREIGN KEY ([Professor]) REFERENCES [ATL_Professor] ([numFuncionario]),
	PRIMARY KEY([Identificador])
)
GO

CREATE TABLE [ATL_Atividade](
	[Identificador] [varchar](16) NOT NULL,
	[Designacao] [varchar](16) NOT NULL,
	[Custo] [int] NOT NULL,
	PRIMARY KEY([Identificador])
)
GO

CREATE TABLE [ATL_ParticipaTurma](
	[Identificador_turma] [varchar](16) NOT NULL,
	[Identificador_atividade] [varchar](16) NOT NULL,
	FOREIGN KEY ([Identificador_turma]) REFERENCES [ATL_Turma] ([Identificador]),
	FOREIGN KEY ([Identificador_atividade]) REFERENCES [ATL_Atividade] ([Identificador]),
	PRIMARY KEY ([Identificador_turma], [Identificador_atividade])
)
GO
CREATE TABLE [ATL_Pessoa](
    [CC] [varchar](10) NOT NULL,
    [nome] [varchar](64) NOT NULL,
    [morada] [varchar](128) NOT NULL,
    [dataNascimento] [date] NOT NULL,
    [email] [varchar](64) UNIQUE NOT NULL,
    [numTelemovel] [varchar](9) NOT NULL,
    PRIMARY KEY([CC])
);
GO

CREATE TABLE [ATL_EncarregadoEducacao](
    [CC] [varchar](10) NOT NULL,
    [RelacaoComAluno] [varchar](32) NOT NULL, 
    PRIMARY KEY([CC]),
    FOREIGN KEY ([CC]) REFERENCES [ATL_Pessoa] ([CC])
);
GO

CREATE TABLE [ATL_PessoaAutorizada](
    [CC] [varchar](10) NOT NULL,
    PRIMARY KEY([CC]),
    FOREIGN KEY ([CC]) REFERENCES [ATL_Pessoa] ([CC])
);
GO

CREATE TABLE [ATL_Aluno](
    [CC] [varchar](10) NOT NULL,
    [nome] [varchar](64) NOT NULL,
    [morada] [varchar](128) NOT NULL,
    [dataNascimento] [date] NOT NULL,
    [turma] [varchar](16) NOT NULL,
    [EncEducacao] [varchar](10) NOT NULL, 
    FOREIGN KEY ([turma]) REFERENCES [ATL_Turma] ([Identificador]),
    FOREIGN KEY ([EncEducacao]) REFERENCES [ATL_EncarregadoEducacao] ([CC]),
    PRIMARY KEY([CC])
);
GO

CREATE TABLE [ATL_Aluno_PessoaAutorizada](
    [CC_Aluno] [varchar](10) NOT NULL,
    [CC_PessoaAutorizada] [varchar](10) NOT NULL,
    PRIMARY KEY ([CC_Aluno], [CC_PessoaAutorizada]),
    FOREIGN KEY ([CC_Aluno]) REFERENCES [ATL_Aluno] ([CC]),
    FOREIGN KEY ([CC_PessoaAutorizada]) REFERENCES [ATL_PessoaAutorizada] ([CC])
);
GO

CREATE TABLE [ATL_ParticipaAluno](
	[Identificador_aluno] [varchar](10) NOT NULL,
	[Identificador_atividade] [varchar](16) NOT NULL,
	FOREIGN KEY ([Identificador_aluno]) REFERENCES [ATL_Aluno] ([CC]),
	FOREIGN KEY ([Identificador_atividade]) REFERENCES [ATL_Atividade] ([Identificador]),
	PRIMARY KEY ([Identificador_aluno], [Identificador_atividade])
)
GO