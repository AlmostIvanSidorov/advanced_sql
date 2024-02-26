
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