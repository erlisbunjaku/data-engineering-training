# Week 1 - Monday Python Data Practice

This project contains the practical assignments completed on Monday as part of the core preparation for transitioning into mini data pipelines with CSV files. The primary focus of this practice is strengthening Python fundamentals—specifically lists, dictionaries, loops, conditions, and data aggregations—essential for effective data engineering pipelines.

## Key Implementations

During this practice session, the following core tasks were successfully covered:
1. **Data Structuring:** Modeled a mock dataset using a list of dictionaries to simulate raw operational data records.
2. **Data Filtering & Operations:** Utilized loops and conditionals to isolate student records based on specific criteria, including location, low attendance thresholds, and high homework scores.
3. **Data Aggregations:** Calculated key performance metrics, including average attendance and average homework scores, alongside record counts grouped by city and course.
4. **Data Cleaning & Transformation:** Designed a pipeline step to extract a lightweight version of the dataset, retaining only relevant reporting metrics to simulate production-level data reduction.
5. **Report Generation:** Developed a terminal-based reporting tool providing a clean, human-readable layout summarizing the aggregated student metrics.

## How to Run the Scripts

To execute and test the scripts locally, navigate to the practice folder in your terminal and run the following commands:

```bash
# To view the step-by-step data exercises and cleaning logic:
python monday_practice.py

# To generate the final structured metrics report:
python student_report.py