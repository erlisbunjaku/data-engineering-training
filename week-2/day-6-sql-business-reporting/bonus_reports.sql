-- Bonus Challenges


-- Create a report for completed revenue by order_date.
SELECT
    orders.order_date,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY orders.order_date
ORDER BY completed_revenue DESC;


-- Create a report for average completed order value by category.
SELECT
    products.category,
    AVG(orders.quantity * products.price) AS average_order_value
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY average_order_value DESC;


-- Create a report that shows each product with total_orders.
SELECT
    products.product_name,
    COUNT(orders.order_id) AS total_orders
FROM products
JOIN orders
ON products.product_id = orders.product_id
GROUP BY products.product_name
ORDER BY total_orders DESC;


-- Create a report that shows each product with completed_orders.
SELECT
    products.product_name,
    COUNT(orders.order_id) AS completed_orders
FROM products
JOIN orders
ON products.product_id = orders.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_orders DESC;


-- Create a report that shows each product with completed_quantity.
SELECT
    products.product_name,
    SUM(orders.quantity) AS completed_quantity
FROM products
JOIN orders
ON products.product_id = orders.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_quantity DESC;


-- Create a report that shows each product with completed_revenue.
SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM products
JOIN orders
ON products.product_id = orders.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC;


-- Create a report that shows each city with total_orders.
SELECT
    customers.city,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.city
ORDER BY total_orders DESC;


-- Create a report that shows each city with completed_orders.
SELECT
    customers.city,
    COUNT(orders.order_id) AS completed_orders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.status = 'completed'
GROUP BY customers.city
ORDER BY completed_orders DESC;


-- Create a report that shows each city with pending_or_cancelled_orders.
SELECT
    customers.city,
    COUNT(orders.order_id) AS pending_or_cancelled_orders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.status IN ('pending', 'cancelled')
GROUP BY customers.city
ORDER BY pending_or_cancelled_orders DESC;


-- Create a report that shows each city with completed_revenue.
SELECT
    customers.city,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city
ORDER BY completed_revenue DESC;


-- Add two new orders and check whether your reports update correctly.
INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity, status)
VALUES
(15, 1, 106, '2026-07-08', 1, 'completed'),
(16, 5, 101, '2026-07-08', 1, 'completed');


-- Check the updated orders.
SELECT *
FROM orders;


-- Bronze Layer:
-- Raw tables that contain the original data.

-- Silver Layer:
-- Cleaned tables where data problems are fixed.

-- Gold Layer:
-- Final reports created for business analysis and decision making.