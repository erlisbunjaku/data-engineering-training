# Python vs SQL Comparison

## Task: Show completed orders

### Python approach:
- Loop through the orders list.
- Check if `order["status"] == "completed"`.
- Print matching orders.

### SQL approach:
- Select data from the orders table.
- Use `WHERE status = 'completed'`.

### What I understood:
Both approaches filter data. Python uses loops and conditions, while SQL uses WHERE to filter rows directly.


---

## Task: Show orders with price greater than 100

### Python approach:
- Loop through orders.
- Use an if statement to check if price is greater than 100.
- Print matching orders.

### SQL approach:
- Use `WHERE price > 100` to filter orders.

### What I understood:
Both methods check a condition and return only the matching records.


---

## Task: Calculate total_amount

### Python approach:
- Multiply `quantity * price` inside a loop.
- Store the result in a variable.

### SQL approach:
- Create a calculated column using `quantity * price AS total_amount`.

### What I understood:
Both approaches calculate new values from existing data. Python calculates during iteration, while SQL calculates during the query.


---

## Task: Sort orders by price descending

### Python approach:
- Use `sorted()` with price as the sorting key.
- Use `reverse=True` for highest to lowest.

### SQL approach:
- Use `ORDER BY price DESC`.

### What I understood:
Both methods organize data based on a value. Python sorts a list, while SQL sorts query results.


---

## Task: Show top 3 orders

### Python approach:
- Sort orders by the required value.
- Use `[:3]` to get the first three records.

### SQL approach:
- Use `ORDER BY` to sort results.
- Use `LIMIT 3` to return only three rows.

### What I understood:
Both approaches limit the amount of results after sorting. Python uses list slicing, while SQL uses LIMIT.