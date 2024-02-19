from transaction.db_connection import MySQL, ExecuteError

mysql = MySQL(auto_commit=False)

try:
    mysql.execute("CALL active_products();")
except ExecuteError:
    pass