SELECT
    ROW_NUMBER() OVER(ORDER BY date) as nums,
    date,
    amount,
    SUM(amount) OVER(
        PARTITION BY YEAR(date), MONTH(date)
        ORDER BY date
    ) as month_amount
FROM orders ORDER BY date

SELECT 
    *,
     SUM(money) OVER(ORDER BY date, id) as balance
FROM transactions ORDER BY date, id;

SELECT * FROM (SELECT 
    *,
     10000 + SUM(money) OVER(ORDER BY date, id) as balance
FROM transactions UNION SELECT 0,'2022-01-01','Начальный баланс', 10000, 10000) as temp_data ORDER BY date, id ;

SELECT 
    *,
     SUM(income) - SUM(outcome) OVER(ORDER BY year, month) as ror
FROM revenues ORDER BY year, month;

SELECT 
    *,
     SUM(income) OVER(ORDER BY year, month) - SUM(outcome) OVER(ORDER BY year, month)as ror
FROM revenues ORDER BY year, month;

SELECT MIN(temp_investment) as investment FROM (SELECT SUM(income - outcome) OVER(ORDER BY year, month) as temp_investment
FROM revenues ORDER BY year, month) as temp WHERE temp_investment < 0;

SELECT COUNT(month) OVER() + 1 as months FROM (SELECT *, SUM(income - outcome) OVER(ORDER BY year, month) as temp_investment
FROM revenues ORDER BY year, month) as temp WHERE temp_investment < 0 LIMIT 1;

SELECT months FROM (
    SELECT
        ROW_NUMBER() OVER() as months,
        SUM(income - outcome) OVER (ORDER BY year, month) as ror
    FROM revenues
    ORDER BY year, month
) t
WHERE ror > 0
LIMIT 1
