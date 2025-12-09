import psycopg2
import time
import json

with open('config.json') as f:
    config = json.load(f)

conn = psycopg2.connect(**config['db_config'])
conn.autocommit = True
cur = conn.cursor()

author = config['test_values']['author']
substr = config['test_values']['substring']

def run(query, params=None):
    start = time.time()
    cur.execute(query, params)
    cur.fetchall()
    return time.time() - start

with open('db.sql') as f:
    cur.execute(f.read())

#1
t1 = run("SELECT COUNT(*) FROM posts WHERE author = %s", (author,))
print(f"3. Время по author (без индекса): {t1} сек")

#2
cur.execute("CREATE INDEX idx_author ON posts(author)")

#3
t2 = run("SELECT COUNT(*) FROM posts WHERE author = %s", (author,))
print(f"5. Время по author (с индексом):  {t2} сек")

#4
t3 = run("SELECT COUNT(*) FROM posts WHERE lower(content) ILIKE %s", (f'%{substr.lower()}%',))
print(f"6. Время ILIKE по content (без индекса): {t3} сек")

#5
cur.execute("CREATE INDEX idx_content_lower ON posts (lower(content))")

#6
t4 = run("SELECT COUNT(*) FROM posts WHERE lower(content) ILIKE %s", (f'%{substr.lower()}%',))
print(f"8. Время ILIKE по content (с индексом):  {t4} сек")

conn.close()