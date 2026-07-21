-- Insert customers
INSERT INTO customers (customer_name, city, segment) VALUES
('Arta', 'Vushtrri', 'Retail'),
('Blend', 'Prishtina', 'Business'),
('Dren', 'Mitrovica', 'Retail'),
('Elira', 'Peja', 'Business'),
('Leart', 'Ferizaj', 'Retail'),
('Gresa', 'Gjakova', 'Business');


-- Insert products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Mouse', 'Accessories', 25.00),
('Monitor', 'Electronics', 250.00),
('Keyboard', 'Accessories', 50.00),
('Desk', 'Furniture', 180.00),
('Headphones', 'Accessories', 80.00);


-- Insert orders
INSERT INTO orders (customer_id, order_date, status, channel) VALUES
(1, '2026-07-01', 'completed', 'Online'),
(2, '2026-07-02', 'completed', 'Store'),
(3, '2026-07-03', 'pending', 'Online'),
(1, '2026-07-04', 'completed', 'Phone'),
(4, '2026-07-05', 'cancelled', 'Store'),
(5, '2026-07-06', 'completed', 'Online'),
(6, '2026-07-07', 'completed', 'Store'),
(2, '2026-07-08', 'completed', 'Online');


-- Insert order items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
-- Order 1: Laptop + Mouse
(1, 1, 1),
(1, 2, 2),
-- Order 2: Monitor
(2, 3, 1),
-- Order 3: Keyboard (Pending)
(3, 4, 1),
-- Order 4: Laptop + Headphones
(4, 1, 1),
(4, 6, 1),
-- Order 5: Desk (Cancelled)
(5, 5, 1),
-- Order 6: Mouse + Keyboard
(6, 2, 3),
(6, 4, 1),
-- Order 7: Monitor
(7, 3, 2),
-- Order 8: Mouse + Headphones
(8, 2, 1),
(8, 6, 2);