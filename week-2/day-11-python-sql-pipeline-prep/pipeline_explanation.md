# Day 11 - Pipeline Explanation

## Part 1 - Data Understanding

- Raw data counts:
  - Orders: **24 records**
  - Customers: **12 records**
  - Products: **10 records**

- Join columns:
  - Orders + Customers → `customer_id`
  - Orders + Products → `product_id`

- Inconsistent values:
  - Status variations (`completed`, `Completed`, `done`, `canceled`)
  - Channel casing differences
  - Missing/invalid quantities
  - Missing dates
  - Invalid product ID (`P999`)

- Not trusted for revenue:
  - Cancelled, pending, returned orders
  - Invalid quantities
  - Missing dates
  - Invalid products

- Layers:
  - Bronze → raw CSV files
  - Silver → cleaned and validated data
  - Gold → reports and business summaries