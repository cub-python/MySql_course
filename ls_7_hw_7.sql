-- ƒз.є7

# 1.—оставьте список пользователей users, которые осуществили 
# хот€ бы один заказ orders в интернет магазине.

INSERT INTO orders (user_id)  #  «аполним табл. зазказы(orders) 
VALUES (1),  # √еннадий
	   (2),  # Ќаталь€
	   (4);  # —ергей
-- SELECT * FROM users;

INSERT INTO orders_products(order_id, product_id) 
values 
(2, 4),
(1, 3),
(3, 2); 

-- SELECT * FROM orders_products;
SELECT u.name FROM orders AS o    
	JOIN users AS u ON o.user_id = u.id;
# список пользователей users, которые осуществили хот€ бы один заказ

-- ¬ар 2
INSERT INTO orders (user_id) VALUES (5);
-- SELECT * FROM users;
INSERT INTO orders_products(order_id, product_id) VALUES (1, 2);
-- SELECT * FROM orders_products;
SELECT u.name,op.product_id FROM orders AS o 
	JOIN users AS u ON o.user_id = u.id 
	JOIN orders_products AS op ON o.id = op.order_id
	WHERE o.id=1;
# так мы получаем дополнительно какой товар был куплен.

-- зад.2
# ¬ыведите список товаров products и разделов catalogs, который 
# соответствует товару.

SELECT * FROM products  # списки получаем,но не соответсв.и не выполн услови€ задачи
JOIN  catalogs;

SELECT 
	p.id, p.name, p.price, 
	c.id AS cat_id,         
	c.name AS catalogs
FROM
	products AS p
JOIN
	catalogs AS c
ON 
	p.catalog_id = c.id; 
# выходит в наличии всего 2 кат товаров и в них 7 видов товаров.
