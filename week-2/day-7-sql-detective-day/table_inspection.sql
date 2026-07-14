-- Show all rows from customers.
SELECT * FROM customers;

-- Show all rows from products.
SELECT * FROM products;

-- Show all rows from orders.
SELECT * FROM orders;


-- Check how many order records exist in the orders table.
select COUNT(*) as total_orders
FROM orders;

-- Check how many customer records exist in the customers table.
SELECT COUNT(*) AS total_customers
FROM customers;

-- Check how many product records exist in the products table.
SELECT COUNT(*) as total_products
from products;