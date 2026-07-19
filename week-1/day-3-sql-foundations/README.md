# Day 3 SQL Foundations Practice

This project contains SQL practice completed during the **Unity Tech Hub x Agilyti Data Engineering / Databricks Training**.

The goal of this practice was to learn SQL basics, table structure, filtering, sorting, calculated columns, and how SQL connects to data pipelines and business reporting.

## Files

- `setup.sql` - Creates the orders table and inserts sample data.
- `sql_practice.sql` - Contains SQL exercises using SELECT, WHERE, AND/OR, ORDER BY, LIMIT, and calculated columns.
- `custom_business_table.sql` - Contains a custom gym membership table with business-focused SQL queries.
- `pipeline_thinking.md` - Explains the data pipeline flow for the chosen business.
- `daily_report.txt` - Short reflection about the day's work.

## Tools Used

- SQLiteOnline.com

## SQL Concepts Practiced

- CREATE TABLE
- INSERT INTO
- SELECT
- WHERE
- AND / OR conditions
- ORDER BY
- LIMIT
- Aliases using AS
- Calculated columns
- Business reporting queries

## Table Understanding

### Table Name
The main table used in this practice is:

`orders`

### What does one row represent?

One row represents a single customer order containing information about the customer, product, quantity, price, and order status.

### Text Columns

- customer_name
- product
- status

### Numeric Columns

- order_id
- quantity
- price

### Calculated Order Value

The total value of an order can be calculated using:
