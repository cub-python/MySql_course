
-- ������ ���� ����
DROP TABLE IF EXISTS games;
CREATE TABLE games(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(300),	
	FOREIGN KEY (user_id) REFERENCES users(id) 
);
-- ������ ������� ���� users, 
-- ��� � ������ ��� ���� ����� ������ � ���� users � games ����� �������.
DROP TABLE IF EXISTS users_games;
CREATE TABLE users_games(
	user_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, game_id),            -- ����� �� ���� 2 �������
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);
-- ������� ������.
DROP TABLE IF EXISTS market;
CREATE TABLE market(
    user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(15),	
	FOREIGN KEY (user_id) REFERENCES users(id)
);
 -- �� ���� ��������, ������� ��� �������������� �������� � 
 -- ���������� ����������� ����� ���������, �� ���� FOREIGN KEY.
-- ��� ���� ���� ���������� ������ � ��������� �����.