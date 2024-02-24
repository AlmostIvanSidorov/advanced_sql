SET foreign_key_checks = 0;
DROP TABLE IF EXISTS orders;
SET foreign_key_checks = 1;
CREATE TABLE orders (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NULL,
    date DATE NOT NULL,
    amount INTEGER NULL
);
INSERT INTO orders (id, user_id, date, amount)
VALUES
    (1, 138, '2021-01-01', 4500),
    (2, 491, '2021-01-02', 700),
    (3, 9841, '2021-01-04', 1200),
    (4, 174, '2021-01-04', 500),
    (5, 19, '2021-01-04', 8700),
    (6, 792, '2021-01-12', 1350),
    (7, 145, '2021-01-14', 600),
    (8, 491, '2021-02-01', 600),
    (9, 145, '2021-02-16', 1400),
    (10, 95, '2021-02-28', 4300),
    (11, 481, '2021-03-12', 8000),
    (12, 491, '2021-04-01', 980),
    (13, 45, '2021-04-14', 1600),
    (14, 671, '2020-12-30', 1500),
    (15, 145, '2020-12-31', 2500),
    (16, 891, '2020-12-29', 3500);
DELETE FROM orders WHERE id = 5;

SELECT 
    *,
    SUM(amount) OVER() as total,
    SUM(amount) OVER(PARTITION BY MONTH(date)) as month_total,
    amount * 100 / SUM(amount) OVER(PARTITION BY MONTH(date)) as percent
FROM orders
WHERE YEAR(date) = 2021

-- В таблице ниже содержатся данные по продажам за каждый месяц в течение двух лет. Напишите SQL запрос, который выведет три колонки: месяц, год и процентный вклад каждого месяца в итоги года.

-- Последняя колонка должна называться month_percent и данные в ней нужно округлить до 1 знака после десятичной точки.
-- Итоговые данные нужно отсортировать по году и месяцу.
SELECT 
    month, year,
    ROUND(revenue * 100 / SUM(revenue) OVER(PARTITION BY year),1) as month_percent
FROM revenues ORDER BY year,month;



-- В одной из прошлых задач мы добавили в таблицу население каждой страны. Теперь давайте посчитаем долю (процент) населения каждого города в общем населении страны.

-- Напишите SQL запрос, который выводит все столбцы таблицы +2 колонки: одну с общим населением страны, в котором находится город, а вторую с процентом, который текущий город занимает в стране.

-- Колонка с общим населением должна называться country_population, а с процентом percent. Проценты нужно вывести с округлением до двух знаков после десятичной точки.

-- Итоговые данные отсортируйте по населению страны и по населению города в возрастающем порядке.

SELECT 
    *,
    SUM(population) OVER(PARTITION BY country) as country_population,
    ROUND(population*100/SUM(population) OVER(PARTITION BY country),2) as percent  
FROM cities ORDER BY country_population,population;
