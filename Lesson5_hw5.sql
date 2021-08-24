-- ���� �5
-- ������ 1.
-- ����� � ������� users ���� created_at � updated_at ��������� 
-- ��������������. ��������� �� �������� ����� � ��������.

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50),
	lastname VARCHAR(50) COMMENT '������',           
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR(100), 
	phone BIGINT UNSIGNED UNIQUE
);

-- �  ���� �������.������� created_at � updated_at,������� ��.
-- ������� ������� �� ����������, DEFAULT CURRENT_TIMESTAMP ��������,
-- ��� ����� ������� ��� ����� ��������� ����� ������� ���������� ������� �����.
-- ��,������� updated_at ���������� ��������� NULL, ������� �� DATETIME DEFAULT NOW(),�� �������,

ALTER TABLE users ADD column created_at DATETIME DEFAULT NOW(),
ALTER TABLE users ADD column updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
ALTER TABLE users MODIFY COLUMN updated_at DATETIME DEFAULT NOW();
UPDATE users SET updated_at = NOW(); -- ������ ���� ������� �� NOW()���������� ������� ���� � ����� 
-- ��� ��������

# ������ 2 
# ������� users ���� �������� ��������������. 
# ������ created_at � updated_at ���� ������ ����� VARCHAR � 
# � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". 

-- ������� �������� ��� ��������  �������� created_at � updated_at � VARCHAR

ALTER TABLE users 
    CHANGE COLUMN `created_at` `created_at` VARCHAR(256) NULL,
    CHANGE COLUMN `updated_at` `updated_at` VARCHAR(256) NULL;
   
# ��������������,� �������� �������� '2021-06-30 14:10:53',	'2021-06-30 15:37:09'.

-- ���������� ������������� ���� � ���� DATETIME, �������� 
-- �������� ����� ��������.()
ALTER TABLE users 
    CHANGE COLUMN `created_at` `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP;

-- ������ 3.
# � ������� ��������� ������� storehouses_products � ���� value ����� 
# ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, 
# ���� �� ������ ������� ������. 
CREATE TABLE storehouses_products 
(
	id SERIAL ,
    storehouse_id INT unsigned, #UNSIGNED ������ ������ ������������� ����� (��� ����)
    product_id INT unsigned,
    `value` INT unsigned COMMENT '���������� ������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ �� ������';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 45),
    (1, 3, 0),
    (1, 5, 9),
    (1, 7, 23),
    (1, 8, 7);
# ���������� ������������� ������ ����� �������, ����� ��� ���������� 
# � ������� ���������� �������� value. ������, ������� ������ ������ ���������� 
# � �����, ����� ���� �������.
SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;

   
 -- ������ 4  
(�� �������) �� ������� users ���������� ������� �������������, 
���������� � ������� � ���. ������ ������ � ���� ������ ���������� 
�������� ('may', 'august')
-- � �������� ������������ ������� � �������� �����,������� ������� birthday_at
-- �� ���� ��������� ������ ����� ������� � ���� �� ����������,������� ������ ����� ����.
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


-- (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- ������������ ������ � �������, �������� � ������ IN.*\
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '�������� �������',
  UNIQUE unique_name(name(10))
) COMMENT = '������� ��������-��������';

INSERT INTO catalogs VALUES
  (NULL, '����������'),
  (NULL, '����������� �����'),
  (NULL, '����������'),
  (NULL, '������� �����'),
  (NULL, '����������� ������');
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id,'5,1,2');

# ������������ ������� ���� ���������� �������
-- ����������� ������� ������� ������������� � ������� users INT NOT NULL

ALTER TABLE users ADD age INT NOT NULL; -- ��������� ������� age �� ���������
UPDATE users SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW()); -- ������� ��� ������ � �������
SELECT AVG(age) FROM users; -- ��� � ���� �������� ��������, ������� age ������ � � �� ���� �������� �������.
--  �������� ���� age = 2021 -  birthday_at, �� ����������� � � ������� � ������.



-- ����������� ���������� ���� ��������,������� ���������� �� 
 -- ������ �� ���� ������.
-- ������� ������,��� ���������� ��� ������ �������� ����,� �� ���� ��������.
# ��� ������� ��� ���� ���� ����������,�� � ��������� ������,
SELECT *, DAYOFWEEK(birthday_at) as day FROM users; -- ������ �������� null

-- (�� �������) ����������� ������������ ����� � ������� ������� *\

SELECT exp(SUM(ln(age))) summ FROM users;

-- �������� ������������ ����� ������� age= 300544763904000.8










