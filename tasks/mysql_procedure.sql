
DELIMITER $$
CREATE PROCEDURE order_payment(order_id int, amount int , payment_date datetime )
BEGIN
    UPDATE orders SET status = 'paid' WHERE id = order_id;
    INSERT INTO transactions (order_id, amount, date) VALUES (order_id, amount, payment_date);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE active_products()
BEGIN
    SELECT id,name,count,price FROM products where active = TRUE and count > 0 ORDER BY price;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE create_user(first_name  VARCHAR(50), last_name  VARCHAR(50),password  VARCHAR(50))
BEGIN
    INSERT INTO users (first_name, last_name, password) VALUES (first_name, last_name, SHA(password));
END$$
DELIMITER ;


CREATE PROCEDURE create_user(first_name  VARCHAR(50), last_name  VARCHAR(50),password  VARCHAR(50))
BEGIN
    INSERT INTO users (first_name, last_name, password) VALUES (TRIM(first_name), TRIM(last_name), SHA(password));
END$$
DELIMITER ;
