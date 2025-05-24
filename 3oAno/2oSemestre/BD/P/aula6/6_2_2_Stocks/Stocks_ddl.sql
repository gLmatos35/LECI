create schema Stocks;
go

create table Tipo_fornecedor(
	Codigo INT NOT NULL,
	Designacao VARCHAR(25),
	PRIMARY KEY (Codigo)
);

create table Fornecedor(
	Nif INT NOT NULL,
	Nome VARCHAR(30),
	Fax INT NOT NULL,
	Endereco VARCHAR(50),
	Condpag INT,
	Tipo INT NOT NULL,
	PRIMARY KEY (Nif),
	FOREIGN KEY (Tipo) REFERENCES  Tipo_fornecedor(Codigo)
);

create table Produto(
	Codigo INT NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Preco INT NOT NULL CHECK(Preco>=0),
	Iva INT NOT NULL CHECK(Iva>=0 and Iva<=100),
	Unidades INT NOT NULL CHECK(Unidades>0),
	PRIMARY KEY (Codigo)
);

create table Encomenda(
	Numero INT NOT NULL,
	Dataa DATE,
	Fornecedor INT NOT NULL,
	PRIMARY KEY (Numero),
	FOREIGN KEY (Fornecedor) REFERENCES  Fornecedor(Nif)
);

create table Item(
	NumEnc INT NOT NULL,
	CodProd INT NOT NULL,
	Unidades INT NOT NULL,
	PRIMARY KEY (NumEnc,CodProd),
	FOREIGN KEY (NumEnc) REFERENCES  Encomenda(Numero),
	FOREIGN KEY (CodProd) REFERENCES  Produto(Codigo)
);