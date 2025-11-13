--Переименование
ALTER TABLE order_raw RENAME TO orders;

--Преобразование
ALTER TABLE orders
    ALTER COLUMN amount_cents TYPE numeric(12,2)
    USING amount_cents / 100.0;

--Переименование столбца
ALTER TABLE orders RENAME COLUMN amount_cents TO amount;

--Заполнение
ALTER TABLE orders ADD COLUMN order_code text;

UPDATE orders
SET order_code = 'ORD-' ||
    TO_CHAR(placed_at, 'YYYYMM') || '-' ||
    LPAD(id::text, 5, '0');

--Удаление
ALTER TABLE orders DROP COLUMN deprecated;