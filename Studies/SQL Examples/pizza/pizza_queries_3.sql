USE pizza

--SELECT * FROM MENU
--SELECT * FROM RECIPES
--SELECT * FROM ITEMS
--Æw.1
--1
SELECT country, CAST(ROUND(AVG(price),2) as decimal(7,2))  as avg_price FROM MENU
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
SELECT country, CAST(ROUND(AVG(price),2) as decimal(7,2)) as avg_price FROM MENU
GROUP BY country
HAVING COUNT(pizza) != 1 AND country IS NOT NULL

--5
SELECT country, CAST(ROUND(AVG(price),2) as decimal(7,2)) as avg_price FROM MENU
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
SELECT DISTINCT pizza FROM RECIPES
WHERE (SELECT type FROM ITEMS
WHERE RECIPES.ingredient = ITEMS.ingredient) = 'meat'
--3
SELECT DISTINCT ingredient, pizza, amount FROM RECIPES t1
WHERE amount = (SELECT MAX(amount) FROM RECIPES t2
WHERE t1.ingredient = t2.ingredient)

--4
SELECT DISTINCT ingredient FROM RECIPES t1
WHERE (SELECT COUNT(ingredient) FROM RECIPES t2
WHERE t1.ingredient = t2.ingredient) > 1
--5
SELECT DISTINCT pizza FROM RECIPES 
WHERE (SELECT country FROM MENU 
WHERE RECIPES.pizza = MENU.pizza) = 
(SELECT country FROM MENU
WHERE pizza = 'siciliano')

EXCEPT

SELECT DISTINCT pizza FROM RECIPES 
WHERE pizza = 'siciliano'


--6
SELECT DISTINCT ingredient FROM ITEMS
WHERE 1 > (SELECT COUNT(ingredient) FROM RECIPES 
WHERE items.ingredient = recipes.ingredient)

--7
SELECT DISTINCT ingredient FROM RECIPES t1
WHERE 1 < (SELECT COUNT(ingredient) FROM RECIPES t2
WHERE t1.ingredient = t2.ingredient)

--8
SELECT DISTINCT pizza,price FROM MENU t1
WHERE (SELECT price FROM MENU t2
WHERE t1.pizza = t2.pizza) BETWEEN 
(SELECT price FROM MENU
WHERE pizza = 'garlic') AND 
(SELECT price FROM MENU
WHERE pizza = 'napoletana')

EXCEPT

SELECT DISTINCT pizza,price FROM MENU t1
WHERE (SELECT price FROM MENU t2
WHERE t1.pizza = t2.pizza) =
(SELECT price FROM MENU
WHERE pizza = 'garlic') 
OR
(SELECT price FROM MENU t2
WHERE t1.pizza = t2.pizza) =
(SELECT price FROM MENU
WHERE pizza = 'napoletana')


--9
SELECT TOP 1 pizza,
  (SELECT COUNT(pizza)  FROM RECIPES
  WHERE RECIPES.pizza = MENU.pizza) AS number
  FROM MENU
  ORDER BY number DESC



--10
SELECT DISTINCT type FROM ITEMS
JOIN RECIPES ON ITEMS.ingredient = RECIPES.ingredient
JOIN MENU ON MENU.pizza = RECIPES.pizza
WHERE MENU.pizza = (SELECT pizza FROM MENU
WHERE price = (SELECT MAX(price) FROM MENU))

