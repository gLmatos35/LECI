# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * FROM authors;
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT au_fname, au_lname, phone FROM authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT au_fname, au_lname, phone 
FROM authors
ORDER BY au_fname, au_lname;
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT	au_fname AS first_name,
		au_lname AS last_name,
		phone AS telephone
FROM authors
ORDER BY au_fname, au_lname;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT au_fname AS first_name,
		au_lname AS last_name,
		phone AS telephone
FROM authors
WHERE [state] = 'CA' and au_lname != 'Ringer'
ORDER BY au_fname, au_lname;
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT * FROM publishers
WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT DISTINCT p.pub_id, pub_name, city, [state], country 
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
WHERE t.[type] = 'Business';
```

### *h)* Número total de vendas de cada editora; 

```
SELECT p.pub_id, p.pub_name, SUM(t.ytd_sales) AS sales
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
GROUP BY p.pub_id, p.pub_name;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT p.pub_name, t.title, SUM(t.ytd_sales) AS sales
FROM publishers p
	JOIN titles t ON p.pub_id = t.pub_id
GROUP BY t.title, p.pub_name;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT p.pub_id, p.pub_name, t.title, st.stor_name
FROM publishers p
	JOIN titles t ON p.pub_id = t.pub_id
	JOIN sales sl ON t.title_id = sl.title_id
	JOIN stores st ON sl.stor_id = st.stor_id
WHERE st.stor_name = 'Bookbeat'
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT a.au_fname, a.au_lname, COUNT(t.type) AS NumTypes
	FROM authors a
	JOIN titleauthor ta ON a.au_id = ta.au_id
	JOIN titles t ON ta.title_id = t.title_id
	JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY a.au_fname, a.au_lname
HAVING COUNT(DISTINCT t.[type]) > 1
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT t.type, p.pub_id, AVG(t.price) AS AveragePrice, SUM(t.ytd_sales) AS NumSales
	FROM titles t
	JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY t.type, p.pub_id
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT t.type, MAX(t.advance) AS max_advance, AVG(t.advance) AS avg_advance
FROM titles t
GROUP BY t.type
HAVING MAX(t.advance) > 1.5 * AVG(t.advance);
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT t.title, a.au_fname, a.au_lname,
	SUM(t.ytd_sales*t.price*t.royalty/100*ta.royaltyper/100) AS authorEarnings
FROM titles t
	JOIN titleauthor ta ON t.title_id = ta.title_id
	JOIN authors a ON ta.au_id = a.au_id
GROUP BY t.title, a.au_fname, a.au_lname
ORDER BY t.title;
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
SELECT title, ytd_sales, ytd_sales*price AS total_earnings, ytd_sales*price * royalty / 100 AS author_earnings, ytd_sales*price - (ytd_sales*price * royalty / 100) AS publisher_earnings
FROM titles
ORDER BY title;
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT t.title, t.ytd_sales, CONCAT(a.au_fname,' ',a.au_lname) AS author, 
	ROUND(SUM(t.ytd_sales*t.price*t.royalty/100*ta.royaltyper/100),3) AS authorRevenue,
	ROUND((t.ytd_sales * t.price) - SUM(t.ytd_sales*t.price*t.royalty/100),3) AS publisherRevenue
FROM titles t
	INNER JOIN titleauthor ta ON t.title_id = ta.title_id
	INNER JOIN authors a ON ta.au_id = a.au_id
GROUP BY t.title, t.ytd_sales, a.au_fname, a.au_lname, t.price;
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT stor_id
FROM sales
GROUP BY stor_id
HAVING COUNT(DISTINCT(title_id)) >= (SELECT COUNT(title_id) FROM titles);
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
SELECT stor_id FROM sales
GROUP BY stor_id
HAVING SUM(qty) > (SELECT AVG(sum_qty) AS avg_all_stores FROM (SELECT stor_id, SUM(qty) AS sum_qty FROM sales GROUP BY stor_id) A);
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
SELECT title FROM titles
EXCEPT
SELECT t.title
FROM titles t
JOIN sales s ON t.title_id = s.title_id
JOIN stores st ON s.stor_id = st.stor_id
WHERE stor_name = 'Bookbeat';
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
(SELECT pub_name, stor_name
FROM stores, publishers)
EXCEPT
(SELECT p.pub_name, s.stor_name  
FROM publishers p
JOIN titles t ON p.pub_id = t.pub_id
JOIN sales sa ON t.title_id = sa.title_id
JOIN stores s ON sa.stor_id = s.stor_id)
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](6_2_1_Company/Company_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](6_2_1_Company/Company_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT DISTINCT (Fname + ' ' + Minit + ' ' + Lname) AS nome, ssn
FROM Employee 
	JOIN Works_On ON Ssn = Essn 
	JOIN Project ON Pno = Pnumber;
```

##### *b)* 

```
SELECT (Fname + ' ' + Minit + ' ' + Lname) AS nome
FROM Employee
WHERE Super_ssn = (
SELECT Ssn
FROM Employee
WHERE Fname='Carlos' AND Minit='D' AND Lname='Gomes');
```

##### *c)* 

```
SELECT Pname, SUM(Hours)
FROM Employee
JOIN Works_ON ON Ssn=Essn
JOIN Project ON Pnumber = Pno
GROUP BY Pname
```

##### *d)* 

```
SELECT (Fname + ' ' + Minit + ' ' + Lname) AS nome
FROM Employee 
JOIN Works_On ON Ssn=Essn
JOIN Project ON Pno=Pnumber
WHERE Dno=3 AND Pname='Aveiro Digital' AND Hours > 20;
```

##### *e)* 

```
SELECT (Fname + ' ' + Minit + ' ' + Lname) AS nome
FROM Employee
FULL OUTER JOIN Works_On ON Ssn=Essn
WHERE Hours IS NULL;
```

##### *f)* 

```
SELECT Dname, AVG(Salary)
FROM Department
JOIN Employee ON Dnumber = Dno
WHERE Sex = 'F'
GROUP BY Dname;
```

##### *g)* 

```
SELECT (Fname + ' ' + Minit + ' ' + Lname) AS nome
FROM Employee 
JOIN Dependents ON Ssn = Essn
GROUP BY Ssn, Fname, Minit, Lname
HAVING COUNT(*) > 2;
```

##### *h)* 

```
SELECT Fname, Minit, Lname, Ssn
FROM Employee 
WHERE Ssn IN (
    SELECT Mgr_ssn FROM Department 
)
AND Ssn NOT IN (
    SELECT Essn FROM Dependents  
);
```

##### *i)* 

```
SELECT DISTINCT Fname,Minit,Lname,Address,Dlocation,Plocation
FROM Employee
	INNER JOIN Department
		ON Dno = Dnumber
	INNER JOIN Project
		ON Dnumber = Dnum
	INNER JOIN Dept_Locations
		ON Department.Dnumber = Dept_Locations.Dnumber
WHERE Plocation = 'Aveiro' AND Dlocation != 'Aveiro'
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](6_2_2_Stocks/Stocks_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](6_2_2_Stocks/Stocks_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT *
FROM Fornecedor
	FULL OUTER JOIN Encomenda
		ON Fornecedor=Nif
WHERE Numero IS NULL;
```

##### *b)* 

```
SELECT nome, AVG(Item.Unidades) AS AvgEncom FROM produto
	JOIN Item ON Codigo = CodProd
GROUP BY Nome;
```


##### *c)* 

```
SELECT 
	COUNT(codProd) * 1.0 / COUNT(DISTINCT numEnc) AS media_produtos_por_encomenda
FROM item;
```


##### *d)* 

```
SELECT Fornecedor.Nome, Produto.Nome, SUM(Item.Unidades) AS ProvidedUnits FROM Encomenda
	JOIN Fornecedor ON Fornecedor=Nif 
	JOIN Item ON NumEnc=Numero
	JOIN Produto ON Codigo=CodProd
GROUP BY Fornecedor.Nome, Produto.Nome;
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](6_2_3_Prescricao/Prescricao_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](6_2_3_Prescricao/Prescricao_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT nome,pa.numUtente,dataNasc,endereco
FROM Prescricao_paciente pa
	FULL OUTER JOIN Prescricao_prescricao pr ON pa.numUtente = pr.numUtente
WHERE numPresc IS NULL;
```

##### *b)* 

```
SELECT especialidade, COUNT(numPresc) AS numPrescricoes
FROM Prescricao_medico m
	INNER JOIN Prescricao_prescricao pr
		ON numSNS = numMedico
GROUP BY especialidade
```


##### *c)* 

```
SELECT farmacia.nome, COUNT(numPresc) AS numPrescricoes
FROM Prescricao_prescricao presc
	INNER JOIN Prescricao_farmacia farmacia
		ON presc.farmacia = farmacia.nome
GROUP BY farmacia.nome;
```


##### *d)* 

```
SELECT nomeFarmaco, numRegFarm, presc.numPresc, dataProc
FROM Prescricao_farmaceutica farmaceutica
	FULL OUTER JOIN presc_farmaco pfarm
		ON farmaceutica.numReg = pfarm.numRegFarm
	FULL OUTER JOIN Prescricao_prescricao presc
		ON pfarm.numPresc = presc.numPresc
WHERE numReg = 906 AND dataProc IS NULL;
```

##### *e)* 

```
SELECT farmacia.nome, farmaceutica.nome, COUNT(presc.numPresc) AS numFarmacosVendidos
FROM Prescricao_farmacia farmacia
	INNER JOIN Prescricao_prescricao presc
		ON farmacia.nome = presc.farmacia
	INNER JOIN presc_farmaco pfarm
		ON presc.numPresc = pfarm.numPresc
	INNER JOIN Prescricao_farmaceutica farmaceutica
		ON pfarm.numRegFarm = farmaceutica.numReg
GROUP BY farmacia.nome, farmaceutica.nome;
```

##### *f)* 

```
SELECT paciente.nome, paciente.numUtente, COUNT(DISTINCT numSNS) AS numMedicos
FROM Prescricao_paciente paciente
	INNER JOIN Prescricao_prescricao presc
		ON paciente.numUtente = presc.numUtente
	INNER JOIN Prescricao_medico medico
		ON presc.numMedico = medico.numSNS
GROUP BY paciente.nome, paciente.numUtente
HAVING COUNT(DISTINCT medico.numSNS) > 1;
```
