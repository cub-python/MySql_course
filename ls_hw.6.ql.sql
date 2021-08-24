# ������������ ������� �� ���� ����������, ����������, ���������� � �����������. ��������� �������. �������� � �� vk � �������, ������� �� ������������� �����:
# 1.����� ����� ��������� ������������. �� ���� ������������� ���. 
# ���� ������� ��������, ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).
-- �������� ��������� �� ������������ � � ������������ (��� � �� ���)
USE vk;  
SELECT count(*) messages, friend FROM # count(*)-����� ���-�� �������
	(SELECT body, to_user_id AS friend FROM messages WHERE from_user_id = 1
	# �������� ����(�����), ������������ ��� ����� �� ��������� ��� �� ������������=1(�� ����)
	 UNION # (���������)                                      
	 SELECT body,from_user_id AS friend FROM messages WHERE to_user_id = 1) as history
     # �������� ����(�����), ������������ ��� ����� �� ��������� ��� � ������������=1(�� ���)
GROUP BY friend
ORDER BY messages DESC
LIMIT 3
; # ��������� ��� ���,� ������� ��� �� id=1 �������� ����� 3 ����� ���� ���� �������,�� ������ �������.
# ������ ����� ������������� � id = 8.,��� ����� ����� - 9.

#2.	���������� ����� ���������� ������, ������� �������� ������������ 
# ������ 10 ���..

SELECT COUNT(*) as 'Likes' FROM profiles WHERE (YEAR(NOW())-YEAR(birthday)) < 10; 
# ������� 'Likes'�� ���� profiles,������� birthday(YEAR(NOW())��� ���� ��������� 
# ��� �������� � ������� < 10 ���.  
SELECT COUNT(*) as 'Likes' FROM profiles WHERE (YEAR(NOW())-YEAR(birthday)) < 10;

#3.	���������� ��� ������ �������� ������ (�����): ������� ��� �������.

SELECT COUNT(*) as 'Likes' FROM profiles GROUP BY gender;
# ������� ���-�� ������,��� ������������ �� ������� � ������������ �� 2 ������.
# m = 58 & f = 48
