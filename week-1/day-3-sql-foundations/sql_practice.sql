-- Day 3 Practice - SQL Foundations
-- File: sql_practice.sql
-- Purpose: Practice SELECT, WHERE, AND/OR, ORDER BY, LIMIT, and calculated columns


-- =========================================
-- Level 1 - Read the table
-- =========================================


-- Query 1: Show all columns and rows from orders
SELECT *
FROM orders;


-- Query 2: Show only customer_name and product
SELECT
    customer_name,
    product
FROM orders;


-- Query 3: Show only order_id, product, and status
SELECT
    order_id,
    product,
    status
FROM orders;


-- Query 4: Show customer_name as customer and product as item
SELECT
    customer_name AS customer,
    product AS item
FROM orders;


-- Query 5: Show product, quantity, and price
SELECT
    product,
    quantity,
    price
FROM orders;


-- Query 6: Show order_id and customer_name
SELECT
    order_id,
    customer_name
FROM orders;



-- =========================================
-- Level 2 - Filter rows with WHERE
-- =========================================


-- Query 7: Show only completed orders
SELECT *
FROM orders
WHERE status = 'completed';


-- Query 8: Show only pending orders
SELECT *
FROM orders
WHERE status = 'pending';


-- Query 9: Show only cancelled orders
SELECT *
FROM orders
WHERE status = 'cancelled';


-- Query 10: Show orders where price is greater than 100
SELECT *
FROM orders
WHERE price > 100;


-- Query 11: Show orders where price is less than 100
SELECT *
FROM orders
WHERE price < 100;


-- Query 12: Show orders where price is greater than or equal to 180
SELECT *
FROM orders
WHERE price >= 180;


-- Query 13: Show orders where status is not cancelled
SELECT *
FROM orders
WHERE status != 'cancelled';


-- Query 14: Show orders where customer_name is Arta
SELECT *
FROM orders
WHERE customer_name = 'Arta';


-- Query 15: Show orders where product is Mouse
SELECT *
FROM orders
WHERE product = 'Mouse';



-- =========================================
-- Level 3 - Combine filters with AND / OR
-- =========================================


-- Query 16: Show completed orders where price is greater than 50
SELECT *
FROM orders
WHERE status = 'completed'
AND price > 50;


-- Query 17: Show completed orders where product is Mouse
SELECT *
FROM orders
WHERE product = 'Mouse'
AND status = 'completed';


-- Query 18: Show orders where status is pending OR status is cancelled
SELECT *
FROM orders
WHERE status = 'pending'
OR status = 'cancelled';


-- Query 19: Show orders where customer_name is Dren AND status is completed
SELECT *
FROM orders
WHERE customer_name = 'Dren'
AND status = 'completed';


-- Query 20: Show orders where product is Laptop AND price is 700
SELECT *
FROM orders
WHERE product = 'Laptop'
AND price = 700;


-- Query 21: Show orders where status is completed OR price is greater than 500
SELECT *
FROM orders
WHERE status = 'completed'
OR price > 500;


-- Query 22: Show orders where status is not cancelled AND price is greater than 100
SELECT *
FROM orders
WHERE status != 'cancelled'
AND price > 100;



-- =========================================
-- Level 4 - Sort and limit results
-- =========================================


-- Query 23: Show all orders from cheapest to most expensive
SELECT *
FROM orders
ORDER BY price ASC;


-- Query 24: Show all orders from most expensive to cheapest
SELECT *
FROM orders
ORDER BY price DESC;


-- Query 25: Show the top 3 most expensive orders
SELECT *
FROM orders
ORDER BY price DESC
LIMIT 3;


-- Query 26: Show the cheapest 2 orders
SELECT *
FROM orders
ORDER BY price ASC
LIMIT 2;


-- Query 27: Show completed orders from highest price to lowest price
SELECT *
FROM orders
WHERE status = 'completed'
ORDER BY price DESC;


-- Query 28: Show products sorted alphabetically
SELECT product
FROM orders
ORDER BY product ASC;


-- Query 29: Show customers sorted alphabetically
SELECT customer_name
FROM orders
ORDER BY customer_name ASC;



-- =========================================
-- Level 5 - Calculated columns
-- =========================================


-- Query 30: Show orders with calculated total_amount
SELECT
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders;


-- Query 31: Show completed orders with total_amount
SELECT
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE status = 'completed';


-- Query 32: Show completed orders sorted by total_amount
SELECT
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;


-- Query 33: Show cancelled or pending orders with total_amount
SELECT
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE status = 'cancelled'
OR status = 'pending';


-- Query 34: Show aliases and calculated total_amount
SELECT
    customer_name AS customer,
    product AS item,
    quantity * price AS total_amount
FROM orders;


-- Query 35: Show top 3 orders by total_amount
SELECT
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 3;


-- Query 36: Show orders where total_amount is greater than 100
SELECT
    customer_name,
    product,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE quantity * price > 100;



-- =========================================
-- Query Explanations
-- =========================================


-- Explanation for Query 7:
-- This query shows only completed orders.
-- It filters the orders table using the WHERE condition
-- and helps identify orders that are finished.


-- Explanation for Query 16:
-- This query uses two conditions with AND.
-- It returns only orders that are completed
-- and have a price higher than 50.


-- Explanation for Query 25:
-- This query sorts orders by price from highest to lowest.
-- LIMIT 3 returns only the three most expensive orders.


-- Explanation for Query 30:
-- This query creates a calculated column called total_amount.
-- The value is calculated by multiplying quantity by price.
-- This helps create business-ready order values.


-- Explanation for Query 35:
-- This query calculates total_amount for every order,
-- sorts the results from highest to lowest,
-- and returns the three highest-value orders.