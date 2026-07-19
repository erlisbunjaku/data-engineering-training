-- ==========================================
-- Day 6 SQL Business Reporting
-- GROUP BY Reports
-- GROUP BY + HAVING
-- ==========================================


-- Count orders by status
-- Business question: How many orders exist in each status?
SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;


-- Count orders by order date
-- Business question: How many orders were created each day?
SELECT
    order_date,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_date
ORDER BY order_count DESC;


-- Count orders by customer
-- Business question: Which customers placed the most orders?
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
ORDER BY order_count DESC;


-- Count orders by product
-- Business question: Which products appear most frequently in orders?
SELECT
    product_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY product_id
ORDER BY order_count DESC;


-- Calculate completed quantity by product
-- Only completed orders are included
SELECT
    product_id,
    SUM(quantity) AS completed_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id
ORDER BY completed_quantity DESC;


-- Calculate completed revenue by product
-- JOIN is required because product prices are stored in products table
SELECT
    orders.product_id,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY orders.product_id
ORDER BY completed_revenue DESC;


-- Calculate revenue by order status
-- This is not a perfect business revenue report because
-- pending and cancelled orders are included.
SELECT
    orders.status,
    SUM(orders.quantity * products.price) AS total_value
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY orders.status
ORDER BY total_value DESC;


-- Show customers with more than one order
-- HAVING filters grouped results after COUNT()
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY order_count DESC;


-- Show products where completed quantity is greater than 2
-- HAVING filters products after calculating SUM(quantity)
SELECT
    product_id,
    SUM(quantity) AS completed_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id
HAVING SUM(quantity) > 2
ORDER BY completed_quantity DESC;