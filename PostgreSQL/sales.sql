DROP TABLE IF EXISTS sales;

-- Создание таблицы
CREATE TABLE IF NOT EXISTS sales (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name text NOT NULL,
    quantity int NOT NULL CHECK (quantity > 0),
    total_amount numeric(10, 2) NOT NULL CHECK (total_amount > 0),
    min_unit_price numeric(10, 2) NOT NULL CHECK (min_unit_price > 0),
    CHECK (total_amount >= quantity * min_unit_price)
);

-- Вставка данных
INSERT INTO sales (product_name, quantity, total_amount, min_unit_price)
VALUES
    ('Ноутбук', 2, 2400.00, 1000.00),
    ('Смартфон', 3, 2100.00, 600.00),
    ('Наушники', 5, 500.00, 90.00),
    ('Монитор', 1, 400.00, 300.00);

SELECT * FROM sales