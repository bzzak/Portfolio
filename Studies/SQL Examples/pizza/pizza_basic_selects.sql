USE pizza;

SELECT * FROM MENU
ORDER BY pizza ASC;

SELECT pizza, price FROM MENU
ORDER BY price DESC, pizza ASC;

SELECT DISTINCT price FROM MENU
ORDER BY price ASC;

SELECT * FROM MENU
WHERE price < 7.00 AND country='Italy';

SELECT * FROM MENU
WHERE country != 'Italy' AND country != 'U.S.' OR country is NULL;

SELECT * FROM MENU
WHERE pizza = 'americano' OR pizza = 'garlic' 
	  OR pizza = 'mexicano' OR pizza = 'vegetarian';

SELECT * FROM MENU
WHERE price BETWEEN 6.00 and 7.00;

SELECT * FROM MENU
WHERE pizza LIKE '%ano';

SELECT * FROM MENU
WHERE country IS NOT NULL;

SELECT DISTINCT amount FROM RECIPES
ORDER BY amount;


