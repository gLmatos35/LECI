--a)
--SELECT * FROM authors;

--b)
--SELECT au_fname, au_lname, phone FROM authors;

--c)
--SELECT au_fname, au_lname, phone 
--FROM authors
--ORDER BY au_fname, au_lname;

--d)
--SELECT	au_fname AS first_name,
--		au_lname AS last_name,
--		phone AS telephone
--FROM authors
--ORDER BY au_fname, au_lname;

--e)
--SELECT	au_fname AS first_name,
--		au_lname AS last_name,
--		phone AS telephone
--FROM authors
--WHERE [state] = 'CA' and au_lname != 'Ringer'
--ORDER BY au_fname, au_lname;

--f)
--SELECT * FROM publishers
--WHERE pub_name LIKE '%Bo%';

-- Teste
--SELECT * FROM publishers
--SELECT [type] FROM titles;

--g)
--SELECT DISTINCT p.pub_id, pub_name, city, [state], country 
--FROM publishers p
--JOIN titles t ON p.pub_id = t.pub_id
--WHERE t.[type] = 'Business';

--h)
--SELECT p.pub_id, p.pub_name, SUM(t.ytd_sales) AS sales
--FROM publishers p
--JOIN titles t ON p.pub_id = t.pub_id
--GROUP BY p.pub_id, p.pub_name;

--i)
--SELECT p.pub_name, t.title, SUM(t.ytd_sales) AS sales
--FROM publishers p
--JOIN titles t ON p.pub_id = t.pub_id
--GROUP BY t.title, p.pub_name;

--j)
--SELECT p.pub_id, p.pub_name, t.title, st.stor_name
--FROM publishers p
--JOIN titles t ON p.pub_id = t.pub_id
--JOIN sales sl ON t.title_id = sl.title_id
--JOIN stores st ON sl.stor_id = st.stor_id
--WHERE st.stor_name = 'Bookbeat'

--k)
--SELECT a.au_fname, a.au_lname, COUNT(t.type) AS NumTypes
--	FROM authors a
--	JOIN titleauthor ta ON a.au_id = ta.au_id
--	JOIN titles t ON ta.title_id = t.title_id
--	JOIN publishers p ON t.pub_id = p.pub_id
--GROUP BY a.au_fname, a.au_lname
--HAVING COUNT(DISTINCT t.[type]) > 1

--l)
--SELECT t.type, p.pub_id, AVG(t.price) AS AveragePrice, SUM(t.ytd_sales) AS NumSales
--	FROM titles t
--	JOIN publishers p ON t.pub_id = p.pub_id
--GROUP BY t.type, p.pub_id

--m)
