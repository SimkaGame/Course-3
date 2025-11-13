ROLLBACK;

DROP TABLE IF EXISTS developer CASCADE;
DROP TABLE IF EXISTS game CASCADE;
DROP TABLE IF EXISTS game_info CASCADE;
DROP TABLE IF EXISTS game_credit CASCADE;


CREATE TABLE developer (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    country TEXT
);

CREATE TABLE game (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INTEGER NOT NULL
        CHECK (release_year BETWEEN 1970 AND EXTRACT(YEAR FROM CURRENT_DATE)),
    primary_developer_id INTEGER NOT NULL
        REFERENCES developer (id)
        ON DELETE RESTRICT
);

CREATE TABLE game_info (
    game_id INTEGER PRIMARY KEY
        REFERENCES game (id)
        ON DELETE CASCADE,
    engine TEXT,
    age_rating TEXT
        CHECK (age_rating IN ('E','T','M','AO')),
    playtime_hours NUMERIC
        CHECK (playtime_hours > 0)
);

CREATE TABLE game_credit (
    game_id INTEGER NOT NULL
        REFERENCES game (id)
        ON DELETE CASCADE,
    developer_id INTEGER NOT NULL
        REFERENCES developer (id),
    role TEXT    NOT NULL,
    PRIMARY KEY (game_id, developer_id, role)
);