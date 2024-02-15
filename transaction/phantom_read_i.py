from db_connection import MySQL,ExecuteError

mysql = MySQL()

mysql.execute("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;")
mysql.execute("START TRANSACTION;")

try:
    mysql.execute("INSERT INTO accounts (user_id, balance) VALUES (2,10000)")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")