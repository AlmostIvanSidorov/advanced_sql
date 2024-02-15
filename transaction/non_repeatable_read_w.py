from db_connection import MySQL,ExecuteError

mysql = MySQL()

mysql.execute("SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;")
mysql.execute("START TRANSACTION;")

try:
    mysql.execute("UPDATE accounts SET balance = balance - 10000 WHERE ID = 4;")
    mysql.execute("UPDATE accounts SET balance = balance + 10000 WHERE ID = 2;")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")