-- дз_4_2
/*Написать скрипт, возвращающий список имен (только firstname) пользователей 
 без повторений в алфавитном порядке */

SELECT name FROM games ORDER BY name;

SELECT firstname FROM users ORDER BY firstname;


-- дз_4_3
-- Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных 
-- (поле is_active = false). Предварительно добавить такое поле 
-- в таблицу profiles со значением по умолчанию = true (или 1)

-- ТАБЛИЦА profiles
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

-- дз_4_4
-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
--  Поставим сообщению с id 15 дату из будущего
UPDATE messages
	SET created_at='2021-07-28 00:06:29'
	WHERE id = 15;

-- Удалим сообщение из будущего
DELETE FROM messages
WHERE created_at > now()
;


--  Написать название темы курсового проекта (в комментарии)
-- тема: Форум строителей, Stroykatut.ru (будет обсуждаться вопросы по Строительству,ГОСТы итп)

