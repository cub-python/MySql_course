/* ������ �1
 ���������� ���� MySQL. 
 MySQL -����������,��������� � DBeaver ����������
 * [client] 
 user=root
 passwod=******** 
 �������� � �������� ���������� ���� .my.cnf, ����� � ��� ����� � ������, ������� ���������� ��� ���������.
 my.cnf ��������� ���� � ������. " . " � ����� Win. ����� root ����� ������� ��� ����� ������ */

/* ������ �2
�������� ���� ������ example.  */

/*SHOW DATABASES;             /* �������� ������ �� */
/*CREATE DATABASE example;       /* ������� ��  example */
/*SHOW DATABASES;               /*�������� ��� ��� � ����� ��� �� ��������� � ������.*/
/*
SHOW TABLES;
USE example;            /*  �������� �� ������ �� example � ������� � ��� ������� users, ��������� �� ���� ��������, ��������� id � ���������� name.
DROP TABLE IF EXISTS users;        /* ���� ��� ������� ���� ��������� ������ � ��������� 
CREATE TABLE users 
(
	id INT,
	name  VARCHAR (20)
	NOT NULL UNIQUE
);  
DESC users;
exit;              */


/* ������ �3
�������� ���� ���� ������ example �� ����������� �������, ���������� ���������� ����� � ����� ���� ������ sample.  
mysqldump example;                        # ������� dump example 
mysqldump example > example.sql              #  dump example �������� � ����� sql 
mysql
CREATE DATABASE sumple;                     # ������� �� 
exit;
mysql sumple < example.sql                # ��������� � dump sumple < example.sql ����. 
USE sunple;
show TABLES;          */


/* ������ �4
(�� �������) ������������ ����� �������� � ������������� ������� mysqldump. 
�������� ���� ������������ ������� help_keyword ���� ������ mysql. 
������ ��������� ����, ����� ���� �������� ������ ������ 100 ����� �������. */

CREATE DATABASE asdf;
CREATE TABLE asdf.help_keyword 
    SELECT *
    FROM  mysql.help_keyword
    LIMIT 100;























