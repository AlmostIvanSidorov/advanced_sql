from db_connection import MySQL,ExecuteError

mysql = MySQL()

mysql.execute("SET TRANSACTION ISOLATION LEVEL READ COMMITTED;")
mysql.execute("START TRANSACTION;")

balance = 0

try:
    mysql.execute("UPDATE accounts SET balance = balance + 10000 WHERE ID =4;")
    balance = mysql.get_value("SELECT balance FROM accounts WHERE ID = 2;")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")

print(f"Мой баланс: {balance}")