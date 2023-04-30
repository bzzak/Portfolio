USE pizza;

SELECT * FROM MENU
SELECT * FROM RECIPES
SELECT * FROM ITEMS
--Æw.1
--1
SELECT country, AVG(price)  as avg_price FROM MENU
GROUP BY country
HAVING country IS NOT NULL
--2
SELECT country, MAX(price) as max_price FROM MENU
GROUP BY country
HAVING country IS NOT NULL
--3
SELECT country, MIN(price) as min_price FROM MENU
GROUP BY country
HAVING country IS NOT NULL

--4
SELECT country, AVG(price) as avg_price FROM MENU
GROUP BY country
HAVING COUNT(pizza) != 1 AND country IS NOT NULL

--5
SELECT country, AVG(price) as avg_price FROM MENU
GROUP BY country
HAVING country LIKE '%i%' AND country IS NOT NULL
--6
SELECT country, MIN(price) as min_price FROM MENU
GROUP BY country
HAVING country IS NOT NULL AND MIN(price) < 7.50

--Æw.2

--1
SELECT pizza, price FROM MENU
WHERE price > (SELECT MAX(price) FROM MENU 
WHERE country = 'Italy')

--2
--SELECT DISTINCT pizza FROM RECIPES
--WHERE (SELECT 1 FROM RECIPES
--WHERE ingredient = 'ham') >= 1
--3
--SELECT ingredient FROM RECIPES
--WHERE 

