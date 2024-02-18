from transaction.db_connection import MySQL, ExecuteError

mysql = MySQL(auto_commit=True)

try:
    mysql.execute("CALL order_payment(2, 7801, '2019-12-12 07:04:43');")
except ExecuteError:
    pass