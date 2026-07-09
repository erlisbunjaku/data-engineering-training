-- Task S2: More filtering with WHERE

-- Show only cancelled orders
SELECT *
FROM orders
WHERE status = 'cancelled';

-- Show orders where price is greater than 100
SELECT *
FROM orders
WHERE price > 100;

-- Show orders from Vushtrri
SELECT *
FROM orders
WHERE city = 'Vushtrri';

-- Show orders where category is Accessories
SELECT *
FROM orders
WHERE category = 'Accessories';


-- Task S3: Combine filters

-- Show completed orders where price is greater than 100
SELECT *
FROM orders
WHERE status = 'completed' AND price > 100;

-- Show completed orders from Prishtina
SELECT *
FROM orders
WHERE status = 'completed' AND city = 'Prishtina';

-- Show orders where status is pending OR cancelled
SELECT *
FROM orders
WHERE status = 'pending' OR status = 'cancelled';

-- Show Accessories orders where price is less than 50
SELECT *
FROM orders
WHERE category = 'Accessories' AND price < 50;


-- Task S4: Sorting and limiting

-- Show orders from cheapest to most expensive
SELECT *
FROM orders
ORDER BY price ASC;

-- Show orders from most expensive to cheapest
SELECT *
FROM orders
ORDER BY price DESC;

-- Show top 3 most expensive orders by price
SELECT *
FROM orders
ORDER BY price DESC
LIMIT 3;

-- Show top 3 orders by total_amount
SELECT 
    *,
    quantity * price AS total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 3;


-- Task S5: Calculated columns

-- Show customer_name, product, quantity, price, and total_amount
SELECT 
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders;

-- Show only completed orders with total_amount
SELECT 
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE status = 'completed';

-- Show completed orders with total_amount sorted from highest to lowest
SELECT 
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;