/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
Используйте транзакции.
 */
# создаем БД и табл 
#  вводим данные вshop.users  и отсюда переместим строку 1 в таблицу sample.users. 
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
#вар.2
INSERT INTO sample.users
SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
-- ROLLBACK; 
COMMIT;

/*
 * Создайте представление, которое выводит название name товарной позиции из 
 * таблицы products и соответствующее 
 * название каталога name из таблицы catalogs.
 */

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  body TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, body, price, catalog_id )
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) ;

INSERT INTO catalogs
VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

 # соединив двух таблиц
# только LEFT JOIN сопоставил всё правильно, а на остальных бывали пустые строки с NULL.
 
DROP VIEW IF EXISTS prod_description;
CREATE VIEW prod_description AS SELECT products.name AS  products,catalogs.name AS catalogs FROM products
LEFT JOIN  catalogs ON catalog_id = catalogs.id;

SELECT * FROM prod_description ; 
--  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
 * фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
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
					                                           '06:00' AND '12:00' THEN RETURN 'Доброе утро',
						                                       '12:00' AND '18:00' THEN RETURN 'Добрый день'.
						                                       '18:00' AND '00:00' THEN RETURN 'Добрый вечер',
						                                        '00:00' AND '06:00' THEN RETURN 'Доброй ночи'
            END CASE;
END//

delimiter ;

CALL hello();

/* С этой задачой у меня были и наверно остаются проблемы. Сам бы его с помощью методички  наверно не решил бы.
 * В смысле, WHEN hour BETWEEN  этих команд я бы не нашел, в гугле нашел задачку,он у меня не работал потому что заканчивался  SELECT NOW(), hello()//
 * искал дальше, и изменил задачу, проверил изменив время - сработало четко, но потом не стал возврашать "Добрый вечер'/
 *  второе- я не понял для чего delimiter ,если его функция всего лишь изменить разделителя,то какая выгода? Может повышает производительность,но об этом я не читал.
 * 
 */



