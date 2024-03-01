SELECT 
    NTILE(3) OVER() AS mail_variant,
    id,
    email,
    first_name
FROM users
ORDER BY id

SELECT 
    NTILE(4) OVER(win) AS mail_variant,
    id,
    email,
    first_name
FROM users 
WINDOW win AS (ORDER BY MD5(email))
ORDER BY id

SELECT
    name,
    first_name,
    last_name,
    SUM(amount) AS amount,
    NTILE(4) OVER(PARTITION BY name ORDER BY SUM(amount) DESC) AS c_level
FROM shops sh
JOIN orders ord ON ord.shop_id = sh.id
JOIN users us ON us.id = ord.user_id
WHERE status = 'success'
GROUP BY name,first_name,last_name
ORDER BY name, c_level;

SELECT month,first_name,last_name,amount FROM (SELECT
    MONTH(date) as month,
    first_name,
    last_name,
    SUM(amount) AS amount,
    NTILE(4) OVER(PARTITION BY MONTH(date) ORDER BY SUM(amount) DESC) AS c_level
FROM orders ord
JOIN users us ON us.id = ord.user_id
WHERE status = 'success'
GROUP BY month,first_name,last_name) tem_table
WHERE c_level = 1
ORDER BY month, amount;
