import psycopg2, psycopg2.extras
from auth_python_to_pg import Connect as auth_data

sql = '''
select * from table as t
'''

try:
    with psycopg2.connect(host= auth_data.hostname, dbname = auth_data.database, user = auth_data.username, password = auth_data.pwd, port = auth_data.port_id) as conn:
        
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:

            cur.execute(sql)
            for record in cur.fetchall():
                print(record['some_column'])


except Exception as error:
    print(error)

finally:
    if conn is not None:
        conn.close()