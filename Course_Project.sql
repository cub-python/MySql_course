DROP DATABASE IF EXISTS goszakupki;
CREATE DATABASE goszakupki;
USE goszakupki

SET foreign_key_checks = 0;                  # ��������� ������� �����
SET foreign_key_checks = 1;                  # ����������  ������� �����
-- truncate `trading_platform`;                     #������� ���� � ���������� ��?���� id

/* ������� ��������� ������� �������� ��������� ��������,��� �������� ��� ��������������� � ������������ 
 * ������� �� ��� ���� ����� � �������. ������� � ����� ������� ������������ ������� �� .
 * 
 * ��� �������� ����������� �������� ���� ����������� �� ��.�������� ����� �������� ���������.
 * � ���� ������������,�� ����� ��� ������ ����� ���������� � ����� ���� ������ ��� ������.
 * ��� ���� ���� ��������� ������������ �������, ����� ���� ������� ������������., ��� �������� ��� 3 ������� ����.,�� � �������� �������������.
 * �� ���� ����� � ������� ��� �������� ��������� ��������� ���� ��� ����������  �������� ����������� �����.
 */
# ��������� �������� ���������� ����,�������� ����,���� �������� � ���� � ���������.
  
DROP TABLE IF EXISTS trading_platform;
CREATE TABLE trading_platform(
  	id SERIAL ,
  	tender_id int PRIMARY KEY,
  	seller_id BIGINT  COMMENT '��� ���������' ,
  	tender_type int,
 	starting_price  DECIMAL (11,2) COMMENT '����',                                                        
  	apply_before DATETIME ,
	FOREIGN KEY ( seller_id) REFERENCES sellers (seller_id ),
	FOREIGN KEY trading_platform(id) REFERENCES tenders(id),
	FOREIGN KEY ( tender_type ) REFERENCES tender_type (type_id )
  );
 
 INSERT INTO `trading_platform` ( id, seller_id, tender_id, tender_type, starting_price, apply_before) 
 VALUES
(NULL,'2', '1',  '1', '4044221.00','2221-08-07 09:40:00 '),
(NULL, '4', '2',  '1', '787053.20','2221-07-23 08:00:00 '),
(NULL,'1', '3',  '1', '146356.80','2221-03-07 09:00:00 '),
(NULL, '5','4',  '1', '1772700.00','2221-08-07 09:00:00 '),
(NULL,'3', '5',  '1', '380332800.00','2221-11-08 09:40:00 '),
(NULL, '4','6',  '1', '280180.13','2221-09-07 08:40:00 '),
(NULL, '6','7',  '2', '150000.00','2221-02-07 08:00:00 '),
(NULL,'8', '8',  '2', '630979.58','2221-12-07 11:00:00 '),
(NULL, '7','9',  '2', '616796.70','2221-07-07 05:00:00 '),
(NULL,'9', '10',  '2', '14850792.30','2221-08-08 09:00:00 '),
(NULL,'10', '11',  '2', '113722.34','2221-05-07 12:00:00 '),
(NULL,'11', '12',  '3', '0.00','2221-07-08 00:00:00 '),
(NULL,'2', '13',  '3', '0.00','2221-03-08 00:00:00 '),
(NULL,'1','14',  '3', '0.00','2221-09-08 00:00:00 '), 
(NULL, '4','15',  '3', '0.00','2221-11-07 00:00:00 '),
(NULL, '3','16',  '1', '580332800.00','2221-11-08 09:00:00 '),
(NULL, '12','17 ', '4','292000.00','2221-03-09 09:00:00 '),
(NULL,'12', '18','4','856000.00','2222-01-08 09:00:00 '),
(NULL, '12','19', '4', '615000.00','2221-06-08 09:00:00 '),
(NULL,'13', '20',  '1', '	404.00','2221-08-07 09:00:00 '),
(NULL, '13','21',  '2', '538.29','2221-11-08 09:00:00 ');


 # ���� ������ ���� � ����������� ��������.

DROP TABLE IF EXISTS tenders;
CREATE table tenders(
	id SERIAL PRIMARY KEY,
	tender_id INT,
	seller_id BIGINT  COMMENT '��� ���������',
	tender_name VARCHAR(255) COMMENT '�������� �������',
	type_id INT,
	starting_price  BIGINT,
	region_id  INT,
	tender_date_at DATETIME DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (region_id ) REFERENCES region(region_id ),
	FOREIGN KEY (type_id) REFERENCES tender_type(type_id ),
	FOREIGN KEY (seller_id ) REFERENCES sellers(seller_id)
	);
 -- truncate tenders;
 INSERT INTO tenders( id, tender_id , seller_id, tender_name,type_id, starting_price, region_id , tender_date_at) 
 VALUES
(NULL, '1', '7723654437', '����������� ������ ������ ���� "���������� ���"',  '1', '4044221.00','77','2221-08-10 09:40:00 '),
(NULL, '2', '7123654897',' ������������� ���������� ��������� ����������',  '1', '787053.20', '07', '2221-07-25 08:00:00 '),
(NULL, '3', '7723654870', '������ ������� �������, ����� � �����',  '1', '146356.80', '03', '2221-03-10 09:00:00 '),
(NULL, '4', '7723654894','�������� ������������� �������.',  '1', '1772700.00', '10','2221-08-10 09:00:00 '),
(NULL, '5', '7723612892', '����������� ���������� �� ������������� �������',  '2', '38033280.00', '02','2221-11-11 09:40:00 '),
(NULL, '6', '7723654894','�������� ��� (�������, ������)',  '2', '280180.13', '10', '2221-09-09 08:40:00 '),
(NULL, '7', '7123654897','������ ����������, ������� � ����������� ������� ',  '06', '150000.00', '07','2221-02-09 08:00:00 '),
(NULL, '8', '7723654437', '���������� ����� �� �������� ������� ������� "�"',  '1', '630979.58', '77','2221-12-10 11:00:00 '),
(NULL, '9', '7723654855','�������� ���������������� �������������',  '2', '616796.70', '11', '2221-07-09 05:00:00 '),
(NULL, '10', '7723654829', '�������� ����������������� ������������ ��� �������',  '2', '14850792.30', '12', '2221-08-10 09:00:00 '),
(NULL, '11', '7723654863', '�� �������� ����������� ����������',  '2', '113722.34', '13', '2221-05-12 12:00:00 '),
(NULL, '12', '7723654821', '���������: 012720000012100015',  '3', '0.00', '14', '2221-07-11 00:00:00 '),
(NULL, '13','7723654805', '���������: 012720000012100027',  '3', '0.00', '15', '2221-03-11 00:00:00 '),
(NULL, '14','7723654887','���������: 012720000019100001',  '3', '0.00', '17', '2221-09-12 00:00:00 '), 
(NULL, '15', '7723654887','���������: 012720000086100017',  '3', '0.00', '17', '2221-11-10 00:00:00 '),
(NULL, '16', '7723654437','����������� ���������� �� ������������� �������',  '1', '580332800.00', '77', '2221-11-13 09:00:00 '),
(NULL, '17', '7723654832','COM15072100039 (��� 1)',  '4 ', '292000.00', '40', '2221-03-13 09:00:00 '),
(NULL, '18','7723654832', 'COM15072100035 (��� 1)',  '4', '856000.00', '40', '2222-01-11 09:00:00 '),
(NULL, '19', '7723654832','COM15072100031 (��� 1)',  '4', '615000.00', '40', '2221-06-11 09:00:00 '),
(NULL, '20', '7723654829', '�������� (����� ����������� ����)',  '3', '	404.00', '12', '2221-10-13 09:10:00 '),
(NULL, '21', '7723654829','���� �������� ������� � ������',  '3', '538.29', '12', '2221-11-12 09:00:00 ');


# ���� ��� �������,������ ��� �������� ������������ ����� ������� ��
DROP TABLE IF EXISTS tender_type;
CREATE table tender_type(
	type_id INT,
	type_name VARCHAR(25),
	PRIMARY KEY (type_id )
 );   
 INSERT INTO tender_type (type_id , type_name) 
 VALUES
	('1','44-��'),
	('2','223-��'),
	('3','615-��'),
	('4','������������ �������');

# ���� region ������ � ������ ������ ��������� � ����� ������������ ���������� �����.
DROP TABLE IF EXISTS region;
CREATE TABLE region (
  id SERIAL,
  region_id INT,
  location_name varchar(128),
  PRIMARY KEY (region_id )
) ;

INSERT INTO region( id, region_id , location_name) 
 VALUES
(NULL, '01', '���������� ������'),
(NULL, '02', '���������� ������������'),
(NULL, '03', '���������� �������'),
(NULL, '04', '���������� �����'),
(NULL, '07', '���������-���������� ����������'),
(NULL, '09', '���������-���������� ����������'),
(NULL, '10', '���������� �������'),
(NULL, '11', '���������� ����'),
(NULL, '12', '���������� ����� ��'),
(NULL, '13', '���������� ��������'),
(NULL, '14', '���������� ���� (������)'),
(NULL, '15', '���������� �������� ������ - ������'),
(NULL, '17', '���������� ����'),
(NULL, '32', '�������� �������'),
(NULL, '36', '����������� �������'),
(NULL, '40', '��������� �������'),
(NULL, '77', '�. ������');

# ���� tender_comments ������ ������� �� ���� ��� ����� �������. ������ ���� ��� ���������
DROP TABLE IF EXISTS  tender_comments;
 CREATE table tender_comments(
	id SERIAL ,
	INT PRIMARY KEY,
	body text,
	created_at  DATE,		
	FOREIGN KEY (tender_id) REFERENCES trading_platform (tender_id));

INSERT INTO tender_comments( id,tender_id ,body, created_at) 
VALUES  
	(NULL, '2',  '�� ������� �������� ��� �����������',  '2221-07-08'),
	(NULL, '13','��������� ���������� �� "2221-08-12 12:00:00" ', '2221-03-11'));

  
 truncate  suppliers; 
# ���� ������� ������ ����������� ��������� ������� � ������������� � ������.

DROP TABLE IF EXISTS suppliers; 
CREATE TABLE suppliers(
	id SERIAL,
	supplier_id BIGINT COMMENT '��� ����������', 
	supplier_name VARCHAR(200) COMMENT '�������� �������',  
	email VARCHAR(120) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	PRIMARY KEY(supplier_id),
	FOREIGN KEY (supplier_id ) REFERENCES sellers(seller_id));


INSERT INTO  suppliers( id,supplier_id, supplier_name, email, phone) 
 VALUES
(NULL, '7789554891' , '��� ��','gh@nm.com','78432123136'),
(NULL, '7723612125' , '��� ���', ' bhj@nm.com','78965422354'),
(NULL, '7723620314' , '��� ���',  ' bvgh@nm.com','73215429874'),
(NULL,'778564892' , '��� ���' , ' ghv@nm.com','5369544232' ),
(NULL, '7129744897' ,'��� ���', ' ah@nm.com','78965364413'),
(NULL, '7987844898' ,'��� ����', ' he@nm.com','78923443698' ),
(NULL, '7720294894' , '��� �����',  ' vwgh@nm.com','78965427892'),
(NULL,'7727944855' ,  '��� ����', ' vq@nm.com','78965427898' ),
(NULL, '7721424829' , '��� ���', ' evgh@nm.com','7896548965' ),
(NULL, '77201094863' ,  '��� ������', ' bh@nm.com','765892012'),
(NULL,'7721764821' ,  '��� ������' ,' bd@nm.com','789654220122'),
(NULL, '774074805' ,  '��� ������', ' vbgf@nm.com','5426326542'),
(NULL,'7727894807' ,  '��� ����',  ' sdb@nm.com','78965425741'),
(NULL, '7727304889' ,'��� ���', ' fnji@nm.com','7896540480'),
(NULL, '7725634816' ,  '��� ����', ' nhg@nm.com','78965426589'),
(NULL,'7721234832' ,  '��� ����� ', ' ytr@nm.com','26313426554'),
(NULL, '7723254437' , '��� ���',  ' tgb@nm.com','26313423426');

# ���� ������� ������  ������ ���������� �����������
DROP TABLE IF EXISTS supplier_contracts;
CREATE TABLE supplier_contracts(
    id SERIAL, 
	contract_id BIGINT,
	seller_id BIGINT UNSIGNED NOT NULL,
	contract_name VARCHAR(250),
	contract_amount DECIMAL (11,2) COMMENT '����� ���������',
	supplier_id BIGINT  COMMENT '��� ����������', 
	PRIMARY KEY (contract_id),
    FOREIGN KEY (contract_id) REFERENCES suppliers(supplier_id));
   
INSERT INTO supplier_contracts( id, contract_id,seller_id,contract_name, contract_amount, supplier_id) 
VALUES
	(NULL, '3', '7723654870', '������ ������� �������, ����� � �����', '120356.00', '7723612125' ),
	(NULL, '7', '7123654897','������ ����������, ������� � ����������� ������� ', '120000.00', '7987844898' ),
	(NULL, '9', '7723654855','�������� ���������������� �������������',  '576796.70', '7129744897' ),
	(NULL, '11', '7723654863', '�� �������� ����������� ����������',  '110722.34', '7727944855' ),
	(NULL, '12', '7723654821', '���������: 012720000012100015', '691124.00', '77201094863' ),
	(NULL, '13','7723654805', '���������: 012720000012100027', '1026784.00',  '77201094863'),
	(NULL, '17', '7723654832','COM15072100039 (��� 1)', '289000.00',  '7723620314'),
	(NULL, '18','7723654832', 'COM15072100035 (��� 1)', '840000.00', '778564892'),
	(NULL, '19', '7723654832','COM15072100031 (��� 1)', '611000.00', '7723620314');
 

# ���� ��������� ����������� � ��� ����������.
 -- truncate  assistance_to_suppliers; 
DROP TABLE IF EXISTS assistance_to_suppliers;
CREATE TABLE  assistance_to_suppliers(
	id SERIAL PRIMARY KEY, 
	from_supplier_id BIGINT UNSIGNED  NULL,
    to_supplier_id BIGINT UNSIGNED  NULL,
    body TEXT,
	created_at  DATETIME ,  
    FOREIGN KEY (from_supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (to_supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY assistance_to_suppliers(id) REFERENCES tech_support(id));
      
INSERT INTO assistance_to_suppliers( from_supplier_id, body, created_at) 
VALUES ( '7789554891', '�������� �� ��������� ������ ! ', '2221-03-01 11:00:00 ');

INSERT INTO assistance_to_suppliers(  to_supplier_id, body, created_at) 
VALUES ( '7789554891', '���� ������ �����������, �� �� ��������� ������� ��� ', '2221-03-01 13:00:00 ');

INSERT INTO assistance_to_suppliers( from_supplier_id, body, created_at) 
VALUES ( '7723654855', '� ����� � ����87656 �� ������� ��,���� �� ��,�������. ', '2221-06-08 10:00:00 ');
	
INSERT INTO assistance_to_suppliers(  to_supplier_id, body, created_at) 
VALUES ( '7723654855', '  � ���� �87656   �� �� ��������� ',  '2221-06-08 13:00:00 ');	
	
 # ���� ������� ������  ���������� 
DROP TABLE IF EXISTS sellers; 
CREATE TABLE sellers (
	id SERIAL,
    seller_id BIGINT  COMMENT '��� ���������' , 
	seller_name VARCHAR(200),  
	region_id  int,
	email VARCHAR(120) DEFAULT NULL,                                 
	phone BIGINT UNSIGNED UNIQUE,
	PRIMARY KEY(seller_id),
	FOREIGN KEY (region_id ) REFERENCES region(region_id ));

INSERT INTO  sellers( id,seller_id,seller_name, region_id , email, phone) 
 VALUES
(NULL, '7723654891' ,  '��� ����','01',' bvgh@nm.com','78965423136'),
(NULL, '7723612892' , '���� ���', '02', ' bvghj@nm.com','78965423178'),
(NULL, '7723654870' , '��� ���', '03', ' bvghd@nm.com','78965423265'),
(NULL,'7753654892' , '��� ���' , '04',' bvghv@nm.com','78965423241' ),
(NULL, '7123654897' ,'��� ���', '07', ' bvgah@nm.com','78965369854'),
(NULL, '7983654898' ,'�������', '09',' bvghe@nm.com','78923441360' ),
(NULL, '7723654894' , '�������� ������', '10', ' bvwgh@nm.com','78965423698'),
(NULL,'7723654855' ,  '��� ����', '11',' bvqgh@nm.com','78965427898' ),
(NULL, '7723654829' , '�� �����',' 12',' ebvgh@nm.com','7896546336' ),
(NULL, '7723654863' ,  '��� ������','13',' bvegh@nm.com','789652012'),
(NULL,'7723654821' ,  '��� ������' ,'14',' bevgh@nm.com','789654233114'),
(NULL, '7723654805' ,  '���� ������', '15',' bvgeh@nm.com','78965427885'),
(NULL,'7723654887' ,  '��� ����','17', ' bvgfh@nm.com','78965425741'),
(NULL, '7723654889' ,'�������� ���', '32', ' fbvgh@nm.com','7896540480'),
(NULL, '7723654816' ,  '��� ����','36',' bvgfh@nm.com','78965426589'),
(NULL,'7723654832' ,  '����� ��','40', ' bvhgh@nm.com','78965426554'),
(NULL, '7723654437' , '��� ���', '77', ' bhvgh@nm.com','78965426313');

# ���� �������   ������ ����������� ���������� ����������
-- truncate  seller_contracts;

DROP TABLE IF EXISTS seller_contracts;
CREATE TABLE seller_contracts(
	id SERIAL,
	contract_id BIGINT,
	seller_id  BIGINT UNSIGNED NOT NULL,
	contract_name  VARCHAR(255),	
	contract_amount DECIMAL (11,2) COMMENT '����� ���������',
	supplier_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (contract_id),
	FOREIGN KEY (contract_id) REFERENCES sellers(seller_id));

 INSERT INTO seller_contracts( id, contract_id,seller_id,contract_name, contract_amount, supplier_id) 
 VALUES
	(NULL, '3', '7723654870', '������ ������� �������, ����� � �����', '120356.00', '7723612125' ),
	(NULL, '7', '7123654897','������ ����������, ������� � ����������� ������� ', '120000.00', '7987844898' ),
	(NULL, '9', '7723654855','�������� ���������������� �������������',  '576796.70', '7129744897' ),
	(NULL, '11', '7723654863', '�� �������� ����������� ����������',  '110722.34', '7727944855' ),
	(NULL, '12', '7723654821', '���������: 012720000012100015', '691124.00', '77201094863' ),
	(NULL, '13','7723654805', '���������: 012720000012100027', '1026784.00',  '77201094863'),
	(NULL, '17', '7723654832','COM15072100039 (��� 1)', '289000.00',  '7723620314'),
	(NULL, '18','7723654832', 'COM15072100035 (��� 1)', '840000.00', '778564892'),
	(NULL, '19', '7723654832','COM15072100031 (��� 1)', '611000.00', '7723620314');

# ���� ��������� ���������� � ��� ����������.
DROP TABLE IF EXISTS assistance_to_sellers;
CREATE TABLE  assistance_to_sellers(
	id SERIAL PRIMARY KEY, 
	from_seller_id BIGINT UNSIGNED  NULL,
    to_seller_id BIGINT UNSIGNED NULL,
    body TEXT,
	created_at  DATETIME DEFAULT NOW(),  
    FOREIGN KEY (from_seller_id) REFERENCES sellers(id),
    FOREIGN KEY (to_seller_id) REFERENCES sellers(id),
    FOREIGN KEY assistance_to_sellers(id) REFERENCES tech_support(id));
   
INSERT INTO assistance_to_sellers( from_seller_id, body, created_at) 
VALUES ( '7723654891', '��� ��� ������������ ������?', '2221-07-11 10:00:00 ');

INSERT INTO assistance_to_sellers( to_seller_id, body, created_at) 
VALUES ('7723654891', '� ������ �������� ���������', '2221-07-11 13:00:00 ');

INSERT INTO assistance_to_sellers( from_seller_id, body, created_at) 
VALUES ('7723654829' , '������ �������� ������ � ��������� ����������� ��������� ', '2221-07-20 09:00:00 ');
	
INSERT INTO assistance_to_sellers(to_seller_id, body, created_at) 
VALUES ('7723654829' , '��� ���� ������� ����� ������ �� ��������� ', '2221-07-20 12:00:00 ');
  
# ���� ��� ��������� �����..
DROP TABLE IF EXISTS tech_support; 
CREATE TABLE tech_support(
	id SERIAL PRIMARY KEY,	
	body TEXT,
	email VARCHAR(120) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	FOREIGN KEY tech_support (id) REFERENCES  trading_platform(id));

INSERT INTO tech_support( body, email,phone) 
VALUES ( '�� ���� �������� �������� �������� �������������� ���.���������', 'tech@support.com', '84956544587 ');

-- ----------------------------------------------------------------------------------------------------------------------
# ����� �������� ������� status � ���� tenders, ������� ������ ������ � ������� �������.

ALTER TABLE tenders ADD status VARCHAR(20) NULL;

-- �������� ������� status;
/*
 * INSERT into tenders 
SET  tender_id = 3, status = 'signed';
 *�� ��������� ������-��� ��������� ����� ������
 */ 

UPDATE tenders           -- �������� ������ 3-� ������
SET status = 'signed'
WHERE tender_id = 3;

UPDATE tenders           -- ������� �������� = �� in � ��������� ������ ����������
SET status = 'signed'
WHERE tender_id in (7,9,11,12,17,18,19);

UPDATE tenders         
SET status = 'postponed'
WHERE tender_id = 13;

UPDATE tenders         
SET status = 'canceled'
WHERE tender_id = 2;

#  �������� ������� ��������� ������������ �����.

SELECT AVG(starting_price) AS tendersAvg FROM tenders;
# �������� ����� - 30 643 944.00.

# �� ���� tenders ������� ���� � ��� �������������� ��������� ����(�������)
SELECT MAX(starting_price) FROM tenders;
#580 332.80
SELECT MIN(starting_price) FROM tenders;
# 0, ��������� ���� ���� �� ���������, ������� � 0�.
-- ������ �� ����� ������������ ��������� ������:
SELECT
 tender_id ,seller_id, tender_name
FROM
  tenders 
WHERE
  starting_price = (SELECT MAX(starting_price) FROM tenders );
# tender_id 16.

# � ������� JOIN , �������� ���������� �������� ���� ������.
SELECT
		t.tender_name,
		t.starting_price,
		s.seller_name
FROM
 		tenders  AS t
LEFT JOIN                           
  		sellers  AS s
ON
  		s.id = t.tender_id;

 #  LEFT JOIN ����������,��� ������� tenders ����� ������������� ����� ��  LEFT JOIN,� �����  RIGHT JOIN ���������� ������������ ����� ������.
  	
SELECT
		s.seller_name,
		t.tender_name,
		t.starting_price	
FROM
 		sellers  AS s
RIGHT JOIN  
  		starting_price AS t    
ON
  	   s.id = t.tender_id  ; 	
  	  
# �������� ���� ������,��������� ����� ���������� �����������.
SELECT
		sp.contract_id,
		sp.contract_name,
		s.seller_name
FROM
 		supplier_contracts AS sp
RIGHT JOIN
  		sellers  AS s
ON
  		s.id = sp.contract_id;
 # 
SELECT DISTINCT seller_id  FROM tenders;

# �������� ���������� � ������ ����� ����� 1000 �.:
SELECT seller_id, sum(starting_price) as sum 
FROM tenders t 
WHERE starting_price > 1000
GROUP BY seller_id
ORDER BY sum DESC;
-- -------------------------------------------------------------------------------------------------------------------------------
# ��������� ���� supplers_contracts

SELECT supplier_id, sum(contract_amount) as sum 
FROM  supplier_contracts
GROUP BY supplier_id
ORDER BY sum DESC; 

-- ----------------------------------------------------------------------------------------------------------------------------------
/*
 * ������������� (VIEW) � ������ ���� ������, ���������� ����������� ���������� ������� � ���� ������, 
 * ������������� � ������� ��������� SELECT, � ������ ��������� � �������������./
 */
DROP VIEW IF EXISTS table_view;
CREATE VIEW table_view
AS
SELECT  seller_id, tender_name,region_id 
FROM tenders 
ORDER BY 3 DESC 
LIMIT  6;
SHOW TABLES;  -- ������� �������,�� ��� ������� ������������� ����.

# ������,���� �� �������� �������� ��� ��� �������,�� ������ �������������.
SELECT *
FROM table_view ;  
