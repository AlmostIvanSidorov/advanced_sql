
SELECT 
    ROW_NUMBER() OVER(ORDER BY date) AS row_num,
    ROW_NUMBER() OVER(PARTITION BY YEAR(date) ORDER BY date) AS row_year_num,
    ROW_NUMBER() OVER(PARTITION BY YEAR(date), MONTH(date) ORDER BY date DESC) AS row_month_num,
    id, date, amount    
FROM orders ORDER BY date;

SELECT 
    ROW_NUMBER() OVER(ORDER BY date) AS row_num,
    ROW_NUMBER() OVER(PARTITION BY YEAR(date) ORDER BY date) AS row_year_num,
    ROW_NUMBER() OVER(PARTITION BY YEAR(date), MONTH(date) ORDER BY amount DESC) AS row_month_num,
    id, date, amount    
FROM orders ORDER BY date;


SET foreign_key_checks = 0;
DROP TABLE IF EXISTS films;
SET foreign_key_checks = 1;
CREATE TABLE films (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NULL,
    rating FLOAT NULL,
    year INTEGER NULL,
    votes INTEGER NULL,
    genre VARCHAR(20)
);
INSERT INTO films (id, name, rating, year, votes, genre)
VALUES
    (1, 'Зеленая миля', 9.135, 1999, 431238, 'фэнтези'),
    (2, 'Бойцовский клуб', 8.715, 1999, 410297, 'триллер'),
    (3, 'Форрест Гамп', 9.013, 1994, 421514, 'драма'),
    (4, 'Побег из Шоушенка', 9.191, 1994, 460078, 'драма'),
    (5, 'Список Шиндлера', 8.884, 1993, 233033, 'драма'),
    (6, 'Иван Васильевич меняет профессию', 8.707, 1973, 320339, 'фантастика'),
    (7, 'Леон', 8.778, 1994, 351308, 'боевик'),
    (8, 'Начало', 8.775, 2010, 484028, 'фантастика'),
    (9, '1+1', 8.838, 2011, 444942, 'драма'),
    (10, 'Король Лев', 8.758, 1994, 300302, 'мультфильм'),
    (11, 'Интерстеллар', 8.600, 2014, 658425, 'фантастика');

SELECT 
    genre,
    ROW_NUMBER() OVER(PARTITION BY genre ORDER BY rating DESC) AS genre_place,
    rating, name   
FROM films;

CREATE TABLE results (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NULL,
    first_name VARCHAR(50) NULL,
    points FLOAT NOT NULL
);
INSERT INTO results (id, last_name, first_name, points)
VALUES
    (1, 'Алтушев', 'Виктор', 9.64),
    (2, 'Иванова', 'Светлана', 9.73),
    (3, 'Абрамова', 'Елена', 7.11),
    (4, 'Кац', 'Василиса', 8.48),
    (5, 'Сорокин', 'Антон', 9.71),
    (6, 'Алясева', 'Алёна', 9.55),
    (7, 'Белая', 'Лиана', 9.63),
    (8, 'Белая', 'Карина', 7.47),
    (9, 'Дейчман', 'Анастасия', 8.98),
    (10, 'Фёдорова', 'Юлия', 9.69);

SELECT 
    *,
    ROW_NUMBER() OVER(ORDER BY points DESC) AS place  
FROM results ORDER BY id;

-- Выведите все столбцы + добавьте колонку place с местами, которые заняли участники. Первое место получает программист, который набрал больше всех очков. Если несколько участников набрали одинаковое количество баллов, то лучшим среди них считается тот, кто выполнил задания за меньшее время.

-- Итоговые данные выведите в соответствии с занятыми местами - первое место сверху.

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS results;
SET foreign_key_checks = 1;
CREATE TABLE results (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NULL,
    first_name VARCHAR(50) NULL,
    points FLOAT NULL,
    time TIME NULL
);
INSERT INTO results (id, last_name, first_name, points, time)
VALUES
    (1, 'Алтушев', 'Виктор', 9.64, '1:13:45'),
    (2, 'Иванова', 'Светлана', 9.73, '1:13:45'),
    (3, 'Абрамова', 'Елена', 7.11, '1:13:45'),
    (4, 'Кац', 'Василиса', 8.48, '1:13:45'),
    (5, 'Сорокин', 'Антон', 9.71, '1:13:45'),
    (6, 'Алясева', 'Алёна', 9.55, '1:13:45'),
    (7, 'Белая', 'Лиана', 9.64, '1:11:05'),
    (8, 'Белая', 'Карина', 7.47, '1:13:45'),
    (9, 'Дейчман', 'Анастасия', 8.98, '1:13:45'),
    (10, 'Фёдорова', 'Юлия', 9.64, '1:17:00');

SELECT 
    *,
    ROW_NUMBER() OVER(ORDER BY points desc, time) as place 
FROM results ORDER BY points desc;

SELECT name, rating, genre 
FROM (SELECT genre, rating, name, ROW_NUMBER() OVER(PARTITION BY genre ORDER BY rating DESC) as r
FROM films ORDER BY rating DESC) as R 
WHERE r<=2;

with
filter_films as (
select *, row_number() over(partition by genre order by rating DESC) as place
from films)
select name, rating, genre
from filter_films 
where place <= 2
order by rating desc

SELECT decade, ROW_NUMBER() OVER(PARTITION BY decade ORDER BY decade, rating desc) as place, name FROM (SELECT (FLOOR(year/10)*10) as decade, rating, name FROM films) as r