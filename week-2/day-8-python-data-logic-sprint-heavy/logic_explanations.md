# Logic Explanations

## Why validation was done before revenue calculation

I did validation before calculating revenue because invalid records should not affect the business results. For example, an order with an empty customer name, zero quantity, or zero price is not a trustworthy order. If those records were included, the revenue numbers could become incorrect and the business could make decisions based on bad data.

---

## How status normalization works

The status normalization function takes the original status value, removes extra spaces, and converts it to lowercase.

For example:
- "Completed" becomes "completed"
- "complete" becomes "completed"
- "completed" stays "completed"

This makes all completed orders have the same value so they can be counted correctly.

---

## Why only completed orders count as revenue

Only completed orders represent real sales. Pending orders are not finished, cancelled orders were not sold, and returned orders should not be counted as successful revenue.

Because of this, the revenue calculations only use orders where the status is "completed".

---

## How count_by_field works

The count_by_field function creates a dictionary that counts how many times each value appears.

Example with cities:

1. It starts with an empty dictionary.
2. It goes through every order one by one.
3. It takes the value from the selected field, for example the city.
4. If the city already exists in the dictionary, it increases the count.
5. If it does not exist, it creates it with a value of 1.

The result shows how many orders belong to each category, city, status, or channel without manually writing every possible value.

---

## How sum_revenue_by_field works

The sum_revenue_by_field function calculates revenue grouped by a specific field.

The steps are:

1. It creates an empty dictionary.
2. It checks every order.
3. It ignores orders that are not completed.
4. It gets the chosen field value, such as city or customer.
5. It adds the order total_amount to that value in the dictionary.

For example, all completed orders from Prishtina are added together to show the total completed revenue from that city.

---

## How sorting is used to find top records

Sorting is used to arrange records from the highest value to the lowest value.

For example, when finding the top 5 orders:
1. The script gets only completed orders.
2. It sorts them using total_amount.
3. It reverses the order so the biggest values appear first.
4. It takes only the first 5 records.

The same idea is used for top customers and products by revenue.

---

## What main() does and why it improves script structure

The main() function controls the whole program flow.

It runs each part in order:
- checks raw data
- validates orders
- cleans the valid data
- calculates business metrics
- creates reports
- prints results

Using main() keeps the code organized because each function has its own responsibility and the program is easier to read and update.

---

## Example metric calculation: Completed Revenue

The completed revenue metric is calculated by first getting only completed orders using the get_completed_orders function.

After that, the calculate_completed_revenue function adds the total_amount of each completed order:
