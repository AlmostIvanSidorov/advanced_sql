DROP TABLE IF EXISTS users;
DROP PROCEDURE IF EXISTS create_user;
CREATE TABLE users (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NULL,
    last_name VARCHAR(50) NULL,
    password VARCHAR(50) NULL
);
INSERT INTO users (id, first_name, last_name, password)
VALUES
    (1, 'Виктор', 'Алтушев', 'e38ad214943daad1d64c102faec29de4afe9da3d'),
    (2, 'Светлана', 'Иванова', '2aa60a8ff7fcd473d321e0146afd9e26df395147'),
    (3, 'Елена', 'Абрамова', '1119cfd37ee247357e034a08d844eea25f6fd20f'),
    (4, 'Василиса', 'Кац', 'a1d7584daaca4738d499ad7082886b01117275d8'),
    (5, 'Антон', 'Сорокин', 'edba955d0ea15fdef4f61726ef97e5af507430c0'),
    (6, 'Алёна', 'Алясева', '6d749e8a378a34cf19b4c02f7955f57fdba130a5'),
    (7, 'Лиана', 'Белая', '330ba60e243186e9fa258f9992d8766ea6e88bc1');