# Layer Explanation - Day 10

## Bronze layer
- Stores the original raw CSV files: orders, customers, and products.
- Raw data is kept unchanged so we can trace the original source and fix issues without losing information.
- Problems found included duplicate IDs, invalid quantities, missing data, and invalid customer/product references.

## Silver layer
- Applied cleaning rules such as removing duplicates, validating IDs, normalizing status/city/channel values, and checking valid quantities and prices.
- Invalid records were separated because they had issues like missing customers, invalid products, duplicate orders, or incorrect quantities.
- Added enriched columns like customer name, city, product name, category, price, and total amount.
- Silver is safer because the data has been cleaned, validated, and is ready for analysis.

## Gold layer
- Created business reports: revenue by category, revenue by city, revenue by customer, top products, executive summary, and data quality report.
- These reports answer questions about revenue performance, best customers, top products, and business trends.
- Dashboards should use Gold outputs because they contain trusted, processed, and business-ready data instead of raw Bronze data.