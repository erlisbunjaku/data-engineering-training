PRAGMA foreign_keys = ON;

-- Foreign Key Test 1
-- Try to insert an order with a customer_id that does not exist.
-- Database should reject it.

INSERT INTO orders (customer_id, order_date, status, channel) VALUES
(999, '2026-07-10', 'completed', 'Online')

-- Foreign Key Test 2
-- Try inserting an order_item with an order_id that does not exist.
-- Database should reject it.

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(999, 1, 2)

-- Foreign Key Test 3
-- Try to insert an order_item with a product_id that does not exist.
INSERT INTO orders_items (order_id, product_id,) VALUES
(1,999,1);

-- CHECK test 1
-- Try to insert a product with price 0 or negative price.
-- Database should reject it if your CHECK is correct.

INSERT INTO products(product_id, category, price) VALUES
('Broken Product', 'Test', 0);


-- CHECK test 2
-- Try to insert an order_item with quantity 0.
-- Database should reject it if your CHECK is correct.

INSERT INTO orders(order_id, product_id, quantity) VALUES
(1,1,0)


-- CHECK test 2
-- Try to insert an order_item with quantity 0.
-- Database should reject it if your CHECK is correct.


-- Try to insert an order with status done.
-- Try to insert an order with status done.
-- Database should reject it if your CHECK
-- only allows completed, pending,
-- +cancelled.
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (1, '2026-07-10', 'done', 'Online');

