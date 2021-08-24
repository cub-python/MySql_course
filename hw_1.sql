/* Задача №1
 Установите СУБД MySQL. 
 MySQL -установлен,подключён с DBeaver редактором
 * [client] 
 user=root
 passwod=******** 
 Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
 my.cnf сохраняем файл с расшир. " . " в Папке Win. тепер root может попасть без ввода пароля */

/* Задача №2
Создайте базу данных example.  */

/*SHOW DATABASES;             /* проверим состав БД */
/*CREATE DATABASE example;       /* создаем БД  example */
/*SHOW DATABASES;               /*проверям еще раз и видим что БВ появилась в списке.*/
/*
SHOW TABLES;
USE example;            /*  выбираем из списка БД example и создаем в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
DROP TABLE IF EXISTS users;        /* чтоб при изменен талб удалялась стапое и обновиась 
CREATE TABLE users 
(
	id INT,
	name  VARCHAR (20)
	NOT NULL UNIQUE
);  
DESC users;
exit;              */


/* Задача №3
Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.  
mysqldump example;                        # создаем dump example 
mysqldump example > example.sql              #  dump example сохраним в файле sql 
mysql
CREATE DATABASE sumple;                     # создали БД 
exit;
mysql sumple < example.sql                # загружаем в dump sumple < example.sql файл. 
USE sunple;
show TABLES;          */


/* Задача №4
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
Создайте дамп единственной таблицы help_keyword базы данных mysql. 
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы. */

CREATE DATABASE asdf;
CREATE TABLE asdf.help_keyword 
    SELECT *
    FROM  mysql.help_keyword
    LIMIT 100;























