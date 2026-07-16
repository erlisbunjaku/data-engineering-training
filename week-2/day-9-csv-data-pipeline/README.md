# Day 9 - CSV Data Pipeline: From Raw Data to Clean Reports

## Practice Goal

The goal of this practice is to build a Python CSV data pipeline that takes raw business data, validates it, cleans inconsistent values, enriches records using customer and product information, and creates trusted business outputs.

The main idea is that raw data is not automatically useful. Before data can be used for reporting, it must be checked, cleaned, transformed, and explained.

This project simulates how a real data engineer prepares data before it reaches dashboards or analytics systems.

---

# Bronze, Silver, and Gold Layers

## Bronze Layer - Raw Data

The Bronze layer contains the original CSV files exactly as received.

Files:

- `orders_raw.csv`
- `customers_raw.csv`
- `products_raw.csv`

At this stage:
- Data can contain missing values.
- Data can contain inconsistent formats.
- No changes are made to the original files.

---

## Silver Layer - Cleaned and Validated Data

The Silver layer contains cleaned and trusted datasets created by the Python pipeline.

Files:

- `orders_clean.csv`
- `invalid_orders.csv`

Cleaning and validation performed:

- Validate customer IDs.
- Validate product IDs.
- Check missing dates.
- Check quantity values.
- Normalize status values.
- Normalize city names.
- Normalize sales channels.
- Enrich orders with customer and product information.
- Calculate total order amount.

Only valid records become Silver clean data.

Invalid records are not deleted. They are separated with a reason explaining why they failed validation.

---

## Gold Layer - Business Reports

The Gold layer contains business-ready outputs created from clean data.

Examples:

- Revenue reports.
- Completed order reports.
- Customer performance reports.
- Product performance reports.
- Business summaries.

These outputs are created only from trusted Silver data.

---

# Project Structure
