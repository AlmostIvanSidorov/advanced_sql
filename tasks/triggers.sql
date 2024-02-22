DELIMITER $$
CREATE TRIGGER calc_client_balance AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
    UPDATE users SET balance = get_client_balance(OLD.user_id) WHERE id = NEW.user_id;
END $$
DELIMITER ;

UPDATE accounts SET balance = balance + 5000 WHERE id = 4;

DELIMITER $$
CREATE TRIGGER calc_client_balance_after_insert AFTER INSERT ON accounts
FOR EACH ROW
BEGIN
    UPDATE users SET balance = get_client_balance(NEW.user_id) WHERE id = NEW.user_id;
END $$
DELIMITER ;