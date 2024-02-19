from transaction.db_connection import MySQL, ExecuteError

mysql = MySQL(auto_commit=True)

try:
    mysql.execute("CALL create_user('Ivan','Sidorov','some_password');")
except ExecuteError:
    pass