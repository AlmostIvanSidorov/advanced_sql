from db_connection import MySQL,ExecuteError

mysql = MySQL()

mysql.execute("SET TRANSACTION ISOLATION LEVEL READ COMMITTED;")

mysql.execute("START TRANSACTION;")

try:
    mysql.execute("UPDATE accounts SET balance = balance + 50000 WHERE ID =2;")
    mysql.sleep(5)
    mysql.execute("UPDATE accounts SET balance = balance - 50000 WHERE ID =4;")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")