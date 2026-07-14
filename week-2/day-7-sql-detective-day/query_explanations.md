# Query Explanations - Day 7 SQL Detective Day

I explained some of the fixed and validation queries below and what I understood from them.

---

Fixed Query 1

This query shows the number of orders from each city. It uses the orders and customers tables because the city is stored in the customers table. The JOIN is needed because the order data and customer data are in different tables. The result helps us see which cities have more orders.

---

Fixed Query 2

This query calculates revenue for each product. It uses orders and products tables because quantity is in orders and price/product name is in products. The JOIN connects these two tables so we can calculate the revenue correctly. The result shows which products make more money.

---

Fixed Query 3

This query counts how many orders exist for each status. It only uses the orders table because all the needed information is there. No JOIN is needed. The result shows the amount of completed, pending, and cancelled orders.

---

Fixed Query 4

This query calculates the total amount for every order by multiplying quantity with price. It uses orders and products because price is not stored in orders. The JOIN is needed to get the correct product price. The result shows the value of each order.

---

Fixed Query 5

This query shows the total quantity sold for every category. It uses orders and products because the category is inside products. The JOIN is needed to connect orders with categories. The result shows which categories have more sales.

---

Fixed Query 6

This query calculates the total revenue from completed orders only. It uses orders and products tables. The JOIN is needed because we need the product price to calculate the revenue. The result shows the real revenue from completed sales.

---

Fixed Query 7

This query finds customers who have more than one order. It only uses the orders table because customer_id is already available there. No JOIN is needed. The result shows returning customers.

---

Fixed Query 8

This query shows the order id and the customer name. It uses orders and customers because customer names are stored in a different table. The JOIN is needed to connect the order with the correct customer.

---

Validation Query V1

This query counts all orders in the database. It only uses the orders table and does not need JOIN because there is no extra information needed. The result shows the total number of orders.

---

Validation Query V7

This query calculates revenue only from completed orders. It uses orders and products because we need quantity and price. The JOIN is needed to get the product price. The result shows the revenue that should actually count.

---

Validation Query V8

This query shows revenue for each product. It uses orders and products tables. The JOIN is needed because product details are stored separately. The result helps find which products bring more revenue.

---

Validation Query V10

This query counts orders by city. It uses orders and customers tables because city information is in customers. The JOIN connects the orders with customer locations. The result shows which cities have more activity.

---

Validation Query V11

This query finds customers that made more than one order. It only uses the orders table because customer_id is already there. No JOIN is needed. The result shows customers who are ordering again.