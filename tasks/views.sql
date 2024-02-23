CREATE VIEW users_roles as SELECT u.first_name, u.last_name, r.name FROM users as u JOIN roles as r ON u.role_id =r.id;
SELECT * FROM user_roles;

CREATE VIEW users_without_balance as SELECT u.id, u.first_name, u.last_name FROM test.users as u;
--  вертикальное представление

CREATE VIEW user_some_person as SELECT * FROM test.users as u WHERE id = 2;
--  горизонтальное представление