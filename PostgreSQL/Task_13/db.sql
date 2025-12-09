-- ==============================================
-- MUSEUM COLLECTION — DDL + SEED
-- ==============================================

DROP TABLE IF EXISTS loan CASCADE;
DROP TABLE IF EXISTS museum_artwork CASCADE;
DROP TABLE IF EXISTS visitor_museum CASCADE;
DROP TABLE IF EXISTS artwork CASCADE;
DROP TABLE IF EXISTS artist CASCADE;
DROP TABLE IF EXISTS museum CASCADE;
DROP TABLE IF EXISTS visitor CASCADE;

-- -------------------------
-- Художники
CREATE TABLE artist (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    birth_year INT
);

-- -------------------------
-- Произведения искусства
CREATE TABLE artwork (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    artist_id INT REFERENCES artist(id) ON DELETE SET NULL,
    year_created INT,
    medium TEXT,
    description TEXT
);

-- -------------------------
-- Музеи
CREATE TABLE museum (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT,
    established_year INT
);

-- -------------------------
-- Посетители
CREATE TABLE visitor (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- -------------------------
-- MtM: visitor ⇄ museum (абонементы)
CREATE TABLE visitor_museum (
    museum_id INT NOT NULL REFERENCES museum(id) ON DELETE CASCADE,
    visitor_id INT NOT NULL REFERENCES visitor(id) ON DELETE CASCADE,
    card_number TEXT NOT NULL,
    member_since DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (museum_id, visitor_id),
    CONSTRAINT uniq_card_per_museum UNIQUE (museum_id, card_number)
);

-- -------------------------
-- MtM: artwork ⇄ museum (экспозиции)
CREATE TABLE museum_artwork (
    museum_id INT NOT NULL REFERENCES museum(id) ON DELETE CASCADE,
    artwork_id INT NOT NULL REFERENCES artwork(id) ON DELETE CASCADE,
    display_count INT NOT NULL CHECK (display_count >= 0),
    room TEXT,
    PRIMARY KEY (museum_id, artwork_id)
);

-- -------------------------
-- Займы / временные экспозиции
CREATE TABLE loan (
    id SERIAL PRIMARY KEY,
    museum_id INT NOT NULL REFERENCES museum(id) ON DELETE CASCADE,
    card_number TEXT NOT NULL,
    artwork_id INT NOT NULL REFERENCES artwork(id) ON DELETE RESTRICT,
    loan_days INT NOT NULL CHECK (loan_days > 0),
    loaned_at DATE NOT NULL DEFAULT CURRENT_DATE,
    returned_at DATE,
    CONSTRAINT fk_visitor_card FOREIGN KEY (museum_id, card_number)
        REFERENCES visitor_museum (museum_id, card_number)
);

CREATE INDEX idx_loan_card ON loan(museum_id, card_number);
CREATE INDEX idx_loan_artwork ON loan(artwork_id);

-- =========================
-- SEED DATA
-- =========================

-- Artists
INSERT INTO artist (id, name, birth_year) VALUES
(1, 'Иван Иванов', 1880),
(2, 'Мария Козлова', 1925),
(3, 'Джон Доу', 1970),
(4, 'Анна Петрова', 1988),
(5, 'Безымянный мастер', NULL),
(6, 'Старый художник', 1850),
(7, 'Новый талант', 1995);

SELECT setval(pg_get_serial_sequence('artist','id'), (SELECT MAX(id) FROM artist));

-- Artwork
INSERT INTO artwork (id, title, artist_id, year_created, medium, description) VALUES
(1, 'Утро в поле', 1, 1905, 'масло', 'Пейзаж'),
(2, 'Ночной город', 2, 1950, 'акварель', 'Городской пейзаж'),
(3, 'Абстракция №1', 3, 2010, 'микст-медиа', 'Современное искусство'),
(4, 'Портрет неизвестного', NULL, 1890, 'масло', 'Неизвестный автор'),
(5, 'Реплика древнего артефакта', NULL, NULL, 'камень', 'Реплика'),
(6, 'Старый пейзаж', 6, 1875, 'масло', 'Исторический пейзаж'),
(7, 'Новая волна', 7, 2020, 'цифровая печать', 'Современность'),
(8, 'Портрет Анны', 4, 2016, 'масло', 'Портрет'),
(9, 'Эксперимент', 3, 2012, 'инсталляция', 'Инсталляция'),
(10, 'Редкая работа', NULL, 1800, 'темпера', 'Раритет'),
(11, 'Нигде не представлен', NULL, 1800, '-', 'Раритет');

SELECT setval(pg_get_serial_sequence('artwork','id'), (SELECT MAX(id) FROM artwork));

-- Museums
INSERT INTO museum (id, name, city, established_year) VALUES
(1, 'Городской музей искусств', 'Москва', 1910),
(2, 'Музей современного искусства', 'Санкт-Петербург', 1989),
(3, 'Исторический музей', 'Казань', 1950),
(4, 'Частная галерея', 'Вологда', 2005),
(5, 'Муниципальная галерея', 'Екатеринбург', NULL);

SELECT setval(pg_get_serial_sequence('museum','id'), (SELECT MAX(id) FROM museum));

-- Visitors
INSERT INTO visitor (id, name) VALUES
(1, 'Ольга Смирнова'),
(2, 'Павел Кузнецов'),
(3, 'Елена Новикова'),
(4, 'Иван Петров'),
(5, 'Гость без абонемента');

SELECT setval(pg_get_serial_sequence('visitor','id'), (SELECT MAX(id) FROM visitor));

-- Visitor_Museum
INSERT INTO visitor_museum (museum_id, visitor_id, card_number, member_since) VALUES
(1, 1, 'M-1001', '2021-04-10'),
(1, 2, 'M-1002', '2022-06-01'),
(2, 3, 'S-2001', '2023-01-15'),
(3, 4, 'K-3001', '2020-09-09'),
(5, 1, 'V-4001', '2024-02-02'),
(4, 1, 'V-4001', '2024-02-02');

-- Museum_Artwork
INSERT INTO museum_artwork (museum_id, artwork_id, display_count, room) VALUES
(1, 1, 1, 'Зал 1'),
(1, 2, 2, 'Зал 2'),
(1, 4, 1, 'Зал 3'),
(1, 6, 1, 'Зал 4'),

(2, 3, 3, 'Современный зал'),
(2, 5, 2, 'Реплики'),
(2, 9, 1, 'Инсталляции'),

(3, 6, 1, 'Экспозиция 19 в.'),
(3, 10, 1, 'Раритеты'),

-- музей 4 — пустой фонд специально

(5, 7, 2, 'Новый зал'),
(5, 8, 1, 'Портретная галерея');

-- Loans
INSERT INTO loan (museum_id, card_number, artwork_id, loan_days, loaned_at) VALUES
(1, 'M-1001', 1, 30, '2025-10-01'),
(1, 'M-1002', 2, 14, '2025-11-01'),
(2, 'S-2001', 3, 60, '2025-09-20'),
(3, 'K-3001', 6, 90, '2025-08-10'),
(5, 'V-4001', 7, 21, '2025-11-10');

-- ==============================================
-- END OF SEED
-- ==============================================


select 'artist', count(*) from artist
union all
select 'artwork', count(*) from artwork
union all
select 'museum', count(*) from museum
union all
select 'visitor', count(*) from visitor
union all
select 'museum_artwork', count(*) from museum_artwork
union all
select 'loan', count(*) from loan;