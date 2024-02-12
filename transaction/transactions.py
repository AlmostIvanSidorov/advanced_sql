from db_connection import MySQL,ExecuteError

mysql = MySQL()

mysql.execute("START TRANSACTION;")

try:
    mysql.execute("UPDATE accounts SET balance = balance - 10000 WHERE ID =2;")
    mysql.execute("UPDATE accounts SET balance = balance + 10000 WHERE ID =4;")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")