--DROP TABLE [RentACar_Aluguer]
--GO
--DROP TABLE [RentACar_Balcao]
--GO
--DROP TABLE [RentACar_Cliente]
--GO
--DROP TABLE [RentACar_Ligeiro]
--GO
--DROP TABLE [RentACar_Pesado]
--GO
--DROP TABLE [RentACar_Veiculo]
--GO
--DROP TABLE [RentACar_TipoVeiculo]
--GO
--DROP TABLE [RentACar_Similaridade]
--GO

CREATE TABLE [RentACar_Cliente](
	[NIF] [varchar](9) NOT NULL,
	[Nome] [varchar](256) NOT NULL,
	[endere�o] [varchar](512) NOT NULL,
	[numCarta] [varchar](16) NOT NULL,
PRIMARY KEY ([NIF]))
GO

CREATE TABLE [RentACar_Balcao](
	[Numero] [int] NOT NULL,
	[Nome] [varchar](256) NOT NULL,
	[Endere�o] [varchar](512) NOT NULL,
PRIMARY KEY ([Numero]))
GO

CREATE TABLE [RentACar_TipoVeiculo](
	[Codigo] [varchar](16) NOT NULL,
	[ArCondicionado] [bit] NOT NULL,
	[Designacao] [varchar](256) NOT NULL,
PRIMARY KEY ([Codigo]))
GO

CREATE TABLE [RentACar_Veiculo](
	[Matricula] [varchar](8) NOT NULL,
	[Marca] [varchar](32) NOT NULL,
	[Ano] [int] NOT NULL,
	[TipoVeiculo_Codigo] [varchar](16) NOT NULL,
	PRIMARY KEY ([Matricula]),
	FOREIGN KEY ([TipoVeiculo_Codigo]) REFERENCES [RentACar_TipoVeiculo] ([Codigo]))
GO

CREATE TABLE [RentACar_Ligeiro](
	[NumLugares] [int] NOT NULL,
	[Portas] [int] NOT NULL,
	[Combustivel] [int] NOT NULL,
	[L_Codigo] [varchar](16) NOT NULL,
	PRIMARY KEY ([L_Codigo]), 
	FOREIGN KEY ([L_Codigo]) REFERENCES [RentACar_TipoVeiculo] ([Codigo]))
GO

CREATE TABLE [RentACar_Pesado](
	[Peso] [int] NOT NULL,
	[Passageiros] [int] NOT NULL,
	[P_Codigo] [varchar](16) NOT NULL,
	PRIMARY KEY ([P_Codigo]), 
	FOREIGN KEY ([P_Codigo]) REFERENCES [RentACar_TipoVeiculo] ([Codigo]))
GO

CREATE TABLE [RentACar_Similaridade](
	Codigo1 [varchar](16) NOT NULL REFERENCES [RentACar_TipoVeiculo] ([Codigo]),
	Codigo2 [varchar](16) NOT NULL REFERENCES [RentACar_TipoVeiculo] ([Codigo]),
	PRIMARY KEY ([Codigo1], [Codigo2]))
GO

CREATE TABLE [RentACar_Aluguer](
	[Numero] [int] NOT NULL PRIMARY KEY,
	[Duracao] [varchar](10) NOT NULL,
	[Data] [varchar](10) NOT NULL,
	[Cliente_NIF] [varchar](9) NOT NULL,
	[Balcao_Numero] [int] NOT NULL REFERENCES [RentACar_Balcao] ([Numero]),
	[Veiculo_Matricula] [varchar](8) REFERENCES [RentACar_Veiculo] ([Matricula]),
	FOREIGN KEY ([Cliente_NIF]) REFERENCES [RentACar_Cliente] ([NIF]))
GO
