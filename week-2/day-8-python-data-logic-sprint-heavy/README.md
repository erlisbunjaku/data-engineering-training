# Day 8 - Python Data Logic Sprint Heavy Version

## Project Overview

This project simulates a real data engineering task for a Kosovo-based technology and office equipment business.

The raw order data contains inconsistent values, invalid records, and different order statuses. The goal of this project is to build a Python data pipeline that validates records, cleans and normalizes data, calculates trusted business metrics, and creates business-ready reports.

The main focus is not only calculating numbers, but making sure the results are accurate and reliable before they are used for business decisions.

---

## Project Structure


day-8-python-data-logic-sprint-heavy/

├── order_data.py
├── python_data_analysis.py
├── output/
│ ├── invalid_records.txt
│ ├── validation_report.txt
│ └── business_report.txt
│
├── logic_explanations.md
├── README.md
└── daily_report.txt


---

## Files Included

### `order_data.py`

Contains the original raw order dataset.

The raw data is not modified directly. All cleaning and validation is performed inside the Python analysis script.

### `python_data_analysis.py`

Main Python pipeline that:

- Inspects raw data
- Validates orders
- Separates valid and invalid records
- Normalizes status, city, category, and channel values
- Calculates order totals
- Calculates completed revenue
- Creates dynamic business reports
- Generates output files

### `output/`

Contains generated reports:

- `invalid_records.txt`
  - Shows invalid orders
  - Includes validation reasons

- `validation_report.txt`
  - Shows raw record count
  - Valid and invalid record counts
  - Data quality information

- `business_report.txt`
  - Contains completed revenue
  - Revenue by city, category, and channel
  - Top customers and products
  - Business recommendations

### `logic_explanations.md`

Explains the reasoning behind the Python logic, including validation, normalization, revenue calculations, and reporting functions.

---

## How to Run

Open the terminal inside the project folder and run:

```bash
python python_data_analysis.py

The script will process the raw dataset and automatically generate all report files inside the output folder.

Python Concepts Practiced

During this practice, I worked with:

Lists and dictionaries
Loops and conditions
Functions and reusable logic
Data validation
Data cleaning
Text normalization
Dictionary-based reporting
Sorting and ranking
File handling
Calculating business metrics
Organizing code using main()
Business Logic Applied

The pipeline follows important data engineering rules:

Invalid customers, quantities, and prices are removed before reporting.
Only completed orders count as real revenue.
Pending, cancelled, and returned orders are treated as non-revenue orders.
Inconsistent values such as Completed, complete, Online, and Prishtine are normalized before analysis.
What Was Difficult

The most difficult part of this practice was understanding that data analysis is not only about calculating metrics. Before creating reports, the data must be trusted.

The hardest parts were validating records correctly, keeping invalid data separate, and making dynamic reports that work with new values without hardcoding cities, categories, or customers.

This practice improved my understanding of how junior data engineers handle raw business data and transform it into reliable information.