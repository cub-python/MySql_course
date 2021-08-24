                                                                                                                                                                                                    DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;


DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50),
	lastname VARCHAR(50) COMMENT 'Фамиль',           -- COMMENT на случай если имя неочевидное
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR(100), 
	phone BIGINT UNSIGNED UNIQUE
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
	
    -- , FOREIGN KEY (photo_id) REFERENCES media(id) -- пока рано, т.к. таблицы media еще нет
);

ALTER TABLE profiles ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE -- (значение по умолчанию)
    ON DELETE RESTRICT; -- (значение по умолчанию)

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests(
	-- id SERIAL, -- изменили на составной ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    -- `status` TINYINT(1) UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, -- можно будет даже не упоминать это поле при обновлении
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id),
    -- CHECK (initiator_user_id <> target_user_id)
);
-- чтобы пользователь сам себе не отправил запрос в друзья
-- ALTER TABLE friend_requests 
-- ADD CHECK(initiator_user_id <> target_user_id);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	INDEX communities_name_idx(name), -- индексу можно давать свое имя (communities_name_idx)
	FOREIGN KEY (admin_user_id) references users(id)
	-- FOREIGN_KEY_CHECKS = 0,
);
-- DELETE FROM communities 
-- WHERE id SERIAL;


DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name VARCHAR(255), -- записей мало, поэтому в индексе нет необходимости
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id  SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    -- file blob,    	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);
DELETE FROM media 
WHERE size INT

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()

    -- PRIMARY KEY (user_id, media_id) – можно было и так вместо id в качестве PK
  	-- слишком увлекаться индексами тоже опасно, рациональнее их добавлять по мере необходимости (напр., провисают по времени какие-то запросы)  

/* намеренно забыли, чтобы позднее увидеть их отсутствие в ER-диаграмме
    , FOREIGN KEY (user_id) REFERENCES users(id)
    , FOREIGN KEY (media_id) REFERENCES media(id)
*/
);

DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums`(
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL,
	`album_id` BIGINT unsigned NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS games;
CREATE TABLE games(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(300),	
	FOREIGN KEY (user_id) REFERENCES users(id) 
);

DROP TABLE IF EXISTS users_games;
CREATE TABLE users_games(
	user_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, game_id),            -- чтобы не было 2 записей
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id)
);
DROP TABLE IF EXISTS market;
CREATE TABLE market(
    user_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(15),	
	FOREIGN KEY (user_id) REFERENCES users(id)
);
  -- Урок №4
-- таблица users

INSERT INTO users (id, firstname, lastname, email, phone) 
VALUES
('1', 'Reuben', 'Nienow', 'arlo50102@example.org', '9374071116'),
('2', 'Frederik', 'Upton', 'terrence.cartwright@example.org', '9127498182'),
('3', 'Unique', 'Windler', 'rupert55@example.org', '9921090703'),
('4', 'Norene', 'West', 'rebekah29@example.net', '9592139196'),
('5', 'Frederick', 'Effertz', 'von.bridget@example.net', '9909791725'),
('6', 'Reuba', 'Nieno', 'arlo501@example.org', '9374071110'),
('7', 'Fred', 'Upto', 'terrence.cartwrigh@example.org', '9127498181'),
('8', 'Uniq', 'Windle', 'rupert5@example.org', '9921090706'),
('9', 'Nor', 'Westa', 'rebekah2@example.net', '9592139192'),
('10', 'Fredericko', 'Efferts', 'von.bridge@example.net', '9909791724'),
('11', 'Reuby', 'Nienowa', 'arlo50@example.org', '9374071117'),
('12', 'Fredes', 'Uptoni', 'terrence.cartwr@example.org', '9127498187'),
('13', 'Uniqum', 'Windleresko', 'rupert@example.org', '9921090700'),
('14', 'Noren', 'Western', 'rebeka@example.net', '9592139190')

;
 -- таблица friend_requests, REPLACE INTO -выдавал ошибку -Duplicate entry '1' for key 'PRIMARY' 
-- пришлось применить REPLACE INTO перезаписать сущ .
REPLACE INTO friend_requests (`initiator_user_id`, `target_user_id`, `status`)
VALUES 
('1', '2', 'requested'),
('1', '3', 'requested'),
('1', '4', 'requested'),
('1', '5', 'requested'),
('6', '1', 'requested'),
('2', '8', 'requested'),
('1', '9', 'requested'),
('9', '3', 'requested'),
('10', '2', 'requested'),
('11', '3', 'requested'),
('7', '1', 'requested'),
('1', '13', 'requested'),
('14', '2', 'requested'),
('12', '3', 'requested')
;
-- отклонить запрос в друзья
UPDATE friend_requests
SET 
	status = 'declined'
	-- confirmed_at = now()
WHERE
	initiator_user_id = 1 and target_user_id = 3
;
UPDATE friend_requests
SET 	
 	status = 'approved'
WHERE
	initiator_user_id = 6 and target_user_id = 1
;
-- таблица messages
REPLACE INTO messages(`id`,`from_user_id`,`to_user_id`,`body`,`created_at`) 
values
('1','1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29'),
('2','2','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.',now()),
('3','3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.','1993-09-14 19:45:58'),
('4','4','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.','1985-11-25 16:56:25'),
('5','9','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','1999-09-19 04:35:46'),
('6','1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29'),
('7','2','1','Sint dolores et debitis est ducimus. Aut et quia beatae minus. Ipsa rerum totam modi sunt sed. Voluptas atque eum et odio ea molestias ipsam architecto.',now()),
('8','8','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.','1993-09-14 19:45:58'),
('9','1','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.','1985-11-25 16:56:25'),
('10','11','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','1999-09-19 04:35:46'),
('11','3','1','Sed mollitia quo sequi nisi est tenetur at rerum. Sed quibusdam illo ea facilis nemo sequi. Et tempora repudiandae saepe quo.','1993-09-14 19:45:58'),
('12','10','3','Quod dicta omnis placeat id et officiis et. Beatae enim aut aliquid neque occaecati odit. Facere eum distinctio assumenda omnis est delectus magnam.','1985-11-25 16:56:25'),
('13','1','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','1999-09-19 04:35:46'),
('14','1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','1995-08-28 22:44:29')
;
-- таблица communities
INSERT INTO communities( `id`,`name`,`admin_user_id`)
VALUES
('1','Автолюбителей','2'),
('2','Эколог','1'),
('3','Облако','4'),
('4','Дорожников','5'),
('5','МАМ','12'),
('6','Альпинистов','8'),
('7','Хороших','1'),
('8','Гурманы','7'),
('9','Тиннейджеры','10'),
('10','Дальнобойщиков','11'),
('11','ГСМ','9'),
('12','МММ','14'),
('13','Дельтаплан','6'),
('14','Кино любителей','13')
;
-- таблица users_communities
INSERT INTO (`user_id`,`community_id`)
VALUES
('1','2'),
('2','1'),
('3','3'),
('4','7'),
('5','9'),
('6','14'),
('7','4'),
('8','5'),
('9','6'),
('10','8'),
('11','10'),
('12','11'),
('13','12'),
('14','13')
;

-- ТАБЛИЦА games
INSERT INTO games( `id`,`user_id`,`name`)
VALUES
('1','2','домино'),
('2','1','шахматы'),
('3','3','что? где? когда?'),
('4','7','Чиполино'),
('5','9','Угадайка'),
('6','14','ТИР'),
('7','4','ГОНКИ'),
('8','5','ТОПОР'),
('9','6','Угадайка'),
('10','8','СтройДом'),
('11','10','ГОНКИ'),
('12','11','ТОПОР'),
('13','12','ГОНКИ'),
('14','13','ТОПОР')
;
-- ТАБЛИЦА likes
INSERT INTO likes(`id`,`user_id`,`media_id`,`created_at`)
VALUES
('1','2','8',now()),
('2','1','54',now()),
('3','3','41',now()),
('4','7','12',now()),
('5','9','4',now()),
('6','14','7',now()),
('7','4','18',now()),
('8','5','32',now()),
('9','6','24',now()),
('10','8','6',now()),
('11','10','67',now()),
('12','11','59',now()),
('13','12','11',now()),
('14','13','95',now())
;


-- ТАБЛИЦА profiles
INSERT INTO profiles(`user_id`,`gender`,`birthday`,`created_at`,`hometown`)
VALUES
('1','м','1981-06-25',now(),'Чита'),
('2','ж','1987-10-10',now(),'Оренбург'),
('3','м','1963-07-07',now(),'Элиста'),
('4','ж','1995-12-31',now(),'Кемерово'),
('5','м','1974-11-30',now(),'Тула'),
('6','ж','1996-12-09',now(),'Волгоград'),
('7','м','1977-02-28',now(),'Челябинск'),
('8','ж','1973-03-30',now(),'Обнинск'),
('9','м','1968-07-10',now(),'Тверь'),
('10','ж','1966-11-06',now(),'Киров'),
('11','м','1998-04-03',now(),'Тамбов'),
('12','ж','2000-12-10',now(),'Казань'),
('13','м','1999-01-09',now(),'Севастополь'),
('14','ж','1971-12-11',now(),'Москва')
;


-- ТАБЛИЦА market
INSERT INTO market(`user_id`,`name`)
VALUES
('1','Гардероб'),
('2','Дет.товары'),
('3','Электроника'),
('4','Транспорт'),
('5','Дом и дача'),
('6','Спорт'),
('7','Продукты'),
('8','Услуги'),
('9','Питомцы'),
('10','Компютер'),
('11','Туризм'),
('12','Рыбалка'),
('13','Авто'),
('14','Дача')
;


-- ТАБЛИЦА photo_albums
INSERT INTO photo_albums( `id`,`name`,`user_id`)
VALUES
('1','Чита','12'),
('2','Оренбург','7'),
('3','Элиста','10'),
('4','Кемерово','3'),
('5','Тула','1'),
('6','Волгоград','13'),
('7','Челябинск','1'),
('8','Обнинск','7'),
('9','Тверь','8'),
('10','Киров','9'),
('11','Тамбов','4'),
('12','Казань','5'),
('13','Севастополь','13'),
('14','Москва','6')
;

INSERT INTO photos( `id`,`album_id`,`media_id`)
VALUES
('1','2','8'),
('2','1','4'),
('3','3','1'),
('4','7','12'),
('5','9','14'),
('6','14','7'),
('7','4','11'),
('8','5','9'),
('9','6','2'),
('10','8','6'),
('11','10','7'),
('12','11','13'),
('13','12','3'),
('14','13','5')
;
-- Таблицa media
INSERT INTO media(`id`,`media_type_id`,`user_id`,
`body`,`filename`, `metadata`,`created_at`,`updated_at`)
VALUES
('1','2','8','','',NULL,now(),now()),
('2','1','4','','',NULL,now(),now()),
('3','3','1','','',NULL,now(),now()),
('4','7','12','','',NULL,now(),now()),
('5','9','4','','',NULL,now(),now()),
('6','14','7','','',NULL,now(),now()),
('7','4','8','','',NULL,now(),now()),
('8','5','2','','',NULL,now(),now()),
('9','6','14','','',NULL,now(),now()),
('10','8','6','','',NULL,now(),now()),
('11','10','7','','',NULL,now(),now()),
('12','11','9','','',NULL,now(),now()),
('13','12','11','','',NULL,now(),now()),
('14','13','5','','',NULL,now(),now())
;
-- Таблица media_types
INSERT INTO media_types(`id`,`name`,`created_at`,`updated_at`)
VALUES
('1','Мировые',now(),now()),
('2','Работа',now(),now()),
('3','3',now(),now()),
('4','Музыка',now(),now()),
('5','Проекты',now(),now()),
('6','14',now(),now()),
('7','4',now(),now()),
('8','5',now(),now()),
('9','6',now(),now()),
('10','8',now(),now()),
('11','10',now(),now()),
('12','11',now(),now()),
('13','12',now(),now()),
('14','13',now(),now())
;





























