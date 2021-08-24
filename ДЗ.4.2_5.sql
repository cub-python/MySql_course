-- ��_4_2
/*�������� ������, ������������ ������ ���� (������ firstname) ������������� 
 ��� ���������� � ���������� ������� */

SELECT name FROM games ORDER BY name;

SELECT firstname FROM users ORDER BY firstname;


-- ��_4_3
-- �������� ������, ���������� ������������������ ������������� ��� ���������� 
-- (���� is_active = false). �������������� �������� ����� ���� 
-- � ������� profiles �� ��������� �� ��������� = true (��� 1)

-- ������� profiles
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
;	
ALTER TABLE profiles ADD is_active BIT DEFAULT false NULL;
UPDATE profiles
SET is_active = 1;

-- ��_4_4
-- �������� ������, ��������� ��������� ��� �������� (���� ������ �����������)
--  �������� ��������� � id 15 ���� �� ��������
UPDATE messages
	SET created_at='2021-07-28 00:06:29'
	WHERE id = 15;

-- ������ ��������� �� ��������
DELETE FROM messages
WHERE created_at > now()
;


--  �������� �������� ���� ��������� ������� (� �����������)
-- ����: ����� ����������, Stroykatut.ru (����� ����������� ������� �� �������������,����� ���)

