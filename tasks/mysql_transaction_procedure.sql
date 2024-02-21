
DROP PROCEDURE IF EXISTS order_payment;
SET @from_balance := 50;
DELIMITER $$
CREATE PROCEDURE order_payment(order_id int, amount int , payment_date datetime )
BEGIN
    DECLARE _rollback BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET _rollback = TRUE;

    SELECT balance INTO from_balance FROM accounts WHERE id = from_account_id;
    IF from_balance < amount THEN
        SET amount := from_balance;
    AND IF;

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    START TRANSACTION;

    UPDATE orders SET status = 'paid' WHERE id = order_id;
    INSERT INTO transactions (order_id, amount, date) VALUES (order_id, amount, payment_date);

    IF _rollback THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$
DELIMITER ;