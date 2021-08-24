/*� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
����������� ������ id = 1 �� ������� shop.users � ������� sample.users. 
����������� ����������.
 */
# ������� �� � ���� 
#  ������ ������ �shop.users  � ������ ���������� ������ 1 � ������� sample.users. 
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
use sample

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id  SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	birthday_at DATE DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM sample.users;


DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id  SERIAL PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	birthday_at DATE DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users( name, birthday_at)
VALUES('Artur', '1998-.05-27');

set autocommit=0;
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

SELECT * FROM shop.users;
#���.2
INSERT INTO sample.users
SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
-- ROLLBACK; 
COMMIT;

/*
 * �������� �������������, ������� ������� �������� name �������� ������� �� 
 * ������� products � ��������������� 
 * �������� �������� name �� ������� catalogs.
 */

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��������',
  body TEXT COMMENT '��������',
  price DECIMAL (11,2) COMMENT '����',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = '�������� �������';

INSERT INTO products
  (name, body, price, catalog_id )
VALUES
  ('Intel Core i3-8100', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.', 7890.00, 1),
  ('Intel Core i5-7400', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� Intel.', 12700.00, 1),
  ('AMD FX-8320E', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� AMD.', 4780.00, 1),
  ('AMD FX-8320', '��������� ��� ���������� ������������ �����������, ���������� �� ��������� AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', '����������� ����� ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', '����������� ����� Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', '����������� ����� MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '�������� �������'
) ;

INSERT INTO catalogs
VALUES
  (NULL, '����������'),
  (NULL, '����������� �����'),
  (NULL, '����������'),
  (NULL, '������� �����'),
  (NULL, '����������� ������');

 # �������� ���� ������
# ������ LEFT JOIN ���������� �� ���������, � �� ��������� ������ ������ ������ � NULL.
 
DROP VIEW IF EXISTS prod_description;
CREATE VIEW prod_description AS SELECT products.name AS  products,catalogs.name AS catalogs FROM products
LEFT JOIN  catalogs ON catalog_id = catalogs.id;

SELECT * FROM prod_description ; 
--  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
 * �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. 
 * � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� 
 * ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
 */

DROP FUNCTION IF EXISTS hello;
delimiter //

CREATE FUNCTION hello ()
RETURN TINYTEXT NOT DETERMINISTIC
BEGIN
			DECLARE hour INT//
			SET hour = HOUR(NOW())//
			CASE				
						WHEN hour BETWEEN  
					                                           '06:00' AND '12:00' THEN RETURN '������ ����',
						                                       '12:00' AND '18:00' THEN RETURN '������ ����'.
						                                       '18:00' AND '00:00' THEN RETURN '������ �����',
						                                        '00:00' AND '06:00' THEN RETURN '������ ����'
            END CASE;
END//

delimiter ;

CALL hello();

/* � ���� ������� � ���� ���� � ������� �������� ��������. ��� �� ��� � ������� ���������  ������� �� ����� ��.
 * � ������, WHEN hour BETWEEN  ���� ������ � �� �� �����, � ����� ����� �������,�� � ���� �� ������� ������ ��� ������������  SELECT NOW(), hello()//
 * ����� ������, � ������� ������, �������� ������� ����� - ��������� �����, �� ����� �� ���� ���������� "������ �����'/
 *  ������- � �� ����� ��� ���� delimiter ,���� ��� ������� ����� ���� �������� �����������,�� ����� ������? ����� �������� ������������������,�� �� ���� � �� �����.
 * 
 */



