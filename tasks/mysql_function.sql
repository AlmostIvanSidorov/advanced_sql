DELIMITER $$
CREATE FUNCTION get_client_balance (client_id INT) RETURNS DECIMAL
BEGIN
    SELECT SUM(balance) FROM accounts WHERE user_id = client_id;
END$$
DELIMITER ;