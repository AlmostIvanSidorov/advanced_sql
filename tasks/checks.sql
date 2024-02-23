CREATE TABLE products_for_checks (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    ean13 VARCHAR(13) NOT NULL DEFAULT '',
    price INT UNSIGNED,
    sale INT UNSIGNED DEFAULT 0
)

DELIMITER $$
CREATE PROCEDURE check_product(ean13 VARCHAR(13), price INT, sale int)
BEGIN
    DECLARE i INT DEFAULT 1;
    IF LENGTH(ean13) NOT IN(0, 13) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Неверная длина ean13';
    ELSE
        WHILE i <= LENGTH(ean13) DO
            IF SUBSTRING(ean13, i, 1) NOT IN ('0','1','2','3','4','5','6','7','8','9') THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Неверный формат ean13';
            END IF;
            SET i = i + 1;
        END WHILE;
    END IF;
    
    IF sale > price THEN
        SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'Значение скидки больше значения цены';
    END IF;
END$$
DELIMITER ;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE TRIGGER check_product_before_insert BEFORE INSERT ON products_for_checks
FOR EACH ROW
BEGIN
   CALL check_product(NEW.ean13, NEW.price, NEW.sale);
END$$
DELIMITER ;

INSERT INTO products_for_checks (name, ean13, price, sale) VALUES ('Шоколад', '',100, 0)

INSERT INTO products_for_checks (name, ean13, price, sale) VALUES ('Шоколад', '1',100, 0)