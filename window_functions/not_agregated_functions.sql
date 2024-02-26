SELECT ROW_NUMBER() OVER() AS place, name, rating FROM films ORDER BY rating DESC;

SELECT ROW_NUMBER() OVER() AS line_num, order_id , product_id FROM orders_products ORDER BY order_id , product_id;

SELECT ROW_NUMBER() OVER() + 20 AS num, name, count, price FROM products ORDER BY order_id , product_id;
