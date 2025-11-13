DROP TABLE IF EXISTS candidates;

CREATE TABLE IF NOT EXISTS candidates (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    department TEXT NOT NULL CHECK (department IN ('Data Platform', 'Data Science', 'Marketing', 'Operations', 'Engineering', 'HR')),
    role TEXT NOT NULL,
    expected_salary NUMERIC NOT NULL CHECK (expected_salary >= 10000 AND expected_salary <= 300000),
    application_date DATE NOT NULL,
    stage TEXT NOT NULL CHECK (stage IN ('Applied', 'Screen', 'Interview'))
);

INSERT INTO candidates
    (full_name, department, role, expected_salary, application_date, stage)
VALUES
    ('Иванов Сергей Петрович', 'Data Platform', 'Senior Data Engineer', 150000, '2021-01-01', 'Interview'),
    ('Петрова Анна Ивановна', 'Data Science', 'Senior Data Scientist', 180000, '2023-12-31', 'Screen'),
    ('Смирнова Ольга Николаевна', 'Marketing', 'Marketing Manager', 60000, '2023-01-15', 'Applied'),
    ('Кузнецов Дмитрий Александрович', 'Marketing', 'Content Strategist', 78000, '2022-03-10', 'Screen'),
    ('Тестов Иван Иванович', 'Operations', 'Operations Manager', 90000, '2015-12-31', 'Applied'),
    ('Тестова Светлана Петровна', 'Operations', 'Logistics Specialist', 85000, '2015-06-01', 'Screen'),
    ('Васильев Павел Андреевич', 'Data Platform', 'Junior Data Engineer', 50000, '2022-05-10', 'Screen'),
    ('Никитина Елена Викторовна', 'Engineering', 'Senior Developer', 120000, '2022-08-20', 'Interview'),
    ('Лебедев Игорь Сергеевич', 'Data Science', 'Senior Researcher', 200000, '2020-12-31', 'Applied'),
    ('Зайцева Юлия Андреевна', 'Marketing', 'Marketing Intern', 30000, '2023-02-10', 'Applied'),
    ('Тестин Михаил Иванович', 'Operations', 'Coordinator', 95000, '2016-01-01', 'Screen'),
    ('Тестова Анна Викторовна', 'HR', 'HR Intern', 40000, '2015-07-01', 'Interview');

-- До исполнения
SELECT * FROM candidates;

-- Выборка
SELECT * FROM candidates
WHERE department ILIKE '%data%' 
    AND role ILIKE '%Senior%' 
    AND application_date BETWEEN '2021-01-01' AND '2023-12-31' 
ORDER BY full_name ASC;

-- Обновление
UPDATE candidates
SET stage = 'Screen'
WHERE department = 'Marketing'
    AND expected_salary BETWEEN 60000 AND 80000
    AND role NOT ILIKE '%Intern%'
    AND stage = 'Applied';

UPDATE candidates
SET stage = 'Interview'
WHERE department = 'Marketing'
    AND expected_salary BETWEEN 60000 AND 80000
    AND role NOT ILIKE '%Intern%'
    AND stage = 'Screen';

-- Удаление
DELETE FROM candidates
WHERE department = 'Operations'
    AND application_date < '2016-01-01'
    AND full_name ILIKE '%Тест%';

-- После исполнения
SELECT * FROM CANDIDATES;