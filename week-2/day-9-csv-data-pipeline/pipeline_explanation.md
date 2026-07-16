# Day 9 - CSV Data Pipeline Explanation

## Source Data

Raw CSV files: orders, customers, and products.

## Ingestion

Load the CSV files using `csv.DictReader`.

## Bronze Layer

Store the raw data without changing it.

## Cleaning Rules

Normalize status, city, and channel values.

## Validation Rules

Check IDs, order date, quantity, status, and channel.

## Silver Layer

Save valid orders to `orders_clean.csv` and invalid orders to `invalid_orders.csv`.

## Transformation Rules

Join orders with customer and product data and calculate `total_amount`.

## Gold Layer

Generate business reports from the clean data.

## Business Output

Create `business_summary.txt` and `data_quality_report.txt`.

## What Makes This Data Trusted

Only validated and cleaned data is used for reporting.
