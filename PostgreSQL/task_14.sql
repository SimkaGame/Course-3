drop table if exists posts cascade;

-- Таблица
create table posts (
    id serial primary key,
    title text not null,
    author text not null,
    content text not null,
    published_at timestamp default current_timestamp
);

-- Заполнение
insert into posts (title, author, content)
select
    'статья ' || n,
    'автор' || (random() * 200 + 1)::integer,
    repeat(md5(random()::text || clock_timestamp()::text), 10)
from generate_series(1, 100000) as n;

-- Точный поиск
explain (analyze, buffers, format text)
select count(*) from posts where author = 'автор42';

-- Обычный b-tree индекс
create index idx_posts_author on posts (author);

select count(*) from posts where author = 'автор42';

-- Поиск подстроки без спец. индекса
explain (analyze, buffers, format text)
select count(*) from posts where content ilike '%a1b2c3%';

-- Правильный индекс для ilike
create extension if not exists pg_trgm;
create index idx_posts_content_trgm 
    on posts using gin (content gin_trgm_ops);

select count(*) from posts where content ilike '%a1b2c3%';

explain analyze select count(*) from posts where author = 'автор42';
explain analyze select count(*) from posts where content ilike '%a1b2c3%';