-- ИСХОДНАЯ ТАБЛИЦА
CREATE TABLE orders_products (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL
);
INSERT INTO orders_products (order_id, product_id) 
VALUES
(1, 4),
(5, 7),
(4, 1),
(3, 1),
(8, 2),
(7, 5),
(11, 4),
(8, 9),
(2, 12),
(5, 1),
(7, 5),
(8, 2),
(9, 9),
(12, 1),
(13, 5),
(8, 2),
(11, 5),
(7, 2),
(1, 4),
(4, 6);
-- РЕШЕНИЕ С WITH И ОКОННЫМИ ФУНКЦИЯМИ
-- Создаем новый столбец
ALTER TABLE orders_products
ADD COLUMN products_count INTEGER DEFAULT 1;

WITH
    -- Удаляем данные из orders_products и сохраняем их копию в deleted_table
    deleted_table as (
        DELETE FROM orders_products RETURNING *
    ),
    -- На основе deleted_table формируем таблицу для вставки
    inserted_table as (
        SELECT
            ROW_NUMBER() OVER(
                PARTITION BY order_id, product_id
                ORDER BY order_id
            ) as row_num,
            order_id,
            product_id,
            COUNT(*) OVER(
                PARTITION BY order_id, product_id
            ) as products_count
        FROM
        deleted_table
	)
-- Вставляем данные из inserted_table в orders_products
INSERT INTO orders_products
SELECT order_id, product_id, products_count FROM inserted_table
WHERE row_num = 1;

-- Создаем уникальный индекс по двум полям
CREATE UNIQUE INDEX op ON orders_products (order_id, product_id);
-- РЕШЕНИЕ С WITH И ГРУППИРОВКОЙ
Для решения задачи можно обойтись и без оконных функций и использовать обычную группировку.

ALTER TABLE orders_products ADD COLUMN products_count INTEGER DEFAULT 1;

WITH 
    deleted_table AS (
        DELETE FROM orders_products RETURNING *),
    inserted_table AS (
        SELECT
            order_id, 
            product_id,
            COUNT(*) as products_count
        FROM deleted_table
        GROUP BY order_id, product_id
    )
INSERT INTO orders_products 
SELECT order_id, product_id, products_count FROM inserted_table;

CREATE UNIQUE INDEX op ON orders_products (order_id, product_id);
РЕШЕНИЕ ЗАДАЧИ В MYSQL
Данную задачу можно решить и в MySQL. Для этого придется создать временную таблицу и заполнить её правильными данными. А после удалить текущую таблицу и переименовать временную.

-- Создаем временную таблицу
CREATE TABLE temp_orders_products (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    products_count INTEGER NOT NULL
);

-- Заполняем временную таблицу данными
INSERT INTO temp_orders_products (order_id, product_id, products_count)
    SELECT order_id, product_id, products_count FROM (
        SELECT
            ROW_NUMBER() OVER(
                PARTITION BY order_id, product_id ORDER BY order_id) as row_num,
            order_id, product_id,
            COUNT(*) OVER(PARTITION BY order_id, product_id) AS products_count
        FROM orders_products) t
    WHERE row_num = 1;

-- Удаляем оригинальную orders_products
DROP TABLE orders_products;

-- Переименовываем временную
RENAME TABLE temp_orders_products TO orders_products;
РЕШЕНИЕ В MYSQL С ПОМОЩЬЮ ГРУППИРОВКИ
CREATE TABLE temp_orders_products (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    products_count INTEGER NOT NULL
);

INSERT INTO temp_orders_products (order_id, product_id, products_count)
    SELECT order_id, product_id, products_count FROM (
        SELECT
            order_id, 
            product_id,
            COUNT(*) as products_count
        FROM orders_products
        GROUP BY order_id, product_id) t;
    
DROP TABLE orders_products;
RENAME TABLE temp_orders_products TO orders_products;