# SQL Foundations - Day 3 Practice

## Table Understanding Checkpoint

### 1. What is the table name?

The table name is **orders**.

---

### 2. What does one row represent?

Each row represents a single customer order. It contains information about the customer, the product they ordered, the quantity, the price of the product, and the current status of the order.

---

### 3. Which columns are text?

The text columns are:

* `customer_name`
* `product`
* `status`

These columns store words or text values instead of numbers.

---

### 4. Which columns are numbers?

The numeric columns are:

* `order_id`
* `quantity`
* `price`

These columns store numerical values that can be used for calculations.

---

### 5. Which column shows the order status?

The **`status`** column shows the current state of each order.

Possible values include:

* `completed`
* `pending`
* `cancelled`

---

### 6. Which column can be used to calculate order value?

The `quantity` and `price` columns are used together to calculate the total value of an order.

Formula:

```
quantity × price
```

---

### 7. What does `quantity * price` mean in this table?

`quantity * price` calculates the **total value of an order**.

For example:

* If a customer buys **2** mice at **15** each:

  * `2 × 15 = 30`

The total order value is **30**.

Another example:

* A laptop with a quantity of **1** and a price of **700**:

  * `1 × 700 = 700`

The total order value is **700**.


# Day 3 SQL Foundations Practice

This folder contains SQL practice completed during the **Unity Tech Hub x Agilyti Data Engineering / Databricks Training**.

## Files:

* `setup.sql` - Creates and inserts sample data into the `orders` table.
* `sql_practice.sql` - Contains SQL practice queries from Level 1 to Level 5.
* `custom_business_table.sql` - Contains a custom business table, sample data, and business queries.
* `pipeline_thinking.md` - Explains the data pipeline flow for the chosen business.
* `daily_report.txt` - Short end-of-day learning report.

## Tools Used:

* SQLiteOnline.com

## What I Practiced:

* CREATE TABLE
* INSERT INTO
* SELECT
* WHERE
* AND / OR
* ORDER BY
* LIMIT
* Aliases using AS
* Filtering and sorting data
* Calculated columns
* Business-focused SQL queries
* Data pipeline thinking
