# Day 11 - Python + SQL Pipeline Preparation

## Project Goal

Build a data pipeline that transforms raw CSV data into clean Silver data and creates business reports using Python and SQL.

Workflow:

Bronze → Silver → Gold

---

## Bronze Data

Raw files received:

- orders_raw.csv (24 records)
- customers_raw.csv (12 records)
- products_raw.csv (10 records)

Problems noticed:

- Missing quantities and dates
- Invalid quantities
- Different status formats
- Different city casing
- Invalid product IDs
- Missing channels

---

## Silver Data

Created:

- orders_clean.csv
- invalid_orders.csv

Validation rules:

- Quantity must be positive
- Status must be valid
- Customer and product IDs must exist
- Order date cannot be missing
- Duplicate orders are rejected

Invalid records were saved separately with reasons.

Normalization:

- Status values
- City names
- Channel values

Python lookup functions were used to connect orders with customers and products.

---

## Gold Reports

Created:

- revenue_by_city.csv
- revenue_by_category.csv
- top_customers.csv
- executive_summary.txt

Most useful report:

Revenue by city because it shows where the business generates the most completed revenue.

---

## Python vs SQL

Python helped with:

- Reading CSV files
- Cleaning data
- Validation
- Transformations
- Creating reports

SQL helped with:

- Data analysis
- Aggregations
- Revenue calculations
- Business reporting

---

## Data Quality Notes

Only trusted Silver data was used for reporting.

Completed revenue only includes:


status = completed


Pending and cancelled orders were excluded.

---

## Business Insights

The pipeline shows:

- Revenue by city
- Revenue by category
- Top customers
- Order performance

---

## What I Can Explain Live

- Bronze → Silver → Gold architecture
- Validation rules
- Python pipeline logic
- SQL reporting logic

---

## What I Would Improve Next

- Move to Databricks
- Use PySpark
- Store data in Delta Lake
- Add automated quality checks