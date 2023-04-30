USE pizza;

SELECT COUNT(*) AS 'Total_pizzas' FROM MENU;

SELECT COUNT(DISTINCT country) AS 'Origins' FROM MENU;

SELECT MIN(price) AS 'Cheapest_Italian' FROM MENU WHERE country='Italy';

SELECT SUM(price) AS 'Margherita_Vegetarian' FROM MENU WHERE pizza='margherita' OR pizza='vegetarian';

SELECT MIN(price) AS 'MIN_PRICE', MAX(price) AS 'MAX_PRICE', AVG(price) AS 'AVG_PRICE' FROM MENU;

SELECT COUNT(*) AS 'no of wheat mix' FROM MENU WHERE base='wholemeal';

SELECT COUNT(*) AS 'no_origin' FROM MENU WHERE country IS NULL;

SELECT CAST(ROUND(AVG(price) * 50 * 0.3, 2) AS decimal(7,2)) AS profit FROM MENU;


SELECT RECIPES.ingredient,ITEMS.type FROM RECIPES INNER JOIN ITEMS ON RECIPES.ingredient=ITEMS.ingredient WHERE RECIPES.pizza='margherita';

SELECT ITEMS.ingredient,RECIPES.pizza FROM ITEMS INNER JOIN RECIPES ON RECIPES.ingredient=ITEMS.ingredient WHERE ITEMS.type='fish';

SELECT ITEMS.ingredient,RECIPES.pizza FROM ITEMS INNER JOIN RECIPES ON RECIPES.ingredient=ITEMS.ingredient WHERE ITEMS.type='meat';

SELECT m1.pizza FROM MENU m1 JOIN MENU m2 ON m1.country = m2.country WHERE m2.pizza='siciliano' and m1.pizza <> 'siciliano'; 

SELECT m1.pizza FROM MENU m1 JOIN MENU m2 ON m1.price > m2.price WHERE m2.pizza='quattro stagioni' and m1.pizza <> 'quattro stagioni';

SELECT ITEMS.ingredient,RECIPES.pizza FROM ITEMS  LEFT OUTER JOIN RECIPES ON ITEMS.ingredient=RECIPES.ingredient  WHERE ITEMS.type='fish'  ORDER BY ITEMS.ingredient,RECIPES.pizza;

SELECT DISTINCT ITEMS.type FROM ITEMS INNER JOIN RECIPES ON RECIPES.ingredient=ITEMS.ingredient INNER JOIN MENU ON RECIPES.pizza=MENU.pizza WHERE MENU.country='Canada' OR MENU.country='Mexico' OR MENU.country='U.S.';

SELECT MENU.pizza FROM MENU INNER JOIN RECIPES ON RECIPES.pizza=MENU.pizza INNER JOIN ITEMS ON ITEMS.ingredient=RECIPES.ingredient WHERE MENU.base='wholemeal' AND ITEMS.type='fruit';