-- Level 1
SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items

SELECT * 
FROM orders
WHERE status = 'completed';

SELECT * FROM orders
WHERE status IN ('pending', 'cancelled')

-- Level 2
SELECT 
order.order_id,
customers.customer_name,
customers.city,
orders.order_date,
orders.orders,
orders.channel,
FROM orders
INNER JOIN Customers
ON orders.customer_id = customers.customer_id; 


SELECT 
order_items.order_item_id,
products.product_name,
products.category,
products.price,
products.category,
FROM order_items
INNER JOIN products
ON order_items.product_id = products.product_id;


SELECT
    orders.order_id,
    customers.customer_name,
    products.product_name,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id;


SELECT
    orders.order_id,
    customers.customer_name,
    products.product_name,
    order_items.quantity,
    products.price
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id
WHERE orders.status = 'completed';


-- Level 3

SELECT
    customers.customer_name,
    orders.order_id,
    products.product_name,
    order_items.quantity
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id;


SELECT
    customers.customer_name,
    customers.city,
    orders.order_id,
    products.product_name,
    products.category,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id;


SELECT
    customers.customer_name,
    orders.order_id,
    products.product_name,
    order_items.quantity,
    products.price
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id
ORDER BY orders.order_id, products.product_name;


SELECT
    customers.customer_name,
    orders.order_id,
    products.product_name,
    order_items.quantity,
    products.price
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id
WHERE orders.status = 'completed';


-- Level 4

SELECT
    customers.city,
    SUM(order_items.quantity * products.price) AS completed_revenue
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city;

SELECT
    products.category,
    SUM(order_items.quantity * products.price) AS completed_revenue
FROM orders
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category;


SELECT
    customers.customer_name,
    SUM(order_items.quantity * products.price) AS revenue
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_items
ON orders.order_id = order_items.order_id
INNER JOIN products
ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_id
ORDER BY revenue DESC
LIMIT 5;


SELECT
    products.product_name,
    SUM(order_items.quantity * products.price) AS revenue
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
INNER JOIN orders
ON order_items.order_id = orders.order_id
WHERE orders.status = 'completed'
GROUP BY products.product_id
ORDER BY revenue DESC
LIMIT 5;


SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id;


-- 28. Count how many items each order has
SELECT
    orders.order_id,
    COUNT(order_items.order_item_id) AS total_items
FROM orders
LEFT JOIN order_items
ON orders.order_id = order_items.order_id
GROUP BY orders.order_id;


SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS order_count
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
HAVING COUNT(orders.order_id) > 1;


SELECT
    products.product_name,
    SUM(order_items.quantity) AS total_quantity_sold
FROM products
INNER JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.product_id
HAVING SUM(order_items.quantity) > 1;