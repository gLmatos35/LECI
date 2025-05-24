CREATE TABLE [Stocks_Empresa](
	[Codigo] [varchar](32) NOT NULL,
	PRIMARY KEY ([Codigo])
)
GO

CREATE TABLE [Stocks_TipoFornecedor](
	[Codigo] [varchar](32) NOT NULL,
	[Designacao] [varchar](16) NOT NULL,
	PRIMARY KEY ([Codigo])
)
GO

CREATE TABLE [Stocks_CondicoesPagamento](
	[Codigo] [varchar](32) NOT NULL,
	[Designacao] [varchar](16) NOT NULL,
	PRIMARY KEY ([Codigo])
)
GO

CREATE TABLE [Stocks_Fornecedor](
    [email] [varchar](64) UNIQUE NOT NULL,
    [nome] [varchar](64) NOT NULL,
	[NIF] [varchar](9) NOT NULL,
	[Tipo_fornecedor] [varchar](32) NOT NULL,
	[CondicoesPagamento] [varchar](32) NOT NULL,
	FOREIGN KEY ([CondicoesPagamento]) REFERENCES [Stocks_CondicoesPagamento] ([Codigo]),
	FOREIGN KEY ([Tipo_fornecedor]) REFERENCES [Stocks_TipoFornecedor] ([Codigo]),
	PRIMARY KEY ([NIF])
)
GO

CREATE TABLE [Stocks_Produto](
	[preco] DECIMAL(5, 2) NOT NULL,
    [nome] [varchar](64) NOT NULL,
	[Codigo] [varchar](32) NOT NULL,
	[Taxa_IVA] [varchar](16) NOT NULL,
	[Empresa_ID] [varchar](32) NOT NULL,
	FOREIGN KEY ([Empresa_ID]) REFERENCES [Stocks_Empresa] ([Codigo]),
	PRIMARY KEY ([Codigo])
)
GO

CREATE TABLE [Stocks_Encomenda](
	[Numero_encomenda] [varchar](32) NOT NULL,
	[data] [date] NOT NULL,
    [Fornecedor] [varchar](9) NOT NULL,
	FOREIGN KEY ([Fornecedor]) REFERENCES [Stocks_Fornecedor] ([NIF]),
	PRIMARY KEY([Numero_encomenda])
)
GO

CREATE TABLE [Stocks_EncomendaProduto](
	[Numero_encomenda] [varchar](32) NOT NULL,
	[Codigo] [varchar](32) NOT NULL,
	[quantidade] [int] NOT NULL,
	FOREIGN KEY ([Numero_encomenda]) REFERENCES [Stocks_Encomenda] ([Numero_encomenda]),
	FOREIGN KEY ([Codigo]) REFERENCES [Stocks_Produto] ([Codigo]),
	PRIMARY KEY ([Numero_encomenda], [Codigo])
)
GO

CREATE TABLE [Stocks_Armazem](
	[Codigo] [varchar](32) NOT NULL,
	PRIMARY KEY ([Codigo])
)
GO

CREATE TABLE [Stocks_ProdutoArmazem](
    [CodigoProduto] [varchar](32) NOT NULL,
    [CodigoArmazem] [varchar](32) NOT NULL,
    [quantidade] [int] NOT NULL,
    FOREIGN KEY ([CodigoProduto]) REFERENCES [Stocks_Produto] ([Codigo]),
    FOREIGN KEY ([CodigoArmazem]) REFERENCES [Stocks_Armazem] ([Codigo]),
    PRIMARY KEY ([CodigoProduto], [CodigoArmazem])
);