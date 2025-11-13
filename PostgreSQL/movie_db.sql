--movie_db

CREATE SCHEMA IF NOT EXISTS movie_db;

CREATE TABLE IF NOT EXISTS movie_db.directors (
    director_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT NOT NULL
);

-- Создание таблицы фильмов
CREATE TABLE IF NOT EXISTS movie_db.movies (
    movie_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    country TEXT NOT NULL,
    rating NUMERIC(3,1) DEFAULT 0,
    UNIQUE (title, release_year)
);

INSERT INTO movie_db.directors (name, country)
VALUES ('Андрей Тарковский', 'СССР')
ON CONFLICT DO NOTHING;

-- Вставка тестового фильма
INSERT INTO movie_db.movies (title, release_year, duration, country)
VALUES ('Солярис', 1972, 165, 'СССР')
ON CONFLICT DO NOTHING;

-- Вывод таблиц
SELECT * FROM movie_db.directors;
SELECT * FROM movie_db.movies;
