# Query Explanations - Day 6 SQL Business Reporting Sprint

## Query title: Count all orders

**File:** basic_aggregations.sql

**Business question:** How many total orders exist in the system?

**Tables used:** orders

**Why JOIN is needed:** A JOIN is not needed because all required information is already stored in the orders table.

**Why WHERE is needed:** WHERE is not needed because we want to count all orders regardless of their status.

**Why GROUP BY is needed:** GROUP BY is not needed because we only need one total number.

**What I understood:** This query gives the total number of orders and helps measure the overall activity of the business.

---

## Query title: Completed revenue

**File:** basic_aggregations.sql

**Business question:** How much revenue was generated from completed orders?

**Tables used:** orders and products

**Why JOIN is needed:** The orders table contains the quantity, but the price is stored in the products table. JOIN connects both tables using product_id.

**Why WHERE is needed:** WHERE filters only completed orders because pending and cancelled orders are not confirmed sales.

**Why GROUP BY is needed:** GROUP BY is not needed because we only need the total revenue value.

**What I understood:** Revenue should only include completed transactions because they represent actual business income.

---

## Query title: Count orders by status

**File:** group_by_reports.sql

**Business question:** How many orders exist for each status?

**Tables used:** orders

**Why JOIN is needed:** A JOIN is not needed because order status is already stored in the orders table.

**Why WHERE is needed:** WHERE is not needed because we want to see all statuses together.

**Why GROUP BY is needed:** GROUP BY creates separate results for completed, pending, and cancelled orders.

**What I understood:** Grouping by status helps managers understand order progress and identify how many orders are not completed.

---

## Query title: Completed revenue by product_id

**File:** group_by_reports.sql

**Business question:** Which products generated the most completed revenue?

**Tables used:** orders and products

**Why JOIN is needed:** The orders table contains product_id and quantity, while the products table contains product prices needed for revenue calculation.

**Why WHERE is needed:** WHERE removes pending and cancelled orders so only completed sales are included.

**Why GROUP BY is needed:** GROUP BY creates one revenue result for each product.

**What I understood:** This report helps identify which products contribute the most money to the business.

---

## Query title: Completed revenue by category

**File:** join_reports.sql

**Business question:** Which product category generated the most completed revenue?

**Tables used:** orders and products

**Why JOIN is needed:** The orders table has product_id, but category and price information are stored in the products table.

**Why WHERE is needed:** Only completed orders should count as real revenue.

**Why GROUP BY is needed:** GROUP BY creates one result row for each product category.

**What I understood:** Electronics generated the highest completed revenue because products like laptops and monitors have higher prices.

---

## Query title: Create order count by city

**File:** join_reports.sql

**Business question:** Which cities have the most customer orders?

**Tables used:** orders and customers

**Why JOIN is needed:** Orders only contain customer_id, while customer city information is stored in the customers table.

**Why WHERE is needed:** WHERE is not needed because all orders should be included.

**Why GROUP BY is needed:** GROUP BY combines orders by city and calculates the number of orders per location.

**What I understood:** This report shows where customers are ordering from and helps compare business activity between cities.

---

## Query title: Top 3 customers by completed revenue

**File:** join_reports.sql

**Business question:** Which customers generated the highest completed revenue?

**Tables used:** orders, customers, and products

**Why JOIN is needed:** Customer names are stored in customers, while prices and quantities needed for revenue are stored across the other tables.

**Why WHERE is needed:** WHERE filters only completed orders because only completed purchases represent real revenue.

**Why GROUP BY is needed:** GROUP BY calculates revenue separately for each customer.

**What I understood:** This query identifies the most valuable customers and can help businesses focus on customer retention.

---

## Query title: Pending and cancelled orders potential value

**File:** join_reports.sql

**Business question:** What is the possible value of orders that are not completed?

**Tables used:** orders, customers, and products

**Why JOIN is needed:** JOIN is needed to display customer names, product names, and calculate the potential amount using product prices.

**Why WHERE is needed:** WHERE filters only pending and cancelled orders.

**Why GROUP BY is needed:** GROUP BY is not needed because the report shows individual orders.

**What I understood:** These orders show possible future value but should not be counted as revenue because they are not completed sales.
