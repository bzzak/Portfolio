USE pizza;

CREATE TABLE MENU(
	pizza varchar(18) NOT NULL,
	price decimal(5, 2),
	country varchar(18),
	base varchar(18),
CONSTRAINT Menu_PK PRIMARY KEY (pizza)
	);

CREATE TABLE ITEMS(
	ingredient varchar(20) NOT NULL,
	type varchar(10),
CONSTRAINT Items_PK PRIMARY KEY (ingredient),
	);

CREATE TABLE RECIPES(
	pizza varchar(18) NOT NULL,
	ingredient varchar(20) NOT NULL,
	amount int,
CONSTRAINT Recipes_FK1 FOREIGN KEY (pizza) REFERENCES MENU(pizza),
CONSTRAINT Recipes_FK2 FOREIGN KEY (ingredient) REFERENCES ITEMS(ingredient),
CONSTRAINT Recipes_PK  PRIMARY KEY (pizza, ingredient)
	);



