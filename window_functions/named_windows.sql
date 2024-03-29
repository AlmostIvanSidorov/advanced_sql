-- 1. Именованное окно с сегментами и сортировкой

SELECT
    ROW_NUMBER() OVER by_month as order_num,
    RANK() OVER by_month as rank_num,
    DENSE_RANK() OVER by_month as dense_num,
    user_id, amount, date
FROM orders
WHERE YEAR(date) = 2021
WINDOW by_month AS (
    PARTITION BY YEAR(date), MONTH(date)
    ORDER BY date)
ORDER BY date, id
-- 2. Именованное окно только с сегментами. 
-- Сортировка происходит в окнах в блоке SELECT

SELECT
    ROW_NUMBER() OVER (
        by_month ORDER BY date) as order_num,
    RANK() OVER (
        by_month ORDER BY amount) as rank_num,
    DENSE_RANK() OVER 
        (by_month ORDER BY user_id) as dense_num,
    user_id, amount, date
FROM orders
WHERE YEAR(date) = 2021
WINDOW by_month AS (
    PARTITION BY YEAR(date), MONTH(date)
)
ORDER BY date, id