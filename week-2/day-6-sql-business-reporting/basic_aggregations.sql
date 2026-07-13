-- Part 2 - Basic Aggregations

-- Count all orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Count only completed orders.
SELECT COUNT(*) AS completed_orders
FROM orders,
WHERE status = 'completed'

-- Count only pending orders.
SELECT COUNT(*) AS pending_orders
FROM orders,
WHERE status = 'pending'

-- Count only cancelled orders.
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE status = 'cancelled'

-- Calculate total quantity ordered across all statuses.
SELECT SUM(quantity) AS total_quantity
FROM orders;

-- Calculate total quantity ordered only from completed orders.
SELECT SUM(quantity) AS completed_quantity
FROM orders
WHERE status = 'completed'

-- Find the average product price.
SELECT AVG(price) AS average_product_price
FROM products

-- Find the cheapest product price.
SELECT MIN(price) AS cheapest_product
FROM products;

-- Find the most expensive product price.
SELECT MAX(price) AS expensive_product
FROM products;

-- Calculate completed revenue using quantity * price. 
-- This requires connecting orders with products. 
SELECT SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed';

-- Calculate non-completed potential value from pending and cancelled orders. Explain why this should not be counted
-- as real revenue.
SELECT SUM(orders.quantity * products.price) AS potential_value
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status IN ('pending', 'cancelled');




