# Logic Explanations

## Why validation was done before revenue calculation

Validation was done before calculating revenue because invalid records should not affect business results.

Orders with missing customer names, zero quantity, or invalid prices are not trustworthy. Including them could create incorrect reports and wrong business decisions.

---

## How status normalization works

Status normalization cleans inconsistent values by removing spaces and converting text to lowercase.

Examples:
- "Completed" → "completed"
- "complete" → "completed"
- "completed" → "completed"

This makes completed orders easier to count correctly.

---

## Why only completed orders count as revenue

Only completed orders represent real business income.

Pending, cancelled, and returned orders are not counted because they are not successful sales.

The revenue calculation only uses orders where the status is "completed".

---

## How count_by_field works

The `count_by_field()` function creates a dictionary with counts for a selected field.

Steps:
1. Start with an empty dictionary.
2. Loop through every record.
3. Get the selected value.
4. Increase the count if it exists, otherwise create it.

Example:
- Prishtina: 5 orders
- Vushtrri: 4 orders

This allows reports to work without hardcoding values.

---

## How sum_revenue_by_field works

The `sum_revenue_by_field()` function calculates revenue grouped by a field.

Steps:
1. Loop through cleaned orders.
2. Keep only completed orders.
3. Get the selected field value.
4. Add the order's `total_amount` to the dictionary.

Example:
- Revenue by city
- Revenue by category
- Revenue by customer

---

## How sorting is used to find top records

Sorting is used to rank records from highest to lowest value.

For top orders:
1. Get completed orders.
2. Sort by `total_amount`.
3. Reverse the order.
4. Take the first 5 records.

The same method is used for top customers and products.

---

## What main() does and why it improves script structure

The `main()` function controls the full pipeline.

It runs:
- Raw data inspection
- Validation
- Cleaning
- Calculations
- Report generation

Using `main()` keeps the code organized because every function has a clear responsibility.

---

## Example metric calculation: Completed Revenue

Completed revenue is calculated by first filtering completed orders using `get_completed_orders()`.

Then `calculate_completed_revenue()` adds the `total_amount` of every completed order.

Formula:


completed revenue = sum of total_amount from completed orders


This ensures only valid completed sales are included.