SELECT id, first_name, last_name, MIN(DATE_FORMAT(date,'%d.%m.%Y')) AS vip_date
FROM 
(
SELECT user_id AS id, first_name, last_name, date, status,
ROW_NUMBER () OVER (PARTITION BY user_id ORDER BY date) AS sales_num
FROM users
INNER JOIN sales ON users.id = sales.user_id
WHERE status = 'success') temp_table
WHERE sales_num =2
GROUP BY id
ORDER BY id;