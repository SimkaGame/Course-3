SELECT 
    id,
    customer_name,
    amount,
    TO_CHAR(placed_at, 'YYYY-MM-DD') AS placed_at,
    status,
    order_code
FROM orders
ORDER BY id
LIMIT 10;