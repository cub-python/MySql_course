-- Урок №5
-- задача 1.
-- Пусть в таблице users поля created_at и updated_at оказались 
-- незаполненными. Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50),
	lastname VARCHAR(50) COMMENT 'Фамиль',           
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR(100), 
	phone BIGINT UNSIGNED UNIQUE
);

-- в  табл отсутсв.столбцы created_at и updated_at,добавим их.
-- добавил столбцы со значениями, DEFAULT CURRENT_TIMESTAMP означает,
-- что любая ВСТАВКА без явной настройки метки времени использует текущее время.
-- но,колонка updated_at занолнился значением NULL, изменил на DATETIME DEFAULT NOW(),не помогло,

ALTER TABLE users ADD column created_at DATETIME DEFAULT NOW(),
ALTER TABLE users ADD column updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
ALTER TABLE users MODIFY COLUMN updated_at DATETIME DEFAULT NOW();
UPDATE users SET updated_at = NOW(); -- пустые табл поменял на NOW()Возвращает текущую дату и время 
-- как значение

# задача 2 
# Таблица users была неудачно спроектирована. 
# Записи created_at и updated_at были заданы типом VARCHAR и 
# в них долгое время помещались значения в формате "20.10.2017 8:10". 

-- сначала приводим тип столбцов  значения created_at и updated_at в VARCHAR

ALTER TABLE users 
    CHANGE COLUMN `created_at` `created_at` VARCHAR(256) NULL,
    CHANGE COLUMN `updated_at` `updated_at` VARCHAR(256) NULL;
   
# переобразовали,и значения столбцов '2021-06-30 14:10:53',	'2021-06-30 15:37:09'.

-- Необходимо преобразовать поля к типу DATETIME, сохранив 
-- введеные ранее значения.()
ALTER TABLE users 
    CHANGE COLUMN `created_at` `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Задача 3.
# В таблице складских запасов storehouses_products в поле value могут 
# встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
# если на складе имеются запасы. 
CREATE TABLE storehouses_products 
(
	id SERIAL ,
    storehouse_id INT unsigned, #UNSIGNED хранит только положительные числа (или нуль)
    product_id INT unsigned,
    `value` INT unsigned COMMENT 'Количество товара',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 45),
    (1, 3, 0),
    (1, 5, 9),
    (1, 7, 23),
    (1, 8, 7);
# Необходимо отсортировать записи таким образом, чтобы они выводились 
# в порядке увеличения значения value. Однако, нулевые запасы должны выводиться 
# в конце, после всех записей.
SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;

   
 -- Задача 4  
(по желанию) Из таблицы users необходимо извлечь пользователей, 
родившихся в августе и мае. Месяцы заданы в виде списка английских 
названий ('may', 'august')
-- я пробовал использовать таблицу с прошлого урока,добавил столбец birthday_at
-- но чтоб заполнить именно новый столбец у меня не получилось,поэтому создал новую табл.
USE vk;
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50),
	birthday_at VARCHAR(50) 
);
INSERT INTO users (id,name,birthday_at ) 
VALUES
('1', 'Reuben','1997-27-may'),
('2', 'Frederik', '1990-03-february'),
('3', 'Unique', '1997-11-june'),
('4', 'Norene', '1997-02-august'),
('5', 'Frederick', '1981-06-october'),
('6', 'Reuba', '1988-31-march'),
('7', 'Fred', '1986-08-august'),
('8', 'Uniq', '1999-09-may'),
('9', 'Nor', '1998-27-april'),
('10', 'Fredericko','1991-02-august')
;

SELECT birthday_at FROM users WHERE 
	(birthday_at LIKE '%may%' OR birthday_at LIKE '%august%');


-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.*\
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id,'5,1,2');

# Практическое задание теме “Агрегация данных”
-- Подсчитайте средний возраст пользователей в таблице users INT NOT NULL

ALTER TABLE users ADD age INT NOT NULL; -- добавляем столбец age со значением
UPDATE users SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW()); -- изменим сущ запись в столбце
SELECT AVG(age) FROM users; -- тут у меня возникли проблемы, столбец age пустой и я не смог запонить автомат.
--  пробовал чтоб age = 2021 -  birthday_at, не пролучилось и я запонил в ручную.



-- Подсчитайте количество дней рождения,которые приходятся на 
 -- каждый из дней недели.
-- Следует учесть,что необходимы дни недели текущего года,а не года рождения.
# это задание для меня было непонятным,но я попытался решить,
SELECT *, DAYOFWEEK(birthday_at) as day FROM users; -- выдает значение null

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы *\

SELECT exp(SUM(ln(age))) summ FROM users;

-- посчитал произведение чисел столбца age= 300544763904000.8










