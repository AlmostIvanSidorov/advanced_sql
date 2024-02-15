from db_connection import MySQL,ExecuteError

mysql = MySQL()

# mysql.execute("SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;")
mysql.execute("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;")

mysql.execute("START TRANSACTION;")

try:
    mysql.execute("SELECT @sum := 5000, @from := 4, @to := 2;")
    mysql.execute("SELECT @balance_from := balance FROM accounts WHERE id = @from;")
    mysql.execute("SELECT @balance_to := balance FROM accounts WHERE id = @to;")

    mysql.sleep(5)

    mysql.execute("UPDATE accounts SET balance = @balance_from - @sum WHERE id = @from;")
    mysql.execute("UPDATE accounts SET balance = @balance_to + @sum WHERE id = @to;")
    mysql.execute("COMMIT;")
except ExecuteError:
    mysql.execute("ROLLBACK;")