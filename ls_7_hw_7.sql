-- ��.�7

# 1.��������� ������ ������������� users, ������� ����������� 
# ���� �� ���� ����� orders � �������� ��������.

INSERT INTO orders (user_id)  #  �������� ����. �������(orders) 
VALUES (1),  # ��������
	   (2),  # �������
	   (4);  # ������
-- SELECT * FROM users;

INSERT INTO orders_products(order_id, product_id) 
values 
(2, 4),
(1, 3),
(3, 2); 

-- SELECT * FROM orders_products;
SELECT u.name FROM orders AS o    
	JOIN users AS u ON o.user_id = u.id;
# ������ ������������� users, ������� ����������� ���� �� ���� �����

-- ��� 2
INSERT INTO orders (user_id) VALUES (5);
-- SELECT * FROM users;
INSERT INTO orders_products(order_id, product_id) VALUES (1, 2);
-- SELECT * FROM orders_products;
SELECT u.name,op.product_id FROM orders AS o 
	JOIN users AS u ON o.user_id = u.id 
	JOIN orders_products AS op ON o.id = op.order_id
	WHERE o.id=1;
# ��� �� �������� ������������� ����� ����� ��� ������.

-- ���.2
# �������� ������ ������� products � �������� catalogs, ������� 
# ������������� ������.

SELECT * FROM products  # ������ ��������,�� �� ���������.� �� ������ ������� ������
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
# ������� � ������� ����� 2 ��� ������� � � ��� 7 ����� �������.
