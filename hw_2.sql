
-- Создаём табл Игры
DROP TABLE IF EXISTS games;
CREATE TABLE games(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(300),	
	FOREIGN KEY (user_id) REFERENCES users(id) 
);
-- создаём таблицу Игры users, 
-- как я понялб это табл будет связан с табл users и games внешн ключами.
DROP TABLE IF EXISTS users_games;
CREATE TABLE users_games(
	user_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, game_id),            -- чтобы не было 2 записей
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);
-- Таблица Маркет.
DROP TABLE IF EXISTS market;
CREATE TABLE market(
    user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(15),	
	FOREIGN KEY (user_id) REFERENCES users(id)
);
 -- По моим понятиям, главное это предназначение столбцов и 
 -- правильное взаимосвязь между таблицами, то есть FOREIGN KEY.
-- для меня пока сложновато понять и применить КЛЮЧИ.