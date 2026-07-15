# Day 8 - Python Data Logic Sprint Heavy Version

This project analyzes raw order data from a Kosovo-based technology and office equipment business. The goal is to clean the data, remove invalid records, calculate correct revenue, and create business reports.

Files included:
- order_data.py - raw orders dataset
- python_data_analysis.py - validation, cleaning, calculations, and reports
- output/ - generated report files
- README.md - project documentation
- logic_explanations.md - logic explanation

To run the project, open the terminal in the project folder and run:

python python_data_analysis.py

The script generates:
- output/invalid_records.txt - invalid orders and reasons
- output/validation_report.txt - validation results
- output/business_report.txt - business metrics and revenue reports

Main Python concepts practiced: functions, lists, dictionaries, loops, conditions, data validation, cleaning, normalization, file handling, sorting, calculations, and organizing code with main().

The most difficult part was managing the full process from raw data to final reports. Making sure invalid records were removed before revenue calculations and creating dynamic reports without hardcoding values required the most attention.