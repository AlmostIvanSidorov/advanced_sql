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

SELECT
     *,
     SUM(income) OVER(ORDER BY quarter) as income_acc,
     (SUM(income) OVER(ORDER BY quarter))*0.06 as usn6 
FROM (SELECT QUARTER(date) as quarter, SUM(income) as income FROM transactions GROUP BY QUARTER(date) ORDER BY QUARTER(date)) temp_table; 

SELECT *, members*100/(SUM(members) OVER()) AS percent FROM (SELECT sex, COUNT(sex) AS members FROM users GROUP BY sex) sex ORDER BY percent;

SELECT
    ROW_NUMBER() OVER(ORDER BY age) as age_num,
    age,
    count(age) as clients,
    count(age)*100/SUM(count(age)) OVER() AS percent
FROM users GROUP BY age ORDER BY age;

SELECT 
   YEAR(date) as year,
   user_id,
   SUM(amount) as amount,
   SUM(amount)*100/SUM(SUM(amount)) OVER(PARTITION BY YEAR(date), status) AS percent
FROM orders WHERE status = "success" GROUP BY year, user_id  ORDER BY YEAR(date), amount;