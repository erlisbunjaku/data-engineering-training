-- Fixed Query 1
-- Fixed by joining the customers table to access the city column.
SELECT
  customers.city,
  COUNT(*) AS order_count
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city;


-- Fixed Query 2
-- Fixed by adding the missing comma after product_name.
SELECT
  product_name,
  SUM(quantity * price) AS revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE status = 'completed'
GROUP BY product_name;


-- Fixed Query 3
-- Fixed by removing the extra semicolon before ORDER BY.
SELECT
  status,
  COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;


-- Fixed Query 4
-- Fixed by joining the products table to access the price column.
SELECT
  orders.order_id,
  orders.quantity,
  products.price,
  orders.quantity * products.price AS total_amount
FROM orders
JOIN products
ON orders.product_id = products.product_id;


-- Fixed Query 5
-- Fixed by joining the products table to access the category column.
SELECT
  products.category,
  SUM(quantity) AS total_quantity
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category;


-- Fixed Query 6
-- Fixed by filtering only completed orders for revenue.
SELECT
  SUM(orders.quantity * products.price) AS total_revenue
FROM orders
JOIN products
ON orders.product_id = products.product_id
WHERE orders.status = 'completed';


-- Fixed Query 7
-- Fixed by placing HAVING after the GROUP BY clause.
SELECT
  customer_id,
  COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Fixed Query 8
-- Fixed by adding the missing JOIN condition.
SELECT
  orders.order_id,
  customers.customer_name
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id;


-- Fixed Query 9
-- Fixed by specifying the table names for selected columns.
SELECT
  orders.customer_id,
  orders.product_id,
  products.price
FROM orders
JOIN products
ON orders.product_id = products.product_id;


-- Fixed Query 10
-- Fixed by selecting non-completed orders instead of completed ones.
SELECT *
FROM orders
WHERE status != 'completed';