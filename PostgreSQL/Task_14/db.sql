DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    content TEXT NOT NULL,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO posts (title, author, content)
SELECT
    'Статья ' || n,
    'автор' || ((random()*199+1)::int),
    'a1b2c3 ' || md5(random()::text)
FROM generate_series(1, 100000) n;