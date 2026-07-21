# Day 12 - Relationships, Foreign Keys, and JOINs

## Project Goal

The goal of this project is to build a relational database for a technology company. 
The data is separated into multiple tables instead of one large table to reduce duplication and improve data quality.

The project demonstrates primary keys, foreign keys, relationships, AUTOINCREMENT, constraints, and SQL JOIN reports.

---

## Database Tables

The database contains four main tables:

### customers
Stores customer information.

Columns:
- customer_id
- customer_name
- city
- segment

### products
Stores product information.

Columns:
- product_id
- product_name
- category
- price

### orders
Stores customer orders.

Columns:
- order_id
- customer_id
- order_date
- status
- channel

### order_items
A bridge table connecting orders and products.

Columns:
- order_item_id
- order_id
- product_id
- quantity

---

## Primary Keys

Primary keys uniquely identify each row in a table.

Examples:
- customer_id identifies each customer.
- product_id identifies each product.
- order_id identifies each order.
- order_item_id identifies each order item.

Each primary key uses AUTOINCREMENT to generate unique IDs.

---

## Foreign Keys

Foreign keys create relationships between tables.

Examples:

- orders.customer_id references customers.customer_id.
- order_items.order_id references orders.order_id.
- order_items.product_id references products.product_id.

Foreign keys prevent invalid data, such as creating an order for a customer that does not exist.

---

## Auto Increment

AUTOINCREMENT automatically creates unique IDs when inserting new records.

It prevents duplicate IDs and allows the database to manage identifiers instead of manually creating them.

Deleted IDs are not reused.

---

## Relationships

The database contains these relationships:

### Customers and Orders

One customer can have many orders.

Example:
- Arta can have Order 1 and Order 4.

### Orders and Products

Orders and products have a many-to-many relationship.

An order can contain many products, and a product can appear in many orders.

The order_items table works as a bridge between them.

---

## Valid and Invalid Insert Tests

The database was tested with invalid inserts to confirm constraints work correctly.

Tests included:

- Adding an order with a non-existing customer_id.
- Adding an order_item with an invalid order_id.
- Adding an order_item with an invalid product_id.
- Adding products with invalid prices.
- Adding order items with quantity 0.
- Adding orders with invalid status values.

The database rejected invalid data because of foreign keys and CHECK constraints.

---

## INNER JOIN vs LEFT JOIN

INNER JOIN returns only matching records between tables.

Example:
Showing orders that have valid customers.

LEFT JOIN returns all records from the left table, even if there is no match.

Example:
Showing all customers, including customers without orders.

JOINs allow data from multiple tables to be combined for reports.

---

## Business Reports

The database can answer business questions such as:

- Revenue by city.
- Revenue by product category.
- Top customers by revenue.
- Top products by revenue.
- Number of orders per customer.
- Products sold multiple times.

These reports are created using JOIN, GROUP BY, SUM, COUNT, and ORDER BY.

---

## What I Can Explain Live

I can explain:

- Difference between primary keys and foreign keys.
- How one-to-many and many-to-many relationships work.
- Why order_items is needed as a bridge table.
- How AUTOINCREMENT creates IDs.
- How INNER JOIN and LEFT JOIN combine tables.
- How constraints protect data quality.

---

## What I Would Improve Next

Possible improvements:

- Add more tables such as payments or employees.
- Add more validation rules.
- Add indexes for faster queries.
- Connect the database to Python for automated reporting.
- Build a data pipeline that loads and cleans data automatically.