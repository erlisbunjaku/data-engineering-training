-- ==========================================
-- Day 6 SQL Business Reporting
-- JOIN Reports
-- Two-table JOINs and Three-table JOINs
-- ==========================================


-- ==========================================
-- Join orders with customers
-- Shows customer information with order details
-- ==========================================

SELECT
    orders.order_id,
    customers.customer_name,
    customers.city,
    orders.order_date,
    orders.status
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY orders.order_id;


-- ==========================================
-- Join orders with products
-- Shows product information and total order value
-- ==========================================

SELECT
    orders.order_id,
    products.product_name,
    products.category,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS total_amount,
    orders.status
FROM orders
JOIN products
ON orders.product_id = products.product_id
ORDER BY total_amount DESC;


-- ==========================================
-- Complete order report using all three tables
-- Customer + Product + Order information
-- ==========================================

SELECT
    orders.order_id,
    customers.customer_name,
    customers.city,
    products.product_name,
    products.category,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS total_amount,
    orders.status,
    orders.order_date
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
ORDER BY total_amount DESC;


-- ==========================================
-- Completed revenue by product name
-- Only completed orders count as real revenue
-- ==========================================

SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC;


-- ==========================================
-- Completed revenue by category
-- Shows best performing product categories
-- ==========================================

SELECT
    products.category,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY completed_revenue DESC;


-- ==========================================
-- Order count by city
-- Shows which cities have the most orders
-- ==========================================

SELECT
    customers.city,
    COUNT(*) AS order_count
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY order_count DESC;


-- ==========================================
-- Completed revenue by city
-- Shows revenue performance by location
-- ==========================================

SELECT
    customers.city,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city
ORDER BY completed_revenue DESC;


-- ==========================================
-- Completed revenue by customer
-- Shows highest-value customers
-- ==========================================

SELECT
    customers.customer_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_name
ORDER BY completed_revenue DESC;


-- ==========================================
-- Customers with more than one order
-- HAVING filters grouped results
-- ==========================================

SELECT
    customers.customer_name,
    COUNT(*) AS order_count
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_name
HAVING COUNT(*) > 1
ORDER BY order_count DESC;


-- ==========================================
-- Top 3 customers by completed revenue
-- ==========================================

SELECT
    customers.customer_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_name
ORDER BY completed_revenue DESC
LIMIT 3;


-- ==========================================
-- Top 3 products by completed revenue
-- ==========================================

SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC
LIMIT 3;


-- ==========================================
-- Pending and cancelled orders
-- Potential value, not real revenue
-- ==========================================

SELECT
    customers.customer_name,
    customers.city,
    products.product_name,
    orders.order_date,
    orders.quantity * products.price AS potential_amount,
    orders.status
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status IN ('pending', 'cancelled')
ORDER BY potential_amount DESC;