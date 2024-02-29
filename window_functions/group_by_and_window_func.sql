SET sql_mode = 'ONLY_FULL_GROUP_BY';

SELECT
    YEAR(date) as year,
    MONTH(date) as month,
    SUM(amount) as month_amount,
    SUM(SUM(amount)) OVER(
        PARTITION BY YEAR(date)
        ORDER BY YEAR(date), MONTH(date)
    ) as cumulative_amount
FROM orders
GROUP BY year, month
ORDER BY year, month

-- сперва данные и потом оконные функции

SELECT QUARTER(date) as quarter, SUM(income) OVER(PARTITION BY QUARTER(date)) as income,SUM(income) OVER(PARTITION BY QUARTER(date) ORDER BY date) as income_acc, (SUM(income) OVER(PARTITION BY QUARTER(date) ORDER BY date))*0.06 as usn6 FROM transactions 