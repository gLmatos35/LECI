CREATE TABLE [Conferencia_Instituicao](
	[Name] varchar(128) NOT NULL,
	[Endereco] varchar(256) NOT NULL,
	PRIMARY KEY([Name])
)
GO

CREATE TABLE [Conferencia_Autor](
	[Name] varchar(128) NOT NULL,
	[Email] varchar(256) NOT NULL,
	[Instituicao_Name] varchar(128) REFERENCES [Conferencia_Instituicao]([Name]) NOT NULL,
	PRIMARY KEY([Email])
)
GO

CREATE TABLE [Conferencia_Artigo](
	[NumRegisto] [varchar](32) NOT NULL,
	[Titulo] varchar(256) NOT NULL,
	[Autor_Email] varchar(256) REFERENCES Conferencia_Autor(Email) NOT NULL,
	PRIMARY KEY([NumRegisto])
)
GO

CREATE TABLE [Conferencia_Comprovativo](
	[Id] [varchar](16) NOT NULL,
	[LocalizacaoEletr] [varchar](64) NOT NULL,
	PRIMARY KEY ([Id])
)
GO

CREATE TABLE [Conferencia_Conferencia](
	[Artigo_NumRegisto] [varchar](32) REFERENCES [Conferencia_Artigo] ([NumRegisto]) NOT NULL,
	PRIMARY KEY([Artigo_NumRegisto])
)
GO

CREATE TABLE [Conferencia_Inscricao](
	[Id] [varchar](64) NOT NULL,
	[Date] [date] NOT NULL,
	[Custo] [int] NOT NULL,
	PRIMARY KEY([Id],[Date])
)
GO

CREATE TABLE [Conferencia_Participante](
	[Email] [varchar](256) NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[Morada] [varchar](256) NOT NULL,
	[Inscricao_Date] [date] NOT NULL,
	[Inscricao_Id] [varchar](64) NOT NULL,
	PRIMARY KEY([Email]),
	FOREIGN KEY([Inscricao_Id],[Inscricao_Date]) REFERENCES [Conferencia_Inscricao] ([Id],[Date]) 
)
GO

CREATE TABLE [Conferencia_NaoEstudante](
	[Name] [varchar](256) NOT NULL,
	[Morada] [varchar](256) NOT NULL,
	[Inscricao_Date] [date] NOT NULL,
	[Participante_Email] [varchar](256) REFERENCES [Conferencia_Participante](Email) NOT NULL,
	[Inscricao_Id] [varchar](64) NOT NULL,
	PRIMARY KEY([Participante_Email]),
	FOREIGN KEY([Inscricao_Id],[Inscricao_Date]) REFERENCES [Conferencia_Inscricao] ([Id],[Date])
)
GO

CREATE TABLE [Conferencia_Estudante](
	[Name] [varchar](256) NOT NULL,
	[Morada] [varchar](256) NOT NULL,
	[Inscricao_Date] [date] NOT NULL,
	[Participante_Email] [varchar](256) REFERENCES [Conferencia_Participante](Email) NOT NULL,
	[Instituicao_Name] varchar(128) REFERENCES [Conferencia_Instituicao]([Name]) NOT NULL,
	[Inscricao_Id] [varchar](64) NOT NULL,
	[Comprovativo_id] [varchar](16) REFERENCES [Conferencia_Comprovativo]([Id]) NOT NULL,
	PRIMARY KEY([Participante_Email]),
	FOREIGN KEY([Inscricao_Id],[Inscricao_Date]) REFERENCES [Conferencia_Inscricao] ([Id],[Date])
)
GO