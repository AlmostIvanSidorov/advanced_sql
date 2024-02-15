from db_connection import MySQL,ExecuteError

mysql = MySQL()

mysql.execute("SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;")
mysql.execute("START TRANSACTION;")

balance = 0

try:
    mysql.print_table("SELECT * FROM accounts WHERE user_id = 2;")
    mysql.sleep(5)
    balance = mysql.get_value("SELECT SUM(balance) FROM accounts WHERE user_id = 2;")
    print(f"Мой баланс: {balance}")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")
