SELECT
    MONTH(date) as month,
    SUM(amount) as month_revenue,
    SUM(amount) - LEAD(SUM(amount), 3, SUM(amount)) OVER (ORDER BY MONTH(date)) as diff
FROM orders
WHERE YEAR(date) = 2021
GROUP BY month
ORDER BY month;

SELECT
    MONTH(date) as month,
    SUM(amount) as month_revenue,
    SUM(amount) - LAG(SUM(amount), 3, SUM(amount)) OVER (ORDER BY MONTH(date)) as diff
FROM orders
WHERE YEAR(date) = 2021
GROUP BY month
ORDER BY month;

SELECT
    month,
    SUM(income) as in2020,
    LEAD(SUM(income),12) OVER() as in2021,
    LEAD(SUM(income),12) OVER() - SUM(income) as diff
FROM revenues
GROUP BY year,month limit 12

SELECT 
    month,
    income as in2020,
    LEAD(income, 12, 0) OVER() as in2021,
    LEAD(income, 12, 0) OVER() - income as diff
FROM revenues
LIMIT 12

SELECT 
    month, in2020, in2021, 
    in2021-in2020 as diff FROM (
    SELECT 
        year, month, income as in2021,
        LAG(income, 12) OVER () as in2020
    FROM revenues
) t
WHERE year = 2021
ORDER BY month

SELECT quarter, sum(in2020) as in2020, sum(in2021) as in2021, sum(in2021)- sum(in2020) as diff FROM(SELECT
    year, month, income as in2021,
        LAG(income, 12) OVER () as in2020,
    NTILE(4) OVER(PARTITION BY year ORDER BY month) AS quarter 
FROM revenues) t where year = 2021 GROUP BY quarter;

SELECT 
    month, 
    ROUND(income * income / (LAG(income) OVER (PARTITION BY month ORDER BY year))) as plan 
FROM revenues ORDER BY year DESC, month
LIMIT 12;
