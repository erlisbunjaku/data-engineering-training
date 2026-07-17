# Day 10 - Bronze / Silver / Gold Pipeline with Python

## Project goal
Built a data pipeline that transforms raw data into clean Silver data and business-ready Gold reports using Python.

## Bronze layer
Stores the original CSV files received from the source. The raw data is kept unchanged for tracking and validation.

## Silver layer
Cleans and validates customers, products, and orders. Invalid records are separated, and clean orders are enriched with additional information like customer details, product details, and total amount.

## Gold layer
Creates business reports including revenue by category, city, customer, top products, executive summary, and data quality report.

## How to run the pipeline
Run the following command:

```bash
python pipeline.py