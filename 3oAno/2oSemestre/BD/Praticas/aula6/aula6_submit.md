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
SELECT	au_fname AS first_name,
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

// confirmar a partir daqui com o rafa
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
SELECT t.title, t.ytd_sales, 
	ROUND((t.ytd_sales * t.price),3) AS totalRevenue,
	ROUND(SUM(t.ytd_sales*t.price*t.royalty/100*ta.royaltyper/100),3) AS authorRevenue, 
	ROUND((t.ytd_sales * t.price) - SUM(t.ytd_sales*t.price*t.royalty/100*ta.royaltyper/100),3) AS publisherRevenue
FROM titles t
	INNER JOIN titleauthor ta ON t.title_id = ta.title_id
	INNER JOIN authors a ON ta.au_id = a.au_id
GROUP BY t.title, t.ytd_sales, t.price
ORDER BY t.title
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
... Write here your answer ...
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
... Write here your answer ...
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
... Write here your answer ...
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
... Write here your answer ...
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```

##### *c)* 

```
... Write here your answer ...
```

##### *d)* 

```
... Write here your answer ...
```

##### *e)* 

```
... Write here your answer ...
```

##### *f)* 

```
... Write here your answer ...
```

##### *g)* 

```
... Write here your answer ...
```

##### *h)* 

```
... Write here your answer ...
```

##### *i)* 

```
... Write here your answer ...
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```


##### *c)* 

```
... Write here your answer ...
```


##### *d)* 

```
... Write here your answer ...
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](6_2_3_Prescricao/Prescricao_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](6_2_3_Prescricao/Prescricao_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
... Write here your answer ...
```

##### *b)* 

```
... Write here your answer ...
```


##### *c)* 

```
... Write here your answer ...
```


##### *d)* 

```
... Write here your answer ...
```

##### *e)* 

```
... Write here your answer ...
```

##### *f)* 

```
... Write here your answer ...
```
