FIRST_VALUE()


SELECT *, DATE_FORMAT(TIMEDIFF(time, FIRST_VALUE(time) OVER()), "%H:%i:%s") AS champion_lag FROM (SELECT
     ROW_NUMBER() OVER() as place,
     last_name,
     first_name,
     DATE_FORMAT(TIMEDIFF(end_time, start_time), "%H:%i:%s") AS time  
FROM runners ORDER BY time) t ORDER BY place

LAST_VALUE()
NTH_VALUE()

ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING

select 
    month,
    income,
    income - NTH_VALUE(SUM(income), 4) OVER(ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as diff,
     ROUND((income - NTH_VALUE(SUM(income), 4) OVER(ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))*100/NTH_VALUE(SUM(income), 4) OVER(ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),1) as diff_percent 
    
from revenues  where year = 2021 GROUP BY month, income ORDER BY month

select
    year,
    month,
    income,
    income - NTH_VALUE(SUM(income), 4) OVER(PARTITION BY year ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as diff,
     ROUND((income - NTH_VALUE(SUM(income), 4) OVER(PARTITION BY year ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))*100/NTH_VALUE(SUM(income), 4) OVER(PARTITION BY year ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),1) as diff_percent 
    
from revenues  GROUP BY year, month, income ORDER BY year,month

-- скользящее среднее

PARTITION BY year ORDER BY month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING 

SELECT
    ROW_NUMBER() OVER(ORDER BY id) as month, 
    plan 
    FROM (
        SELECT
            id,
            ROUND(
                 income * 
                 AVG(income) OVER (
                     ORDER BY year, month
                     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) /
                 AVG(income) OVER (
                     ORDER BY year, month
                     ROWS BETWEEN 14 PRECEDING AND 12 PRECEDING)  
            ) as plan
         FROM revenues
         ORDER BY id
     ) tmp
WHERE plan IS NOT NULL
ORDER BY month