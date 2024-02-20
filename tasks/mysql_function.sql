SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION get_client_balance (client_id INT) RETURNS DECIMAL
BEGIN
	DECLARE client_balance DECIMAL DEFAULT 0;
    SELECT SUM(balance) INTO client_balance FROM accounts WHERE user_id = client_id;
	RETURN client_balance;
END$$
DELIMITER ;

CALL get_client_balance(2);

SELECT * FROM accounts WHERE balance > get_client_balance(2);