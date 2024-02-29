-- RANK, DENSE_RANK, NTILE

SELECT
    ROW_NUMBER() OVER(
        PARTITION BY YEAR(date), MONTH(date)
        ORDER BY date) as order_num,
    RANK() OVER(
        PARTITION BY YEAR(date), MONTH(date)
        ORDER BY date) as rank_num,
    DENSE_RANK() OVER(
        PARTITION BY YEAR(date), MONTH(date)
        ORDER BY date) as dense_num,
    user_id, amount, date
FROM orders
WHERE YEAR(date) = "2021"
ORDER BY date

SELECT
    street,
    house,
    price,
    rooms
FROM (
        SELECT
            street,
            house,
            price,
            rooms,
            RANK() OVER(ORDER BY price) AS rank_flats
        FROM flats 
        WHERE rooms > 1
    ) AS query
WHERE rank_flats < 4
ORDER BY rooms desc, price ASC;

SELECT
    street,
    house,
    price,
    rooms
FROM (
        SELECT
            street,
            house,
            price,
            rooms,
            DENSE_RANK() OVER(ORDER BY price) AS rank_flats
        FROM flats 
        WHERE rooms > 1
    ) AS query
WHERE rank_flats < 4
ORDER BY price ASC, rooms desc;

SELECT DENSE_RANK() OVER(ORDER BY SUM(kills-3*deaths) DESC) AS place, team, SUM(kills-3*deaths) AS points FROM cyber_results INNER JOIN cyber_teams ON cyber_results.team_id = cyber_teams.id GROUP BY team ORDER BY points DESC

    