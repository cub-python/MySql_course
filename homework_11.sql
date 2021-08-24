/* ���� ��,��� ����� �������� ������  ���� ����� ����������.
 * ������������ ������� �� ���� ������������ ��������
�������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, 
catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������, 
������������� ���������� ����� � ���������� ���� name.
 */

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  table_name VARCHAR(20) NOT NULL,
  pr_id INT UNSIGNED NOT NULL,
  name VARCHAR(150),
  created_at DATETIME DEFAULT NOW()
) ENGINE=ARCHIVE;
-- �������� �������� ARCHIVE ������������ ��� �������� �������� ���������� ����������������� ������ � ����� ��������� ������.

-- FOR EACH ROW BEGIN � ���������� ���������  ������� ����� ��������� � ������� ���� 
-- ����������� ��������, � �������� �������� �������. 

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
/*    ��� ����� ���� �� �������,����� ��������� ��������� ����� ���.
 ������������ ������� �� ���� �NoSQL�
� ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.
��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ �
 ��������, ����� ������������ ������ ������������ �� ��� �����.
����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.
 */  
