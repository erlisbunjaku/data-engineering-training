-- ==========================================
-- Part 2 - Basic Aggregations
-- Day 6 SQL Business Reporting Sprint
-- ==========================================


-- Count all orders
SELECT 
    COUNT(*) AS total_orders
FROM orders;


-- Count only completed orders
SELECT 
    COUNT(*) AS completed_orders
FROM orders
WHERE status = 'completed';


-- Count only pending orders
SELECT 
    COUNT(*) AS pending_orders
FROM orders
WHERE status = 'pending';


-- Count only cancelled orders
SELECT 
    COUNT(*) AS cancelled_orders
FROM orders
WHERE status = 'cancelled';


-- Calculate total quantity ordered across all statuses
SELECT 
    SUM(quantity) AS total_quantity
FROM orders;


-- Calculate total quantity ordered only from completed orders
SELECT 
    SUM(quantity) AS completed_quantity
FROM orders
WHERE status = 'completed';


-- Find the average product price
SELECT 
    AVG(price) AS average_product_price
FROM products;


-- Find the cheapest product price
SELECT 
    MIN(price) AS cheapest_product_price
FROM products;


-- Find the most expensive product price
SELECT 
    MAX(price) AS most_expensive_product_price
FROM products;


-- Calculate completed revenue using quantity * price
-- Only completed orders count as real revenue
SELECT
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed';


-- Calculate potential value from pending and cancelled orders
-- This is not real revenue because these orders are not completed
SELECT
    SUM(orders.quantity * products.price) AS potential_value
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status IN ('pending', 'cancelled');