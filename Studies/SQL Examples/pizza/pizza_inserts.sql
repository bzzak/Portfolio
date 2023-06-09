USE pizza;

INSERT INTO MENU (pizza, price, country, base)
VALUES ('americano', 7.40, 'U.S.', 'wholemeal'),
	   ('frutti di mare', 9.20, 'Italy', 'wholemeal'),
	   ('funghi', 7.30, 'Italy', 'wholemeal'),
	   ('garlic', 3.50, NULL, 'wholemeal'),
	   ('ham', 7.30, NULL, 'white flour'),
	   ('hawaiian', 7.40, 'Canada', 'wholemeal'),
	   ('margherita', 6.20, 'Italy', 'white flour'),
	   ('mexicano', 7.40, 'Mexico', 'white flour'),
	   ('napoletana', 7.40, 'Italy', 'white flour'),
	   ('quattro stagioni', 7.80, 'Italy', 'wholemeal'),
	   ('siciliano', 7.40, 'Italy', 'wholemeal'),
	   ('special', 9.90, NULL, 'white flour'),
	   ('vegetarian', 7.40, NULL, 'wholemeal'),
	   ('viennese', 7.40, 'Italy', 'white flour');

INSERT INTO ITEMS (ingredient, type)
VALUES ('anchovies', 'fish'),
	   ('bacon', 'meat'),
	   ('capsicum', 'veg'),
	   ('cheese', 'dairy'),
	   ('chilli', 'spice'),
	   ('egg', 'dairy'),
	   ('garlic', 'spice'),
	   ('German sausage', 'meat'),
	   ('ham', 'meat'),
	   ('mushroom', 'veg'),
	   ('olives', 'veg'),
	   ('onion', 'veg'),
	   ('peas', 'veg'),
	   ('pepperoni', 'meat'),
	   ('pineapple', 'fruit'),
	   ('prawn', 'fish'),
	   ('salami', 'meat'),
	   ('seafood', 'fish'),
	   ('spice', 'spice'),
	   ('tomato', 'veg');

INSERT INTO RECIPES (pizza, ingredient, amount)
VALUES ('americano','pepperoni',75),
	   ('americano','salami',120),
	   ('americano','spice',10),
	   ('frutti di mare','seafood',200),
	   ('frutti di mare','spice',5),
	   ('funghi','mushroom',100),
	   ('funghi','spice',5),
	   ('garlic','garlic',25),
	   ('garlic','spice',10),
	   ('ham','ham',150),
	   ('ham','spice',5),
	   ('hawaiian','ham', 100),
	   ('hawaiian','pineapple',100),
	   ('hawaiian','spice',5),
	   ('margherita','cheese',120),
	   ('margherita','spice',5),
	   ('mexicano','chilli',75),
	   ('mexicano','mushroom',25),
	   ('mexicano','onion',50),
	   ('mexicano','spice',20),
	   ('napoletana','anchovies',100),
	   ('napoletana','olives',75),
	   ('napoletana','spice',10),
	   ('quattro stagioni','anchovies',25),
	   ('quattro stagioni','ham',75),
	   ('quattro stagioni','mushroom',50),
	   ('quattro stagioni','olives',50),
	   ('quattro stagioni','spice',10),
	   ('siciliano','anchovies',50),
	   ('siciliano','capsicum',75),
	   ('siciliano','olives',50),
	   ('siciliano','onion',50),
	   ('siciliano','spice',15),
	   ('special','anchovies',25),
	   ('special','bacon',25),
	   ('special','capsicum',25),
	   ('special','cheese',25),
	   ('special','egg',25),
	   ('special','German sausage',25),
	   ('special','ham',25),
	   ('special','mushroom',25),
	   ('special','olives',25),
	   ('special','onion',25),
	   ('special','peas',25),
	   ('special','pineapple',25),
	   ('special','salami',25),
	   ('special','seafood',25),
	   ('special','spice',10),
	   ('special','tomato',25),
	   ('vegetarian','capsicum',50),
	   ('vegetarian','mushroom',50),
	   ('vegetarian','onion',50),
	   ('vegetarian','peas',50),
	   ('vegetarian','spice',5),
	   ('vegetarian','tomato',50),
	   ('viennese','German sausage',150),
	   ('viennese','spice',5);
