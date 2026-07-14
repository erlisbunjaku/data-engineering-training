-- Bonus Challenge 1
-- Shows completed revenue by city using orders, customers, and products.
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


-- Bonus Challenge 2
-- Shows the average completed order value by category.
SELECT
    products.category,
    AVG(orders.quantity * products.price) AS average_order_value
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY average_order_value DESC;


-- Bonus Challenge 3
-- Shows only products with completed revenue higher than 100.
SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
HAVING SUM(orders.quantity * products.price) > 100
ORDER BY revenue DESC;


-- Bonus Challenge 4
-- Compares completed, pending, and cancelled orders by city.
SELECT
    customers.city,
    orders.status,
    COUNT(*) AS order_count
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city, orders.status
ORDER BY customers.city;


-- Bonus Challenge 5
-- Intentional broken query:
-- Mistake: Trying to select category from orders table, but category exists in products table.
SELECT
    category,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY category;


-- Fixed query:
-- Fixed by joining the products table to access the category column.
SELECT
    products.category,
    SUM(orders.quantity) AS total_quantity
FROM orders
JOIN products
ON orders.product_id = products.product_id
GROUP BY products.category;