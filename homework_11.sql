/* Сдаю то,что успел немножко понять  Тема очень интересная.
 * Практическое задание по теме “Оптимизация запросов”
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name.
 */

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  table_name VARCHAR(20) NOT NULL,
  pr_id INT UNSIGNED NOT NULL,
  name VARCHAR(150),
  created_at DATETIME DEFAULT NOW()
) ENGINE=ARCHIVE;
-- Механизм хранения ARCHIVE используется для хранения большого количества неиндексированных данных в очень небольшом объеме.

-- FOR EACH ROW BEGIN — определяет выражения  которые будут применены к каждому ряду 
-- затронутому событием, к которому привязан триггер. 

DROP TRIGGER IF EXISTS users_log ;
CREATE TRIGGER users_log AFTER INSERT ON users FOR EACH ROW
INSERT INTO logs 
    SET 
      table_name = 'users',
      pr_id = NEW.id,
      name = NEW.name;

DROP TRIGGER IF EXISTS catalogs_log;   
CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs FOR EACH ROW
INSERT INTO logs 
SET 
      table_name = 'catalogs',
      pr_id = NEW.id, 
      name = NEW.name;
     
DROP TRIGGER IF EXISTS  products_log;
CREATE TRIGGER products_log AFTER INSERT ON products FOR EACH ROW
INSERT INTO logs 
SET 
      table_name = 'products',
      pr_id = NEW.id,
      name = NEW.name;
     

-- 
/*    Это часть пока не понятно,успел смоотреть видеоурок всего раз.
 Практическое задание по теме “NoSQL”
В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и
 наоборот, поиск электронного адреса пользователя по его имени.
Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
 */  
