-- Create gym_memberships table

DROP TABLE IF EXISTS gym_memberships;

CREATE TABLE gym_memberships(
    member_id INTEGER,
    member_name TEXT,
    membership_plan TEXT,
    monthly_price INTEGER,
    visits INTEGER,
    status TEXT,
    join_date TEXT
)


-- Insert sample data
INSERT INTO gym_memberships 
(member_id, member_name, membership_plan, monthly_price, visits, status, join_date)
VALUES
(1, 'Arta', 'Premium', 50, 12, 'active', '2026-01-10'),
(2, 'Blend', 'Basic', 25, 5, 'active', '2026-02-15'),
(3, 'Dren', 'Premium', 50, 20, 'active', '2026-01-05'),
(4, 'Elira', 'Standard', 35, 8, 'inactive', '2025-12-20'),
(5, 'Luan', 'Basic', 25, 3, 'active', '2026-03-01'),
(6, 'Sara', 'Premium', 50, 15, 'active', '2026-02-01'),
(7, 'Era', 'Standard', 35, 7, 'inactive', '2025-11-18'),
(8, 'Blerim', 'Premium', 50, 25, 'active', '2026-01-20');

-- Query 1: Show all gym memberships
SELECT *
FROM gym_memberships;


-- Query 2: Show only active members
SELECT *
FROM gym_memberships
WHERE status = 'active';


-- Query 3: Show only inactive members
SELECT *
FROM gym_memberships
WHERE status = 'inactive';


-- Query 4: Show members with Premium plans
SELECT *
FROM gym_memberships
WHERE membership_plan = 'Premium';


-- Query 5: Show members sorted by monthly price from highest to lowest
SELECT *
FROM gym_memberships
ORDER BY monthly_price DESC;


-- Query 6: Show members who visited the gym more than 10 times
SELECT *
FROM gym_memberships
WHERE visits > 10;


-- Query 7: Show member name, plan, and total yearly payment
SELECT member_name,
       membership_plan,
       monthly_price * 12 AS yearly_payment
FROM gym_memberships;


-- Query 8: Show active members with yearly payment sorted highest to lowest
SELECT member_name,
       membership_plan,
       monthly_price * 12 AS yearly_payment
FROM gym_memberships
WHERE status = 'active'
ORDER BY yearly_payment DESC;

-- Query 37: Show all rows from the custom table.
SELECT *
FROM gym_memberships;


-- Query 38: Show only 2 or 3 selected columns.
SELECT member_name, membership_plan, status
FROM gym_memberships;


-- Query 39: Filter rows by a text/status column.
SELECT *
FROM gym_memberships
WHERE status = 'active';


-- Query 40: Filter rows by a numeric column using > or <.
SELECT *
FROM gym_memberships
WHERE visits > 10;


-- Query 41: Combine two conditions using AND.
SELECT *
FROM gym_memberships
WHERE status = 'active'
AND membership_plan = 'Premium';


-- Query 42: Combine two conditions using OR.
SELECT *
FROM gym_memberships
WHERE membership_plan = 'Premium'
OR membership_plan = 'Standard';


-- Query 43: Sort rows from highest to lowest by a numeric column.
SELECT *
FROM gym_memberships
ORDER BY monthly_price DESC;


-- Query 44: Limit the result to the top 3 rows.
SELECT *
FROM gym_memberships
ORDER BY visits DESC
LIMIT 3;


-- Query 45: Create one calculated column using two existing columns.
SELECT member_name,
       monthly_price,
       visits,
       monthly_price * visits AS total_visit_value
FROM gym_memberships;


-- Query 46: Business-ready query showing active premium members and their yearly payments.
SELECT member_name,
       membership_plan,
       monthly_price * 12 AS yearly_payment
FROM gym_memberships
WHERE status = 'active'
AND membership_plan = 'Premium'
ORDER BY yearly_payment DESC;



-- Create a second table for customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Insert sample customers
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES
(1, 'Arta', 'arta@email.com', 'Prishtina'),
(2, 'Dren', 'dren@email.com', 'Vushtrri'),
(3, 'Luan', 'luan@email.com', 'Peja');

-- The customers table stores information about customers,
-- while the orders table stores information about purchases.
-- These two tables can connect through customer_name or,
-- in a better database design, through a customer_id column.
-- Later, a JOIN can be used to combine customer information
-- with their order details.

INSERT INTO orders (order_id, customer_name, product, quantity, price, status)
VALUES
(6, 'Luan', 'Keyboard', 2, 80, 'completed'),
(7, 'Arta', 'Monitor', 1, 250, 'pending'),
(8, 'Dren', 'Laptop', 1, 900, 'completed');

-- Show completed orders ready for business processing
SELECT
    customer_name,
    product,
    quantity * price AS total_amount,
    status
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;

-- This query shows only completed orders that are ready for business use.
-- It displays important information such as the customer,
-- purchased product, total order value, and order status.
-- The total_amount column is calculated by multiplying quantity and price.
-- Sorting by total_amount helps identify the highest-value orders first.